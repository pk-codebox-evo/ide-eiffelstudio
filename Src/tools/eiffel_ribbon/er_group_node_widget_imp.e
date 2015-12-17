note
	description: "[
		Objects that represent an EV_TITLED_WINDOW.
		The original version of this class was generated by EiffelBuild.
		This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
		You should not modify this code by hand, as it will be re-generated every time
		 modifications are made to the project.
		 	]"
	generator: "EiffelBuild"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ER_GROUP_NODE_WIDGET_IMP

inherit
	EV_VERTICAL_BOX
		redefine
			create_interface_objects, initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

feature {NONE}-- Initialization

	frozen initialize
			-- Initialize `Current'.
		do
			Precursor {EV_VERTICAL_BOX}
			initialize_constants

			
				-- Build widget structure.
			extend (common_node)
			extend (l_ev_label_1)
			extend (size_combo_box)
			extend (l_ev_label_2)
			extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (ideal_sizes_large)
			l_ev_horizontal_box_1.extend (ideal_sizes_medium)
			l_ev_horizontal_box_1.extend (ideal_sizes_small)
			extend (l_ev_label_3)
			extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (scale_large)
			l_ev_horizontal_box_2.extend (scale_medium)
			l_ev_horizontal_box_2.extend (scale_small)
			l_ev_horizontal_box_2.extend (scale_popup)

			l_ev_label_1.set_text ("Size definition:")
			l_ev_label_1.align_text_left
			l_ev_label_2.set_text ("Ideal sizes:")
			l_ev_label_2.align_text_left
			l_ev_horizontal_box_1.disable_item_expand (ideal_sizes_large)
			l_ev_horizontal_box_1.disable_item_expand (ideal_sizes_medium)
			l_ev_horizontal_box_1.disable_item_expand (ideal_sizes_small)
			ideal_sizes_large.set_text ("Large")
			ideal_sizes_medium.set_text ("Medium")
			ideal_sizes_small.set_text ("Small")
			l_ev_label_3.set_text ("Scale:")
			l_ev_label_3.align_text_left
			l_ev_horizontal_box_2.disable_item_expand (scale_large)
			l_ev_horizontal_box_2.disable_item_expand (scale_medium)
			l_ev_horizontal_box_2.disable_item_expand (scale_small)
			l_ev_horizontal_box_2.disable_item_expand (scale_popup)
			scale_large.set_text ("Large")
			scale_medium.set_text ("Medium")
			scale_small.set_text ("Small")
			scale_popup.set_text ("Popup")
			integer_constant_set_procedures.extend (agent set_padding (?))
			integer_constant_retrieval_functions.extend (agent default_padding)
			integer_constant_set_procedures.extend (agent set_border_width (?))
			integer_constant_retrieval_functions.extend (agent default_border_width)
			disable_item_expand (common_node)
			disable_item_expand (l_ev_label_1)
			disable_item_expand (size_combo_box)
			disable_item_expand (l_ev_label_2)
			disable_item_expand (l_ev_horizontal_box_1)
			disable_item_expand (l_ev_label_3)
			disable_item_expand (l_ev_horizontal_box_2)

			set_all_attributes_using_constants
			
				-- Connect events.
			size_combo_box.change_actions.extend (agent on_size_text_change)
			ideal_sizes_large.select_actions.extend (agent on_ideal_sizes_large_select)
			ideal_sizes_medium.select_actions.extend (agent on_ideal_sizes_medium_select)
			ideal_sizes_small.select_actions.extend (agent on_ideal_sizes_small_select)
			scale_large.select_actions.extend (agent on_scale_large_select)
			scale_medium.select_actions.extend (agent on_scale_medium_select)
			scale_small.select_actions.extend (agent on_scale_small_select)
			scale_popup.select_actions.extend (agent on_scale_popup_select)

				-- Call `user_initialization'.
			user_initialization
		end
		
	frozen create_interface_objects
			-- Create objects
		do
			
				-- Create all widgets.
			create common_node
			create l_ev_label_1
			create size_combo_box
			create l_ev_label_2
			create l_ev_horizontal_box_1
			create ideal_sizes_large
			create ideal_sizes_medium
			create ideal_sizes_small
			create l_ev_label_3
			create l_ev_horizontal_box_2
			create scale_large
			create scale_medium
			create scale_small
			create scale_popup

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
			user_create_interface_objects
		end


feature -- Access

	common_node: ER_NODE_WIDGET
	size_combo_box: EV_COMBO_BOX
	ideal_sizes_large, ideal_sizes_medium, ideal_sizes_small: EV_RADIO_BUTTON
	scale_large,
	scale_medium, scale_small, scale_popup: EV_CHECK_BUTTON

