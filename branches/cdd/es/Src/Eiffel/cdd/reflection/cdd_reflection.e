indexing
	description: "Objects that represent the state of an object during a feature call"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_REFLECTION

inherit

	SHARED_DEBUG
		export
			{NONE} all
		end

	SHARED_DEBUGGED_OBJECT_MANAGER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_app_status: APPLICATION_STATUS; a_cse: EIFFEL_CALL_STACK_ELEMENT; a_is_creation_call: BOOLEAN) is
			-- Reflect the object associated to `a_cse'
		require
			an_app_status_not_void: an_app_status /= Void
			an_app_status_valid: an_app_status.is_stopped
			a_cse_not_void: a_cse /= Void
			a_cse_valid: an_app_status.current_call_stack.i_th (a_cse.level_in_stack) = a_cse
			is_eiffel_cse: an_app_status.current_call_stack_element.is_eiffel_call_stack_element
		local
			l_alist: LIST [ABSTRACT_DEBUG_VALUE]
			i: INTEGER
		do
			called_feature := a_cse.routine
			is_creation_feature := a_is_creation_call
			create addressed_objects.make (object_count)
			if is_creation_feature then
				root_object := create {CDD_REGULAR_OBJECT}.make_with_count (a_cse.dynamic_class.eiffel_class_c, 0)
			else
				root_object := create_composite_object (a_cse.object_address, a_cse.dynamic_class.eiffel_class_c)
			end
			if reflection_succeded and called_feature.has_arguments then
				l_alist := a_cse.arguments
				create arguments.make (l_alist.count)
				from
					i := 1
				until
					i > l_alist.count
				loop
					arguments.put (create_object (l_alist.i_th (i)), i)
					i := i + 1
				end
			else
				create arguments.make (0)
			end
			if reflection_succeded then
				create composite_objects.make (addressed_objects.count)
				from
					addressed_objects.start
				until
					addressed_objects.after
				loop
					composite_objects.put_last (addressed_objects.item_for_iteration)
					addressed_objects.forth
				end
			else
				create composite_objects.make (0)
			end
			addressed_objects := Void
		end

feature -- Access

	reflection_succeded: BOOLEAN is
			-- Were we able to reflect the state?
		do
			Result := root_object /= Void
		end

	root_object: CDD_COMPOSITE_OBJECT
			-- Actual object beeing reflected

	called_feature: E_FEATURE
			-- Feature which was called before reflection

	is_creation_feature: BOOLEAN
			-- Is `called_feature' a creation feature?

	id: STRING is "not implemented"
			-- Identifier for this reflection

	composite_objects: DS_ARRAYED_LIST [CDD_COMPOSITE_OBJECT]
			-- Objects referenced to directly or indirectly by `root_object'.
			-- NOTE: if `called_feature' is not a creation feature `composite_objects' contains `root_object'.

	arguments: DS_ARRAYED_LIST [CDD_OBJECT]
			-- Reflected arguments of `called_feature'

