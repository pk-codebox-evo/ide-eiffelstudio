indexing

	description:
			"Manager widget that arranges its children in rows and columns.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_ROW_COLUMN

inherit

	MEL_ROW_COLUMN_RESOURCES
		export
			{NONE} all
		end;

	MEL_MANAGER
		redefine
			create_callback_struct
		end

creation 
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif row column.
		require
			name_exists: a_name /= Void;
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_row_column (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			parent_set: parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

feature -- Measurement

	entry_border: INTEGER is
			-- Border width the children
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNentryBorder)
		ensure
			entry_border_large_enough: Result >= 0
		end;

	margin_height: INTEGER is
			-- Amount of blank space between the top edge
			-- of Current and the first item in each column, and the
			-- bottom edge of Current and the last item in each column
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginHeight)
		ensure
			margin_height_large_enough: Result >= 0
		end;

	margin_width: INTEGER is
			-- Amount of blank space between the left edge
			-- of Current and an item in a row, and the
			-- right edge of Current and an item in a row
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNmarginWidth)
		ensure
			margin_width_large_enough: Result >= 0
		end;

	spacing: INTEGER is
			-- The horizontal and vertical spacing between the children
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNspacing)
		ensure
			spacing_large_enough: Result >= 0
		end;

feature -- Status report

	adjust_last: BOOLEAN is
			-- Is the last row expanded so as to be flush with the edge?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNadjustLast)
		end;

	adjust_margin: BOOLEAN is
			-- Is the text in each row aligned with other text in its row?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNadjustMargin)
		end;

	entry_alignment_beginning: BOOLEAN is
			-- Are the children of Current aligned with the beginning?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNentryAlignment) = XmALIGNMENT_BEGINNING
		end;

	entry_alignment_center: BOOLEAN is
			-- Are the children of Current aligned with the center?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNentryAlignment) = XmALIGNMENT_CENTER
		end;

	entry_alignment_end: BOOLEAN is
			-- Are the children of Current aligned with the end?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNentryAlignment) = XmALIGNMENT_END
		end;

	entry_vertical_alignment_baseline_bottom: BOOLEAN is
			-- Will the children that are subclasses of Text, TextField, Label
			-- be vertically aligned with baseline_bottom?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNentryVerticalAlignment)
							= XmALIGNMENT_BASELINE_BOTTOM
		end;

	entry_vertical_alignment_baseline_top: BOOLEAN is
			-- Will the children that are subclasses of Text, TextField, Label
			-- be vertically aligned with baseline_top?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNentryVerticalAlignment) = XmALIGNMENT_BASELINE_TOP
		end;

	entry_vertical_alignment_contents_bottom: BOOLEAN is
			-- Will the children that are subclasses of Text, TextField, Label
			-- be vertically aligned with contents_bottom?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNentryVerticalAlignment)
							= XmALIGNMENT_CONTENTS_BOTTOM
		end;

	entry_vertical_alignment_center: BOOLEAN is
			-- Will the children that are subclasses of Text, TextField, Label
			-- be vertically aligned with the center?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNentryVerticalAlignment) = XmALIGNMENT_CENTER
		end;

	entry_vertical_alignment_contents_top: BOOLEAN is
			-- Will the children that are subclasses of Text, TextField, Label
			-- be vertically aligned with contents_top?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNentryVerticalAlignment) = XmALIGNMENT_CONTENTS_TOP
		end;

	entry_class is
			-- Widget class to which the children must belong.
		require
			exists: not is_destroyed
		do
		end;

	is_aligned: BOOLEAN is
			-- Is alignment enabled?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNisAligned)
		end;

	is_homogeneous: BOOLEAN is
			-- Must all the children belong to the same widget class, the one that
			-- is defined by `entry_class'?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNisHomogeneous)
		end;

	menu_accelerator: STRING is
			-- Keybord short-cut for a menu
		require
			exists: not is_destroyed
		do
			Result := get_xt_string (screen_object, XmNmenuAccelerator)
		ensure
			result_not_void: Result /= Void
		end;

	menu_help_widget: MEL_CASCADE_BUTTON is
			-- Cascade button of a menu bar
		require
			exists: not is_destroyed
		do
			Result ?= get_xt_widget (screen_object, XmNmenuHelpWidget)
		end;

	menu_history: MEL_RECT_OBJ is
			-- Most recently activated menu entry
		require
			exists: not is_destroyed
		do
			Result ?= get_xt_widget (screen_object, XmNmenuHistory)
		end;

	menu_post: STRING is
			-- String that describes the event for a posting menu
		require
			exists: not is_destroyed
		do
			Result := get_xt_string (screen_object, XmNmenuPost)
		ensure
			result_not_void: Result /= Void
		end;

	mnemonic: CHARACTER is
			-- Keysym of the key to press in order to post the pulldown
			-- menu associated with an option menu
		require
			exists: not is_destroyed
		do
			Result := get_xt_keysym (screen_object, XmNmnemonic)
		end;

	mnemonic_char_set: STRING is
			-- Character set for the option menu's mnemonics
		require
			exists: not is_destroyed
		do
			Result := get_xt_string (screen_object, XmNmnemonicCharSet)
		end;

	num_columns: INTEGER is
			-- Number of rows or columns of Current
		require
			exists: not is_destroyed
		do
			Result := get_xt_short (screen_object, XmNnumColumns)
		ensure
			result_large_enough: Result >= 0
		end;

	is_horizontal: BOOLEAN is
			-- Is Current's orientation horizontal?
		require
			exists: not is_destroyed
		do
			Result := orientation = XmHORIZONTAL
		end;

	packing_tight: BOOLEAN is
			-- Is the method of spacing the items in Current tight?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNpacking) = XmPACK_TIGHT
		end;

	packing_column: BOOLEAN is
			-- Is the method of spacing the items in the Current column?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNpacking) = XmPACK_COLUMN
		end;

	packing_none: BOOLEAN is
			-- Is there no packing method?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNpacking) = XmPACK_NONE
		end;

	is_popup_enabled: BOOLEAN is
			-- Are keyboard shortcuts in effects for popup menus?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNpopupEnabled)
		end;

	radio_behavior: BOOLEAN is
			-- Acts Current like a radio box?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNradioBehavior)
		end;

	radio_always_one: BOOLEAN is
			-- Must one toggle always be selected?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNradioAlwaysOne)
		end;

	resize_height: BOOLEAN is
			-- Will resize height requests be made?
		do
			Result := get_xt_boolean (screen_object, XmNresizeHeight)
		end;

	resize_width: BOOLEAN is
			-- Will resize width requests be made?
		do
			Result := get_xt_boolean (screen_object, XmNresizeWidth)
		end;

	is_working_area: BOOLEAN is
			-- Is Current a work area?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNrowColumnType) = XmWORK_AREA
		end;

	is_menu: BOOLEAN is
			-- Is Current a menu?
			-- (ie is it a menu bar or menu popup or menu pulldown
			-- or menu option).
		do
			Result := is_menu_bar or else is_menu_popup or else
				is_menu_pulldown or else is_menu_option
		ensure
			valid_result: Result = is_menu_bar or else 
					is_menu_popup or else
					is_menu_pulldown or else 
					is_menu_option
		end;
				
	is_menu_bar: BOOLEAN is
			-- Is Current a menu bar?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNrowColumnType) = XmMENU_BAR
		end;

	is_menu_popup: BOOLEAN is
			-- Is Current a menu popup
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNrowColumnType) = XmMENU_POPUP
		end;

	is_menu_pulldown: BOOLEAN is
			-- Is Current a menu pulldown?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNrowColumnType) = XmMENU_PULLDOWN
		end;

	is_menu_option: BOOLEAN is
			-- Is Current a menu option?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNrowColumnType) = XmMENU_OPTION
		end;
	
	is_tear_off_enabled: BOOLEAN is
			-- Is the tear-off behavior enabled for Current?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNtearOffModel) = XmTEAR_OFF_ENABLED
		end;

feature -- Status setting

	set_adjust_last (b: BOOLEAN) is
			-- Set `adjust_last' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNadjustLast, b)
		ensure
			adjust_last_disabled: adjust_last = b
		end;

	set_adjust_margin (b: BOOLEAN) is
			-- Set `adjust_margin' to `b'.
			-- aligned with other text in its row. Otherwize,
			-- the text in each row won't be aligned with other
			-- text in its row.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNadjustMargin, b)
		ensure
			adjust_margint_enabled: adjust_margin = b
		end;

	set_entry_alignment_beginning is
			-- Set `entry_alignment_beginning'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNentryAlignment, XmALIGNMENT_BEGINNING)
		ensure
			entry_alignment_beginning_set: entry_alignment_beginning
		end;

	set_entry_alignment_center is
			-- Set `entry_alignment_center'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNentryAlignment, XmALIGNMENT_CENTER)
		ensure
			entry_alignment_center_set: entry_alignment_center
		end;

	set_entry_alignment_end is
			-- Set `entry_alignment_end'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNentryAlignment, XmALIGNMENT_END)
		ensure
			entry_alignment_end_set: entry_alignment_end
		end;

	set_entry_vertical_alignment_baseline_bottom is
			-- Set `entry_vertical_alignment_baseline_bottom'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNentryVerticalAlignment, XmALIGNMENT_BASELINE_BOTTOM)
		ensure
			entry_vertical_alignment_baseline_bottom_set: entry_vertical_alignment_baseline_bottom
		end;

	set_entry_vertical_alignment_baseline_top is
			-- Set `entry_vertical_alignment_baseline_top'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNentryVerticalAlignment, XmALIGNMENT_BASELINE_TOP)
		ensure
			entry_vertical_alignment_baseline_top_set: entry_vertical_alignment_baseline_top
		end;

	set_entry_vertical_contents_bottom is
			-- Set `entry_vertical_alignment_contents_bottom'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNentryVerticalAlignment, XmALIGNMENT_CONTENTS_BOTTOM)
		ensure
			entry_vertical_alignment_contents_bottom_set: entry_vertical_alignment_contents_bottom
		end;

	set_entry_vertical_alignment_center is
			-- Set `entry_vertical_alignment_center'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNentryVerticalAlignment, XmALIGNMENT_CENTER)
		ensure
			entry_vertical_alignment_center_set: entry_vertical_alignment_center
		end;

	set_entry_vertical_contents_top is
			-- Set `entry_vertical_alignment_contents_top'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNentryVerticalAlignment, XmALIGNMENT_CONTENTS_TOP)
		ensure
			entry_vertical_alignment_contents_top_set: entry_vertical_alignment_contents_top
		end;

	set_entry_class is
			-- Set the widget class to which the children must belong.
		require
			exists: not is_destroyed
		do
		ensure
		end;

	set_alignment (b: BOOLEAN) is
			-- Set `is_aligned' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNisAligned, b)
		ensure
			alignment_enabled: is_aligned = b
		end;

	set_is_homogeneous (b: BOOLEAN) is
			-- Set `is_homogeneous' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNisHomogeneous, b)
		ensure
			homogeneous_set: is_homogeneous = b
		end;

	set_menu_accelerator (a_string: STRING) is
			-- Set `menu_accelerator' to `a_string'.
		require
			exists: not is_destroyed;
			a_string_not_void: a_string /= Void
		do
			set_xt_string (screen_object, XmNmenuAccelerator, a_string)
		ensure
			menu_accelerator_set: menu_accelerator.is_equal (a_string)
		end;

	set_menu_help_widget (a_cascade_button: MEL_CASCADE_BUTTON) is
			-- Set `menu_help_widget' to `a_cascade_button'.
		require
			exists: not is_destroyed;
			non_void_button: a_cascade_button /= Void;
			a_cascade_button_exists: not a_cascade_button.is_destroyed
		do
			set_xt_widget (screen_object, XmNmenuHelpWidget, a_cascade_button.screen_object)
		ensure
			menu_help_widget_set: menu_help_widget = a_cascade_button
		end;

	set_menu_history (a_widget: MEL_RECT_OBJ) is
			-- Set `menu_history' to `a_widget'.
		require
			exists: not is_destroyed;
			non_void_button: a_widget /= Void;
			a_widget_exists: not a_widget.is_destroyed
		do
			set_xt_widget (screen_object, XmNmenuHistory, a_widget.screen_object)
		ensure
			menu_history_set: menu_history = a_widget
		end;

	set_menu_post (a_string: STRING) is
			-- Set `menu_post' to `a_string'.
		require
			exists: not is_destroyed;
			a_string_not_void: a_string /= Void
		do
			set_xt_string (screen_object, XmNmenuPost, a_string)
		ensure
			menu_post_set: menu_post.is_equal (a_string)
		end;

	set_mnemonic (a_character: CHARACTER) is
			-- Set `mnemonic'.
		require
			exists: not is_destroyed
		do
			set_xt_keysym (screen_object, XmNmnemonic, a_character)
		ensure
			set: mnemonic = a_character
		end;

	set_mnemonic_char_set (a_string: STRING) is
			-- Set `mnemonic_char_set'.
		require
			exists: not is_destroyed
		do
			set_xt_string (screen_object, XmNmnemonicCharSet, a_string)
		ensure
			set: mnemonic_char_set.is_equal (a_string)
		end;

	set_num_columns (a_number: INTEGER) is
			-- Set `num_columns' to `a_number'.
		require
			exists: not is_destroyed;
			a_number_large_enough: a_number > 0
		do
			set_xt_short (screen_object, XmNnumColumns, a_number)
		ensure
			num_columns_set: num_columns = a_number
		end;

	set_resize_height (b: BOOLEAN) is
			-- Set `resize_height' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNresizeHeight, b)
		ensure
			resize_height_set: resize_height = b
		end;

	set_resize_width (b: BOOLEAN) is
			-- Set `resize_width' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNresizeWidth, b)
		ensure
			resize_width_set: resize_width = b
		end;

	set_horizontal (b: BOOLEAN) is
			-- Set `is_horizontal' to `b'.
		require
			exists: not is_destroyed
		do
			if b then
				set_xt_unsigned_char (screen_object, XmNorientation, XmHORIZONTAL)
			else
				set_xt_unsigned_char (screen_object, XmNorientation, XmVERTICAL)
			end
		ensure
			value_set: is_horizontal = b
		end;

	set_packing_tight is
			-- Set `packing_tight'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNpacking, XmPACK_TIGHT)
		ensure
			packing_tight_set: packing_tight
		end;

	set_packing_column is
			-- Set `packing_column'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNpacking, XmPACK_COLUMN)
		ensure
			packing_column_set: packing_column
		end;

	set_packing_none is
			-- Set `packing_none'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNpacking, XmPACK_NONE)
		ensure
			packing_none_set: packing_none
		end;

	set_popup_enabled (b: BOOLEAN) is
			-- Set `is_popup_enabled' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNpopupEnabled, b)
		ensure
			popup_is_enabled: is_popup_enabled = b
		end;

	set_radio_always_one (b: BOOLEAN) is
			-- Set `radio_always_one' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNradioAlwaysOne, b)
		ensure
			radio_always_one_set: radio_always_one = b
		end;

	set_radio_behavior (b: BOOLEAN) is
			-- Set `radio_behavior' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNradioBehavior, b)
		ensure
			radio_behavior_set: radio_behavior = b
		end;

	set_tear_off_enabled (b: BOOLEAN) is
			-- Set `is_tear_off_enabled' to `b'.
		require
			exists: not is_destroyed
		do
			if b then
				set_xt_unsigned_char (screen_object, XmNtearOffModel, XmTEAR_OFF_ENABLED)
			else
				set_xt_unsigned_char (screen_object, XmNtearOffModel, XmTEAR_OFF_DISABLED)
			end
		ensure
			tear_off_is_enabled: is_tear_off_enabled = b
		end;

