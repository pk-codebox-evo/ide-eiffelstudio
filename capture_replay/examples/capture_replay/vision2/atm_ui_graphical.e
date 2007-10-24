indexing
	description	: "Graphical user interface for the atm"
	author		: "Stefan Sieber"
	date		: "$Date$"
	revision	: "1.0.0"

class
	ATM_UI_GRAPHICAL

inherit
	ATM_UI
	undefine
		default_create,
		copy
	redefine
		make
	end

	EV_TITLED_WINDOW
		undefine
			is_observed
		redefine
			initialize,
			is_in_default_state
		end

	GUI_INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create,
			copy,
			is_observed
		end

create
	make


feature -- Access

	gui_application: EV_APPLICATION

feature -- Basic operations

	initialize_gui_application is

		once
		  create gui_application
		end

	run is
			-- run the ui.
		do
			show
			gui_application.launch
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

feature {NONE} -- Initialization

	make (an_atm: ATM) is
			--
		do
			atm := an_atm
			initialize_gui_application
			default_create
		end


	initialize is
			-- Build the interface for this window.
		do
			Precursor {EV_TITLED_WINDOW}

			build_main_container
			extend (main_container)

				-- Execute `request_close_window' when the user clicks
				-- on the cross in the title bar.
			close_request_actions.extend (agent request_close_window)

				-- Set the title of the window
			set_title (Window_title)

				-- Set the initial size of the window
			set_size (Window_width, Window_height)
		end

	is_in_default_state: BOOLEAN is
			-- Is the window in its default state
			-- (as stated in `initialize')
		do
			Result := (width = Window_width) and then
				(height = Window_height) and then
				(title.is_equal (Window_title))
		end

feature {NONE} -- Implementation, Close event

	request_close_window is
			-- The user wants to close the window
		local
			question_dialog: EV_CONFIRMATION_DIALOG
		do
			create question_dialog.make_with_text (Label_confirm_close_window)
			question_dialog.show_modal_to_window (Current)

			if question_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
					-- Destroy the window
				destroy;

					-- End the application
					--| TODO: Remove this line if you don't want the application
					--|       to end when the first window is closed..
				(create {EV_ENVIRONMENT}).application.destroy
			end
		end

feature {NONE} -- Implementation

	main_container: EV_VERTICAL_BOX
			-- Main container (contains all widgets displayed in this window)

	balance_label: EV_LABEL
			-- Label for displaying current balance

	amount_text_field: EV_TEXT_FIELD
			-- Text field for entering an amount of money

	deposit_button: EV_BUTTON
			-- Button for depositing money

	withdraw_button: EV_BUTTON
			-- Button for withdrawing money

	status_bar: EV_STATUS_BAR
			-- Status bar

	status_label: EV_LABEL
			-- Label for status message

	build_main_container is
			-- Create and populate `main_container'.
		require
			main_container_not_yet_created: main_container = Void
		local
			l_frame: EV_FRAME
		do
			create main_container
			create balance_label
			create amount_text_field
			create deposit_button.make_with_text_and_action ("Deposit", agent deposit_amount)
			create withdraw_button.make_with_text_and_action ("Withdraw", agent withdraw_amount)
			create status_bar
			create status_label.make_with_text ("")
			create l_frame

			main_container.extend (balance_label)
			main_container.extend (amount_text_field)
			main_container.extend (deposit_button)
			main_container.extend (withdraw_button)
			l_frame.extend (status_label)
			status_bar.extend (l_frame)
			main_container.extend (status_bar)
			update_balance_label
		ensure
			main_container_created: main_container /= Void
		end

	update_balance_label is
			--
		local
			l_text: STRING
		do
			l_text := "Current Balance: "
			l_text.append (atm.balance_for_account_name (account_name).out)
			balance_label.set_text (l_text)
		end

	read_amount is
			--
		local
			l_label: EV_LABEL
		do
			last_amount := 0
			status_label.text.wipe_out
			if amount_text_field.text.is_integer then
				last_amount := amount_text_field.text.to_integer
			else
				status_label.text.append ("Please insert an correct amount")
			end
		end

	last_amount: INTEGER

feature -- Access

	account_name:STRING is "test"

feature {NONE} -- Bank account operations

	deposit_amount is
			--
		do
			read_amount
			if last_amount /= 0 then
				atm.deposit (account_name, last_amount)
				update_balance_label
			end
		end

	withdraw_amount is
			--
		local
			l_amount: INTEGER
		do
			read_amount
			if last_amount /= 0 then
				atm.withdraw (account_name, last_amount)
				update_balance_label
			end
		end

feature {NONE} -- Implementation / Constants

	Window_title: STRING is "My Bank Account"
			-- Title of the window.

	Window_width: INTEGER is 400
			-- Initial width for this window.

	Window_height: INTEGER is 400
			-- Initial height for this window.

invariant
	atm_not_void: atm /= Void

end
