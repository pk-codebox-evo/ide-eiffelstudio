note
	description: "[
		Floating point failure
		]"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FLOATING_POINT_FAILURE

inherit
	HARDWARE_EXCEPTION

feature -- Access

	frozen code: INTEGER
			-- Exception code
		do
			Result := {EXCEP_CONST}.floating_point_exception
		end

	tag: IMMUTABLE_STRING_32
			-- <Precursor>
		once
			create Result.make_from_string_8 ("Floating point exception.")
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
