indexing
	description: 
		"EiffelVision Split Area. GTK+ implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_SPLIT_AREA_IMP

inherit
	EV_SPLIT_AREA_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		undefine
			replace
		redefine
			interface,
			initialize,
			height,
			width,
			container_widget
		end

feature {NONE} -- Initialization

	initialize is
		do
			Precursor
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (container_widget)
			update_splitter
			second_expandable := True
			feature {EV_GTK_EXTERNALS}.gtk_container_set_border_width (container_widget, 0)
		end

feature

	height: INTEGER is
			-- Height of `Current' in screen pixels.
		local
			a_box: EV_BOX_IMP
			a_h_box: EV_HORIZONTAL_BOX
			a_v_split: EV_SPLIT_AREA_IMP
		do
			Result := Precursor {EV_CONTAINER_IMP}
			-- Hack to retrieve correct height if geometry calculation has not been done yet.
			
			if Result = minimum_height then
				a_box ?= parent_imp
				a_h_box ?= a_box
				a_v_split ?= parent_imp
				if a_box /= Void and then a_box.is_item_expanded (interface) then
					if a_box.count = 1 or else a_h_box /= Void then
						Result := a_box.height
					end
				else
					if a_v_split /= Void and a_v_split.second = Void then
							Result := a_v_split.height	
					end
				end
			end
		end
		
	width: INTEGER is
			-- Width of `Current' in screen pixels.
		local
			a_box: EV_BOX_IMP
			a_v_box: EV_VERTICAL_BOX
			a_split: EV_SPLIT_AREA
		do
			Result := Precursor {EV_CONTAINER_IMP}
			-- Hack to retrieve correct width if geometry calculation has not been done yet.
			
			if Result = minimum_width then
				a_box ?= parent_imp
				a_v_box ?= a_box
				a_split ?= parent_imp
				if a_box /= Void and then a_box.is_item_expanded (interface) then
					if a_box.count = 1 or else a_v_box /= Void then
						Result := a_box.width
					end
				else
					if a_split /= Void and a_split.second = Void then
						Result := a_split.width
					end
				end
			end
		end

	split_position: INTEGER is
			-- Position from the left/top of the splitter from `Current'.
		do
			Result := gtk_paned_struct_child1_size (container_widget)
			Result := Result.max (minimum_split_position).min (maximum_split_position)
		end

	set_first (an_item: like item) is
			-- Make `an_item' `first'.
		local
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= an_item.implementation
			item_imp.set_parent_imp (Current)
			check item_imp_not_void: item_imp /= Void end
			feature {EV_GTK_EXTERNALS}.gtk_paned_pack1 (container_widget, item_imp.c_object, False, False)
			first := an_item
			set_item_resize (first, False)
			update_splitter
			feature {EV_GTK_EXTERNALS}.gtk_widget_queue_resize (container_widget)
		end

	set_second (an_item: like item) is
			-- Make `an_item' `second'.
		local
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= an_item.implementation
			item_imp.set_parent_imp (Current)
			check item_imp_not_void: item_imp /= Void end
			feature {EV_GTK_EXTERNALS}.gtk_paned_pack2 (container_widget, item_imp.c_object, True, False)
			second := an_item
			set_item_resize (second, True)
			update_splitter
			feature {EV_GTK_EXTERNALS}.gtk_widget_queue_resize (container_widget)
		end

	prune (an_item: like item) is
			-- Remove `an_item' if present from `Current'.
		local
			item_imp: EV_WIDGET_IMP
		do
			if has (an_item) and then an_item /= Void then
				item_imp ?= an_item.implementation
				item_imp.set_parent_imp (Void)
				check item_imp_not_void: item_imp /= Void end
				feature {EV_GTK_DEPENDENT_EXTERNALS}.object_ref (item_imp.c_object)
				feature {EV_GTK_EXTERNALS}.gtk_container_remove (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (item_imp.c_object), item_imp.c_object)
				if an_item = first then
					first_expandable := False
					first := Void
					set_split_position (0)
					if second /= Void then
						set_item_resize (second, True)
					end
				else
					second := Void
					second_expandable := True
					if first /= Void then
						set_item_resize (first, True)
					end
				end
				update_splitter
			end
			feature {EV_GTK_EXTERNALS}.gtk_widget_queue_resize (container_widget)
		end

	enable_item_expand (an_item: like item) is
			-- Let `an_item' expand when `Current' is resized.
		do
			set_item_resize (an_item, True)
		end

	disable_item_expand (an_item: like item) is
			-- Make `an_item' non-expandable on `Current' resize.
		do
			set_item_resize (an_item, False)
		end

	set_split_position (a_split_position: INTEGER) is
			-- Set the position of the splitter.
		do
			feature {EV_GTK_EXTERNALS}.gtk_paned_set_position (container_widget, a_split_position)
		end

	enable_flat_separator is
			-- Set the separator to be "flat".
		do
			flat_separator := True
			--| Do nothing (Win32 Implementation only)
		end

	disable_flat_separator is
			-- Set the separator to be "raised"
		do
			flat_separator := False
			--| Do nothing (Win32 Implementation only)
		end

	show_separator is
			-- Make separator visible.
		local
			first_imp, second_imp: EV_WIDGET_IMP
		do
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_paned_set_gutter_size (container_widget, splitter_width)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_paned_set_handle_size (container_widget, splitter_width)
			
			-- We know that both first and second are non Void.
			
			first_imp ?= first.implementation
			feature {EV_GTK_DEPENDENT_EXTERNALS}.object_ref (first_imp.c_object)
			feature {EV_GTK_EXTERNALS}.gtk_container_remove (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (first_imp.c_object), first_imp.c_object)
			second_imp ?= second.implementation
			feature {EV_GTK_DEPENDENT_EXTERNALS}.object_ref (second_imp.c_object)
			feature {EV_GTK_EXTERNALS}.gtk_container_remove (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (second_imp.c_object), second_imp.c_object)
			
			feature {EV_GTK_EXTERNALS}.gtk_paned_pack1 (container_widget, first_imp.c_object, first_expandable, False)
			feature {EV_GTK_EXTERNALS}.gtk_paned_pack2 (container_widget, second_imp.c_object, second_expandable, False)
			
			feature {EV_GTK_EXTERNALS}.gtk_container_add (c_object, container_widget)
		end

	hide_separator is
			-- Hide Separator.
		local
			item_imp: EV_WIDGET_IMP
		do
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_paned_set_gutter_size (container_widget, 0)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_paned_set_handle_size (container_widget, 0)
			
			
			if feature {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (container_widget) /= NULL then
				feature {EV_GTK_DEPENDENT_EXTERNALS}.object_ref (container_widget)
				feature {EV_GTK_EXTERNALS}.gtk_container_remove (c_object, container_widget)				
			end

			-- If the separator is hidden, then `Current' can only contain at most, one widget.
			if first /= Void then
				item_imp ?= first.implementation
			elseif second /= Void then
				item_imp ?= second.implementation
			end
			if item_imp /= Void then
				feature {EV_GTK_EXTERNALS}.gtk_widget_reparent (item_imp.c_object, c_object)
			end
		end

feature {NONE} -- Implementation

	container_widget: POINTER
		-- Pointer to the GtkPaned widget.

	splitter_width: INTEGER is 8

	set_item_resize (an_item: like item; a_resizable: BOOLEAN) is
			-- Set whether `an_item' is `a_resizable' when `Current' resizes.
		do
			if an_item = first then
				first_expandable := a_resizable
			else
				second_expandable := a_resizable
			end
			set_gtk_paned_struct_child1_resize (container_widget, first_expandable)
			set_gtk_paned_struct_child2_resize (container_widget, second_expandable)
			feature {EV_GTK_EXTERNALS}.gtk_widget_queue_resize (container_widget)
			feature {EV_GTK_EXTERNALS}.gtk_widget_queue_draw (container_widget)
		end

	update_splitter is
			-- Update splitter to account for different configurations
		do
			if first /= Void and second = Void then
				set_split_position (maximum_split_position)
				hide_separator
			elseif first = Void and second /= Void then
				set_split_position (0)
				hide_separator
			elseif first = Void and second = Void then
				set_split_position (0)
				hide_separator
			else
				-- Both first and second are visible
				show_separator
			end
		end

feature {NONE} -- Externals.

	gtk_paned_struct_child1_size (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GtkPaned): EIF_INTEGER"
		alias
			"child1_size"
		end

	set_gtk_paned_struct_child1_resize (a_c_struct: POINTER; a_resize: BOOLEAN) is
		external
			"C [struct <gtk/gtk.h>] (GtkPaned, EIF_BOOLEAN)"
		alias
			"child1_resize"
		end

	set_gtk_paned_struct_child2_resize (a_c_struct: POINTER; a_resize: BOOLEAN) is
		external
			"C [struct <gtk/gtk.h>] (GtkPaned, EIF_BOOLEAN)"
		alias
			"child2_resize"
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SPLIT_AREA


end -- class EV_SPLIT_AREA_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

