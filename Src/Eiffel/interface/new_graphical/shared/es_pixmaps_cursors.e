indexing
	description: "An Eiffel pixmap matrix accessor, generated by Eiffel Matrix Generator."
	legal      : "See notice at end of class."
	status     : "See notice at end of class."
	date       : "$Date$"
	revision   : "$Revision$"

class
	ES_PIXMAPS_CURSORS
	
create
	make

feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Initialize matrix
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_file: FILE_NAME
			l_warn: EV_WARNING_DIALOG
			retried: BOOLEAN
		do
			if not retried then
				create l_file.make_from_string ((create {EIFFEL_ENV}).bitmaps_path)
				l_file.set_subdirectory ("png")
				l_file.set_file_name (a_name)
			end

			if not retried and then (create {RAW_FILE}.make (l_file)).exists then
				create raw_buffer
				raw_buffer.set_with_named_file (l_file)
			else
				create l_warn.make_with_text ("Cannot read pixmap file:%N" + l_file + ".%NPlease make sure the installation is not corrupted.")
				l_warn.show

					-- Fail safe, use blank pixmap
				create raw_buffer.make_with_size ((17 * 32) + 1,(3 * 32) + 1)
			end
		rescue
			retried := True
			retry
		end
		
feature -- Access

	pixel_width: INTEGER is 32
			-- Element width

	pixel_height: INTEGER is 32
			-- Element width

	width: INTEGER is 17
			-- Matrix width

	height: INTEGER is 3
			-- Matrix height

	frozen context_cluster_cursor: EV_PIXMAP is
			-- Access to 'cluster' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (1, 1))
		end

	frozen context_cluster_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'cluster' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (1, 1))
		end

	frozen context_favorite_cursor: EV_PIXMAP is
			-- Access to 'favorite' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (2, 1))
		end

	frozen context_favorite_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'favorite' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (2, 1))
		end

	frozen context_class_cursor: EV_PIXMAP is
			-- Access to 'class' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (3, 1))
		end

	frozen context_class_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'class' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (3, 1))
		end

	frozen context_feature_cursor: EV_PIXMAP is
			-- Access to 'feature' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (4, 1))
		end

	frozen context_feature_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'feature' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (4, 1))
		end

	frozen context_client_link_cursor: EV_PIXMAP is
			-- Access to 'client link' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (5, 1))
		end

	frozen context_client_link_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'client link' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (5, 1))
		end

	frozen context_inherit_link_cursor: EV_PIXMAP is
			-- Access to 'inherit link' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (6, 1))
		end

	frozen context_inherit_link_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'inherit link' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (6, 1))
		end

	frozen context_debug_object_cursor: EV_PIXMAP is
			-- Access to 'debug object' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (7, 1))
		end

	frozen context_debug_object_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'debug object' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (7, 1))
		end

	frozen context_metric_cursor: EV_PIXMAP is
			-- Access to 'metric' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (8, 1))
		end

	frozen context_metric_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'metric' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (8, 1))
		end

	frozen context_criteria_cursor: EV_PIXMAP is
			-- Access to 'criteria' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (9, 1))
		end

	frozen context_criteria_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'criteria' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (9, 1))
		end

	frozen context_classes_cursor: EV_PIXMAP is
			-- Access to 'classes' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (10, 1))
		end

	frozen context_classes_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'classes' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (10, 1))
		end

	frozen context_help_cursor: EV_PIXMAP is
			-- Access to 'help' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (11, 1))
		end

	frozen context_help_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'help' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (11, 1))
		end

	frozen context_debugger_step_cursor: EV_PIXMAP is
			-- Access to 'debugger step' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (12, 1))
		end

	frozen context_debugger_step_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'debugger step' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (12, 1))
		end

	frozen context_library_cursor: EV_PIXMAP is
			-- Access to 'library' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (13, 1))
		end

	frozen context_library_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'library' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (13, 1))
		end

	frozen context_precompile_cursor: EV_PIXMAP is
			-- Access to 'precompile' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (14, 1))
		end

	frozen context_precompile_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'precompile' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (14, 1))
		end

	frozen context_assembly_cursor: EV_PIXMAP is
			-- Access to 'assembly' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (15, 1))
		end

	frozen context_assembly_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'assembly' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (15, 1))
		end

	frozen context_namespace_cursor: EV_PIXMAP is
			-- Access to 'namespace' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (16, 1))
		end

	frozen context_namespace_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'namespace' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (16, 1))
		end

	frozen context_target_cursor: EV_PIXMAP is
			-- Access to 'target' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (17, 1))
		end

	frozen context_target_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'target' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (17, 1))
		end
	frozen context_disabled_cluster_cursor: EV_PIXMAP is
			-- Access to 'cluster' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (1, 2))
		end

	frozen context_disabled_cluster_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'cluster' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (1, 2))
		end

	frozen context_disabled_favorite_cursor: EV_PIXMAP is
			-- Access to 'favorite' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (2, 2))
		end

	frozen context_disabled_favorite_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'favorite' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (2, 2))
		end

	frozen context_disabled_class_cursor: EV_PIXMAP is
			-- Access to 'class' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (3, 2))
		end

	frozen context_disabled_class_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'class' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (3, 2))
		end

	frozen context_disabled_feature_cursor: EV_PIXMAP is
			-- Access to 'feature' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (4, 2))
		end

	frozen context_disabled_feature_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'feature' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (4, 2))
		end

	frozen context_disabled_client_link_cursor: EV_PIXMAP is
			-- Access to 'client link' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (5, 2))
		end

	frozen context_disabled_client_link_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'client link' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (5, 2))
		end

	frozen context_disabled_inherit_link_cursor: EV_PIXMAP is
			-- Access to 'inherit link' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (6, 2))
		end

	frozen context_disabled_inherit_link_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'inherit link' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (6, 2))
		end

	frozen context_disabled_debug_object_cursor: EV_PIXMAP is
			-- Access to 'debug object' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (7, 2))
		end

	frozen context_disabled_debug_object_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'debug object' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (7, 2))
		end

	frozen context_disabled_metric_cursor: EV_PIXMAP is
			-- Access to 'metric' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (8, 2))
		end

	frozen context_disabled_metric_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'metric' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (8, 2))
		end

	frozen context_disabled_criteria_cursor: EV_PIXMAP is
			-- Access to 'criteria' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (9, 2))
		end

	frozen context_disabled_criteria_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'criteria' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (9, 2))
		end

	frozen context_disabled_classes_cursor: EV_PIXMAP is
			-- Access to 'classes' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (10, 2))
		end

	frozen context_disabled_classes_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'classes' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (10, 2))
		end

	frozen context_disabled_help_cursor: EV_PIXMAP is
			-- Access to 'help' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (11, 2))
		end

	frozen context_disabled_help_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'help' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (11, 2))
		end

	frozen context_disabled_debugger_step_cursor: EV_PIXMAP is
			-- Access to 'debugger step' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (12, 2))
		end

	frozen context_disabled_debugger_step_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'debugger step' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (12, 2))
		end

	frozen context_disabled_library_cursor: EV_PIXMAP is
			-- Access to 'library' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (13, 2))
		end

	frozen context_disabled_library_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'library' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (13, 2))
		end

	frozen context_disabled_precompile_cursor: EV_PIXMAP is
			-- Access to 'precompile' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (14, 2))
		end

	frozen context_disabled_precompile_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'precompile' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (14, 2))
		end

	frozen context_disabled_assembly_cursor: EV_PIXMAP is
			-- Access to 'assembly' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (15, 2))
		end

	frozen context_disabled_assembly_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'assembly' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (15, 2))
		end

	frozen context_disabled_namespace_cursor: EV_PIXMAP is
			-- Access to 'namespace' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (16, 2))
		end

	frozen context_disabled_namespace_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'namespace' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (16, 2))
		end

	frozen context_disabled_target_cursor: EV_PIXMAP is
			-- Access to 'target' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (17, 2))
		end

	frozen context_disabled_target_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'target' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (17, 2))
		end
	frozen cursor_hand_open_cursor: EV_PIXMAP is
			-- Access to 'hand open' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (1, 3))
		end

	frozen cursor_hand_open_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'hand open' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (1, 3))
		end

	frozen cursor_hand_clasped_cursor: EV_PIXMAP is
			-- Access to 'hand clasped' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (2, 3))
		end

	frozen cursor_hand_clasped_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'hand clasped' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (2, 3))
		end

	frozen cursor_move_cursor: EV_PIXMAP is
			-- Access to 'move' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (3, 3))
		end

	frozen cursor_move_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'move' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (3, 3))
		end

	frozen cursor_copy_cursor: EV_PIXMAP is
			-- Access to 'copy' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (4, 3))
		end

	frozen cursor_copy_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'copy' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (4, 3))
		end
	frozen docking_up_cursor: EV_PIXMAP is
			-- Access to 'up' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (5, 3))
		end

	frozen docking_up_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'up' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (5, 3))
		end

	frozen docking_down_cursor: EV_PIXMAP is
			-- Access to 'down' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (6, 3))
		end

	frozen docking_down_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'down' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (6, 3))
		end

	frozen docking_left_cursor: EV_PIXMAP is
			-- Access to 'left' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (7, 3))
		end

	frozen docking_left_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'left' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (7, 3))
		end

	frozen docking_right_cursor: EV_PIXMAP is
			-- Access to 'right' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (8, 3))
		end

	frozen docking_right_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'right' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (8, 3))
		end

	frozen docking_float_cursor: EV_PIXMAP is
			-- Access to 'float' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (9, 3))
		end

	frozen docking_float_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'float' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (9, 3))
		end

	frozen docking_tabify_cursor: EV_PIXMAP is
			-- Access to 'tabify' pixmap.
		once
			Result := raw_buffer.sub_pixmap (pixel_rectangle (10, 3))
		end

	frozen docking_tabify_cursor_cursor_buffer: EV_PIXEL_BUFFER is
			-- Access to 'tabify' pixmap pixel buffer.
		once
			Result := raw_buffer.sub_pixel_buffer (pixel_rectangle (10, 3))
		end
		