feature -- Resizing

	set_entry_border (a_width: INTEGER) is
			-- Set `entry_border' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNentryBorder, a_width)
		ensure
			entry_border_set: entry_border = a_width
		end;

	set_margin_height (a_height: INTEGER) is
			-- Set `margin_height' to `a_height'.
		require
			exists: not is_destroyed;
			not_margin_height_negative: a_height >= 0
		do
			set_xt_dimension (screen_object, XmNmarginHeight, a_height)
		ensure
			margin_height_set: margin_height = a_height
		end;

	set_margin_width (a_width: INTEGER) is
			-- Set `margin_width' to `a_width'.
		require
			exists: not is_destroyed;
			not_margin_width_negative: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNmarginWidth, a_width)
		ensure
			margin_width_set: margin_width = a_width
		end;

	set_spacing (a_spacing: INTEGER) is
			-- Set `spacing' to `a_spacing'.
		require
			exists: not is_destroyed;
			not_spacing_negative: a_spacing >= 0
		do
			set_xt_dimension (screen_object, XmNspacing, a_spacing)
		ensure
			spacing_set: spacing = a_spacing
		end;

feature -- Miscellaneaous

	widget_position (a_widget: MEL_RECT_OBJ): INTEGER is
			-- Position of `a_widget' in Current's list of children
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			Result := get_xt_short (a_widget.screen_object, XmNpositionIndex)
		ensure
			position_large_enough: Result >=0;
			position_small_enough: Result < children_count
		end;

	set_widget_position (a_widget: MEL_RECT_OBJ; a_position: INTEGER) is
			-- Set `widget_position' of `a_widget' to `a_position'.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position < children_count
		do
			set_xt_short (a_widget.screen_object, XmNpositionIndex, a_position)
		ensure
			position_set: widget_position (a_widget) = a_position;
		end;

	set_widget_at_last_position (a_widget: MEL_RECT_OBJ) is
			-- Set `widget_position' of `a_widget' to the last position.
		require
			exists: not is_destroyed;
			a_widget_is_a_child: a_widget /= Void and then
								 not a_widget.is_destroyed and then
								 a_widget.parent = Current
		do
			set_xt_short (a_widget.screen_object, XmNpositionIndex, XmLAST_POSITION)
		ensure
			is_at_the_end: widget_position (a_widget) = children_count
		end;

