indexing
	description: "Objects that capture the state of some application by producing and potentially caching CDD_ROUTINE_INVOCATIONs"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_CAPTURER

inherit

	CDD_ROUTINES
		export
			{NONE} all
		end

	DEBUG_VALUE_EXPORTER
		export
			{NONE} all
		end

	UT_STRING_FORMATTER
		export
			{NONE} all
		end

	DT_SHARED_SYSTEM_CLOCK
		export
			{NONE} all
		end

	KL_SHARED_STRING_EQUALITY_TESTER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: like cdd_manager) is
			-- Create `capture_observers'.
		require
			a_manager_not_void: a_manager /= Void
		do
			cdd_manager := a_manager

			create {DS_ARRAYED_LIST [CDD_ROUTINE_INVOCATION]} last_extracted_routine_invocations.make (10)

			create call_stack_target_objects.make (20)
			call_stack_target_objects.set_equality_tester (case_insensitive_string_equality_tester)
		ensure
			cdd_manager_set: cdd_manager = a_manager
		end


feature {ANY} -- Access

	last_extracted_routine_invocations: DS_LIST [CDD_ROUTINE_INVOCATION]
			-- List of all routine invocations extracted by last call to one of the `extract_...' routines

	last_covered_class: CLASS_I
			-- Target class of last captured stack frame

feature {ANY} -- Basic operations

	extract_routine_invocations_for_failure (a_status: APPLICATION_STATUS) is
			-- Extract routine invocations for each feature call on the call stack of `a_status'.
			-- Make extracted routine invocations available in `last_extracted_routine_invocations'.
			-- Do not add any newly extracted routine invocations to cache.
		require
			a_status_not_void: a_status /= Void
			application_is_stopped: a_status.is_stopped
			application_has_failure: a_status.exception_occurred
		do
			a_status.set_max_depth (-1)
			a_status.force_reload_current_call_stack
			capture_stack_frames (a_status, a_status.current_call_stack.count, False)
		ensure
			last_extracted_routine_invocations_not_void: last_extracted_routine_invocations /= Void
			cache_did_not_change: True
		end

	extract_and_cache_routine_invocation_for_active_routine (a_status: APPLICATION_STATUS) is
			-- Extract routine invocation for the active routine of `a_status'.
			-- Make extracted routine invocation available in `last_extracted_routine_invocations'.
			-- Add the newly extracted routine invocation to the cache.
		require
			a_status_not_void: a_status /= Void
			application_is_stopped: a_status.is_stopped
			application_has_no_failure: not a_status.exception_occurred -- TODO Consider: This precondition implies
																		-- that it is never allowed to cache "failure" states. It might be convenient to handle
																		-- this inside the cashing procedures instead of disallowing the call itself.
		do
			capture_stack_frames (a_status, 1, True)
		ensure
			last_extracted_routine_invocations_not_void: last_extracted_routine_invocations /= Void
			exactly_one_routine_invocation_extracted: last_extracted_routine_invocations.count = 1
			extracted_routine_invocation_is_in_cache: True
		end


