
indexing

	description:
		"Directory name abstraction";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class DIRECTORY_NAME

inherit
	PATH_NAME

creation
	make, make_from_string

feature

	is_valid: BOOLEAN is
			-- Is the directory name valid?
		local
			any: ANY
		do
			any := to_c
			Result := eif_is_directory_valid ($any);
		end

feature {NONE} -- Externals

	eif_is_directory_valid (p: POINTER): BOOLEAN is
		external
			"C | %"eif_path_name.h%""
		end

end -- class DIRECTORY_NAME


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

