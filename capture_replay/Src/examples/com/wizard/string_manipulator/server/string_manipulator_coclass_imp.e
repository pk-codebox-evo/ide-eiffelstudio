indexing
	description: "STRING_MANIPULATOR_COCLASS Implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	STRING_MANIPULATOR_COCLASS_IMP

inherit
	STRING_MANIPULATOR_COCLASS

	ECOM_EXCEPTION

create
	make,
	make_from_pointer

feature {NONE}  -- Initialization

	make is
			-- Creation.
		do
			create local_string.make (0)
		end

	make_from_pointer (cpp_obj: POINTER) is
			-- Creation.
		do
			set_item (cpp_obj)
			make
		end

feature -- Access

	string: STRING is
			-- Manipulated string
		do
			Result := string_imp
		end

feature -- Basic Operations

	set_string (a_string: STRING) is
			-- Set manipulated string with `a_string'.
			-- `a_string' [in].
		do
			local_string := a_string
		ensure then
			string_set: local_string = a_string
		end

	replace_substring (s: STRING; start_pos: INTEGER; end_pos: INTEGER) is
			-- Copy the characters of `s' to positions `start_pos' .. `end_pos'.
			-- `s' [in].
			-- `start_pos' [in].
			-- `end_pos' [in].
		do
			replace_substring_imp (s, start_pos, end_pos)
		end

	prune_all (c: CHARACTER) is
			-- Remove all occurrences of `c'.
			-- `c' [in].
		do
			prune_all_imp (c)
		ensure then
			pruned: not local_string.has (c)
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE} -- Implementation for assertion checking

	string_imp: STRING is
			-- Manipulated string.
		require
			local_string /= Void
		do
			Result := local_string
		end

	replace_substring_imp (s: STRING; start_pos: INTEGER; end_pos: INTEGER) is
			-- Copy the characters of `s' to positions `start_pos' .. `end_pos'.
			-- `s' [in].
			-- `start_pos' [in].
			-- `end_pos' [in].
		require
			local_string /= Void
		do
			local_string.replace_substring (s, start_pos, end_pos)
		end

	prune_all_imp (c: CHARACTER) is
			-- Remove all occurrences of `c'.
			-- `c' [in].
		require
			local_string /= Void
		do
			local_string.prune_all (c)
		ensure then
			pruned: not local_string.has (c)
		end

feature {NONE} -- Implementation

	local_string: STRING

feature {NONE}  -- Externals

	ccom_create_item (eif_object: STRING_MANIPULATOR_COCLASS): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_StringManipulatorLib::StringManipulator  %"ecom_StringManipulatorLib_StringManipulator_s.h%"](EIF_OBJECT)"
		end


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- STRING_MANIPULATOR_COCLASS_IMP