feature {NONE} -- Implementation (Capturing)

	capture_stack_frames (a_status: APPLICATION_STATUS; a_count: INTEGER; a_caching_enabled_flag: BOOLEAN) is
			-- Capture max `a_count' routine invocations for valid call stack elements
			-- from top of call stack in `a_status'.
			-- `a_caching_enabled_flag' determines if extracted routine invocations are put in cache.
		require
			a_status_not_void: a_status /= Void
			a_status_valid: a_status.is_stopped
			a_count_not_negative: a_count >= 0
			a_status_valid_for_caching: a_caching_enabled_flag implies not a_status.exception_occurred
		local
			l_call_stack: EIFFEL_CALL_STACK
			l_cse: EIFFEL_CALL_STACK_ELEMENT
			i: INTEGER

			l_dt: DT_DATE_TIME
			l_call_stack_id: INTEGER_32
		do
			log.report_extraction_start

			l_call_stack := a_status.current_call_stack

				-- ** Setup general extraction structures which are persistent over all individual frame extractions ** --

			last_extracted_routine_invocations.wipe_out

				-- Remember all objects which are target of some routine call in the current call stack.
			from
				l_call_stack.start
			until
				l_call_stack.after
			loop
				l_cse ?= l_call_stack.item
				if l_cse /= Void and then l_cse.current_object_value /= Void and then l_cse.current_object_value.address /= Void then
					call_stack_target_objects.force (l_cse.current_object_value.address)
				end
				l_call_stack.forth
			end

				-- TODO: Caching of debug values over multiple stack frame extractions (simply by extending and keeping "Object Map"?)

				-- As a call stack id, we use to number of seconds
				-- elapsed since epoch date. This can later
				-- be used for sorting and displaying an arbitrary
				-- date time format.
			l_dt := system_clock.date_time_now
			l_call_stack_id := l_dt.epoch_days (l_dt.year, l_dt.month, l_dt.day)*l_dt.seconds_in_day
			l_call_stack_id := l_call_stack_id + l_dt.time.second_count


				-- ** Extraction of stack frames ** --

				-- Extract routine invocations for at most `a_count'
				-- valid stack frames on the call stack,
				-- beginning from the top.
				-- A top stack frame having failed due to a precondition violation is ignored.
			from
				l_call_stack.start
				if
					(not l_call_stack.after) and then
					a_status.exception_occurred and then
					a_status.exception_code = {EXCEP_CONST}.precondition
				then
					l_call_stack.forth
				end
				i := 1
			until
				l_call_stack.after or i > a_count
			loop
				if is_valid_call_stack_element (l_call_stack.item, (i = 1)) then
					l_cse ?= l_call_stack.item
					check call_stack_element_not_void: l_cse /= Void end
					capture_call_stack_element (l_cse, l_call_stack_id, i)
					i := i + 1
				end
				l_call_stack.forth
			end


				-- ** Clean up general extraction data structures ** --

			call_stack_target_objects.wipe_out

			log.report_extraction_end
		end

	is_valid_call_stack_element (a_cse: CALL_STACK_ELEMENT; a_candidate_for_first_extraction_flag: BOOLEAN): BOOLEAN is
			-- Is `a_cse' a valid call stack element for extraction of a routine invocation?
			-- A valid call stack element needs to fullfill ALL of the following criteria:
			-- 1. NOT a call stack element for an external feature
			-- 2. NOT a call stack element for an inline agent
			-- 3. NOT a call stack element for a feature of a class which is part of read-only library, EXCEPT `a_cse' is a candidate for first extraction.
			-- 4. Exported to {any} OR a creation procedure
		require
			a_cse_not_void: a_cse /= Void
		local
			l_cse: EIFFEL_CALL_STACK_ELEMENT
			l_class: EIFFEL_CLASS_C
			l_feature: E_FEATURE
		do
				-- 1. `a_cse' has to be an eiffel call stack element (e.g. not an EXTERNAL_CALL_STACK_ELEMENT)
			Result := a_cse.is_eiffel_call_stack_element
			if Result then
				l_cse ?= a_cse
				check eiffel_call_stack_element_not_void: l_cse /= Void end
					-- 1. There has to be an EIFFEL_CLASS_C associated with 'a_cse'
				Result := l_cse.dynamic_class /= Void and then l_cse.dynamic_class.is_eiffel_class_c
				if Result then
					l_class := l_cse.dynamic_class.eiffel_class_c
						-- 3. NOT a call stack element for a feature of a class which is part of read-only library,
						-- except `a_cse' is a candidate for first extraction.
					Result := a_candidate_for_first_extraction_flag or else not (l_class.cluster.is_used_in_library and then l_class.cluster.is_readonly)
					if Result then
						l_feature := l_cse.routine
							-- 1. NOT a call stack element for an external feature
							-- 2. NOT a call stack element for an inline agent
						Result := (not l_feature.is_external) and then (not l_feature.is_inline_agent)
						if Result then
								-- 4. Exported to {any} OR a creation procedure
							Result := l_feature.export_status.is_all or else
										l_class.creation_feature = l_feature.associated_feature_i or else
										(l_class.creators /= Void and then l_class.creators.has (l_feature.name))
						end
					end
				end
			end
		end

	capture_call_stack_element (a_cse: EIFFEL_CALL_STACK_ELEMENT; a_call_stack_id: INTEGER_32; a_cs_level: INTEGER) is
			-- Capture state for `a_cse'. `a_call_stack_id' is the call stack's unique id.
		require
			a_cse_not_void: a_cse /= Void
			valid_cse: is_valid_call_stack_element (a_cse, a_cs_level = 1)
			a_call_stack_id_positive: a_call_stack_id  > 0
			a_cs_level_positiv: a_cs_level > 0
		local
			l_class: CLASS_C
			l_feature: E_FEATURE

			l_arguments: DS_ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]
			i, j, l_ops_count: INTEGER
			l_type: STRING

			l_routine_invocation: CDD_ROUTINE_INVOCATION
			l_context: DS_ARRAYED_LIST [TUPLE [id: STRING; type: STRING; inv: BOOLEAN; attributes: DS_LIST [STRING]]]

			l_start_time: DATE_TIME
		do
			create l_start_time.make_now
			l_feature := a_cse.routine
			l_class := a_cse.dynamic_class
			create l_context.make (20)

				-- Add operands as first object of context
			current_object_id := 1
			create object_queue.make
			create object_map.make (20) -- Note: this value says how many objects we assume to reflect...

			if is_creation_feature (l_feature) then
				i := 1
			else
				i := 2
			end

			create l_arguments.make (l_feature.argument_count + i)
			l_type := "TUPLE"
			l_ops_count := i + l_feature.argument_count
			if l_ops_count > 1 then
				l_type.append (" [")
			end
					-- Add hidden 'object_comparison' field value for the operand tuple
			l_arguments.put_first (create {DEBUG_BASIC_VALUE [BOOLEAN]}.make ({DEBUG_BASIC_VALUE [BOOLEAN]}.sk_bool, False))
			if i > 1 then
				l_arguments.put (a_cse.current_object_value, 2)
				l_type.append (a_cse.current_object_value.dump_value.generating_type_representation (True))
				if l_feature.argument_count > 0 then
					l_type.append (", ")
				end
			end

			from
				j := 1
			until
				j > l_feature.argument_count
			loop
				l_arguments.put (a_cse.arguments.i_th (j), j + i)
				l_type.append (a_cse.arguments.i_th (j).dump_value.generating_type_representation (True))
				if l_feature.argument_count > j then
					l_type.append (", ")
				end
				j := j + 1
			end
			if l_ops_count > 1 then
				l_type.append ("]")
			end

			l_context.force_last (["#operand", l_type, True, fetch_object_attributes (l_arguments, False, 0)])


				-- Start capturing objects
			from until
				object_queue.is_empty
			loop
				process_object (object_queue.item.object, object_queue.item.depth, l_context)
				object_queue.remove
			end

			create l_routine_invocation.make (l_feature, a_cse.current_object_value.dump_value.generating_type_representation (True), l_context, a_call_stack_id, a_cs_level)
			last_extracted_routine_invocations.force_last (l_routine_invocation)

			log.report_extraction (l_start_time, create {DATE_TIME}.make_now, l_routine_invocation)

			last_covered_class := l_feature.associated_class.original_class

			cdd_manager.status_update_actions.call ([create {CDD_STATUS_UPDATE}.make_with_code ({CDD_STATUS_UPDATE}.capturer_extracted_code)])
		ensure
			last_extracted_routine_invocations_not_empty: not last_extracted_routine_invocations.is_empty
		end

	process_object (an_object: ABSTRACT_DEBUG_VALUE; a_depth: INTEGER; a_result_container: DS_ARRAYED_LIST [TUPLE [id: STRING; type: STRING; inv: BOOLEAN; attributes: DS_LIST [STRING]]]) is
			-- Create context representation for `an_object'
			-- and notify observers.
		require
			reference_value: is_reference_value (an_object)
			object_already_added: object_map.has (an_object.address)
			a_depth_not_negative: a_depth >= 0
			a_result_container_not_void: a_result_container /= Void
		local
			l_class: EIFFEL_CLASS_C
			l_id, l_type: STRING
			l_ref_adv: ABSTRACT_REFERENCE_VALUE
			l_attrs: DS_LIST [STRING]

			l_class_id: INTEGER
			l_feature_id: INTEGER
			l_routine_target_type: CLASS_TYPE
			l_routine_target_class: CLASS_C
			l_routine: E_FEATURE
		do
			l_class := an_object.dynamic_class.eiffel_class_c
			l_type := an_object.dump_value.generating_type_representation (True)
			l_id := object_map.item (an_object.address)

			if l_class.name.is_equal ("STRING_8") or l_class.name.is_equal ("STRING_32") then
				create {DS_ARRAYED_LIST [STRING]} l_attrs.make (1)
				l_ref_adv ?= an_object
				check l_ref_adv_not_void: l_ref_adv /= Void end
				l_attrs.put_first (format_output_value (l_ref_adv.dump_value.truncated_string_representation (0, -1)))
			elseif l_class.parents_classes.there_exists (agent (x: CLASS_C): BOOLEAN do Result := x.name_in_upper.is_equal ("ROUTINE") end) then
				l_attrs := fetch_object_attributes (an_object.children, True, a_depth)
					-- find target class for agent
				l_attrs.set_equality_tester (case_insensitive_string_equality_tester)
				l_attrs.start
				l_attrs.search_forth ("class_id")
				check class_id_attr_exists: not l_attrs.after end
				l_attrs.forth
				check class_id_attr_valid: not l_attrs.after and l_attrs.item_for_iteration.is_integer_32 end
				l_class_id := l_attrs.item_for_iteration.to_integer_32 + 1

				l_attrs.start
				l_attrs.search_forth ("feature_id")
				check feature_id_attr_exists: not l_attrs.after end
				l_attrs.forth
				check feature_id_attr_valid: not l_attrs.after and l_attrs.item_for_iteration.is_integer_32 end
				l_feature_id := l_attrs.item_for_iteration.to_integer_32

				if l_class_id > 0 then
					l_routine_target_type := l_class.system.class_type_of_static_type_id (l_class_id)
					if l_routine_target_type /= Void then
						l_routine_target_class := l_routine_target_type.associated_class
					end
				end

				if l_routine_target_class /= Void and l_feature_id > 0 then
					l_attrs.start
					l_attrs.search_forth ("class_id")
					check class_id_attr_exists: not l_attrs.after end
					l_attrs.forth
					check class_id_attr_valid: not l_attrs.after and l_attrs.item_for_iteration.is_integer_32 end
					l_attrs.replace_at (l_routine_target_class.name_in_upper)

					l_routine := l_routine_target_class.feature_with_feature_id (l_feature_id)
					if l_routine /= Void then
						l_attrs.start
						l_attrs.search_forth ("feature_id")
						check feature_id_attr_exists: not l_attrs.after end
						l_attrs.forth
						check feature_id_attr_valid: not l_attrs.after and l_attrs.item_for_iteration.is_integer_32 end
						l_attrs.replace_at (l_routine.name)
					end
				end

			elseif l_class.is_special then
				l_attrs := fetch_object_attributes (an_object.children, False, a_depth)
			elseif l_class.is_tuple then
				l_attrs := fetch_object_attributes (an_object.children, False, a_depth)
			else
				l_attrs := fetch_object_attributes (an_object.children, True, a_depth)
			end

			a_result_container.force_last ([l_id, l_type, not (an_object.address /= Void and then call_stack_target_objects.has (an_object.address)), l_attrs])
		end

	add_referenced_object (an_adv: ABSTRACT_DEBUG_VALUE; a_depth: INTEGER) is
			-- Add `an_adv' to `object_map' and `object_queue'.
		require
			an_adv_valid: an_adv /= Void and is_reference_value (an_adv)
			not_yet_added: not object_map.has (an_adv.address)
			a_depth_not_negative: a_depth >= 0
		local
			l_new_id: STRING
		do
			if object_map.is_full then
				object_map.resize (object_map.capacity * 2)
			end
			current_object_id := current_object_id + 1
			l_new_id := "#" + current_object_id.out
			object_map.put (l_new_id, an_adv.address)
			object_queue.put ([an_adv, a_depth])
		ensure
			added_to_mapping: object_map.has (an_adv.address)
			added_to_queue: object_queue.count = old object_queue.count + 1
		end

	fetch_object_attributes (an_attr_list: DS_LIST [ABSTRACT_DEBUG_VALUE]; an_use_attr_names: BOOLEAN; a_depth: INTEGER): DS_LIST [STRING] is
			-- List of string representations for attributes in `an_attr_list'.
			-- If `an_use_attr_name' is true, also provide the attributes names.
		require
			object_map_not_void: object_map /= Void
			object_queue_not_void: object_queue /= Void
			an_attr_list_not_void: an_attr_list /= Void
			a_depth_not_negative: a_depth >= 0
		local
			l_cursor: DS_LIST_CURSOR [ABSTRACT_DEBUG_VALUE]
			l_child: ABSTRACT_DEBUG_VALUE
			l_value: STRING
		do
			create {DS_LINKED_LIST [STRING]} Result.make
			from
				l_cursor := an_attr_list.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_child := l_cursor.item
				l_value := attribute_value (l_child, a_depth + 1)
				if an_use_attr_names then
					Result.put_last (l_child.name)
				end
				Result.put_last (l_value)
				l_cursor.forth
			end
		end

	attribute_value (an_adv: ABSTRACT_DEBUG_VALUE; a_depth: INTEGER): STRING is
			-- Value represented by `an_adv' if it is a basic type,
			-- otherwise the mapped id for the object it is pointing to.
			-- Is void in case `an_adv' represents a void or unhandled value.
		require
			a_depth_not_negative: a_depth >= 0
		do
			if is_reference_value (an_adv) then
				if  an_adv.dynamic_class /= Void and then an_adv.dynamic_class.is_eiffel_class_c then
					if not object_map.has (an_adv.address) then
						if current_object_id <= max_object_count and a_depth <= max_reference_depth then
							add_referenced_object (an_adv, a_depth)
							Result := object_map.item (an_adv.address)
						else
							Result := "Void"
						end
					else
						Result := object_map.item (an_adv.address)
					end
				end
			elseif an_adv.kind = {VALUE_TYPES}.immediate_value then
				if an_adv.dump_value.output_value (false) /= Void then
					Result := format_output_value (an_adv.output_value)
				else
					Result := ""
				end
			else
				Result := "Void"
			end
		ensure
			not_void: Result /= Void
		end

	is_reference_value (an_adv: ABSTRACT_DEBUG_VALUE): BOOLEAN is
			-- Is `an_adv' a reference to some object?
		do
			Result := an_adv.kind = {VALUE_TYPES}.reference_value or an_adv.kind = {VALUE_TYPES}.special_value
		end

	format_output_value (a_string: STRING): STRING is
			-- Format output value `a_string'
			-- 1. Escape special characters.
			-- 2. Split up string to prevent manifest strings which are too big ("abcd" -> "ab" + "cd")
		require
			a_string_not_void: a_string /= Void
		local
			i: INTEGER
		do
			Result := eiffel_string_out (a_string.substring (1, max_manifest_string_size.min (a_string.count)))

			from
				i := max_manifest_string_size + 1
			until
				i > a_string.count
			loop
				Result := Result + "%" + %"" + eiffel_string_out (a_string.substring (i, (i + max_manifest_string_size - 1).min (a_string.count)))
				i := i + max_manifest_string_size
			end
		ensure
			result_not_void: Result /= Void
		end


feature {NONE} -- Implementation (Capturing Data Structures)

	object_map: DS_HASH_TABLE [STRING, STRING]
			-- Hash table that maps object addresses to an id in the test case context

	object_queue: DS_LINKED_QUEUE [TUPLE [object: ABSTRACT_DEBUG_VALUE; depth: INTEGER]]
			-- Queue of objects together with the reference depth still need to printed in the context

	current_object_id: INTEGER
			-- Counter for giving new objects an id.
			-- NOTE: this will be replaced with id from capture/replay module.

	call_stack_target_objects: DS_HASH_SET [STRING]
			-- Hash set for all addresses of objects which are target for a routine call represented by a frame of current call stack
			-- This is used to prevent invariant checks for theses objects
			-- NOTE: for now we simply check whether a object is part
			-- of the call stack. Actually for a given stack frame,
			-- we should only account for the objects in stack frames
			-- below the given stack frame (assuming we can extract the
			-- prestate).


feature {NONE} -- Implementation

	cdd_manager: CDD_MANAGER
			-- CDD manager

	log: CDD_LOGGER is
			-- Logger
		do
			Result := cdd_manager.log
		end

invariant
	cdd_manager_not_void: cdd_manager /= Void
	last_extracted_routine_invocations_not_void: last_extracted_routine_invocations /= Void
	call_stack_target_objects_not_void: call_stack_target_objects /= Void

end
