indexing
	description: "Objects that support cdd classes"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_SUPPORT

feature -- Access

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

feature -- Project constants

	tests_cluster_name: STRING is "cdd_test_suite"
			-- Name of cdd cluster

feature -- Error constants

	error_none,				-- No error occured
	error_bad_root_cluster,	-- Root cluster is not a normal cluster
	error_need_recompile,
	error_unable_to_create_dir: INTEGER is unique
			-- Error codes


feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
