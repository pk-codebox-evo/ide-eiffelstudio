indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_REFLECTED_OBJECT

inherit

	SHARED_DEBUG
		export
			{NONE} all
		end

	SHARED_DEBUGGED_OBJECT_MANAGER
		export
			{NONE} all
		end

	--SHARED_APPLICATION_EXECUTION
	--	export
	--		{NONE} all
	--	end

create
	make

feature {NONE} -- Initialization

	object_count: INTEGER is 20
			-- approx number of composite objects that will be stored

	make (cse: EIFFEL_CALL_STACK_ELEMENT) is
			-- Initialize `Current'.
		local
			alist: LIST [ABSTRACT_DEBUG_VALUE]
			i: INTEGER
		do
			create instantiated_nodes.make (object_count)
			root_object := create_composite_object (cse.object_address, cse.dynamic_class)
			called_routine := cse.routine
			if reflection_succeded /= Void then
				create {DS_ARRAYED_LIST [CDD_COMPOSITE_OBJECT]} composite_objects.make (instantiated_nodes.count)
				from
					instantiated_nodes.start
				until
					instantiated_nodes.after
				loop
					composite_objects.put_right (instantiated_nodes.item_for_iteration)
					instantiated_nodes.forth
				end

				-- retrieve feature arguments
				alist := cse.arguments
				create {DS_ARRAYED_LIST [CDD_OBJECT]} arguments.make (alist.count)
				from
					i := 1
				until
					i > alist.count
				loop
					arguments.put (create_object (alist.i_th (i)), i)
					i := i + 1
				end
			end
		end

feature -- Access

	reflection_succeded: BOOLEAN is
			-- were we able to reflect the current
		do
			Result := root_object /= Void
		end


	root_object: CDD_COMPOSITE_OBJECT
			-- root object in the reflection tree

	called_routine: E_FEATURE
			-- feature which was called before reflection


	composite_objects: DS_LIST [CDD_COMPOSITE_OBJECT]
			-- non basic objects needed by root_object

	arguments: DS_LIST [CDD_OBJECT]


feature {NONE} -- Implementation

	instantiated_nodes: DS_HASH_TABLE [CDD_COMPOSITE_OBJECT, STRING]

	create_object (dv: ABSTRACT_DEBUG_VALUE): CDD_OBJECT is
		-- returns Void if non eiffel object occures in attribute tree
	do
		if dv.address /= Void then
			if instantiated_nodes.has (dv.address) then
				Result := instantiated_nodes.item (dv.address)
			else
				Result := create_composite_object (dv.address, dv.dynamic_class)
			end
		else
			Result := create_basic_object (dv)
		end
	end

	create_composite_object (addr: STRING; dtype: CLASS_C): CDD_COMPOSITE_OBJECT is
			-- creates an object of type CDD_OBJECT
			-- and adds it to instantiated_nodes
		require
			valid_address: addr /= Void and then not addr.is_empty
			valid_class: dtype /= Void
		do
			if dtype.name.is_equal ("STRING_8") or dtype.name.is_equal ("STRING_32") then
				Result := create_string_object (addr, dtype)
			elseif dtype.is_eiffel_class_c then
				Result := create_regular_object (addr, dtype)
			end
			if Result /= Void then
				instantiated_nodes.put (Result, addr)
			end
		end

	create_string_object (addr: STRING; dtype: CLASS_C): CDD_STRING_OBJECT is
			--
		require
			addr_valid: addr /= Void and then not addr.is_empty
			correct_type: dtype /= Void and then (dtype.name.is_equal ("STRING_8")
				or dtype.name.is_equal ("STRING_32"))
		local
			dv: DUMP_VALUE
		do
			create dv.make_object (addr, dtype)
			create Result.make_with_string (dtype, dv.formatted_output)
		end

	create_regular_object (addr: STRING; dtype: CLASS_C): CDD_REGULAR_OBJECT is
			--
			-- returns Void if non eiffel object occured in attribute tree
		local
			dv: DUMP_VALUE
			dbg_obj: DEBUGGED_OBJECT_CLASSIC
			alist: DS_LIST [ABSTRACT_DEBUG_VALUE]
			attr_count: INTEGER
			gtype: STRING
			attr_obj: CDD_OBJECT
		do
			if dtype.is_special then
				dbg_obj ?= debugged_object_manager.debugged_object (addr, min_slice_ref, max_slice_ref)
			else
				dbg_obj := debugged_object_manager.classic_debugged_object_with_class (addr, dtype)
			end
			alist := dbg_obj.attributes
			if dtype.is_generic or dtype.is_tuple then
				create dv.make_object (addr, dtype)
				gtype := extract_generic_type (dv.generating_type_representation)
				if dtype.is_tuple then
					create {CDD_TUPLE_OBJECT} Result.make_tuple (dtype, alist.count, gtype)
				elseif dtype.is_special then
					create {CDD_SPECIAL_OBJECT} Result.make_special (dtype, alist.count, gtype)
				else
					create {CDD_GENERIC_OBJECT} Result.make_generic (dtype, alist.count, gtype)
				end
			else
				create Result.make_with_count (dtype, alist.count)
			end
			from
				alist.start
			until
				alist.after or Result = Void
			loop
				attr_obj := create_object (alist.item_for_iteration)
				if attr_obj /= Void then
					Result.add_attribute (alist.item_for_iteration.name, attr_obj)
				else
					Result := Void
				end
				alist.forth
			end
		end


	create_basic_object (dv: ABSTRACT_DEBUG_VALUE): CDD_BASIC_OBJECT is
		require
			has_no_address: dv.address = Void
		do
			create Result.make (dv.dynamic_class)
			Result.set_value (dv.dump_value.output_value)
		end

	extract_generic_type (full_type: STRING): STRING is
			--
		require
			full_type_valid: full_type /= Void and then not full_type.is_empty
			full_type_has_generics: full_type.has ('[') and full_type.has (']')
		local
			first, last: INTEGER
		do
			first := full_type.index_of ('[', 1) + 1
			last := full_type.index_of (']', first) - 1
			Result := full_type.substring (first, last)
			Result.prune_all_leading (' ')
			Result.prune_all_trailing (' ')
		end


invariant
	invariant_clause: True -- Your invariant here

end
