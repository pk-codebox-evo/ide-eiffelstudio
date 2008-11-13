indexing
	description: "[
		Widget showing status and control buttons for an {TEST_EXECUTOR_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TESTING_TOOL_EXECUTOR_WIDGET

inherit
	ES_TESTING_TOOL_PROCESSOR_WIDGET
		rename
			processor as executor
		redefine
			executor,
			on_after_initialized,
			on_processor_changed,
			create_tool_bar_items
		end

create
	make

feature {NONE} -- Initialization

	on_after_initialized
			-- <Precursor>
		do
			Precursor
			register_action (grid.item_selected_actions, agent on_selection_change)
			register_action (grid.item_deselected_actions, agent on_selection_change)
			adapt_executor_status
		end

feature -- Access

	executor: !TEST_EXECUTOR_I
			-- Executor being visualized by `Current'

	title: !STRING_32
			-- <Precursor>
		do
			if debug_executor_type.attempt (executor) /= Void then
				Result := locale_formatter.translation (t_title_debugger)
			else
				Result := locale_formatter.translation (t_title_background)
			end
		end

	icon: !EV_PIXEL_BUFFER
			-- <Precursor>
		do
			if debug_executor_type.attempt (executor) /= Void then
				Result := icon_provider.icons.general_bug_icon_buffer
			else
				Result := stock_pixmaps.debug_run_icon_buffer
			end
		end

	icon_pixmap: !EV_PIXMAP
			-- <Precursor>
		do
			if debug_executor_type.attempt (executor) /= Void then
				Result := icon_provider.icons.general_bug_icon
			else
				Result := stock_pixmaps.debug_run_icon
			end
		end

feature {NONE} -- Access: buttons

	run_button: !SD_TOOL_BAR_BUTTON
			-- Button for relaunching past execution

	skip_button: !SD_TOOL_BAR_BUTTON
			-- Button for skipping tests during execution

feature {NONE} -- Status setting

	adapt_executor_status
			-- Adapt widgets according to state of `executor'
		local
			l_run, l_skip: BOOLEAN
		do
			if executor.is_interface_usable then
				if executor.is_running then
					if not executor.is_finished then
						if not grid.selected_items.is_empty then
							l_skip := True
						end
					end
				elseif executor.are_tests_available then
					if not executor.active_tests.is_empty then
						l_run := True
					end
				end
			end
			if l_run then
				if not run_button.is_sensitive then
					run_button.enable_sensitive
				end
			else
				if run_button.is_sensitive then
					run_button.disable_sensitive
				end
			end
			if l_skip then
				if not skip_button.is_sensitive then
					skip_button.enable_sensitive
				end
			else
				if skip_button.is_sensitive then
					skip_button.disable_sensitive
				end
			end
		end

feature {NONE} -- Events: processor

	on_processor_changed
			-- <Precursor>
		do
			adapt_executor_status
		end

feature {NONE} -- Events: widgets

	on_run
			-- Called when `run_button' is selected
		local
			l_test_suite: !TEST_SUITE_S
			l_conf: !TEST_EXECUTOR_CONF
			l_list: !DS_LINEAR [!TEST_I]
		do
			if executor.is_interface_usable and test_suite.is_service_available then
				l_test_suite := test_suite.service
				if executor.are_tests_available then
					if not grid.selected_items.is_empty then
						l_list := grid.selected_items
					else
						l_list := executor.active_tests
					end
					if l_list.count = l_test_suite.tests.count then
						create l_conf.make
					else
						create l_conf.make_with_tests (l_list)
					end
					if executor.is_ready and executor.is_valid_configuration (l_conf) then
						l_test_suite.launch_processor (executor, l_conf, False)
					end
				end
			end
		end

	on_skip
			-- Called when `skip_button' is selected
		local
			l_cursor: DS_LINEAR_CURSOR [!TEST_I]
		do
			if executor.is_interface_usable and then executor.is_running then
				l_cursor := grid.selected_items.new_cursor
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					if executor.active_tests.has (l_cursor.item) then
						executor.skip_test (l_cursor.item)
					end
					l_cursor.forth
				end
			end
		end

	on_selection_change (a_test: !TEST_I)
			-- <Precursor>
		do
			adapt_executor_status
		end

feature {NONE} -- Factory

	create_tool_bar_items: ?DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
			create Result.make (4)

			create run_button.make
			run_button.set_pixel_buffer (stock_pixmaps.debug_run_icon_buffer)
			run_button.set_pixmap (stock_pixmaps.debug_run_icon)
			run_button.set_tooltip (tt_run)
			register_action (run_button.select_actions, agent on_run)
			Result.force_last (run_button)

			if {l_items: DS_LINEAR [SD_TOOL_BAR_ITEM]} Precursor then
				Result.append_last (l_items)
			end

			Result.force_last (create {SD_TOOL_BAR_SEPARATOR}.make)

			create skip_button.make
			skip_button.set_text (b_skip)
			register_action (skip_button.select_actions, agent on_skip)
			Result.force_last (skip_button)
		end

feature {NONE} -- Constants

	t_title_background: !STRING = "Execution"
	t_title_debugger: !STRING = "Debugging"

	tt_run: STRING = "Relaunch previous execution"
	b_skip: STRING = "Skip"

end
