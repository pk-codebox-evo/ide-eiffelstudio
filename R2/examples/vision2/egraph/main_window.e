note
	description	: "Main window for this application"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Generated by the New Vision2 Application Wizard."
	date		: "$Date$"
	revision	: "1.0.0"

deferred class
	MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			initialize,
			is_in_default_state
		end

	INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create, copy
		end

feature {NONE} -- Initialization

	initialize
			-- Build the interface for this window.
		do
			Precursor {EV_TITLED_WINDOW}

				-- Create and add the menu bar.
			build_standard_menu_bar
			set_menu_bar (standard_menu_bar)

				-- Create and add the toolbar.
			build_standard_toolbar

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

	is_in_default_state: BOOLEAN
			-- Is the window in its default state
			-- (as stated in `initialize')
		do
			Result := (width = Window_width) and then
				(height = Window_height) and then
				(title.is_equal (Window_title))
		end


feature {NONE} -- Menu Implementation

	standard_menu_bar: EV_MENU_BAR
			-- Standard menu bar for this window.

	file_menu: EV_MENU
			-- "File" menu for this window (contains New, Open, Close, Exit...)

	help_menu: detachable EV_MENU
			-- "Help" menu for this window (contains About...)

	build_standard_menu_bar
			-- Create and populate `standard_menu_bar'.
		require
			menu_bar_created: standard_menu_bar /= Void and then standard_menu_bar.is_empty
		do
				-- Add the "File" menu
			build_file_menu
			standard_menu_bar.extend (file_menu)

		ensure
			menu_bar_created:
				standard_menu_bar /= Void and then
				not standard_menu_bar.is_empty
		end

	build_file_menu
			-- Create and populate `file_menu'.
		require
			file_menu_created: file_menu /= Void and then file_menu.is_empty
		local
			menu_item: EV_MENU_ITEM
		do

			create menu_item.make_with_text (Menu_file_new_item)
			menu_item.select_actions.extend (agent on_new)
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_open_item)
			menu_item.select_actions.extend (agent on_open)
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_save_item)
			menu_item.select_actions.extend (agent on_save)
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_saveas_item)
			menu_item.select_actions.extend (agent on_save_as)
			file_menu.extend (menu_item)

			create menu_item.make_with_text (Menu_file_close_item)
			menu_item.select_actions.extend (agent on_new)
			file_menu.extend (menu_item)

			file_menu.extend (create {EV_MENU_SEPARATOR})

				-- Create the File/Exit menu item and make it call
				-- `request_close_window' when it is selected.
			create menu_item.make_with_text (Menu_file_exit_item)
			menu_item.select_actions.extend (agent request_close_window)
			file_menu.extend (menu_item)
		ensure
			file_menu_created: file_menu /= Void and then not file_menu.is_empty
		end

feature {NONE} -- ToolBar Implementation

	standard_toolbar: EV_TOOL_BAR
			-- Standard toolbar for this window

	build_standard_toolbar
			-- Create and populate the standard toolbar.
		require
			toolbar_created: standard_toolbar /= Void and then standard_toolbar.is_empty
		local
			toolbar_item: EV_TOOL_BAR_BUTTON
			toolbar_pixmap: EV_PIXMAP
		do
				-- Create the toolbar.

			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("new.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			toolbar_item.select_actions.extend (agent on_new)
			toolbar_item.set_tooltip (apply_new)
			standard_toolbar.extend (toolbar_item)

			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("open.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			toolbar_item.select_actions.extend (agent on_open)
			toolbar_item.set_tooltip (apply_load)
			standard_toolbar.extend (toolbar_item)

			create toolbar_item
			create toolbar_pixmap
			toolbar_pixmap.set_with_named_file ("save.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			toolbar_item.select_actions.extend (agent on_save)
			toolbar_item.set_tooltip (apply_save)
			standard_toolbar.extend (toolbar_item)
		ensure
			toolbar_created: standard_toolbar /= Void and then  not standard_toolbar.is_empty
		end

feature {NONE} -- Implementation, Close event

	request_close_window
			-- The user wants to close the window
		local
			question_dialog: EV_CONFIRMATION_DIALOG
			l_app: detachable EV_APPLICATION
		do
			create question_dialog.make_with_text (Label_confirm_close_window)
			question_dialog.show_modal_to_window (Current)

			if question_dialog.selected_button ~ ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
					-- Destroy the window
				destroy;

					-- End the application
				l_app := (create {EV_ENVIRONMENT}).application
				check l_app /= Void end -- Implied by application is running
				l_app.destroy
			end
		end

feature {NONE} -- Implementation

	main_container: EV_VERTICAL_BOX
			-- Main container (contains all widgets displayed in this window)

	build_main_container
			-- Create and populate `main_container'.
		require
			main_container_created: main_container /= Void and then main_container.is_empty
		deferred
		end

feature {NONE} -- Implementation / Constants

	Window_title: STRING = "egraph"
			-- Title of the window.

	Window_width: INTEGER = 800
			-- Initial width for this window.

	Window_height: INTEGER = 600
			-- Initial height for this window.

feature {NONE} -- Actions

	on_new
			-- New was selected.
		deferred
		end

	on_save
			-- Save was selected.
		deferred
		end

	on_open
			-- Open was selected.
		deferred
		end

	on_save_as
			-- SaveAs was selected.
		deferred
		end


note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class MAIN_WINDOW
