indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end

creation
	make

feature -- Initialization

	make(par: EV_CONTAINER) is
			-- Create the tab and initalise the objects.
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
				-- Commands used by the tab.
			
		do
		{ANY_TAB} Precursor (Void)

		create cmd2.make (~rows)
		create f1.make (Current, "Rows", Void, cmd2)	
		create cmd2.make (~selected)
		create f2.make (Current, "Selected", Void, cmd2)
		create cmd2.make (~selected_items)
		create f3.make (Current, "Selected Items", cmd2, cmd2)
		create cmd1.make (~get_item)
		create f4.make (Current, "Item", cmd1, cmd1)
		create cmd1.make (~select_item)
		create f5.make (Current, "Select Item", cmd1, cmd1)
		create cmd1.make (~deselect_item)
		create f6.make (Current, "Deselect Item", cmd1, cmd1)
		create cmd1.make (~clear_selection)
		create b1.make_with_text (Current, "Clear Selection")
		b1.set_vertical_resize (False)
		b1.add_click_command (cmd1, Void)
		create cmd1.make (~toggle_selection_type)
		create b2.make_with_text (Current, "Currently Multiple Selection. Click To Change.")
		b2.set_vertical_resize (False)
		b2.add_click_command (cmd1, Void)
		create cmd1.make (~clear_items)
		create b3.make_with_text (Current, "Clear Items")
		b3.set_vertical_resize (False)
		b3.add_click_command (cmd1, Void)
		create cmd1.make (~add_item)
		create b4.make_with_text (Current, "Add Item")
		b4.set_vertical_resize (False)
		b4.add_click_command (cmd1, Void)
		set_parent (par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab.
		do
			Result:="List"
		ensure then
			result_exists: Result /= Void
		end

	current_widget: EV_LIST
		-- The current demo.

	f1,f2,f3,f4,f5,f6: TEXT_FEATURE_MODIFIER
		--  A feature modifier for the action window.

	b1,b2,b3,b4: EV_BUTTON
		-- A button for the action window.

feature -- Execution Feature

	rows (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Return the number of rows in the list.
		do
			f1.set_text(current_widget.count.out)	
		end

	selected_items (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Return the selected items.
		local
			item_list: LINKED_LIST[EV_LIST_ITEM]
			output_string: STRING
		do
			item_list:= current_widget.selected_items
			from
				item_list.start
				create output_string.make(0)
			until
				item_list.off
			loop
				output_string.append_string(item_list.item.text)
				if not item_list.islast then
					output_string.append_string(", ")
				end
				item_list.forth
			end
			f3.set_text (output_string)
		end

	selected (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Return the selected item.
			-- Does not work in multiple selection mode.
		do
			if not current_widget.is_multiple_selection then
				f2.set_text (current_widget.selected_item.text)
			end
		end

	get_item (arg: EV_ARGUMENT; data:  EV_EVENT_DATA) is
			-- Returns an element of the list.
		do
			if f4.get_text.is_integer and f4.get_text.to_integer >=0 
			and f4.get_text.to_integer <= current_widget.count then
				f4.set_text (current_widget.get_item (f4.get_text.to_integer).text)
			end
		end

	select_item (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Selects an element of the list.
		do
			if f5.get_text.is_integer and f5.get_text.to_integer >= 0 
			and f5.get_text.to_integer <= current_widget.count then
				current_widget.select_item (f5.get_text.to_integer)
			end
		end

	deselect_item (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Deselect and item in the list.
		do
			if f6.get_text.is_integer and f6.get_text.to_integer >0
			and f6.get_text.to_integer <= current_widget.count then
				current_widget.deselect_item (f6.get_text.to_integer)
			end
		end

	clear_selection (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Clears the selection.
		do
			current_widget.clear_selection	
		end

	toggle_selection_type (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Toggles the selection type between single and multiple.
		do
			if current_widget.is_multiple_selection then
				current_widget.set_single_selection
				b2.set_text ("Currently Single Selection. Click To Change.")
			else
				current_widget.set_multiple_selection
				b2.set_text ("Currently Multiple Selection. Click To Change.")
			end
		end

	clear_items (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Clears the list.
		do
			current_widget.clear_items
		end

	add_item (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Adds an item to the list.
		local
			new_item :EV_LIST_ITEM
			text_string: STRING
		do
			text_string:= "Item "
			text_string.append_string ((current_widget.count + 1).out)
			create new_item.make_with_text (current_widget, text_string)
			
		end
end -- class TEXT_TAB
 

