indexing 
	description: "WIZARD_IDL_DIALOG class created by Resource Bench."

class 
	WIZARD_IDL_DIALOG

inherit
	WEL_MODAL_DIALOG
		redefine
			notify,
			on_ok,
			setup_dialog
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Create dialog.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
		do
			make_by_id (a_parent, Wizard_idl_dialog_constant)
			create universal2_radio.make_by_id (Current, Universal2_radio_constant)
			create standard2_radio.make_by_id (Current, Standard2_radio_constant)
			create automation2_radio.make_by_id (Current, Automation2_radio_constant)
			create virtual_table2_radio.make_by_id (Current, Virtual_table2_radio_constant)
			create id_ok.make_by_id (Current, Idok)
			create marshaling2_static.make_by_id (Current, Marshaling2_static_constant)
			create type2_static.make_by_id (Current, Type2_static_constant)
			create id_cancel.make_by_id (Current, Idcancel)
			create help_button.make_by_id (Current, Help_button_constant)
		end

feature -- Behavior

	on_ok is
			-- Process Next button activation.
		local
			folder_name, file_name: STRING
			a_file: RAW_FILE
		do
			shared_wizard_environment.set_use_universal_marshaller (universal2_radio.checked)
			shared_wizard_environment.set_automation (automation2_radio.checked)
			Precursor
		end

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
			-- Process `control_id' control notification.
		do
			if control = help_button then
		--		Help_dialog.activate
			elseif control = automation2_radio then
				universal2_radio.disable
				standard2_radio.disable
				universal2_radio.set_checked
				standard2_radio.set_unchecked
			elseif control = virtual_table2_radio then
				universal2_radio.enable
				standard2_radio.enable
			end
		end
	
	setup_dialog is
			-- Initialize dialog's controls.
		do
			uncheck_all
			if shared_wizard_environment.automation then
				automation2_radio.set_checked
				universal2_radio.set_checked
				universal2_radio.disable
				standard2_radio.disable
			else
				universal2_radio.enable
				standard2_radio.enable
				virtual_table2_radio.set_checked
				if shared_wizard_environment.use_universal_marshaller then
					universal2_radio.set_checked
				else
					standard2_radio.set_checked
				end
			end
		end
		
feature -- Access

	automation2_radio: WEL_RADIO_BUTTON
			-- Automation server type radio button

	virtual_table2_radio: WEL_RADIO_BUTTON
			-- Virtual table server type radio button

	universal2_radio: WEL_RADIO_BUTTON
			-- Universal marshaling radio button
	
	standard2_radio: WEL_RADIO_BUTTON
			-- Standard marshaling radio button

	id_ok: WEL_PUSH_BUTTON
			-- Next button

	type2_static: WEL_GROUP_BOX
			-- Server type group title

	marshaling2_static: WEL_GROUP_BOX
			-- Marshaling type group title

	id_cancel: WEL_PUSH_BUTTON
			-- Back button

	help_button: WEL_PUSH_BUTTON
			-- Help button

feature {NONE} -- Implementation

	uncheck_all is
			-- Uncheck all buttons.
		do
			automation2_radio.set_unchecked
			virtual_table2_radio.set_unchecked
			universal2_radio.set_unchecked
			standard2_radio.set_unchecked
		end

end -- class WIZARD_IDL_DIALOG

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
