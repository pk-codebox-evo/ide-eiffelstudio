indexing 
	description: "WIZARD_PS_DIALOG class created by Resource Bench."

class 
	WIZARD_PS_DIALOG

inherit
	WIZARD_DIALOG
		redefine
			setup_dialog,
			on_ok,
			notify
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Create the dialog.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			make_by_id (a_parent, Wizard_ps_dialog_constant)
			create universal_radio.make_by_id (Current, Universal_radio_constant)
			create standard_radio.make_by_id (Current, Standard_radio_constant)
			create id_ok.make_by_id (Current, Idok)
			create proxy_stub_file_edit.make_by_id (Current, Proxy_stub_file_edit_constant)
			create id_back.make_by_id (Current, Idback_constant)
			create browse_button.make_by_id (Current, Browse_button_constant)
			create help_button.make_by_id (Current, Help_button_constant)
			create id_cancel.make_by_id (Current, Idcancel)
			create msg_box.make
		end

feature -- Behavior

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
		do
			if control = universal_radio then
				proxy_stub_file_edit.disable
				browse_button.disable
			elseif control = standard_radio then
				proxy_stub_file_edit.enable
				browse_button.enable
			elseif control = browse_button then
				File_selection_dialog.activate (Current)
				if File_selection_dialog.selected then
					proxy_stub_file_edit.set_text (file_selection_dialog.file_name)
				end				
			end
		end

	setup_dialog is
			-- Initialize radio buttons.
		do
			uncheck_all
			if shared_wizard_environment.use_universal_marshaller then
				universal_radio.set_checked
			else
				standard_radio.set_checked
				proxy_stub_file_edit.enable
				browse_button.enable
			end
			if shared_wizard_environment.proxy_stub_file_name /= Void then
				proxy_stub_file_edit.set_text (shared_wizard_environment.proxy_stub_file_name)
			end
		end

	on_ok is
			-- Process next button activation
		local
			a_file: RAW_FILE
		do
			shared_wizard_environment.set_use_universal_marshaller (universal_radio.checked)
			if not universal_radio.checked then
				if proxy_stub_file_edit.text /= Void and then not proxy_stub_file_edit.text.empty then
					!! a_file.make (proxy_stub_file_edit.text)
					if a_file.exists then
						shared_wizard_environment.set_proxy_stub_file_name (proxy_stub_file_edit.text)
						Precursor {WIZARD_DIALOG}
					else
						msg_box.error_message_box (Current, "Proxy/Stub file not valid!", "Wizard Error")
					end
				else
					msg_box.error_message_box (Current, "Proxy/Stub file empty!", "Wizard Error")
				end
			else
				Precursor {WIZARD_DIALOG}
			end
		end

feature -- Access

	universal_radio: WEL_RADIO_BUTTON
			-- Universal marshaling radio button

	standard_radio: WEL_RADIO_BUTTON
			-- Standard marshaling radio button

	proxy_stub_file_edit: WEL_SINGLE_LINE_EDIT
			-- Proxy/Stub file edit
 
	marshaling_static: WEL_GROUP_BOX
			-- Marshaling group box title

	browse_button: WEL_PUSH_BUTTON
			-- Browse button

	File_selection_dialog: WEL_OPEN_FILE_DIALOG is
			-- File selection dialog
		once
			create Result.make
			Result.set_filter (<<"Dynamic Link Library (*.dll)">>, <<"*.dll">>)
		end

	msg_box: WEL_MSG_BOX
			-- Message box

feature {NONE} -- Implementation

	uncheck_all is
			-- Uncheck all buttons.
		do
			universal_radio.set_unchecked
			standard_radio.set_unchecked
		end

end -- class WIZARD_PS_DIALOG

--|-------------------------------------------------------------------
--| This class was automatically generated by Resource Bench
--| Copyright (C) 1996-1997, Interactive Software Engineering, Inc.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------
