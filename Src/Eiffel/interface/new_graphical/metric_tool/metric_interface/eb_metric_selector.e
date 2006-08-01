indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_SELECTOR

inherit
	EB_METRIC_SELECTOR_IMP

	EVS_GRID_TWO_WAY_SORTING_ORDER
		undefine
			default_create,
			is_equal,
			copy
		end

	QL_SHARED_UNIT
		undefine
			default_create,
			is_equal,
			copy
		end

	EB_METRIC_SHARED
		undefine
			default_create,
			is_equal,
			copy
		end

	EB_METRIC_INTERFACE_PROVIDER
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_selectable: BOOLEAN) is
			-- Initialize current.
			-- If `a_selectable' is True, draw checkbox for selection.
		do
			is_selectable := a_selectable
			if is_selectable then
				create selection_status.make (30)
			else
				create selection_status.make (0)
			end
			create metric_name_list.make
			create metric_name_row_table.make (30)
			create input_cache.make (20)
			default_create
		ensure
			is_selectable_set: is_selectable = a_selectable
			metric_name_list_attached: metric_name_list /= Void
			metric_name_row_table_attached: metric_name_row_table /= Void
			input_cache_attached: input_cache /= Void
		end

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.		
		local
			l_sort_info: EVS_GRID_THREE_WAY_SORTING_INFO [ANY]
		do

			create metric_selected_actions
			create group_selected_actions
			create double_click_actions
				-- Initialize `metric_table'.
			create metric_table.make (13)

				-- Initialize `metric_grid'.
			create metric_grid
			if is_selectable then
				metric_grid.set_column_count_to (2)
				select_predefined_btn.set_pixmap (pixmaps.icon_pixmaps.metric_basic_readonly_icon)
				select_userdefined_btn.set_pixmap (pixmaps.icon_pixmaps.metric_basic_icon)
				select_predefined_btn.select_actions.extend (agent on_select_predefined_metric)
				select_userdefined_btn.select_actions.extend (agent on_select_userdefined_metric)
				metric_selection_toolbar.show
			else
				metric_grid.set_column_count_to (1)
				metric_selection_toolbar.hide
			end
			metric_grid.column (metric_column_index).header_item.set_text (metric_names.t_metrics)
			metric_grid.enable_default_tree_navigation_behavior (True, True, True, True)
			metric_grid.enable_selection_on_single_button_click
			create metric_grid_wrapper.make (metric_grid)
			metric_grid_area.extend (metric_grid_wrapper.component_widget)

				-- Initialize sorting information.
			create l_sort_info.make (agent metric_order_tester, ascending_order)
			l_sort_info.enable_auto_indicator
			metric_grid_wrapper.set_sort_info (metric_column_index, l_sort_info)
			metric_grid_wrapper.set_sort_action (agent sort_agent)
			metric_grid.key_press_actions.extend (agent on_key_pressed)

			tree_view_checkbox.remove_text
			tree_view_checkbox.set_text (metric_names.t_group)
			tree_view_checkbox.set_pixmap (pixmaps.icon_pixmaps.metric_group_icon)
			tree_view_checkbox.enable_select
			tree_view_checkbox.select_actions.extend (agent on_tree_view_checkbox_selected)

			metric_grid.set_item_pebble_function (agent item_pebble_function)
			metric_grid.enable_single_row_selection
			metric_grid.row_select_actions.extend (agent on_row_selected)
			metric_grid.key_press_string_actions.extend (agent on_string_key_pressed)

			select_predefined_btn.set_tooltip (metric_names.f_select_predefined_metrics)
			select_userdefined_btn.set_tooltip (metric_names.f_select_userdefined_metrics)
			tree_view_checkbox.set_tooltip (metric_names.f_group_metric_by_unit)
		ensure then
			metric_selected_actions_attached: metric_selected_actions /= Void
			group_selected_actions_attached: group_selected_actions /= Void
			metric_table_attached: metric_table /= Void
			double_click_actions_attached: double_click_actions /= Void
		end

feature -- Access

	metric_selected_actions: ACTION_SEQUENCE [TUPLE [EB_METRIC]]
			-- Actions to be performed when a metric is selected in `metric_grid'.

	group_selected_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when a group item is selected

	double_click_actions: ACTION_SEQUENCE [TUPLE [STRING]]
			-- Actions to be performed when double click on a metric item.
			-- Argument is name of the double-clicked metric.

	next_to_last_selected_metric: STRING
			-- Name of next to last selected metric
			-- Void if there is no next to last selected metric.

	last_selected_metric: STRING
			-- Name of last selected metric
			-- Void if there is no last selected metric.

	metric_column_index: INTEGER is
			-- Column index for metric
		do
			if is_selectable then
				Result := 2
			else
				Result := 1
			end
		end

	selected_metrics: LIST [STRING] is
			-- Names of selected metrics
		local
			l_tbl: like selection_status
		do
			if is_selectable then
				l_tbl := selection_status
				create {LINKED_LIST [STRING]} Result.make
				from
					l_tbl.start
				until
					l_tbl.after
				loop
					if l_tbl.item_for_iteration then
						Result.extend (l_tbl.key_for_iteration)
					end
					l_tbl.forth
				end
			else
				create {LINKED_LIST[STRING]} Result.make
			end
		end

	selected_item_name: STRING is
			-- Name of selected metric in `metric_grid'.
			-- Void if no metric is selected
		local
			l_metric: EB_METRIC
		do
			l_metric := selected_metric
			if l_metric /= Void then
				Result := l_metric.name.twin
			end
		end

	selected_metric: EB_METRIC is
			-- Selected metric
			-- Void if no metric is selected.
		local
			l_item: EV_GRID_ITEM
		do
			if metric_grid.selected_items.count > 0 then
				l_item := metric_grid.selected_items.first
				Result ?= l_item.data
			end
		end

	metric_name_list: LINKED_LIST [STRING]
			-- List of metric names in current

	metric_name_row_table: HASH_TABLE [INTEGER, STRING]
			-- Table of metric rows.
			-- Key is name of metric, value is the grid row index.

	input_cache: STRING
			-- Input cache

feature -- Status report

	is_selectable: BOOLEAN
			-- Is metric selectable

	should_invalid_metric_be_selected: BOOLEAN
			-- Should invalid metric be selected?

feature{NONE} -- Actions

	on_tree_view_checkbox_selected is
			-- Action to be performed when `tree_view_checkbox' selection changes.
		do
			metric_selected_actions.block
			group_selected_actions.block
			metric_grid_wrapper.disable_auto_sort_order_change
			metric_grid_wrapper.sort (0, 0, 1, 0, 0, 0, 0, 0, metric_column_index)
			metric_grid_wrapper.enable_auto_sort_order_change
			try_to_selected_last_metric
			metric_selected_actions.resume
			group_selected_actions.resume
		end

	on_selection_change (a_item: MA_GRID_CHECK_BOX_ITEM) is
			-- Action to be performed when selection in `a_item' changes
		local
			l_metric: EB_METRIC
		do
			l_metric ?= a_item.data
			check l_metric /= Void end
			selection_status.force (a_item.selected, l_metric.name.as_lower)
		end

	on_row_selected (a_row: EV_GRID_ROW) is
			-- Action to be performed when `a_row' is selected
		local
			l_metric: EB_METRIC
			l_item: EV_GRID_ITEM
		do
			l_metric ?= a_row.data
			if l_metric /= Void then
					-- A metric row is selected.
				l_item := a_row.item (metric_column_index)
				if l_item /= Void then
					l_metric ?= l_item.data
					check l_metric /= Void end
					if not metric_selected_actions.is_empty then
						set_last_selected_metric (l_metric.name.twin)
						metric_selected_actions.call ([l_metric])
					end
				end
			else
					-- A group row is selected.
				group_selected_actions.call ([])
			end
		end

	on_select_predefined_metric is
			-- Action to be performed when selection status of `select_predefined_btn' changes
		require
			selectable: is_selectable
		do
			select_metrics (True, select_predefined_btn.is_selected)
		end

	on_select_userdefined_metric is
			-- Action to be performed when selection status of `select_userdefined_btn' changes
		require
			selectable: is_selectable
		do
			select_metrics (False, select_userdefined_btn.is_selected)
		end

	on_pointer_double_pressed_on_metric_item (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER; a_item: EV_GRID_ITEM) is
			-- Action to be performed when double click on a metric item
		local
			l_metric: EB_METRIC
		do
			if a_button = 1 and then a_item /= Void then
				l_metric ?= a_item.data
				if l_metric /= Void then
					double_click_actions.call ([l_metric.name])
				end
			end
		end

	on_key_pressed (a_key: EV_KEY) is
			-- Action to be performed when `a_key' is pressed in `metric_grid'
		require
			a_key_attached: a_key /= Void
		local
			l_selected_rows: LIST [EV_GRID_ROW]
			l_checkbox_item: MA_GRID_CHECK_BOX_ITEM
		do
			if a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				if is_selectable then
					l_selected_rows := metric_grid.selected_rows
					if l_selected_rows /= Void then
						l_checkbox_item ?= l_selected_rows.first.item (1)
						if l_checkbox_item /= Void then
							l_checkbox_item.set_selected (not l_checkbox_item.selected)
						end
					end
				end
			elseif a_key.code = {EV_KEY_CONSTANTS}.key_escape then
				input_cache.wipe_out
			end
		end

	on_string_key_pressed (a_key: STRING_32) is
			-- Action to be performed when a displayable key `a_key' is pressed in `metric_grid'.
		require
			a_key_attached: a_key /= Void
		local
			l_index, l_old_index: INTEGER
			l_selected_rows: LIST [EV_GRID_ROW]
			l_row: EV_GRID_ROW
			l_metric: EB_METRIC
			l_row_cnt: INTEGER
			done: BOOLEAN
			l_grid: like metric_grid
			l_name: STRING
			l_cache: STRING
			l_twice: BOOLEAN
		do
			l_grid := metric_grid
			l_selected_rows := l_grid.selected_rows
			if not l_selected_rows.is_empty then
				l_row := l_selected_rows.first
				if l_row.data = Void then
					l_row := Void
				end
			else
				if not metric_name_list.is_empty then
					l_row := l_grid.row (metric_name_row_table.item (metric_name_list.first))
				end
			end
			if l_row = Void then
				if not metric_name_list.is_empty then
					l_row := l_grid.row (metric_name_row_table.item (metric_name_list.first))
				end
			end
			if l_row /= Void then
				input_cache.append (a_key)
				l_metric ?= l_row.data
				check l_metric /= Void end
				from
					l_index := l_row.index
					l_old_index := l_index
					l_row_cnt := l_grid.row_count
					l_cache := input_cache
				until
					(l_twice and then l_index = l_old_index) or done
				loop
					l_row := l_grid.row (l_index)
					if l_row.data /= Void then
						l_metric ?= l_row.data
						check l_metric /= Void end
						l_name := l_metric.name
						if l_name.count >= l_cache.count and then l_name.substring (1, l_cache.count).is_case_insensitive_equal (l_cache) then
							l_grid.remove_selection
							l_row.enable_select
							l_row.ensure_visible
							done := True
						end
					end
					l_index := l_index + 1
					if l_index > l_row_cnt then
						l_index := 1
						l_twice := True
					end
				end
				if not done then
					input_cache.wipe_out
				end
			else
				input_cache.wipe_out
			end
		end

