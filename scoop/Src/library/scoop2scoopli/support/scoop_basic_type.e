indexing
	description: "Summary description for {SCOOP_BASIC_CLASS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_BASIC_TYPE

feature -- Basic type declaration

	is_basic_type (a_name: STRING): BOOLEAN is
			-- Is `a_class_type' a special type (such as ARRAY, STRING, HASHABLE, that are treated as special by EiffelStudio)?
			-- Such classes should not inherit from SCOOP_SEPARATE_CLIENT, otherwise EiffelStudio reports a library error.
		require
			a_name /= Void
		do
			if a_name.is_equal ("ANY")
				or else a_name.is_equal ("ARRAY")
				or else a_name.is_equal ("STRING")
				or else a_name.is_equal ("STRING_HANDLER")
				or else a_name.is_equal ("TO_SPECIAL")
				or else a_name.is_equal ("HASHABLE")
				or else a_name.is_equal ("MISMATCH_CORRECTOR")
				or else a_name.is_equal ("PART_COMPARABLE")
				or else a_name.is_equal ("REFACTORING_HELPER")
				or else a_name.is_equal ("DEBUG_OUTPUT")
				or else a_name.is_equal ("CONTAINER")
				or else a_name.is_equal ("INTERNAL")
				or else a_name.is_equal ("EXCEP_CONST")
			then
				Result := True
			else
				Result := False
			end
		end

end
