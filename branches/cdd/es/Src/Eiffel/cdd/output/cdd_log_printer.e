indexing
	description: "Objects that print all cdd activities to a log file"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_LOG_PRINTER

create
	make_with_manager

feature {NONE} -- Initialization

	make_with_manager (a_manager: like manager) is
			-- Initialize `Current'.
		require
			a_manager_not_void: a_manager /= Void
		do
			manager := a_manager
		ensure
			manager_set: manager = a_manager
		end

feature -- Access

	manager: CDD_MANAGER
			-- Manager containing current test suite

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

	note_refresh is
			--
		do

		end

	note_test_case_add is
			--
		require
			testing_enabled: manager.is_testing_enabled
		do

		end

	note_test_case_remove is
			--
		require
			testing_enabled: manager.is_testing_enabled
		do

		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Basic log operations

	write_log_message (a_message: STRING) is
			-- Try to write `a_message' into `file' and add information like time etc.
		require
			a_message_not_empty: a_message /= Void and then not a_message.is_empty
		local
			l_string: STRING
			l_time: TIME
		do
			prepare_file
			if can_write_to_file then
				create l_time.make_now
				create l_string.make_from_string (a_message)
				l_string.append ("%T" + l_time.default_format_string)
				file.put_string (l_string)
				file.put_new_line
				close_file
			end
		end

feature {NONE} -- Log file operations

	can_write_to_file: BOOLEAN is
			-- Is `file' opened and writable?
		do
			Result := file /= Void and then file.is_open_write
		end

	file: KL_TEXT_OUTPUT_FILE
			-- File where all logs are written to

	file_name: FILE_NAME is
			-- File name for `file'
		require
			testing_enabled: manager.is_testing_enabled
		do
			create Result.make_from_string (manager.test_suite.tests_cluster.location.build_path ("", "cdd_history.log"))
		ensure
			result_not_empty: Result /= Void and then not Result.is_empty
		end

	prepare_file is
			-- Try to open `file' so log messages can be written.
		do
			create file.make (file_name)
			file.open_append
		end

	close_file is
			-- Close `file'
		require
			opened: can_write_to_file
		do
			file.close
		ensure
			closed: not can_write_to_file
		end

invariant
	manager_not_void: manager /= Void

end