feature -- setting

	set_last_selected_metric (a_name: like last_selected_metric) is
			-- Set `last_selected_metric' with `a_name'.
		do
			set_next_to_last_selected_metric (last_selected_metric)
			if a_name = Void then
				last_selected_metric := Void
			else
				last_selected_metric := a_name.twin
			end
		ensure
			last_selected_metric_set: (a_name /= Void implies last_selected_metric.is_equal (a_name)) and
									  (a_name = Void implies last_selected_metric = Void)
		end

	set_next_to_last_selected_metric (a_name: like next_to_last_selected_metric) is
			-- Set `next_to_last_selected_metric' with `a_name'.
		do
			if a_name = Void then
				next_to_last_selected_metric := Void
			else
				next_to_last_selected_metric := a_name.twin
			end
		ensure
			next_to_last_selected_metric_set: (a_name /= Void implies next_to_last_selected_metric.is_equal (a_name)) and
									  (a_name = Void implies next_to_last_selected_metric = Void)
		end

	remove_selection is
			-- Remove selection.
		do
			metric_grid.remove_selection
		end

	enable_invalid_metric_selection is
			-- Enable selection on invalid metric.
		do
			should_invalid_metric_be_selected := True
		ensure
			invalid_metric_selection_enabled: should_invalid_metric_be_selected
		end

	disable_invalid_metric_selection is
			-- Disable selection on invalid metric.
		do
			should_invalid_metric_be_selected := False
		ensure
			invalid_metric_selection_disabled: not should_invalid_metric_be_selected
		end

