indexing 
	description: "WIZARD_FINAL_DIALOG class created by Resource Bench."

class 
	WIZARD_FINAL_DIALOG

inherit
	WIZARD_DIALOG
		redefine
			setup_dialog,
			on_ok
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
			create maximum_radio.make_by_id (Current, Maximum_radio_constant)
			create standard_radio.make_by_id (Current, Standard_radio_constant)
			create minimum_radio.make_by_id (Current, Minimum_radio_constant)
			create id_ok.make_by_id (Current, Idok)
			create id_back.make_by_id (Current, Idback_constant)
			create help_button.make_by_id (Current, Help_button_constant)
			create id_cancel.make_by_id (Current, Idcancel)
			create compile_check.make_by_id (Current, Compile_check_constant)
		end

feature -- Behavior

	setup_dialog is
			-- Initialize dialog.
		do
			minimum_radio.set_unchecked
			maximum_radio.set_unchecked
			standard_radio.set_unchecked
			compile_check.set_checked
			if Shared_wizard_environment.output_level = Shared_wizard_environment.Output_none then
				minimum_radio.set_checked
			elseif Shared_wizard_environment.output_level = Shared_wizard_environment.Output_all then
				maximum_radio.set_checked
			else
				standard_radio.set_checked
			end
			if not Shared_wizard_environment.compile_eiffel then
				compile_check.set_unchecked
			end
		end

	on_ok is
			-- Finish button was clicked.
		do
			if minimum_radio.checked then
				Shared_wizard_environment.set_no_output
			elseif maximum_radio.checked then
				Shared_wizard_environment.set_all_output
			else
				Shared_wizard_environment.set_warning_output
			end
			Shared_wizard_environment.set_compile_eiffel (Compile_check.checked)
			Precursor {WIZARD_DIALOG}
		end
	
feature -- Access

	minimum_radio: WEL_RADIO_BUTTON
			-- Minimum output radio button

	standard_radio: WEL_RADIO_BUTTON
			-- Standard output radio button

	maximum_radio: WEL_RADIO_BUTTON
			-- Maximum output radio button

	Compile_check: WEL_CHECK_BOX
			-- Comile Eiffel check box

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