feature {NONE} -- Implementation

	l_ev_label_1, l_ev_label_2, l_ev_label_3: EV_LABEL
	l_ev_horizontal_box_1, l_ev_horizontal_box_2: EV_HORIZONTAL_BOX

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := True
		end

	user_create_interface_objects
			-- Feature for custom user interface object creation, called at end of `create_interface_objects'.
		deferred
		end

	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	on_size_text_change
			-- Called by `change_actions' of `size_combo_box'.
		deferred
		end
	
	on_ideal_sizes_large_select
			-- Called by `select_actions' of `ideal_sizes_large'.
		deferred
		end
	
	on_ideal_sizes_medium_select
			-- Called by `select_actions' of `ideal_sizes_medium'.
		deferred
		end
	
	on_ideal_sizes_small_select
			-- Called by `select_actions' of `ideal_sizes_small'.
		deferred
		end
	
	on_scale_large_select
			-- Called by `select_actions' of `scale_large'.
		deferred
		end
	
	on_scale_medium_select
			-- Called by `select_actions' of `scale_medium'.
		deferred
		end
	
	on_scale_small_select
			-- Called by `select_actions' of `scale_small'.
		deferred
		end
	
	on_scale_popup_select
			-- Called by `select_actions' of `scale_popup'.
		deferred
		end
	

feature {NONE} -- Constant setting

	frozen set_attributes_using_string_constants
			-- Set all attributes relying on string constants to the current
			-- value of the associated constant.
		local
			s: detachable STRING_32
		do
			from
				string_constant_set_procedures.start
			until
				string_constant_set_procedures.off
			loop
				string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).call (Void)
				s := string_constant_retrieval_functions.i_th (string_constant_set_procedures.index).last_result
				if s /= Void then
					string_constant_set_procedures.item.call ([s])
				end
				string_constant_set_procedures.forth
			end
		end

	frozen set_attributes_using_integer_constants
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

	frozen set_attributes_using_pixmap_constants
			-- Set all attributes relying on pixmap constants to the current
			-- value of the associated constant.
		local
			p: detachable EV_PIXMAP
		do
			from
				pixmap_constant_set_procedures.start
			until
				pixmap_constant_set_procedures.off
			loop
				pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).call (Void)
				p := pixmap_constant_retrieval_functions.i_th (pixmap_constant_set_procedures.index).last_result
				if p /= Void then
					pixmap_constant_set_procedures.item.call ([p])
				end
				pixmap_constant_set_procedures.forth
			end
		end

	frozen set_attributes_using_font_constants
			-- Set all attributes relying on font constants to the current
			-- value of the associated constant.
		local
			f: detachable EV_FONT
		do
			from
				font_constant_set_procedures.start
			until
				font_constant_set_procedures.off
			loop
				font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).call (Void)
				f := font_constant_retrieval_functions.i_th (font_constant_set_procedures.index).last_result
				if f /= Void then
					font_constant_set_procedures.item.call ([f])
				end
				font_constant_set_procedures.forth
			end	
		end

	frozen set_attributes_using_color_constants
			-- Set all attributes relying on color constants to the current
			-- value of the associated constant.
		local
			c: detachable EV_COLOR
		do
			from
				color_constant_set_procedures.start
			until
				color_constant_set_procedures.off
			loop
				color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).call (Void)
				c := color_constant_retrieval_functions.i_th (color_constant_set_procedures.index).last_result
				if c /= Void then
					color_constant_set_procedures.item.call ([c])
				end
				color_constant_set_procedures.forth
			end
		end

	frozen set_all_attributes_using_constants
			-- Set all attributes relying on constants to the current
			-- calue of the associated constant.
		do
			set_attributes_using_string_constants
			set_attributes_using_integer_constants
			set_attributes_using_pixmap_constants
			set_attributes_using_font_constants
			set_attributes_using_color_constants
		end
	
	string_constant_set_procedures: ARRAYED_LIST [PROCEDURE [READABLE_STRING_GENERAL]]
	string_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [STRING_32]]
	integer_constant_set_procedures: ARRAYED_LIST [PROCEDURE [INTEGER]]
	integer_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [INTEGER]]
	pixmap_constant_set_procedures: ARRAYED_LIST [PROCEDURE [EV_PIXMAP]]
	pixmap_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [EV_PIXMAP]]
	integer_interval_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [INTEGER]]
	integer_interval_constant_set_procedures: ARRAYED_LIST [PROCEDURE [INTEGER_INTERVAL]]
	font_constant_set_procedures: ARRAYED_LIST [PROCEDURE [EV_FONT]]
	font_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [EV_FONT]]
	color_constant_set_procedures: ARRAYED_LIST [PROCEDURE [EV_COLOR]]
	color_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [EV_COLOR]]

	frozen integer_from_integer (an_integer: INTEGER): INTEGER
			-- Return `an_integer', used for creation of
			-- an agent that returns a fixed integer value.
		do
			Result := an_integer
		end

end
