indexing
	description: "Central object for managing all CDD activities"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_MANAGER

inherit

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

	is_valid_status (an_application_status: APPLICATION_STATUS): BOOLEAN is
			-- Is 'an_application_status' valid for creating a test case?
		do
			Result := an_application_status.is_stopped and
					an_application_status.exception_occurred and
					(an_application_status.exception_code = {EXCEP_CONST}.void_call_target or
					an_application_status.exception_code = {EXCEP_CONST}.postcondition or
					an_application_status.exception_code = {EXCEP_CONST}.class_invariant or
					an_application_status.exception_code = {EXCEP_CONST}.precondition or
					an_application_status.exception_code = {EXCEP_CONST}.check_instruction)
		end


feature -- Status setting (Application)

	on_application_stopped (an_application_status: APPLICATION_STATUS) is
			-- Check whether we want to create a new test case from the current
			-- application status `an_application_status'.
		do
			if is_capturing_enabled and is_valid_status (an_application_status) then
				capturer.make_reflection (an_application_status)
				if capturer.last_reflection /= Void then

				end
			end
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
