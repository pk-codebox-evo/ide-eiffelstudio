indexing
	description: "Objects that provide access to all Build reserved words."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BUILD_RESERVED_WORDS

feature -- Access

	build_reserved_words: ARRAYED_LIST [STRING] is
			-- `Result' is reserved words specific to Build.
			-- For example, as we may inherit EV_TITLED_WINDOW,
			-- it is not valie to name an attribute or event that will
			-- clash with any of the features.
		once
			create Result.make (0)
			
				-- All features of EV_TITLED_WINDOW.
			Result.extend ("conforming_pick_actions")
			Result.extend ("drop_actions")
			Result.extend ("pick_actions")
			Result.extend ("pick_ended_actions")
			Result.extend ("close_request_actions")
			Result.extend ("move_actions")
			Result.extend ("show_actions")
			Result.extend ("focus_in_actions")
			Result.extend ("focus_out_actions")
			Result.extend ("key_press_actions")
			Result.extend ("key_press_string_actions")
			Result.extend ("key_release_actions")
			Result.extend ("pointer_button_press_actions")
			Result.extend ("pointer_button_release_actions")
			Result.extend ("pointer_double_press_actions")
			Result.extend ("pointer_enter_actions")
			Result.extend ("pointer_leave_actions")
			Result.extend ("pointer_motion_actions")
			Result.extend ("resize_actions")
			Result.extend ("empty")
			Result.extend ("fill")
			Result.extend ("is_inserted")
			Result.extend ("prune_all")
			Result.extend ("copy")
			Result.extend ("data")
			Result.extend ("default_create")
			Result.extend ("destroy")
			Result.extend ("is_destroyed")
			Result.extend ("set_data")
			Result.extend ("help_context")
			Result.extend ("remove_help_context")
			Result.extend ("set_help_context")
			Result.extend ("height")
			Result.extend ("minimum_height")
			Result.extend ("minimum_width")
			Result.extend ("width")
			Result.extend ("x_position")
			Result.extend ("y_position")
			Result.extend ("set_height")
			Result.extend ("set_position")
			Result.extend ("set_size")
			Result.extend ("set_width")
			Result.extend ("set_x_position")
			Result.extend ("set_y_position")
			Result.extend ("background_color")
			Result.extend ("foreground_color")
			Result.extend ("set_background_color")
			Result.extend ("set_default_colors")
			Result.extend ("set_foreground_color")
			Result.extend ("pixmap_path")
			Result.extend ("remove_background_pixmap")
			Result.extend ("set_background_pixmap")
			Result.extend ("set_pixmap_path")
			Result.extend ("disable_sensitive")
			Result.extend ("enable_sensitive")
			Result.extend ("is_sensitive")
			Result.extend ("id_object")
			Result.extend ("object_id")
			Result.extend ("set_target_name")
			Result.extend ("target_name")
			Result.extend ("accept_cursor")
			Result.extend ("deny_cursor")
			Result.extend ("disable_pebble_positioning")
			Result.extend ("enable_pebble_positioning")
			Result.extend ("mode_is_drag_and_drop")
			Result.extend ("mode_is_pick_and_drop")
			Result.extend ("mode_is_target_menu")
			Result.extend ("pebble")
			Result.extend ("pebble_function")
			Result.extend ("pebble_positioning_enabled")
			Result.extend ("pebble_x_position")
			Result.extend ("pebble_y_position")
			Result.extend ("remove_pebble")
			Result.extend ("set_accept_cursor")
			Result.extend ("set_deny_cursor")
			Result.extend ("set_drag_and_drop_mode")
			Result.extend ("set_pebble")
			Result.extend ("set_pebble_function")
			Result.extend ("set_pebble_position")
			Result.extend ("set_pick_and_drop_mode")
			Result.extend ("set_target_menu_mode")
			Result.extend ("actual_drop_target_agent")
			Result.extend ("center_pointer")
			Result.extend ("disable_capture")
			Result.extend ("enable_capture")
			Result.extend ("has_capture")
			Result.extend ("has_focus")
			Result.extend ("hide")
			Result.extend ("is_displayed")
			Result.extend ("is_show_requested")
			Result.extend ("parent")
			Result.extend ("pointer_position")
			Result.extend ("pointer_style")
			Result.extend ("screen_x")
			Result.extend ("screen_y")
			Result.extend ("set_actual_drop_target_agent")
			Result.extend ("set_focus")
			Result.extend ("set_minimum_height")
			Result.extend ("set_minimum_size")
			Result.extend ("set_minimum_width")
			Result.extend ("set_pointer_style")
			Result.extend ("show")
			Result.extend ("background_pixmap")
			Result.extend ("client_height")
			Result.extend ("client_width")
			Result.extend ("extend")
			Result.extend ("has_recursive")
			Result.extend ("is_parent_recursive")
			Result.extend ("item")
			Result.extend ("may_contain")
			Result.extend ("merge_radio_button_groups")
			Result.extend ("merged_radio_button_groups")
			Result.extend ("propagate_background_color")
			Result.extend ("propagate_foreground_color")
			Result.extend ("put")
			Result.extend ("replace")
			Result.extend ("unmerge_radio_button_groups")
			Result.extend ("count")
			Result.extend ("extendible")
			Result.extend ("full")
			Result.extend ("is_empty")
			Result.extend ("linear_representation")
			Result.extend ("prunable")
			Result.extend ("prune")
			Result.extend ("readable")
			Result.extend ("wipe_out")
			Result.extend ("writable")
			Result.extend ("disable_user_resize")
			Result.extend ("enable_user_resize")
			Result.extend ("has")
			Result.extend ("lock_update")
			Result.extend ("lower_ba")
			Result.extend ("maximum_dimension")
			Result.extend ("maximum_height")
			Result.extend ("maximum_width")
			Result.extend ("menu_bar")
			Result.extend ("remove_menu_bar")
			Result.extend ("remove_title")
			Result.extend ("set_maximum_height")
			Result.extend ("set_maximum_size")
			Result.extend ("set_maximum_width")
			Result.extend ("set_menu_bar")
			Result.extend ("set_title")
			Result.extend ("title")
			Result.extend ("unlock_update")
			Result.extend ("upper_bar")
			Result.extend ("user_can_resize")
			Result.extend ("accelerators")
			Result.extend ("icon_name")
			Result.extend ("icon_pixmap")
			Result.extend ("is_maximized")
			Result.extend ("lower")
			Result.extend ("maximize")
			Result.extend ("minimize")
			Result.extend ("raise")
			Result.extend ("remove_icon_name")
			Result.extend ("restore")
			Result.extend ("set_icon_name")
			Result.extend ("set_icon_pixmap")
			Result.extend ("make_with_title")
			Result.extend ("default_create")
			
				-- Add names specific to Build.
			Result.extend ("window")
			Result.extend ("make_with_window")
				-- Set object comparison.
			Result.compare_objects
		end

end -- class BUILD_RESERVED_WORDS
