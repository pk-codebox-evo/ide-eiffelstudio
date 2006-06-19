indexing
	description: "An Eiffel pixmap matrix accessor, generated by Eiffel Matrix Generator."
	legal      : "See notice at end of class."
	status     : "See notice at end of class."
	date       : "$Date$"
	revision   : "$Revision$"

class
	ES_PIXMAPS_16X16

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
				create raw_matrix
				raw_matrix.set_with_named_file (l_file)
			else
				create l_warn.make_with_text ("Cannot read pixmap file:%N" + l_file + ".%NPlease make sure the installation is not corrupted.")
				l_warn.show

					-- Fail safe, use blank pixmap
				create raw_matrix.make_with_size ((width * pixel_width) + 1,(height * pixel_height) + 1)
			end
		rescue
			retried := True
			retry
		end

feature -- Access

	expanded_normal_icon: EV_PIXMAP is
			-- Access to 'normal' pixmap.
		once
			Result := pixmap_from_coords (1, 1)
		end

	expanded_readonly_icon: EV_PIXMAP is
			-- Access to 'readonly' pixmap.
		once
			Result := pixmap_from_coords (2, 1)
		end

	expanded_uncompiled_icon: EV_PIXMAP is
			-- Access to 'uncompiled' pixmap.
		once
			Result := pixmap_from_coords (3, 1)
		end

	expanded_uncompiled_readonly_icon: EV_PIXMAP is
			-- Access to 'uncompiled readonly' pixmap.
		once
			Result := pixmap_from_coords (4, 1)
		end

	expanded_override_normal_icon: EV_PIXMAP is
			-- Access to 'normal' pixmap.
		once
			Result := pixmap_from_coords (5, 1)
		end

	expanded_override_readonly_icon: EV_PIXMAP is
			-- Access to 'readonly' pixmap.
		once
			Result := pixmap_from_coords (6, 1)
		end

	expanded_override_uncompiled_icon: EV_PIXMAP is
			-- Access to 'uncompiled' pixmap.
		once
			Result := pixmap_from_coords (7, 1)
		end

	expanded_override_uncompiled_readonly_icon: EV_PIXMAP is
			-- Access to 'uncompiled readonly' pixmap.
		once
			Result := pixmap_from_coords (8, 1)
		end

	expanded_overriden_normal_icon: EV_PIXMAP is
			-- Access to 'normal' pixmap.
		once
			Result := pixmap_from_coords (9, 1)
		end

	expanded_overriden_readonly_icon: EV_PIXMAP is
			-- Access to 'readonly' pixmap.
		once
			Result := pixmap_from_coords (10, 1)
		end

	expanded_overriden_uncompiled_icon: EV_PIXMAP is
			-- Access to 'uncompiled' pixmap.
		once
			Result := pixmap_from_coords (11, 1)
		end

	expanded_overriden_uncompiled_readonly_icon: EV_PIXMAP is
			-- Access to 'uncompiled readonly' pixmap.
		once
			Result := pixmap_from_coords (12, 1)
		end

	class_normal_icon: EV_PIXMAP is
			-- Access to 'normal' pixmap.
		once
			Result := pixmap_from_coords (13, 1)
		end

	class_readonly_icon: EV_PIXMAP is
			-- Access to 'readonly' pixmap.
		once
			Result := pixmap_from_coords (14, 1)
		end

	class_deferred_icon: EV_PIXMAP is
			-- Access to 'deferred' pixmap.
		once
			Result := pixmap_from_coords (15, 1)
		end

	class_deferred_readonly_icon: EV_PIXMAP is
			-- Access to 'deferred readonly' pixmap.
		once
			Result := pixmap_from_coords (16, 1)
		end

	class_frozen_icon: EV_PIXMAP is
			-- Access to 'frozen' pixmap.
		once
			Result := pixmap_from_coords (17, 1)
		end

	class_frozen_readonly_icon: EV_PIXMAP is
			-- Access to 'frozen readonly' pixmap.
		once
			Result := pixmap_from_coords (18, 1)
		end

	class_uncompiled_icon: EV_PIXMAP is
			-- Access to 'uncompiled' pixmap.
		once
			Result := pixmap_from_coords (19, 1)
		end

	class_uncompiled_readonly_icon: EV_PIXMAP is
			-- Access to 'uncompiled readonly' pixmap.
		once
			Result := pixmap_from_coords (20, 1)
		end

	class_override_normal_icon: EV_PIXMAP is
			-- Access to 'normal' pixmap.
		once
			Result := pixmap_from_coords (1, 2)
		end

	class_override_readonly_icon: EV_PIXMAP is
			-- Access to 'readonly' pixmap.
		once
			Result := pixmap_from_coords (2, 2)
		end

	class_override_deferred_icon: EV_PIXMAP is
			-- Access to 'deferred' pixmap.
		once
			Result := pixmap_from_coords (3, 2)
		end

	class_override_deferred_readonly_icon: EV_PIXMAP is
			-- Access to 'deferred readonly' pixmap.
		once
			Result := pixmap_from_coords (4, 2)
		end

	class_override_frozen_icon: EV_PIXMAP is
			-- Access to 'frozen' pixmap.
		once
			Result := pixmap_from_coords (5, 2)
		end

	class_override_frozen_readonly_icon: EV_PIXMAP is
			-- Access to 'frozen readonly' pixmap.
		once
			Result := pixmap_from_coords (6, 2)
		end

	class_override_uncompiled_icon: EV_PIXMAP is
			-- Access to 'uncompiled' pixmap.
		once
			Result := pixmap_from_coords (7, 2)
		end

	class_override_uncompiled_readonly_icon: EV_PIXMAP is
			-- Access to 'uncompiled readonly' pixmap.
		once
			Result := pixmap_from_coords (8, 2)
		end

	class_overriden_normal_icon: EV_PIXMAP is
			-- Access to 'normal' pixmap.
		once
			Result := pixmap_from_coords (9, 2)
		end

	class_overriden_readonly_icon: EV_PIXMAP is
			-- Access to 'readonly' pixmap.
		once
			Result := pixmap_from_coords (10, 2)
		end

	class_overriden_deferred_icon: EV_PIXMAP is
			-- Access to 'deferred' pixmap.
		once
			Result := pixmap_from_coords (11, 2)
		end

	class_overriden_deferred_readonly_icon: EV_PIXMAP is
			-- Access to 'deferred readonly' pixmap.
		once
			Result := pixmap_from_coords (12, 2)
		end

	class_overriden_frozen_icon: EV_PIXMAP is
			-- Access to 'frozen' pixmap.
		once
			Result := pixmap_from_coords (13, 2)
		end

	class_overriden_frozen_readonly_icon: EV_PIXMAP is
			-- Access to 'frozen readonly' pixmap.
		once
			Result := pixmap_from_coords (14, 2)
		end

	class_overriden_uncompiled_icon: EV_PIXMAP is
			-- Access to 'uncompiled' pixmap.
		once
			Result := pixmap_from_coords (15, 2)
		end

	class_overriden_uncompiled_readonly_icon: EV_PIXMAP is
			-- Access to 'uncompiled readonly' pixmap.
		once
			Result := pixmap_from_coords (16, 2)
		end

	feature_routine_icon: EV_PIXMAP is
			-- Access to 'routine' pixmap.
		once
			Result := pixmap_from_coords (1, 3)
		end

	feature_attribute_icon: EV_PIXMAP is
			-- Access to 'attribute' pixmap.
		once
			Result := pixmap_from_coords (2, 3)
		end

	feature_once_icon: EV_PIXMAP is
			-- Access to 'once' pixmap.
		once
			Result := pixmap_from_coords (3, 3)
		end

	feature_deferred_icon: EV_PIXMAP is
			-- Access to 'deferred' pixmap.
		once
			Result := pixmap_from_coords (4, 3)
		end

	feature_external_icon: EV_PIXMAP is
			-- Access to 'external' pixmap.
		once
			Result := pixmap_from_coords (5, 3)
		end

	feature_assigner_icon: EV_PIXMAP is
			-- Access to 'assigner' pixmap.
		once
			Result := pixmap_from_coords (6, 3)
		end

	feature_deferred_assigner_icon: EV_PIXMAP is
			-- Access to 'deferred assigner' pixmap.
		once
			Result := pixmap_from_coords (7, 3)
		end

	feature_frozen_routine_icon: EV_PIXMAP is
			-- Access to 'routine' pixmap.
		once
			Result := pixmap_from_coords (8, 3)
		end

	feature_frozen_attribute_icon: EV_PIXMAP is
			-- Access to 'attribute' pixmap.
		once
			Result := pixmap_from_coords (9, 3)
		end

	feature_frozen_once_icon: EV_PIXMAP is
			-- Access to 'once' pixmap.
		once
			Result := pixmap_from_coords (10, 3)
		end

	feature_frozen_external_icon: EV_PIXMAP is
			-- Access to 'external' pixmap.
		once
			Result := pixmap_from_coords (11, 3)
		end

	feature_frozen_assigner_icon: EV_PIXMAP is
			-- Access to 'assigner' pixmap.
		once
			Result := pixmap_from_coords (12, 3)
		end

	feature_obsolete_routine_icon: EV_PIXMAP is
			-- Access to 'routine' pixmap.
		once
			Result := pixmap_from_coords (13, 3)
		end

	feature_obsolete_attribute_icon: EV_PIXMAP is
			-- Access to 'attribute' pixmap.
		once
			Result := pixmap_from_coords (14, 3)
		end

	feature_obsolete_once_icon: EV_PIXMAP is
			-- Access to 'once' pixmap.
		once
			Result := pixmap_from_coords (15, 3)
		end

	feature_obsolete_deferred_icon: EV_PIXMAP is
			-- Access to 'deferred' pixmap.
		once
			Result := pixmap_from_coords (16, 3)
		end

	feature_obsolete_external_icon: EV_PIXMAP is
			-- Access to 'external' pixmap.
		once
			Result := pixmap_from_coords (17, 3)
		end

	feature_obsolete_assigner_icon: EV_PIXMAP is
			-- Access to 'assigner' pixmap.
		once
			Result := pixmap_from_coords (18, 3)
		end

	feature_obsolete_deferred_assigner_icon: EV_PIXMAP is
			-- Access to 'deferred assigner' pixmap.
		once
			Result := pixmap_from_coords (19, 3)
		end

	feature_local_variable_icon: EV_PIXMAP is
			-- Access to 'variable' pixmap.
		once
			Result := pixmap_from_coords (20, 3)
		end

	top_level_folder_clusters_icon: EV_PIXMAP is
			-- Access to 'clusters' pixmap.
		once
			Result := pixmap_from_coords (1, 4)
		end

	top_level_folder_overrides_icon: EV_PIXMAP is
			-- Access to 'overrides' pixmap.
		once
			Result := pixmap_from_coords (2, 4)
		end

	top_level_folder_library_icon: EV_PIXMAP is
			-- Access to 'library' pixmap.
		once
			Result := pixmap_from_coords (3, 4)
		end

	top_level_folder_references_icon: EV_PIXMAP is
			-- Access to 'references' pixmap.
		once
			Result := pixmap_from_coords (4, 4)
		end

	folder_features_all_icon: EV_PIXMAP is
			-- Access to 'all' pixmap.
		once
			Result := pixmap_from_coords (5, 4)
		end

	folder_features_some_icon: EV_PIXMAP is
			-- Access to 'some' pixmap.
		once
			Result := pixmap_from_coords (6, 4)
		end

	folder_features_none_icon: EV_PIXMAP is
			-- Access to 'none' pixmap.
		once
			Result := pixmap_from_coords (7, 4)
		end

	folder_cluster_icon: EV_PIXMAP is
			-- Access to 'cluster' pixmap.
		once
			Result := pixmap_from_coords (8, 4)
		end

	folder_cluster_readonly_icon: EV_PIXMAP is
			-- Access to 'cluster readonly' pixmap.
		once
			Result := pixmap_from_coords (9, 4)
		end

	folder_blank_icon: EV_PIXMAP is
			-- Access to 'blank' pixmap.
		once
			Result := pixmap_from_coords (10, 4)
		end

	folder_blank_readonly_icon: EV_PIXMAP is
			-- Access to 'blank readonly' pixmap.
		once
			Result := pixmap_from_coords (11, 4)
		end

	folder_override_cluster_icon: EV_PIXMAP is
			-- Access to 'cluster' pixmap.
		once
			Result := pixmap_from_coords (12, 4)
		end

	folder_override_cluster_readonly_icon: EV_PIXMAP is
			-- Access to 'cluster readonly' pixmap.
		once
			Result := pixmap_from_coords (13, 4)
		end

	folder_override_blank_icon: EV_PIXMAP is
			-- Access to 'blank' pixmap.
		once
			Result := pixmap_from_coords (14, 4)
		end

	folder_override_blank_readonly_icon: EV_PIXMAP is
			-- Access to 'blank readonly' pixmap.
		once
			Result := pixmap_from_coords (15, 4)
		end

	folder_library_icon: EV_PIXMAP is
			-- Access to 'library' pixmap.
		once
			Result := pixmap_from_coords (16, 4)
		end

	folder_library_readonly_icon: EV_PIXMAP is
			-- Access to 'library readonly' pixmap.
		once
			Result := pixmap_from_coords (17, 4)
		end

	folder_assembly_icon: EV_PIXMAP is
			-- Access to 'assembly' pixmap.
		once
			Result := pixmap_from_coords (18, 4)
		end

	folder_namespace_icon: EV_PIXMAP is
			-- Access to 'namespace' pixmap.
		once
			Result := pixmap_from_coords (19, 4)
		end

	tool_features_icon: EV_PIXMAP is
			-- Access to 'features' pixmap.
		once
			Result := pixmap_from_coords (1, 5)
		end

	tool_clusters_icon: EV_PIXMAP is
			-- Access to 'clusters' pixmap.
		once
			Result := pixmap_from_coords (2, 5)
		end

	tool_class_icon: EV_PIXMAP is
			-- Access to 'class' pixmap.
		once
			Result := pixmap_from_coords (3, 5)
		end

	tool_feature_icon: EV_PIXMAP is
			-- Access to 'feature' pixmap.
		once
			Result := pixmap_from_coords (4, 5)
		end

	tool_search_icon: EV_PIXMAP is
			-- Access to 'search' pixmap.
		once
			Result := pixmap_from_coords (5, 5)
		end

	tool_advanced_search_icon: EV_PIXMAP is
			-- Access to 'advanced search' pixmap.
		once
			Result := pixmap_from_coords (6, 5)
		end

	tool_diagram_icon: EV_PIXMAP is
			-- Access to 'diagram' pixmap.
		once
			Result := pixmap_from_coords (7, 5)
		end

	tool_error_icon: EV_PIXMAP is
			-- Access to 'error' pixmap.
		once
			Result := pixmap_from_coords (8, 5)
		end

	tool_warning_icon: EV_PIXMAP is
			-- Access to 'warning' pixmap.
		once
			Result := pixmap_from_coords (9, 5)
		end

	tool_breakpoints_icon: EV_PIXMAP is
			-- Access to 'breakpoints' pixmap.
		once
			Result := pixmap_from_coords (10, 5)
		end

	tool_external_commands_icon: EV_PIXMAP is
			-- Access to 'external commands' pixmap.
		once
			Result := pixmap_from_coords (11, 5)
		end

	tool_preferences_icon: EV_PIXMAP is
			-- Access to 'preferences' pixmap.
		once
			Result := pixmap_from_coords (12, 5)
		end

	tool_call_stack_icon: EV_PIXMAP is
			-- Access to 'call stack' pixmap.
		once
			Result := pixmap_from_coords (13, 5)
		end

	tool_favorites_icon: EV_PIXMAP is
			-- Access to 'favorites' pixmap.
		once
			Result := pixmap_from_coords (14, 5)
		end

	tool_output_icon: EV_PIXMAP is
			-- Access to 'output' pixmap.
		once
			Result := pixmap_from_coords (15, 5)
		end

	tool_external_output_icon: EV_PIXMAP is
			-- Access to 'external output' pixmap.
		once
			Result := pixmap_from_coords (16, 5)
		end

	tool_objects_icon: EV_PIXMAP is
			-- Access to 'objects' pixmap.
		once
			Result := pixmap_from_coords (17, 5)
		end

	tool_watch_icon: EV_PIXMAP is
			-- Access to 'watch' pixmap.
		once
			Result := pixmap_from_coords (18, 5)
		end

	project_melt_icon: EV_PIXMAP is
			-- Access to 'melt' pixmap.
		once
			Result := pixmap_from_coords (1, 6)
		end

	project_quick_melt_icon: EV_PIXMAP is
			-- Access to 'quick melt' pixmap.
		once
			Result := pixmap_from_coords (2, 6)
		end

	project_freeze_icon: EV_PIXMAP is
			-- Access to 'freeze' pixmap.
		once
			Result := pixmap_from_coords (3, 6)
		end

	project_finalize_icon: EV_PIXMAP is
			-- Access to 'finalize' pixmap.
		once
			Result := pixmap_from_coords (4, 6)
		end

	debug_run_icon: EV_PIXMAP is
			-- Access to 'run' pixmap.
		once
			Result := pixmap_from_coords (5, 6)
		end

	debug_pause_icon: EV_PIXMAP is
			-- Access to 'pause' pixmap.
		once
			Result := pixmap_from_coords (6, 6)
		end

	debug_stop_icon: EV_PIXMAP is
			-- Access to 'stop' pixmap.
		once
			Result := pixmap_from_coords (7, 6)
		end

	debug_run_without_breakpoint_icon: EV_PIXMAP is
			-- Access to 'run without breakpoint' pixmap.
		once
			Result := pixmap_from_coords (8, 6)
		end

	debug_run_finalized_icon: EV_PIXMAP is
			-- Access to 'run finalized' pixmap.
		once
			Result := pixmap_from_coords (9, 6)
		end

	debug_step_into_icon: EV_PIXMAP is
			-- Access to 'step into' pixmap.
		once
			Result := pixmap_from_coords (10, 6)
		end

	debug_step_over_icon: EV_PIXMAP is
			-- Access to 'step over' pixmap.
		once
			Result := pixmap_from_coords (11, 6)
		end

	debug_step_out_icon: EV_PIXMAP is
			-- Access to 'step out' pixmap.
		once
			Result := pixmap_from_coords (12, 6)
		end

	new_cluster_icon: EV_PIXMAP is
			-- Access to 'cluster' pixmap.
		once
			Result := pixmap_from_coords (1, 7)
		end

	new_feature_icon: EV_PIXMAP is
			-- Access to 'feature' pixmap.
		once
			Result := pixmap_from_coords (2, 7)
		end

	new_class_icon: EV_PIXMAP is
			-- Access to 'class' pixmap.
		once
			Result := pixmap_from_coords (3, 7)
		end

	new_window_icon: EV_PIXMAP is
			-- Access to 'window' pixmap.
		once
			Result := pixmap_from_coords (4, 7)
		end

	new_editor_icon: EV_PIXMAP is
			-- Access to 'editor' pixmap.
		once
			Result := pixmap_from_coords (5, 7)
		end

	new_document_icon: EV_PIXMAP is
			-- Access to 'document' pixmap.
		once
			Result := pixmap_from_coords (6, 7)
		end

	general_open_icon: EV_PIXMAP is
			-- Access to 'open' pixmap.
		once
			Result := pixmap_from_coords (1, 8)
		end

	general_save_icon: EV_PIXMAP is
			-- Access to 'save' pixmap.
		once
			Result := pixmap_from_coords (2, 8)
		end

	general_save_all_icon: EV_PIXMAP is
			-- Access to 'save all' pixmap.
		once
			Result := pixmap_from_coords (3, 8)
		end

	general_add_icon: EV_PIXMAP is
			-- Access to 'add' pixmap.
		once
			Result := pixmap_from_coords (4, 8)
		end

	general_edit_icon: EV_PIXMAP is
			-- Access to 'edit' pixmap.
		once
			Result := pixmap_from_coords (5, 8)
		end

	general_delete_icon: EV_PIXMAP is
			-- Access to 'delete' pixmap.
		once
			Result := pixmap_from_coords (6, 8)
		end

	general_document_icon: EV_PIXMAP is
			-- Access to 'document' pixmap.
		once
			Result := pixmap_from_coords (7, 8)
		end

	refactor_feature_up_icon: EV_PIXMAP is
			-- Access to 'feature up' pixmap.
		once
			Result := pixmap_from_coords (1, 9)
		end

	refactor_rename_icon: EV_PIXMAP is
			-- Access to 'rename' pixmap.
		once
			Result := pixmap_from_coords (2, 9)
		end

	context_link_icon: EV_PIXMAP is
			-- Access to 'link' pixmap.
		once
			Result := pixmap_from_coords (3, 9)
		end

	context_unlink_icon: EV_PIXMAP is
			-- Access to 'unlink' pixmap.
		once
			Result := pixmap_from_coords (4, 9)
		end

	context_sync_icon: EV_PIXMAP is
			-- Access to 'sync' pixmap.
		once
			Result := pixmap_from_coords (5, 9)
		end

	diagram_zoom_in_icon: EV_PIXMAP is
			-- Access to 'zoom in' pixmap.
		once
			Result := pixmap_from_coords (1, 12)
		end

	diagram_zoom_out_icon: EV_PIXMAP is
			-- Access to 'zoom out' pixmap.
		once
			Result := pixmap_from_coords (2, 12)
		end

	view_previous_icon: EV_PIXMAP is
			-- Access to 'previous' pixmap.
		once
			Result := pixmap_from_coords (1, 13)
		end

	view_next_icon: EV_PIXMAP is
			-- Access to 'next' pixmap.
		once
			Result := pixmap_from_coords (2, 13)
		end

	view_editor_icon: EV_PIXMAP is
			-- Access to 'editor' pixmap.
		once
			Result := pixmap_from_coords (3, 13)
		end

	view_flat_icon: EV_PIXMAP is
			-- Access to 'flat' pixmap.
		once
			Result := pixmap_from_coords (4, 13)
		end

	view_clickable_icon: EV_PIXMAP is
			-- Access to 'clickable' pixmap.
		once
			Result := pixmap_from_coords (5, 13)
		end

	view_contracts_icon: EV_PIXMAP is
			-- Access to 'contracts' pixmap.
		once
			Result := pixmap_from_coords (6, 13)
		end

	view_flat_contracts_icon: EV_PIXMAP is
			-- Access to 'flat contracts' pixmap.
		once
			Result := pixmap_from_coords (7, 13)
		end

	view_editor_feature_icon: EV_PIXMAP is
			-- Access to 'editor feature' pixmap.
		once
			Result := pixmap_from_coords (8, 13)
		end

	view_clickable_feature_icon: EV_PIXMAP is
			-- Access to 'clickable feature' pixmap.
		once
			Result := pixmap_from_coords (9, 13)
		end

	feature_callers_icon: EV_PIXMAP is
			-- Access to 'callers' pixmap.
		once
			Result := pixmap_from_coords (1, 14)
		end

	feature_callees_icon: EV_PIXMAP is
			-- Access to 'callees' pixmap.
		once
			Result := pixmap_from_coords (2, 14)
		end

	feature_assigners_icon: EV_PIXMAP is
			-- Access to 'assigners' pixmap.
		once
			Result := pixmap_from_coords (3, 14)
		end

	feature_assignees_icon: EV_PIXMAP is
			-- Access to 'assignees' pixmap.
		once
			Result := pixmap_from_coords (4, 14)
		end

	feature_creaters_icon: EV_PIXMAP is
			-- Access to 'creaters' pixmap.
		once
			Result := pixmap_from_coords (5, 14)
		end

	feature_creators_icon: EV_PIXMAP is
			-- Access to 'creators' pixmap.
		once
			Result := pixmap_from_coords (6, 14)
		end

	feature_implementers_icon: EV_PIXMAP is
			-- Access to 'implementers' pixmap.
		once
			Result := pixmap_from_coords (7, 14)
		end

	feature_ancestors_icon: EV_PIXMAP is
			-- Access to 'ancestors' pixmap.
		once
			Result := pixmap_from_coords (8, 14)
		end

	feature_descendents_icon: EV_PIXMAP is
			-- Access to 'descendents' pixmap.
		once
			Result := pixmap_from_coords (9, 14)
		end

	feature_homonyms_icon: EV_PIXMAP is
			-- Access to 'homonyms' pixmap.
		once
			Result := pixmap_from_coords (10, 14)
		end

	class_ancestors_icon: EV_PIXMAP is
			-- Access to 'ancestors' pixmap.
		once
			Result := pixmap_from_coords (1, 15)
		end

	class_descendents_icon: EV_PIXMAP is
			-- Access to 'descendents' pixmap.
		once
			Result := pixmap_from_coords (2, 15)
		end

	class_clients_icon: EV_PIXMAP is
			-- Access to 'clients' pixmap.
		once
			Result := pixmap_from_coords (3, 15)
		end

	class_supliers_icon: EV_PIXMAP is
			-- Access to 'supliers' pixmap.
		once
			Result := pixmap_from_coords (4, 15)
		end

	class_features_attribute_icon: EV_PIXMAP is
			-- Access to 'attribute' pixmap.
		once
			Result := pixmap_from_coords (5, 15)
		end

	class_features_routine_icon: EV_PIXMAP is
			-- Access to 'routine' pixmap.
		once
			Result := pixmap_from_coords (6, 15)
		end

	class_features_invariant_icon: EV_PIXMAP is
			-- Access to 'invariant' pixmap.
		once
			Result := pixmap_from_coords (7, 15)
		end

	class_features_creator_icon: EV_PIXMAP is
			-- Access to 'creator' pixmap.
		once
			Result := pixmap_from_coords (8, 15)
		end

	class_features_deferred_icon: EV_PIXMAP is
			-- Access to 'deferred' pixmap.
		once
			Result := pixmap_from_coords (9, 15)
		end

	class_features_once_icon: EV_PIXMAP is
			-- Access to 'once' pixmap.
		once
			Result := pixmap_from_coords (10, 15)
		end

	class_features_external_icon: EV_PIXMAP is
			-- Access to 'external' pixmap.
		once
			Result := pixmap_from_coords (11, 15)
		end

	class_features_exported_icon: EV_PIXMAP is
			-- Access to 'exported' pixmap.
		once
			Result := pixmap_from_coords (12, 15)
		end


