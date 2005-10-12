indexing
	description: "Objects that represents a GRID containing Object values (for debugging)"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_OBJECTS_GRID

inherit
	ES_GRID
		redefine
			initialize, grid_menu
		end

create
	make_with_name

feature {NONE} -- Initialization

	make_with_name (a_name: STRING) is
			-- Create current with a_name and a_tool
		do
			default_create
			name := a_name
			enable_single_row_selection
			enable_border
		end
		
	initialize is
		do
			Precursor {ES_GRID}

			enable_tree
			enable_row_height_fixed

			enable_partial_dynamic_content
			set_dynamic_content_function (agent compute_grid_item)

			row_expand_actions.extend (agent on_row_expand)
			row_collapse_actions.extend (agent on_row_collapse)
			set_item_pebble_function (agent on_pebble_function)
			set_item_accept_cursor_function (agent on_pnd_accept_cursor_function)
			set_item_deny_cursor_function (agent on_pnd_deny_cursor_function)
			pointer_double_press_item_actions.extend (agent on_pointer_double_press_item)
		end
		
feature -- Properties

	name: STRING
			-- associated name to identify the related grid.

feature -- Access

	grid_menu: EV_MENU is
		local
			mci: EV_CHECK_MENU_ITEM
		do
			if layout_manager /= Void then
				create Result.make_with_text ("Grid " + name)
				create mci.make_with_text ("Keep grid layout")
				if is_layout_managed then
					mci.enable_select
					mci.select_actions.extend (agent disable_layout_management)
				else
					mci.select_actions.extend (agent enable_layout_management)
				end
				Result.extend (mci)
			end
		end

feature -- Query

	grid_pebble_from_cell (a_cell: EV_GRID_ITEM): ANY is
			-- Return pebble which may be contained in `a_cell'
		do
				--| Nota: At this point we could try to return 
				--| special stone depending of the clicked cell
			Result := grid_pebble_from_row (a_cell.row)
		end
		
	grid_pebble_from_row (a_row: EV_GRID_ROW): ANY is
			-- Return pebble which may be contained in `a_row'
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			if a_row /= Void then
				ctler ?= a_row.data
				if ctler /= Void then
					Result := ctler.pebble
				end
			end
		end

feature {NONE} -- Actions implementation
		
	on_pebble_function (a_item: EV_GRID_ITEM): ANY is
		do
			if 
				not ev_application.ctrl_pressed
				and a_item /= Void 
			then
				Result := grid_pebble_from_cell (a_item)
			end
		end

	on_pnd_accept_cursor_function (a_item: EV_GRID_ITEM): EV_CURSOR is
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			if a_item /= Void then
				ctler ?= a_item.row.data
				if ctler /= Void then
					Result := ctler.pnd_accept_cursor
				end
			end
		end

	on_pnd_deny_cursor_function (a_item: EV_GRID_ITEM): EV_CURSOR is
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			if a_item /= Void then
				ctler ?= a_item.row.data
				if ctler /= Void then
					Result := ctler.pnd_deny_cursor
				end
			end
		end
		
	on_pointer_double_press_item (ax,ay,ab: INTEGER; a_item: EV_GRID_ITEM) is
		local
			ei: ES_OBJECTS_GRID_CELL
		do
			if ab = 1 then
				ei ?= a_item
				if ei /= Void then
					grid_activate (ei)
				end
			end
		end
		
	on_row_expand (a_row: EV_GRID_ROW) is
		require
			a_row /= Void
			row_related_to_current: a_row.parent = Current
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			ctler ?= a_row.data
			if ctler /= Void then
				ctler.call_expand_actions (a_row)
				process_columns_auto_resizing
			end
			request_columns_auto_resizing			
		end

	on_row_collapse (a_row: EV_GRID_ROW) is
		require
			a_row /= Void
			row_related_to_current: a_row.parent = Current
		local
			ctler: ES_GRID_ROW_CONTROLLER
		do
			ctler ?= a_row.data
			if ctler /= Void then
				ctler.call_collapse_actions (a_row)
			end
			request_columns_auto_resizing
		end

	compute_grid_item (c, r: INTEGER): EV_GRID_ITEM is
		local
			a_row: EV_GRID_ROW
			obj_item: ES_OBJECTS_GRID_LINE
		do
debug ("debugger_interface")
	print (generator + ".compute_grid_item ("+c.out+", "+r.out+") %N")
end
			if not is_processing_remove_and_clear_all_rows then
				if c <= column_count and r <= row_count then
					Result := item (c, r)
				end
				if Result = Void then
					a_row := row (r)
					obj_item ?= a_row.data
					if obj_item /= Void then
						if not obj_item.compute_grid_display_done then
							Result := obj_item.computed_grid_item (c)
-- We don't return the item, since they have already been added to the grid ...
--							if 0 < c and c <= a_row.count then
--								Result := a_row.item (c)
--							end
						else
								--| line already computed .. but still missing cells
								--| then we fill with empty cells
							create Result
						end
					else
						create Result
					end
				end
				request_columns_auto_resizing
			end
		end

feature -- Layout manager

	layout_preference: BOOLEAN_PREFERENCE
	
	on_layout_preferenced_changed is
		do
			if layout_preference.value then
				if not is_layout_managed then
					enable_layout_management
				end
			else
				if is_layout_managed then
					disable_layout_management
				end
			end
		end
	
	initialize_layout_management (v: BOOLEAN_PREFERENCE) is
		require
			layout_manager_void: layout_manager = Void
			layout_preference = Void
		do
			layout_preference := v
			create layout_manager.make (Current, name)
			if layout_preference /= Void then
				layout_preference.change_actions.extend (agent on_layout_preferenced_changed)
				on_layout_preferenced_changed				
			end
		end

	reset_layout_recorded_values is
		do
			if layout_manager /= Void then
				layout_manager.reset_layout_recorded_values
			end
		end

	clear_layout_manager is
		do
			if layout_manager /= Void then
				layout_manager.wipe_out
			end
		end

	enable_layout_management is
		do
			if layout_manager /= Void then
				layout_manager.enable
				is_layout_managed := True
				if 
					layout_preference /= Void
					and then layout_preference.value /= is_layout_managed 
				then
					layout_preference.set_value (is_layout_managed)
				end
			end
		end

	disable_layout_management is
		do
			if layout_manager /= Void then
				layout_manager.disable
			end
			is_layout_managed := False
			if 
				layout_preference /= Void
				and then layout_preference.value /= is_layout_managed 
			then
				layout_preference.set_value (is_layout_managed)
			end
		end

	is_layout_managed: BOOLEAN

	layout_manager: ES_OBJECTS_GRID_LAYOUT_MANAGER

	record_layout is
		do
			if is_layout_managed and layout_manager /= Void then
				layout_manager.record
			end
		end
		
	restore_layout is
		do
			if is_layout_managed and layout_manager /= Void then
				layout_manager.restore
			end
		end

end
