indexing
	description: 
		"EiffelVision menu box. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_MENU_IMP
	
inherit
	EV_MENU_I

	EV_MENU_ITEM_CONTAINER_IMP

	WEL_MENU
		rename
			make as wel_make
		end

creation
	make_with_text

feature {NONE} -- Initialization
	
	make_with_text (par: EV_MENU_CONTAINER; label: STRING) is
			-- Create the control window and the menu inside. 
		local
			par_imp: EV_MENU_CONTAINER_IMP
		do
			wel_make
			par_imp ?= par.implementation
			check
				valid_container: par_imp /= Void
			end
			ev_children := par_imp.ev_children
			set_text (label)
		end	

feature -- Status report

	text: STRING
		-- Label of the current menu

	destroyed: BOOLEAN is
			-- Is Current object destroyed?  
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Status setting

	set_text (str:STRING) is
			-- Set `text' to `str'
		do
			text := str
		end

	destroy is
			-- Destroy actual object.
		do
			check
				not_yet_implemented: False
			end
		end

feature {EV_MENU_ITEM_CONTAINER_IMP} -- Implementation

	submenu: WEL_MENU is
			-- Wel menu used when the item is a sub-menu.
		do
			Result := Current
		end

end -- class EV_MENU_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
