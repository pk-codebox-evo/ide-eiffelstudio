note
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
	ENVIRONMENT_CONFIG_PANEL_IMP

inherit
	EV_VERTICAL_BOX
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

feature {NONE}-- Initialization

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_VERTICAL_BOX}
			initialize_constants
			
				-- Create all widgets.
			create l_ev_frame_1
			create l_ev_vertical_box_1
			create chk_preference
			create l_ev_frame_2
			create l_ev_vertical_box_2
			create chk_editing_layout
			create chk_debug_layout
			
				-- Build widget structure.
			extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (chk_preference)
			extend (l_ev_frame_2)
			l_ev_frame_2.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (chk_editing_layout)
			l_ev_vertical_box_2.extend (chk_debug_layout)
			
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
			l_ev_frame_1.set_text ("Environment")
			l_ev_vertical_box_1.set_border_width (4)
			l_ev_vertical_box_1.disable_item_expand (chk_preference)
			chk_preference.enable_select
			chk_preference.set_text ("Preferences")
			chk_preference.set_tooltip ("Cleans EiffelStudio's preferences, when checked.")
			l_ev_frame_2.set_text ("Docking")
			l_ev_vertical_box_2.set_border_width (4)
			l_ev_vertical_box_2.disable_item_expand (chk_editing_layout)
			l_ev_vertical_box_2.disable_item_expand (chk_debug_layout)
			chk_editing_layout.enable_select
			chk_editing_layout.set_text ("Editing layout")
			chk_editing_layout.set_tooltip ("Cleans EiffelStudio's docking editing layout, when checked.")
			chk_debug_layout.enable_select
			chk_debug_layout.set_text ("Debugging layout")
			chk_debug_layout.set_tooltip ("Cleans EiffelStudio's docking debug layout, when checked.")
			set_padding (4)
			disable_item_expand (l_ev_frame_1)
			disable_item_expand (l_ev_frame_2)
			
			set_all_attributes_using_constants
			
				-- Connect events.
			chk_preference.select_actions.extend (agent on_environment_preference_changed)
			chk_editing_layout.select_actions.extend (agent on_environment_layout_changed)
			chk_debug_layout.select_actions.extend (agent on_environment_debug_changed)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end


feature -- Access

	chk_preference, chk_editing_layout, chk_debug_layout: EV_CHECK_BUTTON

feature {NONE} -- Implementation

	l_ev_vertical_box_1, l_ev_vertical_box_2: EV_VERTICAL_BOX
	l_ev_frame_1, l_ev_frame_2: EV_FRAME

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	on_environment_preference_changed
			-- Called by `select_actions' of `chk_preference'.
		deferred
		end
	
	on_environment_layout_changed
			-- Called by `select_actions' of `chk_editing_layout'.
		deferred
		end
	
	on_environment_debug_changed
			-- Called by `select_actions' of `chk_debug_layout'.
		deferred
		end
	
	
feature {NONE} -- Constant setting

	set_attributes_using_string_constants
			-- Set all attributes relying on string constants to the current
			-- value of the associated constant.
		local
			s: STRING_GENERAL
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
		
	set_attributes_using_integer_constants
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
		
	set_attributes_using_pixmap_constants
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
		
	set_attributes_using_font_constants
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
		
	set_attributes_using_color_constants
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
		
	set_all_attributes_using_constants
			-- Set all attributes relying on constants to the current
			-- calue of the associated constant.
		do
			set_attributes_using_string_constants
			set_attributes_using_integer_constants
			set_attributes_using_pixmap_constants
			set_attributes_using_font_constants
			set_attributes_using_color_constants
		end
					
	string_constant_set_procedures: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [STRING_GENERAL]]]
	string_constant_retrieval_functions: ARRAYED_LIST [FUNCTION [ANY, TUPLE [], STRING_GENERAL]]
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
	
	integer_from_integer (an_integer: INTEGER): INTEGER
			-- Return `an_integer', used for creation of
			-- an agent that returns a fixed integer value.
		do
			Result := an_integer
		end

end
