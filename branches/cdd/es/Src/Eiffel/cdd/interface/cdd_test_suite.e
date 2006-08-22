indexing
	description: "Objects that ..."
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_SUITE

inherit
	ANY
		redefine
			default_create
		end

	PROJECT_CONTEXT
		export
			{NONE} all
		undefine
			default_create
		end

feature {NONE} -- Initialization

	default_create is
			--
		do
			test_case_created := False
			create test_case_hash.make (20) -- better value?
			create new_test_case_subscribers.make
		end



feature {EB_DEBUGGER_MANAGER} -- Test Case Generation

	report_postcondition_violation (app_status: APPLICATION_STATUS) is
			-- Initialize Current.
		require
			app_status_valid: app_status /= Void and app_status.is_stopped
			exception_occurred: app_status.exception_occurred
			valid_exception: app_status.exception_code = 4
			is_eiffel_class: app_status.dynamic_class.is_eiffel_class_c
		local
			addr: STRING
			cse: EIFFEL_CALL_STACK_ELEMENT
			obj: CDD_REFLECTED_OBJECT
			dclass: EIFFEL_CLASS_C
			i: INTEGER
			class_name: STRING
			tc: CDD_TEST_CASE
			file_path: STRING
			file: PLAIN_TEXT_FILE
		do
			addr := app_status.object_address
			dclass ?= app_status.dynamic_class
			check dclass /= Void end
			cse ?= app_status.current_call_stack_element
			check cse /= Void end
			create obj.make (addr, dclass, cse)
			if obj.root_object /= Void then
				create class_name.make_from_string ("test_" + dclass.name)
				class_name.to_lower
				from
					i := 0
				until
					i > 0 and then not file.exists
				loop
					i := i + 1
					file_path := project_location.path.string + "/tests/" + class_name + "_" + i.out + ".e"
					create file.make (file_path)
				end
				class_name.to_upper
				class_name.append ("_" + i.out)
				file.open_write
				printer.print_test_case (obj, class_name, app_status.e_feature, file)
				create tc.make (dclass, app_status.e_feature, class_name, file_path)

				if not test_case_hash.has (dclass) then
					test_case_hash.put_new (create {DS_LINKED_LIST [CDD_TEST_CASE]}.make, dclass)
				end
				test_case_hash.item (dclass).put_last (tc)
				test_case_created := True
				notify_new_test_case (tc)
			else
				test_case_created := False
			end
		end

	test_case_created: BOOLEAN

feature -- Access


	count: INTEGER
			-- Number of test cases in the system

	classes: DS_LIST [EIFFEL_CLASS_C] is
			--
		do
			Result := create {DS_ARRAYED_LIST [EIFFEL_CLASS_C]}.make (test_case_hash.count)
			from
				test_case_hash.start
			until
				test_case_hash.after
			loop
				Result.put_last (test_case_hash.key_for_iteration)
				test_case_hash.forth
			end
		end


	test_cases (a_class: EIFFEL_CLASS_C): DS_LIST [CDD_TEST_CASE] is
			--
		do
			Result := test_case_hash.item (a_class)
		end


feature -- Event handling

	subscribe_new_test_case (an_action: PROCEDURE [ANY, TUPLE [CDD_TEST_CASE]]) is
			--
		do
			new_test_case_subscribers.put_last (an_action)
		end


feature {NONE} -- Event Handling

	new_test_case_subscribers: DS_LINKED_LIST [PROCEDURE [ANY, TUPLE [CDD_TEST_CASE]]]

	notify_new_test_case (a_test_case: CDD_TEST_CASE) is
			--
		do
			from
				new_test_case_subscribers.start
			until
				new_test_case_subscribers.after
			loop
				new_test_case_subscribers.item_for_iteration.call ([a_test_case])
				new_test_case_subscribers.forth
			end
		end

	delete_test_case_subscribers: DS_LINKED_LIST [PROCEDURE [ANY, TUPLE [CDD_TEST_CASE]]]

	notify_delete_test_case (a_test_case: CDD_TEST_CASE) is
			--
		do
			from
				delete_test_case_subscribers.start
			until
				delete_test_case_subscribers.after
			loop
				delete_test_case_subscribers.item_for_iteration.call ([a_test_case])
				delete_test_case_subscribers.forth
			end
		end


feature {NONE} -- Implementation

	test_case_hash: DS_HASH_TABLE [DS_LIST [CDD_TEST_CASE], EIFFEL_CLASS_C]

	printer: CDD_TEST_CASE_PRINTER is
			--
		once
			create Result
		end


end -- class CDD_TEST

