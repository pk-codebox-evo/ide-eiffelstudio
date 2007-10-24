indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_FIXED_POSITIONER

inherit
	GB_FIXED_POSITIONER_IMP

	GB_CONSTANTS
		undefine
			default_create, copy, is_equal
		end

	EV_STOCK_COLORS
		rename
			implementation as stock_colors_implementation
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make_with_editor

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			set_icon_pixmap (Icon_build_window @ 1)
			set_title ("EV_FIXED child positioner")
		end

	make_with_editor (an_editor: GB_EV_FIXED_EDITOR_CONSTRUCTOR) is
			-- Create `Current' and assign `an_editor' to `editor'.
		local
			list_item: EV_LIST_ITEM
		do
			default_create
			editor := an_editor
			first := editor.first
			create world
			create pixmap
			create status_timer.make_with_interval (50)
			status_timer.actions.extend (agent update_status)

			drawing_area.resize_actions.force_extend (agent draw_widgets)
			grid_visible_control.enable_select
			grid_visible_control.select_actions.force_extend (agent draw_widgets)
			scrollable_area.resize_actions.force_extend (agent set_initial_area_size)

				-- Set resizing behaviour for `split_area'.
			split_area.enable_item_expand (split_area.first)
			split_area.disable_item_expand (split_area.second)

			create projector.make_with_buffer (world, pixmap, drawing_area)
			grid_size_control.change_actions.force_extend (agent draw_widgets)
			grid_size_control.focus_out_actions.extend (agent draw_widgets)
			grid_size_control.return_actions.extend (agent draw_widgets)
			grid_size_control.set_value (20)
			snap_button.enable_select
			from
				first.start
			until
				first.off
			loop
					-- Note that this is slow, as we have to loop through objects
					-- to get a match, while inside this loop.
				list_item := editor.named_list_item_from_widget (first.item)

					-- We must update all other editors referencing `object'.
					-- when an item is selected.
				list_item.select_actions.extend (agent update_editors)
					-- We must also re-draw the widgets when a selection changes,
					-- as the selected widget should be highlighted.
				list_item.select_actions.extend (agent draw_widgets)
				list_item.deselect_actions.extend (agent check_unselect)
				list_item.set_data (first.item)
				list.extend (list_item)
				first.forth
			end
			set_initial_area_size
		end

feature -- Basic operation

	update is
			-- Update `Current' to reflect changes to widgets.
		do
			list.remove_selection
			draw_widgets
		end

feature {NONE} -- Implementation

	editor: GB_EV_FIXED_EDITOR_CONSTRUCTOR
		-- Editor which created `Current'.

	first: EV_FIXED
		-- First object referenced by `editor'.

	set_item_width (widget: EV_WIDGET; a_width: INTEGER) is
			-- Set `width' of `widget' to `a_width'.
		require
			widget_not_void: widget /= Void
		do
			editor.set_item_width (widget, a_width)
		end

	set_item_x_position (widget: EV_WIDGET; an_x_position: INTEGER) is
			-- Set `x_position' of `widget' to `an_x_position'.
		require
			widget_not_void: widget /= Void
		do
			editor.set_item_x_position (widget, an_x_position)
		end

	set_item_height (widget: EV_WIDGET; a_height: INTEGER) is
			-- Set `height' of widget to `a_height'.
		require
			widget_not_void: widget /= Void
		do
			editor.set_item_height (widget, a_height)
		end

	set_item_y_position (widget: EV_WIDGET; a_y_position: INTEGER) is
			-- Set `y_position' of `widget' to `a_y_position'.
		require
			widget_not_void: widget /= Void
		do
			editor.set_item_y_position (widget, a_y_position)
		end

	update_editors is
			-- Update staus of all other editors.
		do
			editor.update_editors
		end

	ok_pressed is
			-- Called by `select_actions' of `ok_button'.
		do
			pre_close_tidy
			hide
		end