feature {NONE} -- Query

	frozen pixel_rectangle (a_x: INTEGER; a_y: INTEGER): EV_RECTANGLE is
			-- Retrieves a pixmap from matrix coordinates `a_x', `a_y'	
		require
			a_x_positive: a_x > 0
			a_x_small_enough: a_x <= 17
			a_y_positive: a_y > 0
			a_y_small_enough: a_y <= 3
		local
			l_x_offset: INTEGER
			l_y_offset: INTEGER
		do
			l_x_offset := ((a_x - 1) * (32 + 1)) + 1
			l_y_offset := ((a_y - 1) * (32 + 1)) + 1

			Result := rectangle
			Result.set_x (l_x_offset)
			Result.set_y (l_y_offset)
			Result.set_width (32)
			Result.set_height (32)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	raw_buffer: EV_PIXEL_BUFFER
			-- raw matrix pixel buffer

	frozen rectangle: EV_RECTANGLE is
			-- Reusable rectangle for `pixmap_from_constant'.
		once
			create Result
		end

invariant
	raw_buffer_attached: raw_buffer /= Void

indexing
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
		Eiffel Software
		356 Storke Road, Goleta, CA 93117 USA
		Telephone 805-685-1006, Fax 805-685-6869
		Website http://www.eiffel.com
		Customer support http://support.eiffel.com
	]"

end -- class {ES_PIXMAPS_CURSORS}