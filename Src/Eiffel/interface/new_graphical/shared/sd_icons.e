indexing
	description: "All the icons requied by docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_ICONS

inherit

	SD_ICONS_SINGLETON
		redefine
			tool_bar_separator_icon
		end

	EB_SHARED_PIXMAPS

	EB_SHARED_CURSORS

create
	make

feature {NONE} -- Initlization
	make is
			-- Creation method
		do
			init
			create internal_shared
		end

feature -- Implementation

	sd_shared: SD_SHARED is
			--
		do
			create Result
		end

	unstick: EV_PIXMAP is
			-- Unstick icon pixmap.
		once
			Result := mini_pixmaps.toolbar_unpinned_icon
		end

	stick: 	EV_PIXMAP is
			-- Stick icon pixmap.
		once
			Result := mini_pixmaps.toolbar_pinned_icon
		end

	minimize: EV_PIXMAP is
			-- Minimize icon pixmap.
		once
			Result := mini_pixmaps.toolbar_minimize_icon
		end

	maximize: EV_PIXMAP is
				-- Maximize icon pixmap.
		once
			Result := mini_pixmaps.toolbar_maximize_icon
		end

	normal: EV_PIXMAP is
			-- Minimize icon pixmap.
		once
			Result := mini_pixmaps.toolbar_restore_icon
		end

	close: EV_PIXMAP is
			-- close icon pixmap.
		once
			Result := mini_pixmaps.toolbar_close_icon
		end

	default_icon: EV_PIXMAP is
			-- Redefine
		local
			l_icons: EV_STOCK_PIXMAPS
		once
			create l_icons
			Result := l_icons.default_window_icon
		end

	tool_bar_separator_icon: EV_PIXMAP is
			-- Refefine
		once
			Result := pixmap_from_constant (icon_toolbar_separator_value)
		end

	hide_tab_indicator (a_hide_number: INTEGER): EV_PIXMAP is
			-- Hide tab indicator.
		local
			l_colors: EV_STOCK_COLORS
			l_font: EV_FONT
			l_orignal: EV_PIXMAP
		do
			l_orignal := mini_pixmaps.toolbar_expand_icon
			Result := l_orignal.sub_pixmap (create {EV_RECTANGLE}.make (0, 0, l_orignal.width, l_orignal.height))
--
--			create l_colors
--			Result.set_background_color (l_colors.default_background_color)
--
--			if a_hide_number < 10 then
--				Result.set_size (18, Result.height)
--			elseif a_hide_number < 100 then
--				Result.set_size (20, Result.height)
--			end
----			Result.set_minimum_width (Result.width)
--			create l_font
--			l_font.set_height (8)
--			Result.set_font (l_font)
--
--			Result.draw_text_top_left (Result.width - 7, 2, a_hide_number.out)
		end

	tool_bar_indicator: EV_PIXMAP is
			-- Redefine.
		do
--			Result := pixmap_from_constant (hide_tab_indicator_s)
			Result := mini_pixmaps.toolbar_expand_icon
		end

	tool_bar_customize_indicator: EV_PIXMAP is
			-- Redefine.
		do
			Result := icons_8_16.tool_bar_customize_indicator_icon
		end

	tool_bar_customize_indicator_buffer: EV_PIXEL_BUFFER is
			-- Redefine.
		do
			Result := icons_8_16.tool_bar_customize_indicator_hidden_items_icon_buffer
		end

	tool_bar_customize_indicator_horizontal: EV_PIXMAP is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("8_16_indicator_horizontal.png")
			Result.set_with_named_file (l_file_name)

		end

	tool_bar_customize_indicator_horizontal_buffer: EV_PIXEL_BUFFER is
			-- Redefine
		do

		end

	tool_bar_customize_indicator_with_hidden_items_horizontal: EV_PIXMAP is
			-- Redefine
		once

		end

	tool_bar_customize_indicator_with_hidden_items_horizontal_buffer: EV_PIXEL_BUFFER is
			-- Redefine
		once

		end

	tool_bar_customize_indicator_with_hidden_items_buffer: EV_PIXEL_BUFFER is
			-- Redefine
		once

		end

	tool_bar_customize_indicator_with_hidden_items: EV_PIXMAP is
			-- Redefine.
		do
			Result := icons_8_16.tool_bar_customize_indicator_hidden_items_icon
		end

	tool_bar_floating_customize: EV_PIXMAP is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("tool_bar_title_bar.png")
			Result.set_with_named_file (l_file_name)
		end

	tool_bar_floating_close: EV_PIXMAP is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("tool_bar_title_bar_close.png")
			Result.set_with_named_file (l_file_name)
		end

	tool_bar_customize_dialog: EV_PIXMAP is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("default_window_icon.png")
			Result.set_with_named_file (l_file_name)
		end

