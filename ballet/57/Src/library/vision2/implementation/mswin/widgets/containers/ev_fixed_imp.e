indexing
	description:
		"Eiffel Vision fixed. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIXED_IMP

inherit
	EV_FIXED_I
		redefine
			interface
		end

	EV_WIDGET_LIST_IMP
		redefine
			interface,
			compute_minimum_height,
			compute_minimum_width,
			compute_minimum_size,
			on_size,
			insert_i_th,
			notify_change
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		redefine
			top_level_window_imp,
			default_style,
			on_erase_background
		end

	WEL_RGN_CONSTANTS
		export {NONE}
			all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the fixed container.
		do
			base_make (an_interface)
			ev_wel_control_container_make
			create ev_children.make (2)
		end

feature -- Status setting

	set_item_position (a_widget: EV_WIDGET; an_x, a_y: INTEGER) is
			-- Set `a_widget.x_position' to `an_x'.
			-- Set `a_widget.y_position' to `a_y'.
		local
			wel_win: EV_WIDGET_IMP
		do
			wel_win ?= a_widget.implementation
			check
				wel_win_not_void: wel_win /= Void
			end
			wel_win.ev_move (an_x, a_y)
			wel_win.invalidate
			notify_change (Nc_minsize, wel_win)
		end

	set_item_size (a_widget: EV_WIDGET; a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		local
			wel_win: EV_WIDGET_IMP
		do
			wel_win ?= a_widget.implementation
			check
				wel_win_not_void: wel_win /= Void
			end
			wel_win.parent_ask_resize (a_width, a_height)
			notify_change (Nc_minsize, wel_win)
		end

feature {EV_ANY_I} -- Implementation

	ev_children: ARRAYED_LIST [EV_WIDGET_IMP]
			-- Child widgets in z-order starting with farthest away.

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains the current widget.

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Assign `a_window' to `top_level_window_imp'.
		do
			top_level_window_imp := a_window
			from
				ev_children.start
			until
				ev_children.after
			loop
				ev_children.item.set_top_level_window_imp (a_window)
				ev_children.forth
			end
		end

	default_style: INTEGER is
		do
			Result := Ws_child | Ws_visible | Ws_clipchildren | Ws_clipsiblings
		end

	interface: EV_FIXED
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

feature {NONE} -- Implementation

	compute_minimum_width is
			-- Compute both to avoid duplicate code.
		local
			v_imp: EV_WIDGET_IMP
			new_min_width: INTEGER
			cur: INTEGER
		do
			if not child_cell.is_user_min_width_set then
				cur := ev_children.index
				from
					ev_children.start
				until
					ev_children.after
				loop
					v_imp := ev_children.item
					new_min_width := new_min_width.max (v_imp.x_position + v_imp.width)
					ev_children.forth
				end
				ev_children.go_i_th (cur)
				ev_set_minimum_width (new_min_width)
			end
		end

	compute_minimum_height is
			-- Compute both to avoid duplicate code.
		local
			v_imp: EV_WIDGET_IMP
			new_min_height: INTEGER
			cur: INTEGER
		do
			if not child_cell.is_user_min_height_set then
				cur := ev_children.index
				from
					ev_children.start
				until
					ev_children.after
				loop
					v_imp := ev_children.item
					new_min_height := new_min_height.max (v_imp.y_position + v_imp.height)
					ev_children.forth
				end
				ev_children.go_i_th (cur)
				ev_set_minimum_height (new_min_height)
			end
		end

	compute_minimum_size is
			-- Recompute the minimum size of the object.
		local
			v_imp: EV_WIDGET_IMP
			new_min_width, new_min_height: INTEGER
			cur: INTEGER
		do
			if not child_cell.is_user_min_height_set or else not child_cell.is_user_min_width_set then
				cur := ev_children.index
				from
					ev_children.start
				until
					ev_children.after
				loop
					v_imp := ev_children.item
					new_min_width := new_min_width.max (v_imp.x_position + v_imp.width)
					new_min_height := new_min_height.max (v_imp.y_position + v_imp.height)
					ev_children.forth
				end
				ev_children.go_i_th (cur)
				ev_set_minimum_size (new_min_width, new_min_height)
			end
		end

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		do
			Precursor {EV_WIDGET_LIST_IMP} (v, i)
			if child_cell.is_user_min_height_set or else child_cell.is_user_min_width_set then
				set_item_size (v, v.minimum_width, v.minimum_height)
			end
		end

	notify_change (type: INTEGER; child: EV_SIZEABLE_IMP) is
			-- Notify the current widget that the change identify by
			-- type have been done. For types, see `internal_changes'
			-- in class EV_SIZEABLE_IMP. If the container is shown,
			-- we integrate the changes immediatly, otherwise, we postpone
			-- them.
			-- Use the constants defined in EV_SIZEABLE_IMP
		local
			widget_imp: EV_WIDGET_IMP
		do
			if not child_cell.is_user_min_height_set or else not child_cell.is_user_min_width_set then
				Precursor {EV_WIDGET_LIST_IMP} (type, child)
			else
				widget_imp ?= child
				check
					widget_imp_not_void: widget_imp /= Void
				end
				widget_imp.parent_ask_resize (child.width, child.height)
			end
		end

feature {NONE} -- WEL Implementation

	on_size (size_type: INTEGER; a_width, a_height: INTEGER) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
			-- And we reajust size of all children.
		local
			v_imp: EV_WIDGET_IMP
			cur: INTEGER
		do
			Precursor {EV_WIDGET_LIST_IMP} (size_type, a_width, a_height)
			cur := ev_children.index
			from
				ev_children.start
			until
				ev_children.after
			loop
				v_imp := ev_children.item
				v_imp.set_move_and_size (v_imp.x_position,
						v_imp.y_position, v_imp.width, v_imp.height)
				ev_children.forth
			end
			ev_children.go_i_th (cur)
		end

	ev_apply_new_size (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
			-- And we reajust size of all children.
		local
			v_imp: EV_WIDGET_IMP
			cur: INTEGER
		do
			ev_move_and_resize (a_x, a_y, a_width, a_height, repaint)
			cur := ev_children.index
			from
				ev_children.start
			until
				ev_children.after
			loop
				v_imp := ev_children.item
				v_imp.ev_apply_new_size (v_imp.x_position,
						v_imp.y_position, v_imp.width, v_imp.height, repaint)
				ev_children.forth
			end
			ev_children.go_i_th (cur)
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
		local
			main_region: WEL_REGION
			tmp_region, new_region: WEL_REGION
			original_index: INTEGER
			temp_children: ARRAYED_LIST [EV_WIDGET_IMP]
			current_child: EV_WIDGET_IMP
			bk_brush: WEL_BRUSH
		do
				-- Disable default windows processing which would re-draw the
				-- complete background of `Current'. This is not nice behaviour
				-- as some widgets such as EV_LIST_IMP re-draw themselves as
				-- required and will be hidden by `Current' if they are inside.
				-- This will solve that problem.
			disable_default_processing
			set_message_return_value (to_lresult (1))
				-- Quick access to `ev_children'.
			temp_children := ev_children
				-- Retrieve original index of `ev_children'.
			original_index := temp_children.index
				-- Create the region as the invalid area of `Current' that
				-- needs to be redrawn.
			create main_region.make_rect_indirect (invalid_rect)
				-- We now need to subtract the area of every child held in
				-- `Current' from the invalid area.
			from
				temp_children.start
			until
				temp_children.off
			loop
				current_child := temp_children.item
					-- Create a temporary region the size of the current child.
				if current_child.is_show_requested then
					create tmp_region.make_rect
						(current_child.x_position, current_child.y_position,
						current_child.x_position + current_child.width,
						current_child.y_position + current_child.height)
						-- Subtract this temporary region from the `main_region'
						-- and store in `main_region'.
					new_region := main_region.combine (tmp_region, Rgn_diff)
					tmp_region.delete
					main_region.delete
					main_region := new_region
				end
					-- Point to the next child if there is one.
				temp_children.forth
			end
				-- Fill the remaining region, `main_region'.
			bk_brush := background_brush
			paint_dc.fill_region (main_region, bk_brush)
				-- Restore our index in the children.
			temp_children.go_i_th (original_index)

				-- Clean up GDI objects
			bk_brush.delete
			main_region.delete
		end

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' currently contained in `Current'.
		do
			Result := a_child = item.implementation
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class EV_FIXED_IMP