feature -- Basic operations

	select_metric (a_name: STRING) is
			-- Enable metric named `a_name' is selected in `metric_grid'.
		require
			a_name_attached: a_name /= Void
		local
			l_row: EV_GRID_ROW
			l_row_index: INTEGER
			l_row_count: INTEGER
			l_metric: EB_METRIC
			done: BOOLEAN
			l_item: EV_GRID_ITEM
		do
			from
				l_row_index := 1
				l_row_count := metric_grid.row_count
			until
				l_row_index > l_row_count or done
			loop
				l_row := metric_grid.row (l_row_index)
				l_item := l_row.item (metric_column_index)
				if l_item /= Void then
					l_metric ?= l_item.data
					if l_metric /= Void then
						if l_metric.name.is_equal (a_name) then
							metric_grid.remove_selection
							if l_row.parent_row /= Void and then l_row.parent_row.is_expandable and then not l_row.parent_row.is_expanded then
								l_row.parent_row.expand
							end
							l_row.enable_select
							l_row.ensure_visible
							done := True
						end
					end
				end
				l_row_index := l_row_index + 1
			end
		end

	select_first_metric is
			-- Select the first available metric.
		local
			l_item: EV_GRID_ITEM
			l_row_index: INTEGER
			l_row_count: INTEGER
			l_metric: EB_METRIC
			done: BOOLEAN
		do
			metric_grid.remove_selection
			from
				l_row_index := 1
				l_row_count := metric_grid.row_count
			until
				l_row_index > l_row_count or done
			loop
				l_item := metric_grid.row (l_row_index).item (metric_column_index)
				if l_item /= Void then
					l_metric ?= l_item.data
					if l_metric /= Void then
						l_item.row.enable_select
						done := True
					end
				end
				l_row_index := l_row_index + 1
			end
		end

	try_to_selected_last_metric is
			-- Try to select `last_selected_metric'.
			-- If not possible, try to select the first available metric.
		do
			if last_selected_metric /= Void then
				select_metric (last_selected_metric)
				if metric_grid.selected_rows.is_empty then
					select_first_metric
				end
			end
		end

feature -- Metric management

	load_metrics (a_preserve_last_selected_metric: BOOLEAN) is
			-- Load metrics in `metric_manager' into `metric_grid'.
			-- If `a_preserve_last_selected_metric' is True, try to preserve last selected metric.
		do
			metric_name_list.wipe_out
			metric_name_row_table.wipe_out
			metric_selected_actions.block
			group_selected_actions.block
			metric_grid_wrapper.disable_auto_sort_order_change
			metric_grid_wrapper.sort (0, 0, 1, 0, 0, 0, 0, 0, metric_column_index)
			metric_grid_wrapper.enable_auto_sort_order_change
			load_metric_in_grid
			if a_preserve_last_selected_metric then
				try_to_selected_last_metric
			end
			metric_selected_actions.resume
			group_selected_actions.resume
		end

	load_metric_in_grid is
			-- Load `metrics' in `metric_grid'.
		local
			l_row: EV_GRID_ROW
			l_metric_list: LIST [EB_METRIC]
			l_item: EV_GRID_LABEL_ITEM
			l_unit_list: LIST [TUPLE [unit: QL_METRIC_UNIT; pixmap: EV_PIXMAP]]
		do
			if metric_grid.row_count > 0 then
				metric_grid.remove_rows (1, metric_grid.row_count)
			end
			if tree_view_checkbox.is_selected then
				metric_grid.enable_tree
				from
					l_unit_list := unit_list (True)
					l_unit_list.start
				until
					l_unit_list.after
				loop
					l_metric_list := metric_table.item (l_unit_list.item.unit)
					if l_metric_list /= Void and then not l_metric_list.is_empty then
						metric_grid.insert_new_row (metric_grid.row_count + 1)
						l_row := metric_grid.row (metric_grid.row_count)
						create l_item.make_with_text (displayed_name (l_unit_list.item.unit.name))
						l_item.set_pixmap (l_unit_list.item.pixmap)
						l_row.set_item (1, l_item)
						l_metric_list.do_all (agent load_metric (?, l_row))
						if l_row.is_expandable then
							l_row.expand
						end
					end
					l_unit_list.forth
				end
			else
				metric_grid.disable_tree
				l_metric_list := metric_table.item (no_unit)
				from
					l_metric_list.start
				until
					l_metric_list.after
				loop
					metric_grid.insert_new_row (metric_grid.row_count + 1)
					l_row := metric_grid.row (metric_grid.row_count)
					load_metric (l_metric_list.item, l_row)
					l_metric_list.forth
				end
			end
			if metric_grid.row_count > 0 then
				metric_grid.column (1).resize_to_content
			end
		end

	load_metric (a_metric: EB_METRIC; a_row: EV_GRID_ROW) is
			-- Load `a_metric' in `a_row' of `metric_grid'.
		require
			a_metric_attached: a_metric /= Void
			a_metric_registered: a_metric.is_registered
			a_row_attached: a_row /= Void
		local
			l_grid_item: EV_GRID_LABEL_ITEM
			l_grid_row: EV_GRID_ROW
			l_font: EV_FONT
			l_tooltip: STRING
			l_vadility: EB_METRIC_ERROR
			l_red: EV_COLOR
			l_check_item: MA_GRID_CHECK_BOX_ITEM
		do
			metric_name_list.extend (a_metric.name)
			create l_grid_item.make_with_text (a_metric.name)
			create l_font
			l_red := (create {EV_STOCK_COLORS}).red
			l_grid_item.set_font (l_font)
			l_vadility := metric_manager.metric_vadility (a_metric.name)
			if l_vadility = Void then
				if a_metric.is_predefined or else a_metric.description /= Void then
					create l_tooltip.make (128)
					if a_metric.description /= Void then
						l_tooltip.append (a_metric.description)
					end
				end
			else
				l_tooltip := l_vadility.out
				l_grid_item.set_foreground_color (l_red)
			end
			if not l_tooltip.is_empty then
				l_tooltip.append_character ('%N')
			end
			l_tooltip.append (metric_names.f_double_click_to_go_to_definition)
			l_grid_item.set_tooltip (l_tooltip)
			l_grid_item.set_pixmap (pixmap_from_metric (a_metric))
			l_grid_item.set_data (a_metric)
			l_grid_item.pointer_double_press_actions.extend (agent on_pointer_double_pressed_on_metric_item (?, ?, ?, ?, ?, ?, ?, ?, l_grid_item))
			if metric_grid.is_tree_enabled then
				a_row.insert_subrow (a_row.subrow_count + 1)
				l_grid_row := a_row.subrow (a_row.subrow_count)
				metric_name_row_table.force (l_grid_row.index, a_metric.name)
				l_grid_row.set_data (a_metric)
				l_grid_row.set_item (metric_column_index, l_grid_item)
				if is_selectable then
					create l_check_item.make_with_boolean (selection_status.item (a_metric.name.as_lower))
					l_check_item.selected_changed_actions.extend (agent on_selection_change)
					l_check_item.set_data (a_metric)
					l_grid_row.set_item (1, l_check_item)
				end
			else
				a_row.set_item (metric_column_index, l_grid_item)
				a_row.set_data (a_metric)
				metric_name_row_table.force (a_row.index, a_metric.name)
				if is_selectable then
					create l_check_item.make_with_boolean (selection_status.item (a_metric.name.as_lower))
					l_check_item.selected_changed_actions.extend (agent on_selection_change)
					l_check_item.set_data (a_metric)
					a_row.set_item (1, l_check_item)
				end
			end
		end

