note
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EVENTS_TAB

inherit
	EVENTS_TAB_IMP
	
	GRID_ACCESSOR
		undefine
			copy, default_create, is_equal
		end

feature {NONE} -- Initialization

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			no_events_button.select_actions.block
			no_events_button.enable_select
			no_events_button.select_actions.resume
		end
		
feature -- Events

	motion_item_event (an_x, a_y: INTEGER; an_item: EV_GRID_ITEM)
			-- Respond to a pointer motion at the grid level.
		local
			l_string: STRING
		do
			l_string := "Pointer_motion_item_actions : " + an_x.out + ", " +a_y.out
			if an_item /= Void then
				l_string.append (". Item : " + an_item.column.index.out + ", " + an_item.row.index.out)
			else
				l_string.append (". No item")
			end
			add_event_item_to_list (l_string)
		end

	motion_event (an_x, a_y: INTEGER)
			-- Respond to a pointer motion at the widget level.
		local
			l_string: STRING
		do
			l_string := "Pointer_motion_actions : " + an_x.out + ", " + a_y.out
			add_event_item_to_list (l_string)
		end

	item_motion_event (an_x, a_y: INTEGER; a1, a2, a3: DOUBLE; i1, i2: INTEGER; an_item: EV_GRID_ITEM)
			-- Respond to a pointer motion at the item level.
		local
			l_string: STRING
		do
			l_string := "Item.pointer_motion_actions : " + an_x.out + ", " + a_y.out
			if an_item /= Void then
				l_string.append (". Item : " + an_item.column.index.out + ", " + an_item.row.index.out)
			else
				l_string.append (". No item")
			end
			add_event_item_to_list (l_string)
		end

	press_item_event (an_x, a_y, a_button: INTEGER; an_item: EV_GRID_ITEM)
			-- Respond to a pointer press at the grid level.
		local
			l_string: STRING
		do
			l_string := "Pointer_button_press_item_actions : " + an_x.out + ", " +a_y.out + " Button : " + a_button.out
			if an_item /= Void then
				l_string.append (". Item : " + an_item.column.index.out + ", " + an_item.row.index.out)
			else
				l_string.append (". No item")
			end
			add_event_item_to_list (l_string)
		end

	press_event (an_x, a_y, a_button: INTEGER)
			-- Respond to a pointer press at the widget level.
		local
			l_string: STRING
		do
			l_string := "Pointer_button_press_actions : " + an_x.out + ", " +a_y.out + " Button : " + a_button.out
			add_event_item_to_list (l_string)
		end

	item_press_event (an_x, a_y, a_button: INTEGER)
			-- Respond to a pointer press at the item level.
		local
			l_string: STRING
		do
			l_string := "Item.pointer_button_press_actions : " + an_x.out + ", " +a_y.out + " Button : " + a_button.out
			add_event_item_to_list (l_string)
		end
		
	item_enter_event
			-- Respond to a pointer enter at the item level.
		local
			l_string: STRING
		do
			l_string := "Item.pointer_enter_actions"
			add_event_item_to_list (l_string)
		end
		
	item_leave_event
			-- Respond to a pointer leave at the item level.
		local
			l_string: STRING
		do
			l_string := "Item.pointer_leave_actions"
			add_event_item_to_list (l_string)
		end
		
	double_press_item_event (an_x, a_y, a_button: INTEGER; an_item: EV_GRID_ITEM)
			-- Respond to a pointer double press at the grid level.
		local
			l_string: STRING
		do
			l_string := "Pointer_button_press_item_actions : " + an_x.out + ", " +a_y.out + " Button : " + a_button.out
			if an_item /= Void then
				l_string.append (". Item : " + an_item.column.index.out + ", " + an_item.row.index.out)
			else
				l_string.append (". No item")
			end
			add_event_item_to_list (l_string)
		end

	double_press_event (an_x, a_y, a_button: INTEGER)
			-- Respond to a pointer double press at the widget level.
		local
			l_string: STRING
		do
			l_string := "Pointer_double_press_actions : " + an_x.out + ", " +a_y.out + " Button : " + a_button.out
			add_event_item_to_list (l_string)
		end

	item_double_press_event (an_x, a_y, a_button: INTEGER)
			-- Respond to a pointer double_press at the item level.
		local
			l_string: STRING
		do
			l_string := "Item.pointer_double_press_actions : " + an_x.out + ", " +a_y.out + " Button : " + a_button.out
			add_event_item_to_list (l_string)
		end

	release_item_event (an_x, a_y, a_button: INTEGER; an_item: EV_GRID_ITEM)
			-- Respond to a pointer release at the grid level.
		local
			l_string: STRING
		do
			l_string := "Pointer_release_item_actions : " + an_x.out + ", " +a_y.out + " Button : " + a_button.out
			if an_item /= Void then
				l_string.append (". Item : " + an_item.column.index.out + ", " + an_item.row.index.out)
			else
				l_string.append (". No item")
			end
			add_event_item_to_list (l_string)
		end

	release_event (an_x, a_y, a_button: INTEGER)
			-- Respond to a pointer release at the widget level.
		local
			l_string: STRING
		do
			l_string := "Pointer_release_actions : " + an_x.out + ", " +a_y.out + " Button : " + a_button.out
			add_event_item_to_list (l_string)
		end

	item_release_event (an_x, a_y, a_button: INTEGER)
			-- Respond to a pointer release at the item level.
		local
			l_string: STRING
		do
			l_string := "Item.pointer_release_actions : " + an_x.out + ", " +a_y.out + " Button : " + a_button.out
			add_event_item_to_list (l_string)
		end

	pointer_enter_event (on_grid: BOOLEAN; an_item: EV_GRID_ITEM)
			--
		local
			l_string: STRING
		do
			l_string := "Pointer_enter_actions"
			if an_item /= Void then
				l_string.append (". Item : " + an_item.column.index.out + ", " + an_item.row.index.out)
			else
				l_string.append (". No item")
			end
			add_event_item_to_list (l_string)
		end

	pointer_leave_event (on_grid: BOOLEAN; an_item: EV_GRID_ITEM)
			--
		local
			l_string: STRING
		do
			l_string := "Pointer_leave_actions"
			if an_item /= Void then
				l_string.append (". Item : " + an_item.column.index.out + ", " + an_item.row.index.out)
			else
				l_string.append (". No item")
			end
			add_event_item_to_list (l_string)
		end
		
	mouse_wheel_event (a_value: INTEGER)
			--
		do
			add_event_item_to_list ("Mouse_wheel_actions " + a_value.out)
		end
		
	key_press_event (a_key: EV_KEY)
			--
		do
			add_event_item_to_list ("Key_press_actions " + a_key.code.out)
		end
		
	key_press_string_event (a_key: STRING)
			--
		do
			add_event_item_to_list ("Key_press_string_actions " + a_key.out)
		end
		
	key_release_event (a_key: EV_KEY)
			--
		do
			add_event_item_to_list ("Key_release_actions " + a_key.out)
		end
		
	focus_in_event
			--
		do
			add_event_item_to_list ("Focus_in_actions")
		end
		
	focus_out_event
			--
		do
			add_event_item_to_list ("Focus_out_actions")
		end
		
	resize_event (an_x, a_y, a_width, a_height: INTEGER)
			--
		do
			add_event_item_to_list ("Resize_actions " + an_x.out + " " + a_y.out + " " + a_width.out + " " + a_height.out)
		end
		
	row_collapsed (a_row: EV_GRID_ROW)
			--
		do
			add_event_item_to_list ("Row " + a_row.index.out + " collapsed.")
		end
		
	row_expanded (a_row: EV_GRID_ROW)
			--
		do
			add_event_item_to_list ("Row " + a_row.index.out + " expanded.")
		end
		
	item_selected (an_item: EV_GRID_ITEM)
			--
		do
			add_event_item_to_list ("Item at row " + an_item.row.index.out + ", column " + an_item.column.index.out + " selected.")
		end
		
	item_deselected (an_item: EV_GRID_ITEM)
			--
		do
			add_event_item_to_list ("Item at row " + an_item.row.index.out + ", column " + an_item.column.index.out + " deselected.")
		end

	item_activated (an_item: EV_GRID_ITEM; a_window: EV_POPUP_WINDOW)
			--
		do
			add_event_item_to_list ("Item at row " + an_item.row.index.out + ", column " + an_item.column.index.out + " activated.")
		end
		
	item_deactivated (an_item: EV_GRID_ITEM; a_window: EV_POPUP_WINDOW)
			--
		do
			add_event_item_to_list ("Item at row " + an_item.row.index.out + ", column " + an_item.column.index.out + " deactivated.")
		end		
	
	row_selected (a_row: EV_GRID_ROW)
			--
		do
			add_event_item_to_list ("Row " + a_row.index.out + " selected.")
		end
		
	row_deselected (a_row: EV_GRID_ROW)
			--
		do
			add_event_item_to_list ("Row " + a_row.index.out + " deselected.")
		end
		
	column_selected (a_column: EV_GRID_COLUMN)
			--
		do
			add_event_item_to_list ("Column " + a_column.index.out + " selected.")
		end
		
	column_deselected (a_column: EV_GRID_COLUMN)
			--
		do
			add_event_item_to_list ("Column " + a_column.index.out + " deselected.")
		end

	add_event_item_to_list (a_string: STRING)
			--
		local
			list_item: EV_LIST_ITEM
		do
			create list_item.make_with_text (a_string)
			if event_list.count > 50 then
				event_list.wipe_out
			end
			event_list.extend (list_item)
			if event_list.is_displayed then
				event_list.ensure_item_visible (list_item)
			end
		end

	motion_highlight_event (an_x, a_y: INTEGER; an_item: EV_GRID_ITEM)
			--
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			if an_item /= Void then
				label_item ?= an_item