feature -- Element change

	add_entry_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when any button is pressed or when its
			-- value changes.
	   require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNentryCallback, a_callback, an_argument)
		end;

	add_tear_off_menu_activate_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when a tear-off menu pane is going to
			-- be torn on.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNtearOffMenuActivateCallback, a_callback, an_argument)
		end;

	add_tear_off_menu_deactivate_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when a tear-off menu pane is going to
			-- be deactivated.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNtearOffMenuDeactivateCallback, a_callback, an_argument)
		end;

	add_map_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the widget is mapped, if the
			-- widget is a child of a dialog shell.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNmapCallback, a_callback, an_argument)
		end;

	add_unmap_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the widget is unmapped, if the
			-- widget is a child of a dialog shell.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNunmapCallback, a_callback, an_argument)
		end;

feature -- Removal

	remove_entry_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when any button is pressed or when its
			-- value changes.
	   require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNentryCallback, a_callback, an_argument)
		end;

	remove_tear_off_menu_activate_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when a tear-off menu pane is going to
			-- be torn on.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNtearOffMenuActivateCallback, a_callback, an_argument)
		end;

	remove_tear_off_menu_deactivate_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when a tear-off menu pane is going to
			-- be deactivated.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNtearOffMenuDeactivateCallback, a_callback, an_argument)
		end;

	remove_map_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the widget is mapped, if the
			-- widget is a child of a dialog shell.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNmapCallback, a_callback, an_argument)
		end;

	remove_unmap_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the widget is unmapped, if the
			-- widget is a child of a dialog shell.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNunmapCallback, a_callback, an_argument)
		end;

feature {MEL_DISPATCHER} -- Basic operations

	create_callback_struct (a_callback_struct_ptr, 
				resource_name: POINTER): MEL_ROW_COLUMN_CALLBACK_STRUCT is
			-- Create the callback structure specific to this widget
			-- according to `a_callback_struct_ptr'.
		do
			!! Result.make (Current, a_callback_struct_ptr)
		end;

feature {NONE} -- Implementation

	orientation: INTEGER is
			-- Direction in which the widget is displayed
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNorientation)
		end;

	xm_create_row_column (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/RowColumn.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateRowColumn"
		end;

end -- class MEL_ROW_COLUMN

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
