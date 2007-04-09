indexing
	description: "Central object for managing all CDD activities"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_MANAGER

inherit

	CDD_SUPPORT

	EB_CLUSTER_MANAGER_OBSERVER
		rename
			manager as eb_cluster_manager,
			refresh as be_cluster_refresh,
			on_class_removed as remove_test_case_for_class
		export
			{NONE} all
		redefine
			remove_test_case_for_class
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

--	EB_SHARED_WINDOW_MANAGER
--		export
--			{NONE} all
--		end

--	EB_CONSTANTS
--		export
--			{NONE} all
--		end

--	CONF_ACCESS
--		export
--			{NONE} all
--		end

--	EB_SHARED_GRAPHICAL_COMMANDS
--		export
--			{NONE} all
--		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Add `Current' to cluster observer list.
		do
			create capturer
		end

feature -- Access (CDD Status)

	is_cdd_enabled: BOOLEAN
			-- Is testing currently enabled?

	is_capturing_enabled: BOOLEAN
			-- Is capturing currently enabled?

	test_suite: CDD_TEST_SUITE
			-- Test suite which is managed by `Current'

	can_enable_cdd: BOOLEAN is
			-- Can testing mode be enabled?
		do
		end

	can_enable_capturing: BOOLEAN is
			-- Can capturing be enabled?
		do
		end

	project: E_PROJECT is
			-- Currently opened project
		do
			Result := eiffel_project
		ensure
			open_project_not_void: Result /= Void
		end

feature -- Status setting (Application)

	on_application_stopped (an_application_status: APPLICATION_STATUS) is
			-- Check whether we want to create a new test case from the current
			-- application status `an_application_status'.
		do
			--if is_capturing_enabled and is_valid_status (an_application_status) then
				capturer.reflect_call_stack (an_application_status)
				if not capturer.reflected_call_stack.is_empty then

				end
			--end
		end

	on_application_quit is
			-- If `is_debugging' is true, notify test debugger that application is quit.
		do
		end

feature -- Status setting (CDD)

	enable_cdd is
			-- Create test suite and notify tools.
		do
		end

	disable_cdd is
			-- Disable cdd support.
		do
		end

	enable_capturing is
			-- Enable capturing mode.
		do
		end

feature {EB_CLUSTERS} -- Status setting (Eiffel Project)

	check_for_existing_cdd_cluster is
			-- Check if testing was enabled for this project before
			-- Note: Usually called when project is opened in EiffelStudio.
		do
		end

	refresh is
			-- Refresh all CDD components.
		do
		end

	remove_test_case_for_class (a_class: CLASS_I) is
			-- Check if there is a test case for `a_class'. If this is
			-- the case, remove the test case.
		do
		end

feature -- Status change

	refresh_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions performed after `Current' has refreshed the test suite

	update_state_actions: ACTION_SEQUENCE [TUPLE [STRING]]
			-- Actions performed when testing status changes

	log_actions: ACTION_SEQUENCE [TUPLE [STRING]]
			-- Agents for redirecting all output from external processes

feature {NONE} -- Implementation

	capturer: CDD_CAPTURER
			-- Capturer used for retrieving reflection

invariant
	capturer_not_void: capturer /= Void
	capturing_implies_cdd_enabled: is_capturing_enabled implies is_cdd_enabled
end