--				if label_item /= Void then
--					label_item.set_font (small_font)
--				end
				an_item.enable_select
			end
		end
		
	motion_event_in_item (an_x, a_y: INTEGER; an_item: EV_GRID_ITEM)
			--
		local
			l_string: STRING
			textable:  EV_TEXTABLE
		do
			textable ?= an_item
			if textable /= Void then
				l_string := "Motion : " + (an_x - an_item.virtual_x_position).out + ", " + (a_y - an_item.virtual_y_position).out
				textable.set_text (l_string)
			end
		end
		
		
	small_font: EV_FONT
			--
		once
			create Result
			Result.set_height (6)
		end
		

feature {NONE} -- Implementation

	
	highlight_items_on_motion_selected
			-- Called by `select_item_actions' of `highlight_items_on_motion'.
		do
			disable_event_tracking
			disable_item_event_tracking
			event_list.disable_sensitive
--			grid.pointer_motion_item_actions.extend (agent motion_event)
			if highlight_items_on_motion.is_selected then
				grid.pointer_motion_item_actions.extend (agent motion_highlight_event)
			end
		end
	
	show_events_in_items_selected
			-- Called by `select_item_actions' of `show_events_in_items'.
		do
			disable_event_tracking
			disable_item_event_tracking
			event_list.disable_sensitive
