indexing
	description: "STRING_MANIPULATOR_COCLASS Implementation."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	STRING_MANIPULATOR_COCLASS_IMP

inherit
	STRING_MANIPULATOR_COCLASS
		redefine
			string_user_precondition,
			replace_substring_user_precondition,
			prune_all_user_precondition
		end

	ECOM_EXCEPTION
	
creation
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
			Result := local_string
		end

	string_user_precondition: BOOLEAN is
			-- Precondition of `string'.
		do
			Result := local_string /= Void
		end

	replace_substring_user_precondition (s: STRING; start_pos: INTEGER; end_pos: INTEGER): BOOLEAN is
			-- Precondition of `replace_substring'.
		do
			Result := local_string /= Void
		end

	prune_all_user_precondition (c: CHARACTER): BOOLEAN is
			-- Precondition of `prune_all'.
		do
			Result := local_string /= Void
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
			local_string.replace_substring (s, start_pos, end_pos)
		end

	prune_all (c: CHARACTER) is
			-- Remove all occurrences of `c'.
			-- `c' [in].  
		do
			local_string.prune_all (c)
		ensure then
			pruned: not local_string.has (c)
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end


feature {NONE} -- Implementation

	local_string: STRING
	
feature {NONE}  -- Externals

	ccom_create_item (eif_object: STRING_MANIPULATOR_COCLASS): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_StringManipulatorLib::StringManipulator  %"ecom_StringManipulatorLib_StringManipulator_s.h%"](EIF_OBJECT)"
		end


end -- STRING_MANIPULATOR_COCLASS_IMP

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-2001.
--| Modifications and extensions: copyright (C) ISE, 2001.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

