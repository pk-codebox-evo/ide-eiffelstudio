note
	description: "Integer preference."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	INTEGER_PREFERENCE

inherit
	TYPED_PREFERENCE [INTEGER]

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature {PREFERENCE_EXPORTER} -- Access

	text_value: STRING_32
			-- String representation of `value'.		
		do
			create Result.make_empty
			Result.append_integer (value)
		end

feature -- Access

	string_type: STRING
			-- String description of this preference type.
		once
			Result := "INTEGER"
		end

feature -- Query

	valid_value_string (a_string: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_string' valid for this preference type to convert into a value?
		do
			Result := a_string.is_integer
		end

feature {PREFERENCES} -- Access

	generating_preference_type: STRING
			-- The generating type of the preference for graphical representation.
		once
			Result := "TEXT"
		end

feature {NONE} -- Implementation

	set_value_from_string (a_value: READABLE_STRING_GENERAL)
			-- Parse the string value `a_value' and set `value'.
		do
			set_value (a_value.to_integer)
		end

	auto_default_value: INTEGER;
			-- Value to use when Current is using auto by default (until real auto is set)

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class INTEGER_PREFERENCE