--			grid.pointer_motion_item_actions.wipe_out
--			grid.pointer_motion_item_actions.extend (agent motion_event)
			if show_events_in_items.is_selected then
				grid.pointer_motion_item_actions.extend (agent motion_event_in_item)
			end
		end

	no_events_button_selected
			-- Called by `select_actions' of `no_events_button'.
		do
			event_list.disable_sensitive
			event_list.wipe_out
			disable_event_tracking
			disable_item_event_tracking
		end

	enable_event_tracking_selected
			-- Called by `select_actions' of `enable_event_tracking'.
		do
			event_list.enable_sensitive
			disable_event_tracking
			disable_item_event_tracking

				-- Now connect all events
			grid.pointer_motion_item_actions.extend (agent motion_item_event)
			grid.pointer_motion_actions.force_extend (agent motion_event)

			grid.pointer_button_press_item_actions.extend (agent press_item_event)
			grid.pointer_button_press_actions.force_extend (agent press_event)

			grid.pointer_double_press_item_actions.extend (agent double_press_item_event)
			grid.pointer_double_press_actions.force_extend (agent double_press_event)
			
			grid.pointer_button_release_item_actions.extend (agent release_item_event)
			grid.pointer_button_release_actions.force_extend (agent release_event)

			grid.pointer_enter_item_actions.extend (agent pointer_enter_event)
			grid.pointer_leave_item_actions.extend (agent pointer_leave_event)
			grid.mouse_wheel_actions.extend (agent mouse_wheel_event)
			grid.key_press_actions.extend (agent key_press_event)
			grid.key_press_string_actions.extend (agent key_press_string_event)
			grid.key_release_actions.extend (agent key_release_event)
			grid.focus_in_actions.extend (agent focus_in_event)
			grid.focus_out_actions.extend (agent focus_out_event)
			grid.resize_actions.extend (agent resize_event)
			grid.row_expand_actions.extend (agent row_expanded)
			grid.row_collapse_actions.extend (agent row_collapsed)
			grid.item_select_actions.extend (agent item_selected)
			grid.item_deselect_actions.extend (agent item_deselected)
			grid.row_select_actions.extend (agent row_selected)
			grid.row_deselect_actions.extend (agent row_deselected)
			grid.column_select_actions.extend (agent column_selected)
			grid.column_deselect_actions.extend (agent column_deselected)
			grid.item_activate_actions.extend (agent item_activated)
			grid.item_deactivate_actions.extend (agent item_deactivated)			
		end

	disable_event_tracking
			-- Ensure no events are tracked on the grid.
		do
				-- Now connect all events
			grid.pointer_motion_item_actions.wipe_out
			grid.pointer_motion_actions.wipe_out

			grid.pointer_button_press_item_actions.wipe_out
			grid.pointer_button_press_actions.wipe_out

			grid.pointer_double_press_item_actions.wipe_out
			grid.pointer_double_press_actions.wipe_out
			
			grid.pointer_button_release_item_actions.wipe_out
			grid.pointer_button_release_actions.wipe_out

			grid.pointer_enter_item_actions.wipe_out
			grid.pointer_leave_item_actions.wipe_out
			grid.mouse_wheel_actions.wipe_out
			grid.key_press_actions.wipe_out
			grid.key_press_string_actions.wipe_out
			grid.key_release_actions.wipe_out
			grid.focus_in_actions.wipe_out
			grid.focus_out_actions.wipe_out
			grid.resize_actions.wipe_out
			grid.row_expand_actions.wipe_out
			grid.row_collapse_actions.wipe_out
			grid.item_select_actions.wipe_out
			grid.item_deselect_actions.wipe_out
			grid.row_select_actions.wipe_out
			grid.row_deselect_actions.wipe_out
			grid.column_select_actions.wipe_out
			grid.column_deselect_actions.wipe_out
			grid.item_activate_actions.wipe_out
			grid.item_deactivate_actions.wipe_out	
		end

	enable_event_tracking_item_selected
			-- Called by `select_actions' of `enable_event_tracking_item'.
		local
			l_x, l_y: INTEGER
			current_item: EV_GRID_ITEM
			current_row: EV_GRID_ROW
			current_column: EV_GRID_COLUMN
		do
			disable_event_tracking
			disable_item_event_tracking
			event_list.enable_sensitive
				-- First connect to all items.
			from
				l_x := 1
			until
				l_x > grid.column_count
			loop
				from
					l_y := 1
				until
					l_y > grid.row_count
				loop
					current_item := grid.item (l_x, l_y)
					if current_item /= Void then
						current_item.pointer_motion_actions.force_extend (agent item_motion_event (?, ?, ?, ?, ?, ?, ?, current_item))
						current_item.pointer_button_press_actions.force_extend (agent item_press_event)
						current_item.pointer_double_press_actions.force_extend (agent item_double_press_event)
						current_item.pointer_button_release_actions.force_extend (agent item_release_event)
						current_item.pointer_enter_actions.force_extend (agent item_enter_event)
						current_item.pointer_leave_actions.force_extend (agent item_leave_event)
						current_item.select_actions.extend (agent item_selected (current_item))
						current_item.deselect_actions.extend (agent item_deselected (current_item))