feature{NONE} -- Implementation/Sorting

	sort_agent (a_column_list: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [ANY]) is
			-- Action to be performed when sort `a_column_list' using `a_comparator'.
		require
			a_column_list_attached: a_column_list /= Void
			not_a_column_list_is_empty:
		do
			metric_selected_actions.block
			group_selected_actions.block
			metric_table := metric_manager.ordered_metrics (mapped_sorting_order, not tree_view_checkbox.is_selected)
			setup_selection_status
			load_metric_in_grid
			try_to_selected_last_metric
			metric_selected_actions.resume
			group_selected_actions.resume
		end

	metric_order_tester (a_metric, b_metric: EB_METRIC; a_order: INTEGER): BOOLEAN is
		do
		end

	current_sort_order: INTEGER is
			-- Current sort order for metrics
		do
			Result := metric_grid_wrapper.column_sort_info.item (metric_column_index).current_order
		end

	selection_status: HASH_TABLE [BOOLEAN, STRING]
			-- Selection status table
			-- Key is metric name in lower-case, value is selection status

	setup_selection_status is
			-- Setup `selection_status' after load metrics.
		local
			l_metric_tbl: like metric_table
			l_metrics: LIST [EB_METRIC]
			l_old_tbl: like selection_status
			l_new_tbl: like selection_status
			l_name: STRING
		do
			l_metric_tbl := metric_manager.ordered_metrics (mapped_sorting_order, True)
			l_metrics := l_metric_tbl.item (no_unit)
			l_old_tbl := selection_status.twin
			l_new_tbl := selection_status
			l_new_tbl.wipe_out
			from
				l_metrics.start
			until
				l_metrics.after
			loop
				l_name := l_metrics.item.name.as_lower
				if l_old_tbl.has (l_name) then
					l_new_tbl.put (l_old_tbl.item (l_name), l_name)
				else
					l_new_tbl.put (False, l_name)
				end
				l_metrics.forth
			end
		end

feature {NONE} -- Implementation

	metric_grid: ES_GRID
			-- Grid to display metrics

	metric_grid_wrapper: EVS_SEARCHABLE_COMPONENT [ANY]
			-- Sortable grid component

	metric_table: HASH_TABLE [LIST [EB_METRIC], QL_METRIC_UNIT]
			-- Table representation of `metrics'.
			-- Key is metric unit, and value is a list of metrics with that unit.

	item_pebble_function (a_item: EV_GRID_ITEM): ANY is
			-- Pebble of `a_item'.
		local
			l_item: EV_GRID_LABEL_ITEM
			l_metric: EB_METRIC
		do
			l_item ?= a_item
			if l_item /= Void then
				l_metric ?= l_item.data
				if l_metric /= Void then
					Result := l_metric
					metric_grid.set_accept_cursor (cursors.cur_metric)
					metric_grid.set_deny_cursor (cursors.cur_x_metric)
				end
			end
		end

	mapped_sorting_order: INTEGER is
			-- Mapped sorting order for `metric_grid'
		do
			if current_sort_order = ascending_order then
				Result := metric_manager.ascending_order
			elseif current_sort_order = descending_order then
				Result := metric_manager.descending_order
			elseif current_sort_order = topology_order then
				Result := metric_manager.topological_order
			end
		end

	select_metrics (a_predefined: BOOLEAN; a_select: BOOLEAN) is
			-- Selected metrics:
			-- `a_predefined' is True indicates that this selection is applied to predefined metrics, otherwise user-defined metrics.
			-- `a_select' is True indicate selecting those metrics, otherwise unselect them.
		require
			selectable: is_selectable
		local
			i, c: INTEGER
			l_row: EV_GRID_ROW
			l_grid: like metric_grid
			l_metric: EB_METRIC
			l_check_item: MA_GRID_CHECK_BOX_ITEM
		do
			from
				i := 1
				l_grid := metric_grid
				c := l_grid.row_count
			until
				i > c
			loop
				l_row := l_grid.row (i)
				if l_row.data /= Void then
					l_check_item ?= l_row.item (1)
					l_metric ?= l_row.data
					check
						l_check_item /= Void
						l_metric /= Void
					end
					if l_metric.is_predefined = a_predefined then
						if a_select then
							if metric_manager.is_metric_valid (l_metric.name) or else should_invalid_metric_be_selected then
								l_check_item.set_selected (a_select)
							end
						else
							l_check_item.set_selected (a_select)
						end

					end
				end
				i := i + 1
			end
		end

invariant
	metric_selected_actions_attached: metric_selected_actions /= Void
	group_selected_actions_attached: group_selected_actions /= Void
	metric_table_attached: metric_Table /= Void
	selection_status_attached: selection_status /= Void
	double_click_actions_attached: double_click_actions /= Void
	metric_name_list_attached: metric_name_list /= Void
	metric_name_row_table_attached: metric_name_row_table /= Void
	input_cache_attached: input_cache /= Void

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


end -- class EB_METRIC_SELECTOR

