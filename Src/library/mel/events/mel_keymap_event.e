indexing

	description: 
		"Implementation of XKeymapEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_KEYMAP_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Pointer access

	key_vector: POINTER is
			-- Key vector pointer
		do
			Result := c_event_key_vector (handle)
		end

feature {NONE} -- Implementation

	c_event_key_vector (event_ptr: POINTER): POINTER is
		external
			"C [macro %"events.h%"] (XKeymapEvent *): EIF_POINTER"
		end;

end -- class MEL_KEYMAP_EVENT

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
