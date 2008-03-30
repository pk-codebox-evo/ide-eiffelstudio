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
		ensure
			cdd_manager_set: cdd_manager = a_manager
		end


feature {ANY} -- Access

	last_extracted_routine_invocations: DS_LIST [CDD_ROUTINE_INVOCATION]
			-- List of all routine invocations extracted by last call to one of the `extract_...' routines

	last_covered_class: CLASS_I
			-- Target class of last captured stack frame

	last_covered_feature: E_FEATURE
			-- Target feature of last captured stack frame

feature {ANY} -- Status Report

	is_using_cache: BOOLEAN
			-- Is `Current' using a cache for extraction operations?

	is_cache_available: BOOLEAN is
			-- Does `Current' have a cache to use?
		do
			Result := cache /= Void
		end

	is_last_extraction_successful: BOOLEAN
			-- Is last extraction successful?
			-- NOTE: only `extract_active_routine' can fail,
			-- `extract_routine_invocations_for_failure' succeeds always (but is allowed to leave `last_extracted_routine_invocations' empty)

feature {ANY} -- Status setting

	set_use_cache (a_flag: BOOLEAN) is
			-- Set `is_using_cache' to `a_flag'.
		require
			cache_available_if_enabled: a_flag implies is_cache_available
		do
			is_using_cache := a_flag
		ensure
			is_using_cache_flag_set: is_using_cache = a_flag
		end

feature {ANY} -- Basic operations

	set_cache (a_cache: CDD_ROUTINE_INVOCATION_CACHE) is
			-- Set `cache' to `a_cache'.
		require
			a_cache_not_void: a_cache /= Void
		do
			cache := a_cache
		ensure
			cache_set: cache = a_cache
		end

	unset_cache is
			-- Set `cache' to Void
		require
			is_not_using_cache: not is_using_cache
		do
			cache := Void
		ensure
			cache_unset: cache = Void
		end

	extract_routine_invocations_for_failure (a_status: APPLICATION_STATUS) is
			-- Extract routine invocations for each feature call on the call stack of `a_status'.
			-- Make extracted routine invocations available in `last_extracted_routine_invocations'.
			-- Ignore top of stack upon precondition violation and apply failure extraction conditions for extraction
			-- of individual call stack elements.
			-- In case `Current' `is_using_cache' take routine invocations from cache instead of extracting them, if available.
			-- Additionally, if `Current' `is_using_cache', pop all elements from cache which would have been used without
			-- special handling because of a failure (-> for each element of the call stack, pop a corresponding routine invocation
			-- from the stack if available, even if it is not used to replace actual extraction because of special failure extraction
			-- conditions like "no failure extraction for read only library classes")
		require
			a_status_not_void: a_status /= Void
			application_is_stopped: a_status.is_stopped
			application_has_failure: a_status.exception_occurred
		local
			l_cse: EIFFEL_CALL_STACK_ELEMENT
		do
			last_extracted_routine_invocations.wipe_out
			a_status.set_max_depth (-1)
			a_status.force_reload_current_call_stack
			initialize_capturing (a_status)

			if not current_call_stack.after then

					-- If failure is a precondition, ignore first call stack element
				if a_status.exception_code = {EXCEP_CONST}.precondition then
					if is_using_cache then
						l_cse ?= current_call_stack.item
						if l_cse /= Void and then cache.has_cached_routine_invocation (l_cse.routine) then
							cache.pop_cached_routine_invocation (l_cse.routine)
						end
					end
					current_call_stack.forth
				end

					-- Capture routine invocations for failure
				capture_stack_frames (a_status.current_call_stack.count, True)
			end

			clean_up
			is_last_extraction_successful := True
		ensure
			last_extracted_routine_invocations_not_void: last_extracted_routine_invocations /= Void
			is_successful: is_last_extraction_successful
		end

	extract_active_routine (a_status: APPLICATION_STATUS) is
			-- Try to extract routine invocation for the active routine of `a_status' (top of current call stack).
			-- If possible make extracted routine invocation available in `last_extracted_routine_invocations'.
		require
			a_status_not_void: a_status /= Void
			application_is_stopped: a_status.is_stopped
		local
			l_cse: EIFFEL_CALL_STACK_ELEMENT
		do
			last_extracted_routine_invocations.wipe_out
			l_cse ?= a_status.current_call_stack_element
			if l_cse /= Void then
				initialize_capturing (a_status)
				capture_call_stack_element (l_cse, 1)
				clean_up
				is_last_extraction_successful := True
			else
				is_last_extraction_successful := False
			end
		ensure
			last_extracted_routine_invocations_not_void: last_extracted_routine_invocations /= Void
			exactly_one_routine_invocation_extracted_if_successful: is_last_extraction_successful implies (last_extracted_routine_invocations.count = 1)
			extracted_top_of_stack_if_successful: is_last_extraction_successful implies
														last_extracted_routine_invocations.first.represented_feature.written_feature.same_as (a_status.e_feature.written_feature)
		end


