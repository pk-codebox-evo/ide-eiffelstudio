indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IOLE_IN_PLACE_ACTIVE_OBJECT_INTERFACE

inherit
	IOLE_WINDOW_INTERFACE

feature -- Status Report

	translate_accelerator_user_precondition (lpmsg: TAG_MSG_RECORD): BOOLEAN is
			-- User-defined preconditions for `translate_accelerator'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	on_frame_window_activate_user_precondition (f_activate: INTEGER): BOOLEAN is
			-- User-defined preconditions for `on_frame_window_activate'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	on_doc_window_activate_user_precondition (f_activate: INTEGER): BOOLEAN is
			-- User-defined preconditions for `on_doc_window_activate'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	resize_border_user_precondition (prc_border: TAG_RECT_RECORD; p_uiwindow: IOLE_IN_PLACE_UIWINDOW_INTERFACE; f_frame_window: INTEGER): BOOLEAN is
			-- User-defined preconditions for `resize_border'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	enable_modeless_user_precondition (f_enable: INTEGER): BOOLEAN is
			-- User-defined preconditions for `enable_modeless'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	translate_accelerator (lpmsg: TAG_MSG_RECORD)is
			-- Processes menu accelerator-key messages 
			-- from the container's message queue. 
			-- This method should only be used for 
			-- objects created by a DLL object application. 
			-- `lpmsg' [in] Pointer to the message that might 
			-- need to be translated. 
		require
			non_void_message: lpmsg /= Void
			translate_accelerator_user_precondition: translate_accelerator_user_precondition (lpmsg)
		deferred

		end

	on_frame_window_activate (f_activate: INTEGER) is
			-- No description available.
			-- `f_activate' [in].  
		require
			on_frame_window_activate_user_precondition: on_frame_window_activate_user_precondition (f_activate)
		deferred

		end

	on_doc_window_activate (f_activate: INTEGER) is
			-- No description available.
			-- `f_activate' [in].  
		require
			on_doc_window_activate_user_precondition: on_doc_window_activate_user_precondition (f_activate)
		deferred

		end

	resize_border (prc_border: TAG_RECT_RECORD; p_uiwindow: IOLE_IN_PLACE_UIWINDOW_INTERFACE; f_frame_window: INTEGER) is
			-- No description available.
			-- `prc_border' [in].  
			-- `p_uiwindow' [in].  
			-- `f_frame_window' [in].  
		require
			non_void_prc_border: prc_border /= Void
			valid_prc_border: prc_border.item /= default_pointer
			resize_border_user_precondition: resize_border_user_precondition (prc_border, p_uiwindow, f_frame_window)
		deferred

		end

	enable_modeless (f_enable: INTEGER) is
			-- No description available.
			-- `f_enable' [in].  
		require
			enable_modeless_user_precondition: enable_modeless_user_precondition (f_enable)
		deferred

		end

end -- IOLE_IN_PLACE_ACTIVE_OBJECT_INTERFACE

