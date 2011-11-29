note
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ATTRIBUTE_SETTING_PANEL

inherit
	ATTRIBUTE_SETTING_PANEL_IMP

	DOCKING_MANAGER_HODLER
		undefine
			default_create, copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: SD_DOCKING_MANAGER; a_window: like window)
			-- Set `docking_manager' with `a_manager'.
		require
			a_manager_not_void: a_manager /= Void
		do
			docking_manager := a_manager
			window := a_window

			create_all_widgets
			create_all_actions

			default_create
		ensure
			docking_manager_not_void: docking_manager /= Void
			window_not_void: window /= Void
		end

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
--			pixmap_radio_button.enable_select
		end

	create_all_widgets
			-- Create all widgets
		do
			create l_ev_frame_1
			create l_ev_horizontal_box_1
			create apply_button
			create l_ev_button_1
			create l_ev_cell_1
			create l_ev_button_2
			create l_ev_button_3
			create l_ev_button_4
			create l_ev_horizontal_separator_1
			create l_ev_horizontal_box_2
			create l_ev_label_1
			create short_title_field
			create l_ev_horizontal_separator_2
			create l_ev_horizontal_box_3
			create l_ev_label_2
			create long_title_field
			create l_ev_horizontal_separator_3
			create l_ev_horizontal_box_4
			create l_ev_label_3
			create tab_tooltip_field
			create l_ev_horizontal_separator_4
			create l_ev_horizontal_box_5
			create l_ev_label_4
			create description_field
			create l_ev_horizontal_separator_5
			create l_ev_horizontal_box_6
			create l_ev_label_5
			create detail_field
			create l_ev_horizontal_separator_6
			create l_ev_frame_2
			create l_ev_vertical_box_1
			create l_ev_horizontal_box_7
			create pixmap_radio_button
			create pixel_buffer_radio_button
			create l_ev_horizontal_box_8
			create l_ev_label_6
			create pixmap_field
			create browse_pixmap_button
			create l_ev_horizontal_box_9
			create l_ev_label_7
			create pixel_buffer_field
			create browse_pixel_buffer_button
			create l_ev_frame_3
			create mini_toolbar_check_button
		end

	create_all_actions
			-- Create all actions
		do
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
		end

feature {NONE} -- Show/Close/Hide content

	close_focused_content (a_hide: BOOLEAN)
			-- Show focused content.
		local
			l_content: detachable SD_CONTENT
		do
			l_content := docking_manager.focused_content
			if l_content /= Void then
				close_content (l_content, a_hide)
			end
		end

	show_all_content
			-- Show all content
		local
			l_list: ACTIVE_LIST [SD_CONTENT]
		do
			l_list := docking_manager.contents
			from
				l_list.start
			until
				l_list.after
			loop
				l_list.item.show
				l_list.forth
			end
		end


feature -- Element Change

	content_focused (a_content: SD_CONTENT)
			-- Content focused.'
		require
			a_content_not_void: a_content /= Void
		do
			set_attributes (a_content)
		end

	set_attributes (a_content: SD_CONTENT)
			-- Set attributes to fields.
		require
			a_content_not_void: a_content /= Void
		do
			short_title_field.set_text (a_content.short_title)
			long_title_field.set_text (a_content.long_title)

			if attached a_content.tab_tooltip as l_tooltip then
				tab_tooltip_field.set_text (l_tooltip)
			else
				tab_tooltip_field.set_text ("")
			end

			if attached a_content.detail as l_detail then
				detail_field.set_text (l_detail)
			else
				detail_field.set_text ("")
			end

			if attached a_content.description as l_description then
				description_field.set_text (l_description)
			else
				description_field.set_text ("")
			end

			if a_content.mini_toolbar /= Void then
				mini_toolbar_check_button.enable_select
			else
				mini_toolbar_check_button.disable_select
			end
		end

	close_content (a_content: SD_CONTENT; a_hide: BOOLEAN)
			-- Close/hide a content.
		require
			a_content_not_void: a_content /= Void
		do
			if a_hide then
				a_content.hide
			else
				a_content.close
			end
		end

