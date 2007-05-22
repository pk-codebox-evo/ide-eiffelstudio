indexing
	description: "Objects that capture the state of some application"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_CAPTURER

inherit

		-- NOTE: will be removed when cdd manager has its own cdd cluster
	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: like manager) is
			-- Create `last_created_test_cases'.
		require
			a_manager_not_void: a_manager /= Void
		do
			create last_created_test_cases.make
			manager := a_manager
		ensure
			manager_set: manager = a_manager
		end

feature -- Access

	manager: CDD_MANAGER
			-- Manager for all CDD activities

	last_created_test_cases: DS_LINKED_LIST [STRING]
			-- File names of last captured cdd test cases

feature -- Basic operations

	capture_call_stack (a_status: APPLICATION_STATUS) is
			-- Create test cases for each feature call in the stack.
		require
			a_status_not_void: a_status /= Void
			a_status_valid: a_status.is_stopped
		do
			capture_stack_frames (a_status, a_status.current_call_stack.count)
		end

	capture_active_stack_frame (a_status: APPLICATION_STATUS) is
			-- Create test case for top feature call in call stack.
		require
			a_status_not_void: a_status /= Void
			a_status_valid: a_status.is_stopped
		do
			capture_stack_frames (a_status, 1)
		end

feature {NONE} -- Implementation

	cdd_directory_name: STRING is "cdd_tests"
			-- Directory name within root cluster in which all test cases will be created
			-- NOTE: assuming directy already exists - this will be replaced
			-- as soon CDD_MANAGER has its own cdd cluster

	capture_stack_frames (a_status: APPLICATION_STATUS; a_count: INTEGER) is
			-- Capture max `a_count' test cases for valid call stack elements
			-- from top of call stack in `a_status'.
			-- Wipes out `last_created_test_cases'.
		require
			a_status_not_void: a_status /= Void
			a_status_valid: a_status.is_stopped
		local
			i: INTEGER
			l_cse: EIFFEL_CALL_STACK_ELEMENT
		do
			last_created_test_cases.wipe_out
			l_cse ?= a_status.current_call_stack_element
			if a_status.exception_code = {EXCEP_CONST}.precondition then
				if l_cse /= Void and then l_cse.level_in_stack < a_status.current_call_stack.count then
					l_cse := caller (l_cse, a_status.current_call_stack)
				end
			end
			from
				i := 1
			until
				l_cse = Void or i > a_count
			loop
				l_cse := next_valid_cse (a_status, l_cse)
				if l_cse /= Void then
					create_test_case (l_cse)
					l_cse := caller (l_cse, a_status.current_call_stack)
					i := i + 1
				end
			end
		end

	caller (a_element: EIFFEL_CALL_STACK_ELEMENT; a_call_stack: EIFFEL_CALL_STACK): EIFFEL_CALL_STACK_ELEMENT is
			-- Call stack element which called the routine in `a_element' in `a_call_stack'.
			-- NOTE: Void if `a_element' is first element in `a_call_stack' or caller is not a eiffel call stack element.
		require
			a_element_not_void: a_element /= Void
			a_call_stack_not_void: a_call_stack /= Void
			a_element_valid: a_call_stack.i_th (a_element.level_in_stack) = a_element
		do
			if a_call_stack.valid_index (a_element.level_in_stack + 1) then
				Result ?= a_call_stack.i_th (a_element.level_in_stack + 1)
			end
		ensure
			valid_result: Result = Void or else Result.level_in_stack = a_element.level_in_stack + 1
			valid_result: Result = Void or else a_call_stack.i_th (Result.level_in_stack) = Result
		end

	is_valid_cse (a_cse: EIFFEL_CALL_STACK_ELEMENT): BOOLEAN is
			-- Are `a_cse' a valid call stack element in `an_app_status' for creating a test case?
			-- e.g. exported to all or creation procedure?
		require
			a_cse_not_void: a_cse /= Void
		local
			l_class: EIFFEL_CLASS_C
			l_feature: E_FEATURE
			l_is_creation_call: BOOLEAN
		do
			if a_cse.dynamic_class /= Void and then a_cse.dynamic_class.is_eiffel_class_c then
				l_class := a_cse.dynamic_class.eiffel_class_c
				l_feature := a_cse.routine
				l_is_creation_call := l_class.creation_feature = l_feature.associated_feature_i or
					(l_class.creators /= Void and then l_class.creators.has (l_feature.name))
				if l_is_creation_call or l_feature.export_status.is_all then
					Result := True
				end
			end
		end

	next_valid_cse (an_app_status: APPLICATION_STATUS; a_cse: EIFFEL_CALL_STACK_ELEMENT): EIFFEL_CALL_STACK_ELEMENT is
			-- Next valid call stack element below `a_cse' (including `a_cse') in
			-- `an_app_status' call stack.
		require
			an_app_status_not_void: an_app_status /= Void
			a_cse_not_void: a_cse /= Void
			valid_a_cse: an_app_status.current_call_stack.i_th (a_cse.level_in_stack) = a_cse
		local
			i: INTEGER
		do
			from
				Result := a_cse
			until
				Result = Void or else is_valid_cse (Result)
			loop
				i := Result.level_in_stack + 1
				if an_app_status.current_call_stack.valid_index (i) then
					Result := caller (Result, an_app_status.current_call_stack)
				else
					Result := Void
				end
			end
		ensure
			valid_result: Result = Void or else Result.level_in_stack >= a_cse.level_in_stack
			result_is_valid_cse: Result = Void or else an_app_status.current_call_stack.i_th (Result.level_in_stack) = Result
		end

	create_test_case (a_cse: EIFFEL_CALL_STACK_ELEMENT) is
			-- Create a test case which will invoke `a_cse'.
		require
			a_cse_not_void: a_cse /= Void
			valid_cse: is_valid_cse (a_cse)
		local
			l_file: KL_TEXT_OUTPUT_FILE
			l_dir_name: DIRECTORY_NAME
			l_dir: KL_DIRECTORY
			i: INTEGER
			l_file_name, l_class_name: STRING
		do
			create l_dir_name.make_from_string (eiffel_system.root_cluster.location.evaluated_directory)
			l_dir_name.extend (cdd_directory_name)
			create l_dir.make (l_dir_name)
			if l_dir.exists then
				l_dir_name.extend ("")
				from
					i := 1
				until
					(l_file /= Void and then not l_file.exists) or i > 999
				loop
					l_class_name := "CDD_TEST_" + a_cse.dynamic_class.name_in_upper + "_"
					if i < 10 then
						l_class_name.append ("00")
					elseif i < 100 then
						l_class_name.append_character ('0')
					end
					l_class_name.append_integer (i)
					l_file_name := l_class_name.as_lower + ".e"
					create l_file.make (l_dir_name + l_file_name)
					i := i + 1
				end

				if not l_file.exists then
					l_file.open_write
					if l_file.is_open_write  then
						printer.print_test_case (a_cse, l_class_name, l_file, uuid_generator.generate_uuid.out)
						last_created_test_cases.put_last (l_file_name)
					end
				end
			end
		end

