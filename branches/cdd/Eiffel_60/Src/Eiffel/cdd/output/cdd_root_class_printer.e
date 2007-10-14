indexing
	description: "[
			Objects that print root class for executing test cases. All test
			cases in system shall be created through this class.
		]"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_ROOT_CLASS_PRINTER

inherit

	CDD_CLASS_PRINTER

	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite) is
			-- Set `test_suite' to `a_test_suite'.
		require
			a_test_suite_not_void: a_test_suite /= Void
		do
			test_suite := a_test_suite
			internal_refresh_agent := agent print_root_class
			test_suite.refresh_actions.extend (internal_refresh_agent)
		ensure
			test_suite_set: test_suite = a_test_suite
		end

feature -- Access

	test_suite: CDD_TEST_SUITE
			-- Test suite containing test cases for root class

feature -- Measurement

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

	print_root_class is
			-- Print a new root class containing all test cases in `test_suite'.
		local
			l_directory: KL_DIRECTORY
			l_output_file: KL_TEXT_OUTPUT_FILE
			l_root: CONF_ROOT
			l_root_class: CLASS_C
		do
			--l_root := target.root
			--l_directory := target.project
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	internal_refresh_agent: PROCEDURE [like Current, TUPLE]

	put_indexing (an_uuid: STRING; an_index: INTEGER) is
			-- Append indexing clause.
		require
			initialized: is_output_stream_valid
			an_uuid_not_empty: an_uuid /= Void and then not an_uuid.is_empty
			an_index_positive: an_index > 0
		do
			put_line ("indexing%N")
			increase_indent
			put_line ("description: %"Objects that execute test cases%"")
			put_line ("author: %"CDD Tool%"")
			decrease_indent
			put_line ("")
		end

	put_class_header is
			-- Append cdd interpreter class header.
		require
			initialized: is_output_stream_valid
		do
			put_line ("class")
			increase_indent
			--put_line ("CDD_" + target.name.as_upper + "_INTERPRETER%N")
			decrease_indent
			put_line ("inherit")
			increase_indent
			put_line ("CDD_ABSTRACT_INTERPRETER%N")
			decrease_indent
			put_line ("create")
			increase_indent
			put_line ("execute")
			decrease_indent
		end

	put_test_setting_header is
			-- Append `test_setting' feature header.
		require
			initialized: is_output_stream_valid
		do
			put_line ("feature -- Access%N")

				-- Context
			increase_indent
			put_line ("test_setting: HASH_TABLE [TUPLE [instance: CDD_ABSTRACT_TEST_CASE; test_features: HASH_TABLE [PROCEDURE [CDD_ABSTRACT_TEST_CASE, TUPLE [CDD_ABSTRACT_TEST_CASE]], STRING]], STRING] is")
			increase_indent
			put_comment ("All test cases in this target")
			put_line ("once")
			increase_indent
		end

	put_footer is
			-- Append `test_setting' feature and class footer.
		require
			initialized: is_output_stream_valid
		do
			put_line ("%N")
			decrease_indent
			put_string ("%N%Nend -- class %N%N")
		end

invariant
	test_suite_not_void: test_suite /= Void
	internal_refresh_agent_not_void: internal_refresh_agent /= Void
	subscribed: test_suite.refresh_actions.has (internal_refresh_agent)

end