--						current_item.activate_actions.extend (agent item_activated (current_item))
--						current_item.deactivate_actions.extend (agent item_deactivated (current_item))
					end
					l_y := l_y + 1
				end
				l_x := l_x + 1
			end
				-- Now conenct to all rows
			from
				l_y := 1
			until
				l_y > grid.row_count
			loop
				current_row := grid.row (l_y)
				current_row.expand_actions.extend (agent row_expanded (current_row))
				current_row.collapse_actions.extend (agent row_collapsed (current_row))
				current_row.select_actions.extend (agent row_selected (current_row))
				current_row.deselect_actions.extend (agent row_deselected (current_row))
		
				l_y := l_y + 1
			end

				-- Now conenct to all Columns
			from
				l_x := 1
			until
				l_x > grid.column_count
			loop
				current_column := grid.column (l_x)
				current_column.select_actions.extend (agent column_selected (current_column))
				current_column.deselect_actions.extend (agent column_deselected (current_column))
		
				l_x := l_x + 1
			end
		end

	disable_item_event_tracking
			-- Ensure no events are tracked on the grid items.
		local
			l_x, l_y: INTEGER
			current_item: EV_GRID_ITEM
			current_row: EV_GRID_ROW
			current_column: EV_GRID_COLUMN
		do
				-- First connect to all items.
			from
				l_x := 1
			until
				l_x > grid.column_count
			loop
				from
					l_y := 1
				until
					l_y > grid.row_count
				loop
					current_item := grid.item (l_x, l_y)
					if current_item /= Void then
						current_item.pointer_motion_actions.wipe_out
						current_item.pointer_button_press_actions.wipe_out
						current_item.pointer_double_press_actions.wipe_out
						current_item.pointer_button_release_actions.wipe_out
						current_item.pointer_enter_actions.wipe_out
						current_item.pointer_leave_actions.wipe_out
						current_item.select_actions.wipe_out
						current_item.deselect_actions.wipe_out
--						current_item.activate_actions.wipe_out
--						current_item.deactivate_actions.wipe_out
					end
					l_y := l_y + 1
				end
				l_x := l_x + 1
			end
				-- Now conenct to all rows
			from
				l_y := 1
			until
				l_y > grid.row_count
			loop
				current_row := grid.row (l_y)
				current_row.expand_actions.wipe_out
				current_row.collapse_actions.wipe_out
				current_row.select_actions.wipe_out
				current_row.deselect_actions.wipe_out
		
				l_y := l_y + 1
			end

				-- Now conenct to all Columns
			from
				l_x := 1
			until
				l_x > grid.column_count
			loop
				current_column := grid.column (l_x)
				current_column.select_actions.wipe_out
				current_column.deselect_actions.wipe_out
		
				l_x := l_x + 1
			end
		end
		
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class EVENTS_TAB

