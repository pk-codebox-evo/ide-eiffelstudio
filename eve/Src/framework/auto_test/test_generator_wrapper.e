note
	description: "[
		This is a wrapper for {TEST_GENERATOR}. Instead of directly generating tests it will first 
		write a speficif interpreter root class and compile the project.
		
		This is currently used in the EVE branch to provide the test generation process with more
		information by directly coding it into the new root class.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_GENERATOR_WRAPPER

inherit
	TEST_GENERATOR
		redefine
			start_creation,
			remove_task,
			clean,
			compute_interpreter_root_class,
			initiate_testing_task
		end

create
	make

feature {NONE} -- Status setting

	start_creation
			-- <Precursor>
		do
			interpreter_root_class_name_cell.put ("ITP_INTERPRETER_ROOT")
			random.start
			prepare
			compile_project (class_names, Features_under_test)
		end

	initiate_testing_task
			-- Launch a {ETEST_GENERATION_TESTING} task in `sub_task'
		do
			compute_interpreter_root_class
		end

	remove_task (a_task: like sub_task; a_cancel: BOOLEAN)
			-- <Precursor>
		local
			l_feature_contract_remover: AUT_FEATURE_CONTRACT_REMOVER
			l_names: LIST[STRING]
			l_test_task: ETEST_GENERATION_TESTING
		do
			if not a_cancel then
				if
					attached {like new_melt_task} sub_task as l_task and then
					l_task.is_successful
				then
					system.remove_explicit_root (interpreter_root_class_name, interpreter_root_feature_name)
					system.make_update (False)

					if is_precondition_reduction_enabled or else is_random_testing_enabled then
						initiate_testing_task
						if attached interpreter_root_class then
							if is_precondition_reduction_enabled then
								create l_test_task.make_precondition_reduction (Current, class_names)
								l_test_task.start
								sub_task := l_test_task
							elseif is_random_testing_enabled then
								create l_test_task.make_random (Current, class_names)
								l_test_task.generation.log_start_time ("Testing started")
								l_test_task.start
								sub_task := l_test_task
							end
						end
					else
						launch_additional_process
					end
				elseif attached {ETEST_GENERATION_TESTING} sub_task as lt_task then
					launch_additional_process
				end
			end
			if not has_next_step then
				Precursor (a_task, a_cancel)
			end
		end

	clean
			-- <Precursor>
		do
			Precursor
			interpreter_root_class_cell.put (Void)
		end

	compute_interpreter_root_class
			-- <Precursor>
		local
			l_uni: UNIVERSE_I
		do
			l_uni := system.universe
			if
				attached l_uni.cluster_of_name ({TEST_SYSTEM_I}.eifgens_cluster_name) as l_cluster and then
				attached l_uni.class_named (interpreter_root_class_name, l_cluster) as l_class and then
				attached {EIFFEL_CLASS_C} l_class.compiled_class as l_eclass
			then
				interpreter_root_class_cell.put (l_eclass)
			else
				interpreter_root_class_cell.put (Void)
			end
		end

feature {NONE} -- Basic operations

	compile_project (a_class_name_list: like class_names; a_features_under_test: like Features_under_test)
			-- Compile `a_project'.
			--
			-- TODO: `class_names' should be retrieved from `session'
		local
			l_dir: PROJECT_DIRECTORY
			l_file: KL_TEXT_OUTPUT_FILE
			l_file_name: FILE_NAME
			l_source_writer: TEST_INTERPRETER_SOURCE_WRITER
			l_related_class_collector: AUT_INTERFACE_RELATED_CLASS_COLLECTOR
			l_system: SYSTEM_I
			l_melt: like new_melt_task
			l_classes: DS_HASH_SET [STRING]
		do
			l_system := system
			check l_system /= Void end

				-- Collect all types that may be necessary during testing, including
				-- the union of `a_class_name_list' and the set of classes in the signature of `a_features_under_test'.
			create l_classes.make_equal (a_class_name_list.count + 1)
			a_class_name_list.do_all (agent l_classes.force)
			create l_related_class_collector
			l_related_class_collector.collect_from_features (a_features_under_test)
			l_classes.append (l_related_class_collector.last_interface_related_classes_from_features)

				-- Create actual root class in EIFGENs cluster
			l_dir := l_system.project_location
			create l_file_name.make_from_string (l_dir.eifgens_cluster_path.out)
			l_file_name.set_file_name (interpreter_root_class_name.as_lower)
			l_file_name.add_extension ("e")
			create l_file.make (l_file_name)
			if not l_file.exists then
				l_system.force_rebuild
			end
			l_file.recursive_open_write
			create l_source_writer.make (Current)
			if l_file.is_open_write then
				l_source_writer.write_class (l_file, l_classes, l_system)
				l_file.flush
				l_file.close
			end

			if not l_system.is_explicit_root (interpreter_root_class_name, interpreter_root_feature_name) then
				l_system.add_explicit_root (Void, interpreter_root_class_name, interpreter_root_feature_name)
			end

			append_output (
				agent (a_formatter: TEXT_FORMATTER)
					do
						a_formatter.process_basic_text ("Compiling project%N")
					end, True)

			l_melt := new_melt_task
			l_melt.set_is_freezing_needed (should_freeze_before_testing)
			l_melt.start (True)
			sub_task := l_melt
		end

	launch_additional_process
			-- Launch additional process according to the configuration.
		do
			if is_load_log_enabled then
				load_log
			elseif is_test_case_deserialization_enabled or current.is_building_behavioral_models then
				process_deserialization
			elseif is_collecting_interface_related_classes then
				collect_interface_related_classes
			end
		end

feature {NONE} -- Factory

	new_melt_task: ETEST_MELT_TASK
			-- Create new task for compiling `system'.
		do
			create Result.make (etest_suite)
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
