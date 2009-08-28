note
	description: "[
		Objects implementing {TEST_SUITE_S}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SUITE

inherit
	TEST_SUITE_S

	DISPOSABLE_SAFE

	ROTA_OBSERVER
		redefine
			on_task_finished
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			l_rota: ROTA_S


			l_project: E_PROJECT
			l_project_factory: SHARED_EIFFEL_PROJECT
		do
			create test_map.make_default
			test_map.set_key_equality_tester (create {KL_STRING_EQUALITY_TESTER_A [READABLE_STRING_GENERAL]})

				-- Events
			create test_added_event
			create test_removed_event
			create session_launched_event
			create session_finished_event

			create record_repository.make

			if rota.is_service_available then
				l_rota := rota.service
				if l_rota.is_interface_usable then
					l_rota.connection.connect_events (Current)
				end
			end
			create factories.make_default

				-- register test executor
			register_factory (create {TEST_DEFAULT_SESSION_FACTORY [TEST_EXECUTION]})
		end

feature -- Access

	tests: DS_LINEAR [TEST_I]
			-- <Precursor>
		do
			Result := test_map
		end

	test (an_identifier: READABLE_STRING_GENERAL): TEST_I
			-- <Precursor>
		do
			Result := test_map.item (an_identifier)
		end

	record_repository: TEST_RECORD_REPOSITORY
			-- <Precursor>

feature -- Access: output

	output (a_session: TEST_SESSION_I): detachable OUTPUT_I
			-- <Precursor>
			--
			-- Note: the session does not have to care about clearing the output when launching, since this
			--       is done by `Current'.
		local
			l_output_manager: OUTPUT_MANAGER_S
			l_output: OUTPUT_I
		do
			if a_session = current_output_session then
				Result := internal_output
			end
		end

feature -- Access: tagging

	tag_tree: TAG_TREE [like test]
			-- <Precursor>

feature {NONE} -- Access

	test_map: DS_HASH_TABLE [like test, READABLE_STRING_GENERAL]
			-- Table mapping test names to their instances
			--
			-- key: Test name
			-- value: Test instance

feature {NONE} -- Access: sessions

	factories: DS_ARRAYED_LIST [TEST_SESSION_FACTORY [TEST_SESSION_I]]
			-- List containing all registered factories

	frozen rota: SERVICE_CONSUMER [ROTA_S]
			-- Access to rota service {ROTA_S}
		do
			create Result
		end

feature {NONE} -- Access: output

	frozen output_manager: SERVICE_CONSUMER [OUTPUT_MANAGER_S]
			-- Access to output manager service {OUTPUT_MANAGER_S}
		do
			create Result
		end

	internal_output: like output
			-- Usable OUTPUT_I instance for `output'
		local
			l_output_manager: OUTPUT_MANAGER_S
			l_output: OUTPUT_I
		do
			if output_manager.is_service_available then
				l_output_manager := output_manager.service
				if
					l_output_manager.is_interface_usable and then
					l_output_manager.is_valid_registration_key (output_key) and then
					l_output_manager.is_output_available (output_key)
				then
					l_output := l_output_manager.output (output_key)
					if l_output.is_interface_usable then
						Result := l_output
					end
				end
			end
		ensure
			result_attached_implies_usable: Result /= Void implies Result.is_interface_usable
		end

	output_key: UUID
			-- Key for testing output
		once
			Result := (create {OUTPUT_MANAGER_KINDS}).testing
		end

	current_output_session: detachable TEST_SESSION_I
			-- Session currently using the testing output

feature -- Query

	has_test (an_identifier: READABLE_STRING_GENERAL): BOOLEAN
			-- <Precursor>
		do
			Result := test_map.has (an_identifier)
		end

feature -- Status setting: tests

	add_test (a_test: like test)
			-- <Precursor>
		do
			test_map.force (a_test, a_test.name)
			test_added_event.publish ([Current, a_test])
		end

	remove_test (a_test: like test)
			-- <Precursor>
		do
			test_map.remove (a_test.name)
			if tag_tree.has_item (a_test) then
				tag_tree.remove_all_tags (a_test)
			end
			test_removed_event.publish ([Current, a_test])
		end

feature -- Status setting: sessions

	launch_session (a_session: TEST_SESSION_I)
			-- <Precursor>
		local
			l_rota: ROTA_S
			l_repo: like record_repository
		do
			if current_output_session = Void then
				current_output_session := a_session
				if attached internal_output as l_output then
					l_output.clear
					l_output.activate (False)
				end
			end
			a_session.start
			if a_session.has_next_step then
				l_repo := record_repository
				if not l_repo.has_record (a_session.record) then
					l_repo.append_record (a_session.record)
				end
				session_launched_event.publish ([Current, a_session])
				if rota.is_service_available then
					l_rota := rota.service
					if l_rota.is_interface_usable and not l_rota.has_task (a_session) then
						l_rota.run_task (a_session)
					end
				end
			elseif current_output_session = a_session then
				current_output_session := Void
			end
		end

feature -- Element change

	register_factory (a_factory: TEST_SESSION_FACTORY [TEST_SESSION_I])
			-- <Precursor>
		do
			factories.force_last (a_factory)
		end

feature -- Basic operations

	new_session (a_type: TYPE [TEST_SESSION_I]): detachable TEST_SESSION_I
			-- <Precursor>
		local
			l_list: like factories
			l_factory: TEST_SESSION_FACTORY [TEST_SESSION_I]
		do
			from
				l_list := factories
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				l_factory := l_list.item_for_iteration
				if l_factory.type.conforms_to (a_type) then
					Result := l_factory.new_session (Current)
				end
				l_list.forth
			end
		end

feature -- Events

	test_added_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; test: like test]]
			-- <Precursor>

	test_removed_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; test: like test]]
			-- <Precursor>

	session_launched_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; session: TEST_SESSION_I]]
			-- <Precursor>

	session_finished_event: EVENT_TYPE [TUPLE [test_suite: TEST_SUITE_S; session: TEST_SESSION_I]]
			-- <Precursor>

feature {ROTA_S} -- Events: rota

	on_task_finished (a_rota: ROTA_S; a_task: ROTA_TIMED_TASK_I)
			-- <Precursor>
		do
			if
				attached {TEST_SESSION_I} a_task as l_session and then
				l_session.test_suite = Current
			then
				if current_output_session = l_session then
					current_output_session := Void
				end
				session_finished_event.publish ([Current, l_session])
			end
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		local
			l_rota: ROTA_S
		do
			if a_explicit then
				if rota.is_service_available then
					l_rota := rota.service
					if l_rota.is_interface_usable then
						l_rota.connection.disconnect_events (Current)
					end
				end
			end
		end

invariant
	test_map_attached: test_map /= Void
	test_map_contains_usables: test_map.for_all (agent {TEST_I}.is_interface_usable)

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
