indexing
	description:
		"A Demo for scroll bar items"
	author: ""
	date: "$Date: 1999/07/21"
	revision: "$Revision$"

class
	SCROLL_BAR_ITEM

	inherit
		DEMO_ITEM
		redefine
			demo_window
		end

creation
	make

feature {NONE} -- Initialization
	make (par:EV_TREE_ITEM_HOLDER) is
			-- Create the item and the demo that goes with it.
		do
			make_with_title (par, "EV_SCROLL_BAR")
		end


	create_demo is
			-- Create the demo window
		do
			!!demo_window.make (demo_page)
		end

feature -- Access

	demo_window: SCROLL_BAR_WINDOW

end -- class SCROLL_BAR_ITEM
 