feature {NONE} -- Implementation

	pre_close_tidy is
			-- Perform necessary actions before `layout_window'
			-- is destroyed.
		do
			status_timer.destroy
		end

	set_initial_area_size is
			-- Set initial size of `drawing_area' relative to `scrollable_area'
		local
			biggest_x, biggest_y: INTEGER
			widget: EV_WIDGET
		do
			from
				first.start
			until
				first.off
			loop
				widget := first.item
				if widget.x_position + widget.width > biggest_x then
					biggest_x := widget.x_position + widget.width
				end
				if widget.y_position + widget.height > biggest_y then
					biggest_y := widget.y_position + widget.height
				end
				first.forth
			end
			if biggest_x > scrollable_area.width then
				drawing_area.set_minimum_width (biggest_x)
			else
				drawing_area.set_minimum_width (scrollable_area.width)
			end
			if biggest_y > scrollable_area.height then
				drawing_area.set_minimum_height (biggest_y)
			else
				drawing_area.set_minimum_height (scrollable_area.height)
			end
		end

	update_pixmap_size (x, y, a_width, a_height: INTEGER) is
			-- Resize `pixmap' to `width', `height'.
		do
				-- A pixmap is 1x1 as default,
				-- and you can not set the size to 0x0.
				-- Why is this?
			if width >= 1 and height >=1 then
				pixmap.set_size (width, height)
			end
		end

	draw_widgets is
			-- Draw representation of all widgets and grid if shown.
		local
			listi: EV_LIST_ITEM
			relative_pointa, relative_pointb: EV_RELATIVE_POINT
			figure_rectangle: EV_FIGURE_RECTANGLE
		do
				-- Reset `selected_item_index' as it is not
				-- local.
			selected_item_index := 0

				-- Remove all previous figures from `world'.
			world.wipe_out

				-- We must  draw the grid if necessary.
			if grid_visible_control.is_selected then
				draw_grid
			end

			from
				first.start
			until
				first.off
			loop
				listi := list.selected_item
				if list.selected_item /= Void and then first.item = list.selected_item.data then
					selected_item_index := first.index
				else
					create relative_pointa.make_with_position (first.item.x_position, first.item.y_position)
					create relative_pointb.make_with_position (first.item.x_position + first.item.width, first.item.y_position + first.item.height)
					create figure_rectangle.make_with_points (relative_pointa, relative_pointb)
					figure_rectangle.set_foreground_color (black)
					figure_rectangle.remove_background_color
					world.extend (figure_rectangle)
				end
				first.forth
			end

			if selected_item_index > 0 then
				first.go_i_th (selected_item_index)
				create relative_pointa.make_with_position (first.item.x_position, first.item.y_position)
				create relative_pointb.make_with_position (first.item.x_position + first.item.width, first.item.y_position + first.item.height)
				create figure_rectangle.make_with_points (relative_pointa, relative_pointb)
				figure_rectangle.remove_background_color
				figure_rectangle.set_foreground_color (red)
				figure_rectangle.set_line_width (Highlighted_width)
				world.extend (figure_rectangle)
			end

			projector.project
		end

	draw_grid is
			-- Draw snap to grid in `world'.
		local
			counter: INTEGER
			figure_line: EV_FIGURE_LINE
			color: EV_COLOR
			relative_point: EV_RELATIVE_POINT
		do
				-- Create a light green for the grid color.
				create color.make_with_8_bit_rgb (196, 244, 204)
			from
				counter := 0
			until
				counter > drawing_area.width
			loop
				create figure_line.make_with_positions (counter, 0, counter, drawing_area.height)
				figure_line.set_foreground_color (color)
				create relative_point.make_with_position (drawing_area.width, counter)
				world.extend (figure_line)
				counter := counter + grid_size
			end
			from
				counter := 0
			until
				counter > drawing_area.height
			loop
				create figure_line.make_with_positions (0, counter, drawing_area.width, counter)
				figure_line.set_foreground_color (color)
				figure_line.set_foreground_color (color)
				world.extend (figure_line)
				counter := counter + grid_size
			end
		end

	track_movement (x, y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Track `x', `y' position of cursor, and
		local
			widget: EV_WIDGET
			temp: INTEGER
			temp_x: INTEGER
			new_x, new_y: INTEGER
		do
				-- Store `x' and `y' for use elsewhere.
			last_x := x
			last_y := y
				-- We only need to perform this operation if a widget representation
				-- is selected for manipulation.
			if selected_item_index > 0  and not resizing_widget and not moving_widget then
				widget := first.i_th (selected_item_index)
				if close_to (x, y, widget.x_position + widget.width, widget.y_position + widget.height) or
					close_to (x, y, widget.x_position, widget.y_position) then
					if not resizing_widget then
						set_all_pointer_styles (sizenwse_cursor)
					end
				elseif close_to (x, y, widget.x_position, widget.y_position + widget.height) or
					close_to (x, y, widget.x_position + widget.width, widget.y_position) then
					if not resizing_widget then
						set_all_pointer_styles (sizenesw_cursor)
					end
				elseif close_to_line (x, y, widget.y_position + widget.height, widget.x_position + accuracy_value, widget.x_position + widget.width - accuracy_value) or
					close_to_line (x, y, widget.y_position, widget.x_position + accuracy_value, widget.x_position + widget.width - accuracy_value) then
					if not resizing_widget then
						set_all_pointer_styles (sizens_cursor)
					end
				elseif close_to_line (y, x, widget.x_position, widget.y_position + accuracy_value, widget.y_position + widget.height - accuracy_value) or
					close_to_line (y, x, widget.x_position + widget.width, widget.y_position + accuracy_value, widget.y_position + widget.height - accuracy_value) then
					if not resizing_widget then
						set_all_pointer_styles (sizewe_cursor)
					end
				elseif x > widget.x_position and x < widget.x_position + widget.width and y > widget.y_position and y < widget.y_position + widget.height then
					if not resizing_widget then
						set_all_pointer_styles (sizeall_cursor)
					end
				else
					if not resizing_widget or not moving_widget then
						set_all_pointer_styles (standard_cursor)
					end
				end
			end
			if resizing_widget then
					-- Update scrolling status.
				update_scrolling (x, y)
				temp_x := x
				if snap_button.is_selected then
					new_x := temp_x + half_grid_size - ((temp_x + half_grid_size) \\ grid_size)
					new_y := y + half_grid_size - ((y + half_grid_size) \\ grid_size)
				else
					new_x := temp_x
					new_y := y
				end
				widget := first.i_th (selected_item_index)

				if x_scale /= 0 then
				if x_offset = 0 then
					if new_x < widget.x_position + widget.width - widget.minimum_width then
						if widget.x_position + (new_x - widget.x_position) > 0 then
							set_item_width (widget, (widget.width - (new_x - widget.x_position)).max (widget.minimum_width))
							set_item_x_position (widget, (widget.x_position + (new_x - widget.x_position)))
						else
							temp := widget.x_position
							set_item_width (widget, widget.width + temp)
							set_item_x_position (widget, (0))
						end
					else
						temp := widget.width - widget.minimum_width
						set_item_width (widget, widget.width - temp)
						set_item_x_position (widget, widget.x_position + temp)
						end
				else
					set_item_width (widget, (new_x - widget.x_position).max (widget.minimum_width))
				end
				end

				if y_scale /= 0 then
				if y_offset = 0 then
					if new_y < widget.y_position + widget.height - widget.minimum_height then
						if widget.y_position + (new_y - widget.y_position) > 0 then
							set_item_height (widget, (widget.height - (new_y - widget.y_position)).max (widget.minimum_height))
							set_item_y_position (widget, (widget.y_position + (new_y - widget.y_position)))
						else
							temp := widget.y_position
							set_item_height (widget, widget.height + temp)
							set_item_y_position (widget, (0))
						end
					else
						temp := widget.height - widget.minimum_height
						set_item_height (widget, widget.height - temp)
						set_item_y_position (widget, widget.y_position + temp)
					end
				else
					set_item_height (widget, (new_y - widget.y_position).max (widget.minimum_height))
				end
				end
				draw_widgets
			end
			if moving_widget then
				widget := first.i_th (selected_item_index)
					-- Update scrolling status.
				update_scrolling (x, y)
				if snap_button.is_selected then
					new_x := x - (((x - x_offset))  \\ grid_size)
					new_y := y - (((y - y_offset)) \\ grid_size)
				else
					new_x := x
					new_y := y
				end
				if new_x - x_offset > 0 then
					set_item_x_position (widget, new_x - x_offset)
				else
					set_item_x_position (widget, 0)
				end
				if new_y - y_offset > 0 then
					set_item_y_position (widget,  new_y - y_offset)
				else
					set_item_y_position (widget, 0)
				end
				draw_widgets
			end
			update_editors
		end

	x_scrolling_velocity: INTEGER is
			-- `Result' is desired x scrolling velocity based on the last known position
			-- of the mouse pointer.
		do
			if last_x > drawing_area.width and scrolled_x_once and scrolling_x_start = x_right then
				Result := (last_x - drawing_area.width) // 20 + 1
			elseif last_x > scrollable_area.width + scrollable_area.x_offset and scrolling_x_start = x_center then
				Result := (last_x - scrollable_area.width - scrollable_area.x_offset) // 20 + 1
			elseif last_x < scrollable_area.x_offset then
				Result := - ((scrollable_area.x_offset - last_x) //20 + 1)
			end
		end

	y_scrolling_velocity: INTEGER is
			-- `Result' is desired y scrolling velocity based on the last known position
			-- of the mouse pointer.
		do
			if last_y > drawing_area.height and scrolled_y_once and scrolling_y_start = y_bottom then
				Result := (last_y - drawing_area.height) // 20 + 1
			elseif last_y > scrollable_area.height + scrollable_area.y_offset and scrolling_y_start = y_center then
				Result := (last_y - scrollable_area.height - scrollable_area.y_offset) // 20 + 1
			elseif last_y < scrollable_area.y_offset then
				Result := - ((scrollable_area.y_offset - last_y) //20 + 1)
			end
		end

	update_scrolling (x, y: INTEGER) is
			-- Update current scrolling to reflect mouse coordinates `x', `y'.
		do
				-- First deal with the x axis
			if (x > drawing_area.width) and not scrolled_x_once then
				scrolled_x_once := True
				scrolling_x_start := x_right
				start_x_scrolling
			elseif (x > drawing_area.width) and scrolled_x_once and scrolling_x_start = x_right then
				if not scrolling_x then
					start_x_scrolling
				end
			elseif scrolling_x_start = x_right then
				if scrolling_x then
					end_x_scrolling
				end
			end
			if (x > scrollable_area.width + scrollable_area.x_offset) and not scrolled_x_once then
				scrolled_x_once := True
				scrolling_x_start := x_center
				start_x_scrolling
			elseif (x > scrollable_area.width + scrollable_area.x_offset) and scrolled_x_once and scrolling_x_start = x_center then
				if not scrolling_x then
					start_x_scrolling
				end
			elseif scrolling_x_start = x_center then
				if scrolling_x then
					end_x_scrolling
				end
			end
			if x < scrollable_area.x_offset then
				if not scrolling_x then
					start_x_scrolling
				end
			end

				-- Then Y axis.
			if (y > drawing_area.height) and not scrolled_y_once then
				scrolled_y_once := True
				scrolling_y_start := y_bottom
				start_y_scrolling
			elseif (y > drawing_area.height) and scrolled_y_once and scrolling_y_start = y_bottom then
				if not scrolling_y then
					start_y_scrolling
				end
			elseif scrolling_y_start = y_bottom then
				if scrolling_y then
					end_y_scrolling
				end
			end
			if (y > scrollable_area.height + scrollable_area.y_offset) and not scrolled_y_once then
				scrolled_y_once := True
				scrolling_y_start := y_center
				start_y_scrolling
			elseif (y > scrollable_area.height + scrollable_area.y_offset) and scrolled_y_once and scrolling_y_start = y_center then
				if not scrolling_y then
					start_y_scrolling
				end
			elseif scrolling_y_start = y_center then
				if scrolling_y then
					end_y_scrolling
				end
			end
			if y < scrollable_area.y_offset then
				if not scrolling_y then
					start_y_scrolling
				end
			end
		end

	start_x_scrolling is
			-- Begin automatic scrolling on x axis.
		do
			if not scrolling_x then
				if not scrolling_y then
						-- Create a timeout which will repeatedly cause the scrolling to
						-- take place.
					create timeout.make_with_interval (25)
					timeout.actions.extend (agent scroll)
				end
				scrolling_x := True
			end
		end

	start_y_scrolling is
			-- Begin automatic scrolling on y axis.
		do
			if not scrolling_y then
				if not scrolling_x then
						-- Create a timeout which will repeatedly cause the scrolling to
						-- take place.
					create timeout.make_with_interval (25)
					timeout.actions.extend (agent scroll)
				end
				scrolling_y := True
			end
		end

	end_x_scrolling is
			-- End scrolling on x axis.
		do
				-- Only destroy if not scrolling in either
				-- direction. `timeout' controls scrolling in
				-- both directions.
			if not scrolling_y then
				timeout.destroy
			end
			scrolling_x := False
		end

	end_y_scrolling is
			-- End scrolling on y axis.
		do
				-- Only destroy if not scrolling in either
				-- direction. `timeout' controls scrolling in
				-- both directions.
			if not scrolling_x then
				timeout.destroy
			end
			scrolling_y := False
		end

	scroll is
			--
		local
			current_velocity: INTEGER
		do
			current_velocity := x_scrolling_velocity
			if current_velocity > 0 then
				drawing_area.set_minimum_width (drawing_area.width + current_velocity)
			end
				-- Max 0 ensures that if we are scrolling to the left, we do not
				-- move to less than position 0.
			scrollable_area.set_x_offset ((scrollable_area.x_offset + current_velocity).max (0))


			current_velocity := y_scrolling_velocity
			if current_velocity > 0 then
				drawing_area.set_minimum_height (drawing_area.height + current_velocity)

			end
				-- Max 0 ensures that if we are scrolling to the top, we do not
				-- move to less than position 0.
			scrollable_area.set_y_offset ((scrollable_area.y_offset + current_velocity).max (0))
		end

	close_to (current_x, current_y, desired_x, desired_y: INTEGER): BOOLEAN is
			-- Is position `current_x', `current_y' within `accuracy_value' of `desired_x', `desired_y'.
		do
			if (current_x - desired_x).abs < accuracy_value and (current_y - desired_y).abs < accuracy_value then
				Result := True
			end
		end

	close_to_line (coordinate_a, coordinate_b, line_offset, line_start, line_end: INTEGER): BOOLEAN is
		do
			if coordinate_a > line_start and coordinate_a < line_end and (coordinate_b - line_offset).abs < accuracy_value then
				Result := True
			end
		end

	grid_size: INTEGER is
			-- Size of current grid from
			-- `grid_size_control'
		do
			Result := grid_size_control.value
		end

	half_grid_size: INTEGER is
			-- Half size of current grid.
		do
			Result := grid_size // 2
		end

	button_pressed (x, y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- A button has been pressed. If `a_button' = 1 then
			-- check for movement/resizing.
		local
			widget: EV_WIDGET
			list_item: EV_LIST_ITEM
		do
			if selected_item_index > 0 then
				widget := first.i_th (selected_item_index)
				if a_button = 1 and not resizing_widget and not moving_widget then
						-- Unset this, if this is not the case, as we have 8 checks which would need it
						-- assigning otherwise
					resizing_widget := True
					if close_to (x, y, widget.x_position + widget.width, widget.y_position + widget.height) then
						x_offset := widget.width
						y_offset := widget.height
						x_scale := 1; y_scale := 1
					elseif close_to (x, y, widget.x_position, widget.y_position) then
						x_offset := 0
						y_offset := 0
						x_scale := 1; y_scale := 1
					elseif close_to (x, y, widget.x_position, widget.y_position + widget.height) then
						x_offset := 0
						y_offset := widget.height
						x_scale := 1; y_scale := 1
					elseif close_to (x, y, widget.x_position + widget.width, widget.y_position) then
						x_offset := widget.width
						y_offset := 0
						x_scale := 1; y_scale := 1
					elseif close_to_line (x, y, widget.y_position + widget.height, widget.x_position + accuracy_value, widget.x_position + widget.width - accuracy_value) then
						x_offset := x - widget.x_position
						y_offset := widget.height
						x_scale := 0; y_scale := 1
					elseif close_to_line (x, y, widget.y_position, widget.x_position + accuracy_value, widget.x_position + widget.width - accuracy_value) then
						x_offset := x
						y_offset := 0
						x_scale := 0; y_scale := 1
					elseif close_to_line (y, x, widget.x_position, widget.y_position + accuracy_value, widget.y_position + widget.height - accuracy_value) then
						x_offset := 0
						y_offset := y
						x_scale := 1; y_scale := 0
					elseif close_to_line (y, x, widget.x_position + widget.width, widget.y_position + accuracy_value, widget.y_position + widget.height - accuracy_value) then
						x_offset := widget.width
						y_offset := y
						x_scale := 1; y_scale := 0
					elseif x > widget.x_position and x < widget.x_position + widget.width and y > widget.y_position and y < widget.y_position + widget.height then
						moving_widget := True
						resizing_widget := False
						x_offset := x - widget.x_position
						y_offset := y - widget.y_position
					else
						resizing_widget := False
					end
					if resizing_widget or moving_widget then
						drawing_area.enable_capture
					end
				end
			end
			if a_button = 1 and not resizing_widget and not moving_widget then
					-- Now select a widget if a user is pressing the left mouse button while over
					-- a widget in the view.
				from
					first.start
				until
					first.off
				loop
					widget := first.item
					if x > widget.x_position and x < widget.x_position + widget.width and
						y > widget.y_position and y < widget.y_position + widget.height then
						selected_item_index := first.index
						list_item := list.i_th (selected_item_index)
						list_item.select_actions.block
						list_item.enable_select
						list_item.select_actions.resume
					end
					if not first.after then
						first.forth
					end
				end
				draw_widgets
			end
		end

	button_released (x, y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- A button has been released on `drawing_area'
			-- If `a_button' = 1, check for end of resize/movement.
		do
			scrolled_x_once := False
			if a_button = 1 then
				if scrolling_x then
					end_x_scrolling
				end
				if resizing_widget then
					resizing_widget := False
					set_all_pointer_styles (standard_cursor)
					drawing_area.disable_capture
				elseif moving_widget then
					moving_widget := False
					set_all_pointer_styles (standard_cursor)
					drawing_area.disable_capture
				end
			set_initial_area_size
			draw_widgets
			end
		end

	set_all_pointer_styles (cursor: EV_POINTER_STYLE) is
			-- Assign a pointer style to all figures in
			-- `world' and `drawing_area'.
		do
			from
				world.start
			until
				world.off
			loop
				world.item.set_pointer_style (cursor)
				world.forth
			end
			drawing_area.set_pointer_style (cursor)
		end

	update_status is
			-- Display status message in `prompt_label'.
			-- This prompts the user.
		do
			if list.selected_item = Void then
				prompt_label.set_text (select_widget_prompt)
			else
				if (first @ (list.index_of (list.selected_item, 1))).width < 3 and
				(first @ (list.index_of (list.selected_item, 1))).height < 3 then
					prompt_label.set_text (widget_size_prompt)
				else
					prompt_label.set_text (resize_widget_prompt)
				end
			end
		end

	clicked_for_enlarge (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Enlarge selected widget if sizing prompt
			-- is displayed.
		local
			widget: EV_WIDGET
		do
			if prompt_label.text.is_equal (widget_size_prompt) then
				widget := (first @ (list.index_of (list.selected_item, 1)))
					-- We do not enlarge the display widget, as they are already
					-- larger.
				first.set_item_width (widget, 50)
				first.set_item_height (widget, 50)
				draw_widgets
			end
		end

	check_unselect is
			-- If no item is selected in `list' any more,
			-- then we must remove the highlighting from
			-- the display.
		do
			if list.selected_items.count = 0 then
				selected_item_index := 0
				draw_widgets
			end
		end

feature {NONE} -- Scrolling attributes.

	last_x, last_y: INTEGER
		-- Last known coordinates of mouse pointer.

	x_right, x_center: INTEGER is unique
		-- Constants used with `scrolling_x_start'.

	y_bottom, y_center: INTEGER is unique
		-- Constants used with `scrolling_y_start'.

	scrolling_x_start: INTEGER
		-- Where did the scrolling operation start?
			-- `x_right' if started when reached edge of `drawing_area'.
			-- `x_center' if started when reached visible edge of `drawing_area'.

	scrolling_y_start: INTEGER
		-- Where did the scrolling operation start?
			-- `y_bottom' if started when reached the bottom of `drawing_area'.
			-- `y_center' if started when reached visible edge of `drawing_area'.

	timeout: EV_TIMEOUT
		-- Used to execute the timing of scrolling.

	scrolling_x: BOOLEAN
		-- Are we currently scrolling onx axis??

	scrolling_y: BOOLEAN
			-- Are we currently scrolling on y axis?


	scrolled_x_once: BOOLEAN
		-- Have we scrolled in the x direction since the last
		-- button 1 release?

	scrolled_y_once:BOOLEAN
		-- Have we scrolled in the y direction since the last
		-- button 1 release?

feature {NONE} -- Attributes

	status_timer: EV_TIMEOUT
		-- Timer executed to keep `prompt_label'
		-- current.

	grid_spacing: INTEGER
		-- Spacing used for grid.

	resizing_widget: BOOLEAN
		-- Is a widget currently being resized?

	moving_widget: BOOLEAN
		-- Is a widget currently being moved?

	x_offset, y_offset: INTEGER
		-- Offsets used to hold cursor distance from
		-- point being targeted.

	x_scale, y_scale: INTEGER
		-- Amount to scale movement in the X or Y axis by.
		-- Should be 1 or 0. 1 means full movement, 0 means
		-- that axis is ignored.

	selected_item_index: INTEGER
		-- Index of item currently selected in

	grid_color: EV_COLOR is
			-- Color used for grid.
		do
			create Result.make_with_8_bit_rgb (196, 244, 204)
		end

	highlighted_width: INTEGER is 3
		-- Width of line used to draw highlighted item.

	accuracy_value: INTEGER is 3
			-- Value which determines how close pointer must be
			-- to lines/points for resizing.

	projector: EV_DRAWING_AREA_PROJECTOR
		-- Projector used for `world'

	pixmap: EV_PIXMAP
		-- Pixmap for double buffering `world'.

	world: EV_FIGURE_WORLD;
		-- Figure world containg all widget representations.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_FIXED_POSITIONER

