indexing
	description: ""
	
class
	HELLO_WORLD


create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Entry point."
		local
			dummy: SYSTEM_OBJECT
		do
			create my_window.make
			initialize_components
			
			dummy := my_window.show_dialog
		end

feature -- Access

	my_window: WINFORMS_FORM
			-- Main window.

	components: SYSTEM_DLL_SYSTEM_CONTAINER	
			-- System.ComponentModel.Container
	
	my_button: WINFORMS_BUTTON			
			-- System.Windows.Forms.Button
	
	my_text_box: WINFORMS_TEXT_BOX		
			-- System.Windows.Forms.TextBox 

feature -- Implementation

	initialize_components is
			--
		local
			l_size: DRAWING_SIZE
			l_location: DRAWING_POINT
		do
			create components.make
			create my_button.make
			create my_text_box.make
			
				-- Initialize window.
			my_window.set_text (("Hello world").to_cil)
--			my_window.set_auto_scale_base_size (create {DRAWING_SIZE}.make_from_width_and_height (5, 13))
			l_size.make_from_width_and_height (5, 13)
			my_window.set_auto_scale_base_size (l_size)
			my_window.set_accessible_role (feature {WINFORMS_ACCESSIBLE_ROLE}.window)
			my_window.set_accessible_name (("AccessibleForm").to_cil)
			my_window.set_accept_button (my_button)
			my_window.set_accessible_description (("Simple Form that demonstrates accessibility").to_cil)
--			set_client_size_size (create {DRAWING_SIZE}.make_from_width_and_height (392, 117))
			
				-- Initialize my_button.
			my_button.set_accessible_description (("Once you've entered some text push this my_button").to_cil)
--			my_button.set_size_size (create {DRAWING_SIZE}.make_from_width_and_height (120, 40))
			l_size.make_from_width_and_height (120, 40)
			my_button.set_size (l_size)
			my_button.set_tab_index (1)
			my_button.set_anchor (feature {WINFORMS_ANCHOR_STYLES}.bottom | feature {WINFORMS_ANCHOR_STYLES}.right)
--			my_button.set_location (create {DRAWING_POINT}.make_from_x_and_y (256, 64))
			l_location.make_from_x_and_y (256, 64)
			my_button.set_location (l_location)
			my_button.set_text (("Click Me!").to_cil)
			my_button.set_accessible_name (("DefaultAction").to_cil)
			my_button.add_click (create {EVENT_HANDLER}.make (Current, $my_button_clicked))
			
				-- Initialize my_text_box.
--			my_text_box.set_location (create {DRAWING_POINT}.make_from_x_and_y (16, 24))
			l_location.make_from_x_and_y (16, 24)
			my_text_box.set_location (l_location)
			my_text_box.set_text (("Hello WinForms World").to_cil)
			my_text_box.set_accessible_name (("TextEntryField").to_cil)
			my_text_box.set_tab_index (0)
			my_text_box.set_accessible_description (("Please enter some text in the box").to_cil)
--			my_text_box.set_anchor (feature {WINFORMS_ANCHOR_STYLES}.from_integer (13))
--			my_text_box.set_size (create {DRAWING_SIZE}.make_from_width_and_height (360, 20))
			l_size.make_from_width_and_height (360, 20)
			my_text_box.set_size (l_size)
			
			my_window.controls.add (my_button)
			my_window.controls.add (my_text_box)
		end


feature {NONE} -- Implementation

	dispose is
			-- method call when form is disposed.
		local
			dummy: WINFORMS_DIALOG_RESULT
		do
			dummy := feature {WINFORMS_MESSAGE_BOX}.show (("Disposed !").to_cil)
		end
	
	my_button_clicked (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- feature performed when my_button is clicked.
		local
			msg: SYSTEM_STRING
			dummy: WINFORMS_DIALOG_RESULT
		do
			msg := msg.concat_string_string_string (("Text is : '").to_cil, my_text_box.text, ("'").to_cil)
			dummy := feature {WINFORMS_MESSAGE_BOX}.show (msg)
		end
		
end -- class HELLO_WORLD
