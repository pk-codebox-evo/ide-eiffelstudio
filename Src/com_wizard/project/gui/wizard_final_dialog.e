indexing 
	description: "WIZARD_FINAL_DIALOG class created by Resource Bench."

class 
	WIZARD_FINAL_DIALOG

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
			make_by_id (a_parent, Wizard_final_dialog_constant)
			create warnings_check.make_by_id (Current, Warnings_check_constant)
			create information_check.make_by_id (Current, Information_check_constant)
			create stop_check.make_by_id (Current, Stop_check_constant)
			create id_ok.make_by_id (Current, Idok)
			create id_back.make_by_id (Current, id_back_constant)
			create help_button.make_by_id (Current, Help_button_constant)
			create id_cancel.make_by_id (Current, Idcancel)
		end

feature -- Behavior

	setup_dialog is
			-- Initialize dialog.
		do
			Precursor {WIZARD_DIALOG}
			information_check.set_unchecked
			warnings_check.set_unchecked
			if Shared_wizard_environment.output_level = Shared_wizard_environment.Output_all then
				information_check.set_checked
				warnings_check.set_checked
			elseif Shared_wizard_environment.output_level = Shared_wizard_environment.Output_warnings then
				warnings_check.set_checked
			end
		end

	on_ok is
			-- Finish button was clicked.
		do
			if information_check.checked then
				Shared_wizard_environment.set_all_output
			elseif warnings_check.checked then
				Shared_wizard_environment.set_warning_output
			else
				Shared_wizard_environment.set_no_output
			end
			Shared_wizard_environment.set_stop_on_error (not stop_check.checked)
			Precursor {WIZARD_DIALOG}
		end

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
			-- A `notify_code' is received for `control'.
		do
			if control = warnings_check and not warnings_check.checked then
				information_check.set_unchecked
			elseif control = information_check and information_check.checked then
				warnings_check.set_checked
			end
		end

feature -- Access

	warnings_check: WEL_CHECK_BOX
			-- Warning messages check box
			
	information_check: WEL_CHECK_BOX
			-- Information messages check box

	stop_check: WEL_CHECK_BOX
			-- Do not stop on compilation check box

end -- class WIZARD_FINAL_DIALOG

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