feature {NONE} -- Implementation

	object_count: INTEGER is 20
			-- Approx avarage number of addressed objects that will be reflected

	max_object_count: INTEGER is 100
			-- Maximum number of addressed objects that will be reflected

	addressed_objects: DS_HASH_TABLE [CDD_COMPOSITE_OBJECT, STRING]
			-- All composite objects stored by the reflected objects address,
			-- (used to determine cycles in the reference graph, void after creation
			-- since addresses or no longer valid)

	add_addressed_object (an_object: CDD_COMPOSITE_OBJECT; an_address: STRING) is
			-- Add `an_object' with `an_address' to `addressed_objects'.
		require
			an_object_not_void: an_object /= Void
			an_address_not_void: an_address /= Void
			not_added_yet: not addressed_objects.has (an_address)
		do
			if addressed_objects.is_full then
				addressed_objects.resize (addressed_objects.count * 2)
			end
			addressed_objects.put (an_object, an_address)
		ensure
			added: addressed_objects.has (an_address)
		end

	create_object (a_dv: ABSTRACT_DEBUG_VALUE): CDD_OBJECT is
			-- Object reflection for `a_dv'
		require
			a_dv_not_void: a_dv /= Void
		do
			if a_dv.dynamic_class /= Void  or else not a_dv.dynamic_class.is_eiffel_class_c then
				if a_dv.address /= Void then
					if addressed_objects.has (a_dv.address) then
						Result := addressed_objects.item (a_dv.address)
					elseif addressed_objects.count < max_object_count then
						Result := create_composite_object (a_dv.address, a_dv.dynamic_class.eiffel_class_c)
					end
				else
					if a_dv.dynamic_class.name.is_equal ("POINTER") then
						Result := create {CDD_POINTER_OBJECT}
					else
						Result := create_basic_object (a_dv)
					end
				end
			elseif a_dv.address /= Void then
				Result := create {CDD_VOID_OBJECT}
			end
		end

	create_composite_object (an_addr: STRING; a_type: EIFFEL_CLASS_C): CDD_COMPOSITE_OBJECT is
			-- Object reflection of type 'a_type' at address 'a_addr'
			-- (Void if non eiffel object in reference graph)
		require
			valid_address: an_addr /= Void and then not an_addr.is_empty
			valid_class: a_type /= Void
		do
			if a_type.name.is_equal ("STRING_8") or a_type.name.is_equal ("STRING_32") then
				Result := create_string_object (an_addr, a_type)
			else
				Result := create_regular_object (an_addr, a_type)
			end
		end

	create_string_object (an_addr: STRING; a_type: EIFFEL_CLASS_C): CDD_STRING_OBJECT is
			-- Reflection of a string object at address `an_addr' and add it to `addressed_objects'.
		require
			addr_valid: an_addr /= Void and then not an_addr.is_empty
			correct_type: a_type /= Void and then (a_type.name.is_equal ("STRING_8")
				or a_type.name.is_equal ("STRING_32"))
		local
			l_dv: DUMP_VALUE
		do
			create l_dv.make_object (an_addr, a_type)
			create Result.make_with_string (a_type, l_dv.formatted_output)
			add_addressed_object (Result, an_addr)
		ensure
			result_not_void: Result /= Void
		end

	create_regular_object (an_addr: STRING; a_type: EIFFEL_CLASS_C): CDD_REGULAR_OBJECT is
			-- Object reflection of type `a_type' at address `a_addr'
			-- (Void if non eiffel object in reference graph)
		require
			an_addr_valid: an_addr /= Void and then not an_addr.is_empty
			a_type_not_void: a_type /= Void
		local
			l_dv: DUMP_VALUE
			l_dbg_obj: DEBUGGED_OBJECT_CLASSIC
			l_dv_list: DS_LIST [ABSTRACT_DEBUG_VALUE]
			l_attr_count: INTEGER
			l_gen_type: STRING
			l_attr_obj: CDD_OBJECT
		do
			if a_type.is_special then
				l_dbg_obj ?= debugged_object_manager.debugged_object (an_addr, min_slice_ref, max_slice_ref)
			else
				l_dbg_obj := debugged_object_manager.classic_debugged_object_with_class (an_addr, a_type)
			end
			l_dv_list := l_dbg_obj.attributes
			if a_type.is_generic or a_type.is_tuple then
				create l_dv.make_object (an_addr, a_type)
				l_gen_type := extract_generic_type (l_dv.generating_type_representation)
				if a_type.is_tuple then
					create {CDD_TUPLE_OBJECT} Result.make_tuple (a_type, l_dv_list.count, l_gen_type)
				elseif a_type.is_special then
					create {CDD_SPECIAL_OBJECT} Result.make_special (a_type, l_dv_list.count, l_gen_type)
				else
					create {CDD_GENERIC_OBJECT} Result.make_generic (a_type, l_dv_list.count, l_gen_type)
				end
			else
				create Result.make_with_count (a_type, l_dv_list.count)
			end
			add_addressed_object (Result, an_addr)
			from
				l_dv_list.start
			until
				l_dv_list.after or Result = Void
			loop
				l_attr_obj := create_object (l_dv_list.item_for_iteration)
				if l_attr_obj /= Void then
					Result.add_attribute (l_dv_list.item_for_iteration.name, l_attr_obj)
				else
					Result := Void
				end
				l_dv_list.forth
			end
		end

	create_basic_object (a_dv: ABSTRACT_DEBUG_VALUE): CDD_BASIC_OBJECT is
			-- Value of `a_dv' for an basic object
		require
			a_dv_not_void: a_dv /= Void
			not_addressed: a_dv.address = Void
			eiffel_type: a_dv.dynamic_class.is_eiffel_class_c
		do
			create Result.make_with_value (a_dv.dump_value.output_value)
		ensure
			result_not_void: Result /= Void
		end

	is_void_or_external_object (a_dv: ABSTRACT_DEBUG_VALUE) is
			--
		do

		end

	extract_generic_type (a_type: STRING): STRING is
			-- Generic substring of some class type
		require
			a_type_valid: a_type /= Void and then not a_type.is_empty
			a_type_has_generics: a_type.has ('[') and a_type.has (']')
		local
			first, last: INTEGER
		do
			first := a_type.index_of ('[', 1) + 1
			last := a_type.index_of (']', first) - 1
			Result := a_type.substring (first, last)
			Result.prune_all_leading (' ')
			Result.prune_all_trailing (' ')
		ensure
			valid_result: Result /= Void and then not Result.is_empty
			substring_of_a_type: a_type.has_substring (Result)
		end

invariant
	correct_reflection_status: reflection_succeded = (
									root_object /= Void and
									called_feature /= Void)
	composite_objects_not_void: composite_objects /= Void
	arguments_not_void: arguments /= Void
	valid_argument_count: arguments.is_empty = not called_feature.has_arguments

end
