-- This file has been generated by EWG. Do not edit. Changes will be lost!

class DATA_BROWSER_CALLBACKS_STRUCT

inherit

	EWG_STRUCT

	DATA_BROWSER_CALLBACKS_STRUCT_EXTERNAL
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

	version: INTEGER is
			-- Access member `version'
		require
			exists: exists
		do
			Result := get_version_external (item)
		ensure
			result_correct: Result = get_version_external (item)
		end

	set_version (a_value: INTEGER) is
			-- Set member `version'
		require
			exists: exists
		do
			set_version_external (item, a_value)
		ensure
			a_value_set: a_value = version
		end

end