feature {NONE} -- Implementation

	printer: CDD_TEST_CASE_PRINTER
			-- Printer for creating test case classes
		once
			create Result
		ensure
			not_void: Result /= Void
		end

	uuid_generator: UUID_GENERATOR is
			-- UUID generator for creating uuid's
		once
			create Result
		ensure
			not_void: Result /= Void
		end

-- NOTE: everything below is obsolete and will be removed soon...

--feature {NOEN} -- Access

--	reflected_call_stack: DS_LINKED_LIST [CDD_REFLECTION]
--			-- List of all reflected call stack elements
--			-- Note: Top element of the stack is first in the list

--feature {NONE} -- Basic operations

--	reflect_call_stack (an_application_status: APPLICATION_STATUS) is
--			-- Try to reflect current state of `an_application_status' for called feature in `a_cse'.
--			-- Result is stored in `last_reflection'.
--		require
--			an_application_status_not_void: an_application_status /= Void
--			valid_application_status: is_valid_status (an_application_status)
--		local
--			l_cse: EIFFEL_CALL_STACK_ELEMENT
--			l_feature: E_FEATURE
--			l_class: EIFFEL_CLASS_C
--			l_is_creation_call: BOOLEAN
--			l_reflection: CDD_REFLECTION
--			l_uuid: STRING
--		do
--			create reflected_call_stack.make
--			l_cse ?= an_application_status.current_call_stack_element

--			-- Check whether it is the callers fault
--			if l_cse /= Void then
--				if an_application_status.exception_code = {EXCEP_CONST}.precondition and
--						l_cse.level_in_stack < an_application_status.current_call_stack.count then
--					l_cse := caller (l_cse, an_application_status.current_call_stack)
--				end
--			end

--			-- Make sure we are trying to reflect an eiffel class
--			if l_cse /= Void and then l_cse.dynamic_class /= Void and then l_cse.dynamic_class.is_eiffel_class_c then
--				l_uuid := uuid_generator.generate_uuid.out
--				from
--					l_feature := l_cse.routine
--				until
--					l_cse = Void
--				loop
--					if l_cse.dynamic_class /= Void and then l_cse.dynamic_class.is_eiffel_class_c then
--						l_class := l_cse.dynamic_class.eiffel_class_c
--						l_is_creation_call := is_creation_procedure (l_class, l_feature)
--						if l_is_creation_call or l_feature.export_status.is_all then
--							create l_reflection.make (an_application_status, l_cse, l_is_creation_call, l_uuid)
--							if l_reflection.reflection_succeded then
--								reflected_call_stack.put_last (l_reflection)
--							end
--						end
--					end
--					l_cse := caller (l_cse, an_application_status.current_call_stack)
--				end
--			end
--		end

--feature {NONE} -- Implementation

--	is_creation_procedure (a_class: EIFFEL_CLASS_C; a_feature: E_FEATURE): BOOLEAN is
--			-- Is `l_feature' a creation procedure of `a_class'?
--		require
--			a_class_not_void: a_class /= Void
--			a_feature_not_void: a_feature /= Void
--		do
--			Result := a_class.creation_feature = a_feature.associated_feature_i
--			if not Result then
--				Result := a_class.creators /= Void and then a_class.creators.has (a_feature.name)
--			end
--		end

invariant
	manager_not_void: manager /= Void


end
