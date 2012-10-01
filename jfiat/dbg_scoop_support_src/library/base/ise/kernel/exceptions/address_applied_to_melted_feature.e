note
	description: "[
		Exception raised when $ is applied to melted feature
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	ADDRESS_APPLIED_TO_MELTED_FEATURE

inherit
	EIFFELSTUDIO_SPECIFIC_LANGUAGE_EXCEPTION

feature -- Access

	frozen code: INTEGER
			-- Exception code
		do
			Result := {EXCEP_CONST}.dollar_applied_to_melted_feature
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING = "CECIL cannot call melted code."

end