feature -- Status report

	is_pixmap_selected: BOOLEAN
			-- Is pixmap selected?
		do
			Result := pixmap_radio_button.is_selected
		end

	is_mini_tool_bar_enabled: BOOLEAN
			-- Is mini toolbar enabled?
		do
			Result := mini_toolbar_check_button.is_selected
		end

feature {NONE} -- Implementation

	on_hide_content
			-- Called by `select_actions' of l_ev_button_3.
			-- (export status {NONE})
		do
			close_focused_content (True)
		end

	on_close_content
			-- Called by `select_actions' of l_ev_button_4.
			-- (export status {NONE})
		do
			close_focused_content (False)
		end

	refresh
			-- Called by `select_actions' of l_ev_button_1.
		local
			l_content: detachable SD_CONTENT
		do
			l_content := docking_manager.focused_content
			if l_content /= Void then
				set_attributes (l_content)
			end
		end

	on_apply
			-- Called by `select_actions' of `apply_button'.
		local
			l_content: detachable SD_CONTENT
			l_warning_dialog: EV_WARNING_DIALOG
			l_pixmap: EV_PIXMAP
			l_pixel_buffer: EV_PIXEL_BUFFER
			l_string: STRING_32
		do
			l_content := docking_manager.focused_content
			if l_content /= Void then
				l_content.set_short_title (short_title_field.text)
				l_content.set_long_title (long_title_field.text)
				l_content.set_tab_tooltip (tab_tooltip_field.text)
				l_content.set_detail (detail_field.text)
				l_content.set_description (description_field.text)
				if is_pixmap_selected then
					l_string := pixmap_field.text
					if not l_string.is_empty then
						create l_pixmap
						l_pixmap.set_with_named_file (l_string)
						l_content.set_pixmap (l_pixmap)
					else
						create l_pixmap
						l_content.set_pixmap (l_pixmap)
					end
				else
					l_string := pixel_buffer_field.text
					if not l_string.is_empty then
						create l_pixel_buffer
						l_pixel_buffer.set_with_named_file (l_string)
						l_content.set_pixel_buffer (l_pixel_buffer)
					else
						create l_pixel_buffer
						l_content.set_pixel_buffer (l_pixel_buffer)
					end
				end
				if is_mini_tool_bar_enabled then
					l_content.set_mini_toolbar (create {MINI_TOOL_BAR}.make)
				else
						-- No way to remove.
				end
			else
				create l_warning_dialog.make_with_text ("No focused docking content!")
				l_warning_dialog.show_modal_to_window (window)
			end
		end


	on_browse_pixmap
			-- Called by `select_actions' of `browse_pixmap_button'.
		local
			l_dialog: EV_FILE_OPEN_DIALOG
		do
			create l_dialog
			l_dialog.filters.extend (["*.png", "PNG File ('png')"]);
			l_dialog.open_actions.extend (agent on_open_pixmap (l_dialog))
			l_dialog.show_modal_to_window (window)
		end

	on_open_pixmap (a_dialog: EV_FILE_OPEN_DIALOG)
			-- On open pixmap.
		require
			a_dialog_not_void: a_dialog /= Void
		do
			pixmap_field.set_text (a_dialog.file_name)
		end

	pixmap_radio_button_selected
			-- Called by `select_actions' of `pixmap_radio_button'.
		do
		end

	on_browse_pixel_buffer
			-- Called by `select_actions' of `browse_pixel_buffer_button'.
		local
			l_dialog: EV_FILE_OPEN_DIALOG
		do
			create l_dialog
			l_dialog.filters.extend (["*.png", "PNG File ('png')"]);
			l_dialog.open_actions.extend (agent on_open_pixel_buffer (l_dialog))
			l_dialog.show_modal_to_window (window)
		end

	on_open_pixel_buffer (a_dialog: EV_FILE_OPEN_DIALOG)
			-- On open pixel buffer.
		require
			a_dialog_not_void: a_dialog /= Void
		do
			pixel_buffer_field.set_text (a_dialog.file_name)
		end

	pixel_buffer_radio_button_selected
			-- Called by `select_actions' of `pixel_buffer_radio_button'.
		do
		end

invariant

	docking_manager_not_void: docking_manager /= Void
	window_not_void: window /= Void

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

end