feature {NONE} -- Access

	pixel_width: INTEGER is 16
			-- Element width

	pixel_height: INTEGER is 16
			-- Element width

	width: INTEGER is 20
			-- Matrix width

	height: INTEGER is 20
			-- Matrix height

feature {NONE} -- Query

	frozen pixmap_from_coords (a_x: INTEGER; a_y: INTEGER): EV_PIXMAP is
			-- Retrieves a pixmap from matrix coordinates `a_x', `a_y'	
		require
			a_x_positive: a_x > 0
			a_x_small_enough: a_x <= width
			a_y_positive: a_y > 0
			a_y_small_enough: a_y <= height
		local
			l_x_offset: INTEGER
			l_y_offset: INTEGER
			l_pw: INTEGER
			l_ph: INTEGER
			l_rectangle: like rectangle
		do
			l_pw := pixel_width
			l_ph := pixel_height
			l_x_offset := ((a_x - 1) * (l_pw + 1)) + 1
			l_y_offset := ((a_y - 1) * (l_ph + 1)) + 1

			l_rectangle := rectangle
			l_rectangle.set_x (l_x_offset)
			l_rectangle.set_y (l_y_offset)
			l_rectangle.set_width (l_pw)
			l_rectangle.set_height (l_ph)
			Result := raw_matrix.implementation.sub_pixmap (l_rectangle)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation


	raw_matrix: EV_PIXMAP
			-- raw matrix pixmap

	frozen rectangle: EV_RECTANGLE is
			-- Reusable rectangle for `pixmap_from_constant'.
		once
			create Result
		end

invariant
	raw_matrix_attached: raw_matrix /= Void

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

end -- class {ES_PIXMAPS_16X16}