--	big_icons: SD_BIG_ICONS is
--			--
--		once
--			create Result
--		end

	icons_8_16: SD_ICONS_8_16 is
			--
		local
			l_file_name: FILE_NAME
		once
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("smart_docking_icon_matrix_8_16.png")
			create Result.make (l_file_name)
		end

	icons_16_8: SD_ICONS_8_16_HORIZONTAL is
			--
		local
			l_file_name: FILE_NAME
		once
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("smart_docking_icon_matrix_16_8.png")
			create Result.make (l_file_name)
		end

	drag_pointer_up: EV_POINTER_STYLE is
			-- Redefine
		do
			create Result.make_with_pixel_buffer (icon_cursors.docking_up_cursor_cursor_buffer, 16, 16)
		end

	drag_pointer_down: EV_POINTER_STYLE is
			-- Redefine
		do
			create Result.make_with_pixel_buffer (icon_cursors.docking_down_cursor_cursor_buffer, 16, 16)
		end

	drag_pointer_left: EV_POINTER_STYLE is
			-- Redefine
		do
			create Result.make_with_pixel_buffer (icon_cursors.docking_left_cursor_cursor_buffer, 16, 16)
		end

	drag_pointer_right: EV_POINTER_STYLE is
			-- Redefine
		do
			create Result.make_with_pixel_buffer (icon_cursors.docking_right_cursor_cursor_buffer, 16, 16)
		end

	drag_pointer_center: EV_POINTER_STYLE is
			-- Redefine
		local
			l_screen: EV_SCREEN
		do
			create Result.make_with_pixel_buffer (icon_cursors.docking_tabify_cursor_cursor_buffer, 16, 16)

			create l_screen
			l_screen.draw_pixmap (0, 0, icon_cursors.docking_tabify_cursor)
		end

	drag_pointer_float: EV_POINTER_STYLE is
			-- Redefine
		do
			create Result.make_with_pixel_buffer (icon_cursors.docking_float_cursor_cursor_buffer, 16, 16)
		end

feature -- Feedback indicators

	arrow_indicator_center: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("center.png")
			Result.set_with_named_file (l_file_name)
		end

	arrow_indicator_center_lightening_up: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("center_up_light.png")
			Result.set_with_named_file (l_file_name)
		end

	arrow_indicator_center_lightening_down: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("center_up_light.png")
			Result.set_with_named_file (l_file_name)
		end

	arrow_indicator_center_lightening_left: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("center_left.png")
			Result.set_with_named_file (l_file_name)
		end

	arrow_indicator_center_lightening_right: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("center_right.png")
			Result.set_with_named_file (l_file_name)
		end

	arrow_indicator_center_lightening_center: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("center_center_light.png")
			Result.set_with_named_file (l_file_name)
		end

	arrow_indicator_up: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("up.png")
			Result.set_with_named_file (l_file_name)
		end

	arrow_indicator_down: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("down.png")
			Result.set_with_named_file (l_file_name)
		end

	arrow_indicator_left: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("left.png")
			Result.set_with_named_file (l_file_name)
		end

	arrow_indicator_right: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("right.png")
			Result.set_with_named_file (l_file_name)
		end

	arrow_indicator_up_lightening: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("up_light.png")
			Result.set_with_named_file (l_file_name)
		end

	arrow_indicator_down_lightening: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("down_light.png")
			Result.set_with_named_file (l_file_name)
		end

	arrow_indicator_left_lightening: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("left_light.png")
			Result.set_with_named_file (l_file_name)
		end

	arrow_indicator_right_lightening: EV_PIXEL_BUFFER is
			-- Redefine
		local
			l_file_name: FILE_NAME
		once
			create Result
			create l_file_name.make_from_string (pixmap_path)
			l_file_name.set_file_name ("right_light.png")
			Result.set_with_named_file (l_file_name)
		end

feature -- Right click on tabs context tool bars' icons.

	close_context_tool_bar: EV_PIXMAP  is
			-- Redefine
		once
			Result := icon_pixmaps.general_close_document_icon
		end

	close_others: EV_PIXMAP is
			-- Redefine
		once
			create Result
		end

	close_all: EV_PIXMAP is
			-- Redefine
		once
			Result := icon_pixmaps.general_close_all_documents_icon
		end

feature {NONE}  -- Implementation

	internal_shared: SD_SHARED
			-- All singletons

invariant
	internal_shared_not_void: internal_shared /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
