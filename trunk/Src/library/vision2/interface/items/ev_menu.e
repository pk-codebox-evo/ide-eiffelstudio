indexing

	description: 
		"EiffelVision menu. Menu contains menu items several menu items and shows them when the menu is opened."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class EV_MENU

inherit

	EV_MENU_ITEM_CONTAINER 
		redefine
			implementation
		end
creation
	
	make
	
feature {NONE} -- Initialization
	
	make (par: EV_CONTAINER) is         
			-- Create a menu widget with `par' as
                        -- parent
		do
			!EV_MENU_IMP!implementation.make (par)
			widget_make (par)
		end	
	
feature {EV_MENU_ITEM} -- Implementation
	
	implementation: EV_MENU_I	

end -- class EV_MENU
