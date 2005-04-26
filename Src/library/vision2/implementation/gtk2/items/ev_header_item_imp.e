indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER_ITEM_IMP

inherit
	EV_HEADER_ITEM_I
		redefine
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP
	
	EV_TEXTABLE_IMP
		redefine
			interface
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

create
	make

feature -- Initialization

	needs_event_box: BOOLEAN is False

	make (an_interface: like interface) is
			-- Create the tree item.
		do
			base_make (an_interface)
			set_c_object  ({EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_new)
		end

	initialize is
			-- Initialize the header item
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_resizable (c_object, True)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_clickable (c_object, True)
			
				-- Allow the column to be shrank to nothing
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_min_width (c_object, 0)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_sizing (c_object, {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_fixed_enum)

				-- Set the default width to 80 pixels wide
			set_width (80)

			real_signal_connect (c_object, "notify::width", agent handle_resize, Void)
			
			pixmapable_imp_initialize
			textable_imp_initialize
			
			box := {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			{EV_GTK_EXTERNALS}.gtk_widget_show (box)
			{EV_GTK_EXTERNALS}.gtk_container_add (box, pixmap_box)
			{EV_GTK_EXTERNALS}.gtk_container_add (box, text_label)

			is_initialized := True
		end

	handle_resize is
			-- Call the appropriate actions for the header item resize
		do
			if parent_imp /= Void and then parent_imp.item_resize_actions_internal /= Void and then width /= old_width then
				parent_imp.item_resize_actions_internal.call ([interface])
				parent_imp.item_resize_end_actions_internal.call ([interface])
			end
			old_width := width
		end

	old_width: INTEGER
		-- Previous width of `Current', used to prevent multiple calls to resize actions when the item hasn't actually resized

feature -- Access

	width: INTEGER is
			-- `Result' is width of `Current' used
			-- while parented.
		do
			if parent_imp /= Void and then parent_imp.is_displayed then
				Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_get_width (c_object)
			else
				Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_get_fixed_width (c_object)
			end
		end

feature -- Status setting

	set_width (a_width: INTEGER) is
			-- Assign `a_width' to `width'.
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_fixed_width (c_object, a_width)
		end
		
	resize_to_content is
			-- Resize `Current' to fully display both `pixmap' and `text'.
			-- As size of `text' is dependent on `font' of `parent', `Current'
			-- must be parented.
		do
		end

feature -- PND

	enable_transport is
			-- Enable PND transport
		do
			is_transport_enabled := True
		end

	disable_transport is
			-- Disable PND transport
		do
			is_transport_enabled := False
		end

	draw_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	erase_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	enable_capture is
		do
			check
				do_not_call: False
			end
		end

	disable_capture is
		do
			check
				do_not_call: False
			end
		end

	start_transport (
        	a_x, a_y, a_button: INTEGER;
        	a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        	a_screen_x, a_screen_y: INTEGER) is 
        	-- Start PND transport (not needed)
		do
			check
				do_not_call: False
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER) is
			-- End PND transport (not needed)
		do
			check
				do_not_call: False
			end
		end

	set_pointer_style, internal_set_pointer_style (curs: EV_CURSOR) is
			-- Set 'pointer_style' to 'curs' (not needed)
		do
			check
				do_not_call: False
			end
		end

feature {EV_HEADER_IMP} -- Implementation

	set_parent_imp (par_imp: like parent_imp) is
			-- Set `parent_imp' to `par_imp'
		do
			parent_imp := par_imp
			if par_imp /= Void then
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_widget (c_object, box)
			else
				{EV_GTK_EXTERNALS}.object_ref (box)
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_set_widget (c_object, {EV_GTK_EXTERNALS}.gtk_label_new (default_pointer))
			end
		end

	parent_imp: EV_HEADER_IMP
		-- Parent of `Current'

feature {NONE} -- Implementation

	box: POINTER
		-- Box to hold column text and pixmap.
	
	create_drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Create a drop action sequence.
		do
		end

feature {NONE} -- Redundant implementation

	real_pointed_target: EV_PICK_AND_DROPABLE is
		do
			check do_not_call: False end
		end

feature {NONE} -- Implementation

	destroy is do end

	interface: EV_HEADER_ITEM


end
