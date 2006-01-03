indexing
	description: "[
		Objects that represent an EV_TITLED_WINDOW.
		The original version of this class was generated by EiffelBuild.
		This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
		You should not modify this code by hand, as it will be re-generated every time
		 modifications are made to the project.
		 	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_ZONE_NAVIGATION_DIALOG_IMP

inherit
	EV_UNTITLED_DIALOG
		redefine
			initialize, is_in_default_state
		end

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		local
			internal_font: EV_FONT
		do
			Precursor {EV_UNTITLED_DIALOG}

				-- Create all widgets.
			create internal_vertical_box_top
			create internal_label_box
			create internal_tools_box
			create internal_tools_label
			create tools_box.make
			create internal_files_box
			create internal_files_label
			create files_box.make
			create internal_info_box
			create full_title
			create description
			create detail

				-- Build widget structure.
			extend (internal_vertical_box_top)
			internal_vertical_box_top.extend (internal_label_box)
			internal_label_box.extend (internal_tools_box)
			internal_tools_box.extend (internal_tools_label)
			internal_tools_box.disable_item_expand (internal_tools_label)
			internal_tools_box.extend (tools_box)
			internal_tools_box.disable_item_expand (tools_box)
			internal_label_box.extend (internal_files_box)
			internal_files_box.extend (internal_files_label)
			internal_files_box.disable_item_expand (internal_files_label)
			internal_files_box.extend (files_box)
			internal_files_box.disable_item_expand (files_box)
			internal_vertical_box_top.extend (internal_info_box)
			internal_info_box.extend (full_title)
			internal_info_box.extend (description)
			internal_info_box.extend (detail)

			create string_constant_set_procedures.make (10)
			create string_constant_retrieval_functions.make (10)
			create integer_constant_set_procedures.make (10)
			create integer_constant_retrieval_functions.make (10)
			create pixmap_constant_set_procedures.make (10)
			create pixmap_constant_retrieval_functions.make (10)
			create integer_interval_constant_retrieval_functions.make (10)
			create integer_interval_constant_set_procedures.make (10)
			create font_constant_set_procedures.make (10)
			create font_constant_retrieval_functions.make (10)
			create pixmap_constant_retrieval_functions.make (10)
			create color_constant_set_procedures.make (10)
			create color_constant_retrieval_functions.make (10)
			internal_vertical_box_top.set_padding (10)
			internal_vertical_box_top.set_border_width (10)
			create internal_font
			internal_font.set_family (feature {EV_FONT_CONSTANTS}.Family_sans)
			internal_font.set_weight (feature {EV_FONT_CONSTANTS}.Weight_bold)
			internal_font.set_shape (feature {EV_FONT_CONSTANTS}.Shape_regular)
			internal_font.set_height_in_points (8)
			internal_font.preferred_families.extend ("Microsoft Sans Serif")
			internal_tools_label.set_font (internal_font)
			internal_tools_label.set_text ("Tools")
			create internal_font
			internal_font.set_family (feature {EV_FONT_CONSTANTS}.Family_sans)
			internal_font.set_weight (feature {EV_FONT_CONSTANTS}.Weight_bold)
			internal_font.set_shape (feature {EV_FONT_CONSTANTS}.Shape_regular)
			internal_font.set_height_in_points (8)
			internal_font.preferred_families.extend ("Microsoft Sans Serif")
			internal_files_label.set_font (internal_font)
			internal_files_label.set_text ("Files")
			internal_info_box.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 0, 0))
			internal_info_box.set_border_width (1)
			internal_info_box.disable_item_expand (full_title)
			full_title.align_text_left
			set_title ("Display window")

			set_all_attributes_using_constants

				-- Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization

			create internal_shared
			init_background (internal_shared.tool_tip_color)
		end

	init_background (a_color: EV_COLOR) is
			-- Set all widget's background color.
		do
			internal_vertical_box_top.set_background_color (a_color)
			internal_label_box.set_background_color (a_color)
			internal_tools_box.set_background_color (a_color)
			internal_tools_label.set_background_color (a_color)
			tools_box.set_background_color (a_color)
			internal_files_box.set_background_color (a_color)
			internal_files_label.set_background_color (a_color)
			files_box.set_background_color (a_color)
--			internal_info_box.set_background_color (a_color)
			full_title.set_background_color (a_color)
			description.set_background_color (a_color)
			detail.set_background_color (a_color)
		end