feature {NONE} -- Implementation (Capturing)

	initialize_capturing (a_status: APPLICATION_STATUS) is
			-- Initialize all data structures required by any capturing routines.
		local
			l_dt: DT_DATE_TIME
		do
			current_application_status := a_status
			current_call_stack := a_status.current_call_stack

				-- TODO: Caching of debug values over multiple stack frame extractions (simply by extending and keeping "Object Map"?)

				-- As a call stack id, we use to number of seconds
				-- elapsed since epoch date. This can later
				-- be used for sorting and displaying an arbitrary
				-- date time format.
			l_dt := system_clock.date_time_now
			current_call_stack_id := l_dt.epoch_days (l_dt.year, l_dt.month, l_dt.day) * l_dt.seconds_in_day
			current_call_stack_id := current_call_stack_id + l_dt.time.second_count

				-- Set start for iteration over call stack
			current_call_stack.start
		ensure
			application_status_initialized: current_application_status /= Void
			call_stack_initialized: current_call_stack /= Void
			call_stack_ready_for_extraction: current_call_stack.after or else
												(not current_call_stack.is_empty and then (current_call_stack.item = current_call_stack.i_th (1)))
			current_call_stack_id_initialized: current_call_stack_id > 0
--			current_call_stack_target_objects_initialized: current_call_stack_target_objects /= Void
		end

	clean_up is
			-- Clean up capturing data structures
		do
			current_application_status := Void
			current_call_stack := Void
			current_call_stack_target_objects := Void
		ensure
			application_status_uninitialized: current_application_status = Void
			call_stack_uninitialized: current_call_stack = Void
			current_call_stack_target_objects_uninitialized: current_call_stack_target_objects = Void
		end

	capture_stack_frames (a_count: INTEGER; an_apply_failure_extraction_conditions_flag: BOOLEAN) is
			-- Capture max `a_count' routine invocations from `current_call_stack'.
			-- Start where internal cursor of `current_call_stack' is pointing to.
			-- Stack frames for which extraction is impossible (e.g. not conforming to EIFFEL_CALL_STACK_ELEMENT) are ignored.
			-- `an_apply_failure_extraction_conditions_flag' determines if call stack elements not meeting the failure extraction conditions
			-- are ignored as well.
			-- If `Current' `is_using_cache' routine invocations are taken from cache if possible, and they are popped for all call stack
			-- elements regardles if actual extraction takes place.
		require
			application_status_initialized: current_application_status /= Void
			call_stack_initialized: current_call_stack /= Void
			current_call_stack_id_initialized: current_call_stack_id > 0
		local
			l_cse: EIFFEL_CALL_STACK_ELEMENT
			i: INTEGER
		do
			from
				i := 1
			until
				current_call_stack.after or i > a_count
			loop
				l_cse ?= current_call_stack.item
				if l_cse /= Void then
					if
						not an_apply_failure_extraction_conditions_flag or else
						is_valid_call_stack_element_for_failure_extraction (l_cse, i = 1)
					then
						capture_call_stack_element (l_cse, i)
						i := i + 1
					else
							-- Pop corresponding feature from cache anyway if `is_using_cache'
						if is_using_cache and then cache.has_cached_routine_invocation (l_cse.routine) then
							cache.pop_cached_routine_invocation (l_cse.routine)
						end
					end
				end
				current_call_stack.forth
			end
		end

	is_valid_call_stack_element_for_failure_extraction (a_cse: EIFFEL_CALL_STACK_ELEMENT; a_candidate_for_first_extraction_flag: BOOLEAN): BOOLEAN is
			-- Is `a_cse' a valid call stack element for extraction of a routine invocation?
			-- A valid call stack element needs to fullfill ALL of the following criteria:
			-- 1. NOT a call stack element for an external feature
			-- 2. NOT a call stack element for an inline agent
			-- 3. NOT a call stack element for a feature of a class which is part of read-only library, EXCEPT `a_cse' is a candidate for first extraction.
			-- 4. Exported to {any} OR a creation procedure
		require
			a_cse_not_void: a_cse /= Void
		local
			l_class: EIFFEL_CLASS_C
			l_feature: E_FEATURE
		do
				-- 1. There has to be an EIFFEL_CLASS_C associated with 'a_cse'
			Result := a_cse.dynamic_class /= Void and then a_cse.dynamic_class.is_eiffel_class_c
			if Result then
				l_class := a_cse.dynamic_class.eiffel_class_c
					-- 3. NOT a call stack element for a feature of a class which is part of read-only library,
					-- except `a_cse' is a candidate for first extraction.
				Result := a_candidate_for_first_extraction_flag or else not (l_class.cluster.is_used_in_library and then l_class.cluster.is_readonly)
				if Result then
					l_feature := l_class.feature_with_name (a_cse.routine.name)
					check
						feature_exists_in_descendant: l_feature /= Void
					end
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

	capture_call_stack_element (a_cse: EIFFEL_CALL_STACK_ELEMENT; a_cs_level: INTEGER) is
			-- Capture state for `a_cse'. `a_call_stack_id' is the call stack's unique id.
		require
			application_status_initialized: current_application_status /= Void
			call_stack_initialized: current_call_stack /= Void
			call_stack_ready_for_extraction: not current_call_stack.after
			current_call_stack_id_initialized: current_call_stack_id > 0
		local
			l_cse: EIFFEL_CALL_STACK_ELEMENT
			l_class: CLASS_C
			l_feature: E_FEATURE

			l_arguments: DS_ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]
			i, j, l_ops_count: INTEGER
			l_type: STRING
			l_argument_generating_type_list: DS_ARRAYED_LIST [STRING_8]

			l_routine_invocation: CDD_ROUTINE_INVOCATION
			l_context: DS_ARRAYED_LIST [TUPLE [id: STRING; type: STRING; inv: BOOLEAN; attributes: DS_LIST [STRING]]]

			l_start_time: DATE_TIME
			l_done: BOOLEAN
		do
			create l_start_time.make_now
			l_feature := a_cse.routine
			l_class := a_cse.dynamic_class
			create l_context.make (20)

				-- If `is_using_cache' = False, always do extract a new routine invocation (no cache look-up)
				-- Otherwise extract only a new routine invocation if none is available in cache already

			if is_using_cache then

					-- NOTE: This ugly workaround handles invariant violation exceptions.
					-- These are sometimes thrown after `on_routine_exit' of CDD_MANAGER is called.
					-- In this case the corresponding routine_invocation has been popped already
					-- and we resort to `last_popped_routine_invocation'
				if
					a_cse.level_in_stack = 1 and then -- For top element only
					current_application_status.exception_occurred and then
					current_application_status.exception_code = {EXCEP_CONST}.class_invariant and then
					cdd_manager.cdd_breakpoints.has_cdd_breakpoint (a_cse.routine) and then -- There was prestate extracted at all
					a_cse.break_index = a_cse.routine.number_of_breakpoint_slots
							-- If the break slot for the exception is the very last breakpoint slot, the invariant exception was thrown
							-- after the corresponding state was popped already
				then
					check
						last_popped_available: cache.last_popped_routine_invocation /= Void
						last_popped_valid: cache.last_popped_routine_invocation.represented_feature.same_as (a_cse.routine)
					end
					l_routine_invocation := cache.last_popped_routine_invocation
					l_routine_invocation.set_call_stack_id (current_call_stack_id)
					l_routine_invocation.set_call_stack_index (a_cs_level)
					last_extracted_routine_invocations.force_last (l_routine_invocation)
					l_done := True
				elseif
					cache.has_cached_routine_invocation (l_feature)
				then
					l_routine_invocation := cache.cached_routine_invocation (l_feature)
						-- Remove the just "consumed" routine invocation
					cache.pop_cached_routine_invocation (l_feature)

					l_routine_invocation.set_call_stack_id (current_call_stack_id)
					l_routine_invocation.set_call_stack_index (a_cs_level)
					last_extracted_routine_invocations.force_last (l_routine_invocation)
					l_done := True
				end
			end

			if not l_done then
					-- Extract new routine invocation

					-- Remember all call target objects in stack below `a_cse'
				from
					create current_call_stack_target_objects.make (20)
					current_call_stack_target_objects.set_equality_tester (case_insensitive_string_equality_tester)
					i := a_cse.level_in_stack + 1
				until
					i > current_call_stack.count
				loop
					l_cse ?= current_call_stack.i_th (i)
					if l_cse /= Void and then l_cse.current_object_value /= Void and then l_cse.current_object_value.address /= Void then
						current_call_stack_target_objects.force (l_cse.current_object_value.address)
					end
					i := i + 1
				end


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

						-- This special list of all argument generating types is required for propper printing of routine invocations.
				create l_argument_generating_type_list.make (l_feature.argument_count + 1)

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
					-- In this list the target object type is always required
				l_argument_generating_type_list.put (a_cse.current_object_value.dump_value.generating_type_representation (True), 1)

				from
					j := 1
				until
					j > l_feature.argument_count
				loop
					l_arguments.put (a_cse.arguments.i_th (j), j + i)
					l_type.append (a_cse.arguments.i_th (j).dump_value.generating_type_representation (True))
					l_argument_generating_type_list.put (a_cse.arguments.i_th (j).dump_value.generating_type_representation (True), j + 1)
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

				create l_routine_invocation.make (l_feature, l_argument_generating_type_list, l_context, current_call_stack_id, a_cs_level)
				last_extracted_routine_invocations.force_last (l_routine_invocation)


				log.report_extraction (l_start_time, create {DATE_TIME}.make_now, l_routine_invocation)

				last_covered_class := l_feature.associated_class.original_class
				last_covered_feature := l_feature

				cdd_manager.status_update_actions.call ([create {CDD_STATUS_UPDATE}.make_with_code ({CDD_STATUS_UPDATE}.capturer_extracted_code)])
			end
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

			a_result_container.force_last ([l_id, l_type, not (an_object.address /= Void and then current_call_stack_target_objects.has (an_object.address)), l_attrs])
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

	current_application_status: APPLICATION_STATUS
			-- Currently handled application status

	current_call_stack: EIFFEL_CALL_STACK
			-- Currently handled call stack

	current_call_stack_target_objects: DS_HASH_SET [STRING]
			-- Hash set for all addresses of objects which are target for a routine call represented by a frame of current call stack
			-- This is used to prevent invariant checks for theses objects

	current_call_stack_id: INTEGER
			-- Generated id for currently handled call stack

feature {NONE} -- Implementation

	cdd_manager: CDD_MANAGER
			-- CDD manager

	log: CDD_LOGGER is
			-- Logger
		do
			Result := cdd_manager.log
		end

	cache: CDD_ROUTINE_INVOCATION_CACHE
			-- Cache used for extraction if `is_using_cache' flag is set.

invariant
	cdd_manager_not_void: cdd_manager /= Void
	last_extracted_routine_invocations_not_void: last_extracted_routine_invocations /= Void
	cache_not_void_if_use_cache_enabled: is_using_cache implies is_cache_available

end
