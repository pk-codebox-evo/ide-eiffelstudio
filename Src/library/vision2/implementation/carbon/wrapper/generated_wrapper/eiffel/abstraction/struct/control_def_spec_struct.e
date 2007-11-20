-- This file has been generated by EWG. Do not edit. Changes will be lost!

class CONTROL_DEF_SPEC_STRUCT

inherit

	EWG_STRUCT

	CONTROL_DEF_SPEC_STRUCT_EXTERNAL
		export
			{NONE} all
		end

create

	make_new_unshared,
	make_new_shared,
	make_unshared,
	make_shared

feature {ANY} -- Access

	sizeof: INTEGER is
		do
			Result := sizeof_external
		end

feature {ANY} -- Member Access

	deftype: INTEGER is
			-- Access member `defType'
		require
			exists: exists
		do
			Result := get_deftype_external (item)
		ensure
			result_correct: Result = get_deftype_external (item)
		end

	set_deftype (a_value: INTEGER) is
			-- Set member `defType'
		require
			exists: exists
		do
			set_deftype_external (item, a_value)
		ensure
			a_value_set: a_value = deftype
		end

end