feature -- Access

	internal_label_box: EV_HORIZONTAL_BOX
	tools_box, files_box: SD_ZONE_NAVIGATION_BOX
	internal_vertical_box_top, internal_tools_box, internal_files_box,
	internal_info_box: EV_VERTICAL_BOX
	internal_tools_label, internal_files_label, full_title,
	description, detail: EV_LABEL

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end

	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end

feature {NONE} -- Constant setting

	set_attributes_using_string_constants is
			-- Set all attributes relying on string constants to the current
			-- value of the associated constant.
		local
			s: STRING
		do
			from
				string_constant_set_procedures.start
			until
				string_constant_set_procedures.off
			loop
				string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).call (Void)
				s := string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).last_result
				string_constant_set_procedures.item.call ([s])
				string_constant_set_procedures.forth
			end
		end

	set_attributes_using_integer_constants is
			-- Set all attributes relying on integer constants to the current
			-- value of the associated constant.
		local
			i: INTEGER
			arg1, arg2: INTEGER
			int: INTEGER_INTERVAL
		do
			from
				integer_constant_set_procedures.start
			until
				integer_constant_set_procedures.off
			loop
				integer_constant_retrieval_functions.i_th (integer_constant_set_procedures.index).call (Void)
				i := integer_constant_retrieval_functions.i_th (integer_constant_set_procedures.index).last_result
				integer_constant_set_procedures.item.call ([i])
				integer_constant_set_procedures.forth
			end
			from
				integer_interval_constant_retrieval_functions.start
				integer_interval_constant_set_procedures.start
			until
				integer_interval_constant_retrieval_functions.off
			loop
				integer_interval_constant_retrieval_functions.item.call (Void)
				arg1 := integer_interval_constant_retrieval_functions.item.last_result
				integer_interval_constant_retrieval_functions.forth
				integer_interval_constant_retrieval_functions.item.call (Void)
				arg2 := integer_interval_constant_retrieval_functions.item.last_result
				create int.make (arg1, arg2)
				integer_interval_constant_set_procedures.item.call ([int])
				integer_interval_constant_retrieval_functions.forth
				integer_interval_constant_set_procedures.forth
			end
		end

	set_attributes_using_pixmap_constants is
			-- Set all attributes relying on pixmap constants to the current
			-- value of the associated constant.
		local
			p: EV_PIXMAP
		do
			from
				pixmap_constant_set_procedures.start
			until
				pixmap_constant_set_procedures.off
			loop
				pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).call (Void)
				p := pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).last_result
				pixmap_constant_set_procedures.item.call ([p])
				pixmap_constant_set_procedures.forth
			end
		end

	set_attributes_using_font_constants is
			-- Set all attributes relying on font constants to the current
			-- value of the associated constant.
		local
			f: EV_FONT
		do
			from
				font_constant_set_procedures.start
			until
				font_constant_set_procedures.off
			loop
				font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).call (Void)
				f := font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).last_result
				font_constant_set_procedures.item.call ([f])
				font_constant_set_procedures.forth
			end
		end

	set_attributes_using_color_constants is
			-- Set all attributes relying on color constants to the current
			-- value of the associated constant.
		local
			c: EV_COLOR
		do
			from
				color_constant_set_procedures.start
			until
				color_constant_set_procedures.off
			loop
				color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).call (Void)
				c := color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).last_result
				color_constant_set_procedures.item.call ([c])
				color_constant_set_procedures.forth
			end
		end

	set_all_attributes_using_constants is
			-- Set all attributes relying on constants to the current
			-- calue of the associated constant.
		do
			set_attributes_using_string_constants
			set_attributes_using_integer_constants
			set_attributes_using_pixmap_constants
			set_attributes_using_font_constants
			set_attributes_using_color_constants
		end

	string_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [STRING]]]
	string_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], STRING]]
	integer_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [INTEGER]]]
	integer_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], INTEGER]]
	pixmap_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_PIXMAP]]]
	pixmap_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], EV_PIXMAP]]
	integer_interval_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], INTEGER]]
	integer_interval_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [INTEGER_INTERVAL]]]
	font_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_FONT]]]
	font_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], EV_FONT]]
	color_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [EV_COLOR]]]
	color_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], EV_COLOR]]

	integer_from_integer (an_integer: INTEGER): INTEGER is
			-- Return `an_integer', used for creation of
			-- an agent that returns a fixed integer value.
		do
			Result := an_integer
		end

feature {NONE}  -- Implementation

	internal_shared: SD_SHARED
			-- All singletons.

invariant

	internal_shared_not_void: internal_shared /= Void

end -- class SD_ZONE_NAVIGATION_DIALOG_IMP
