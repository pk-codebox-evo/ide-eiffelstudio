note
	description: "Summary description for {EWB_AUTO_FIX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_AUTO_FIX

inherit
	EWB_CMD

	AFX_SHARED_SESSION

	EPA_COMPILATION_UTILITY

	AFX_SHARED_PROJECT_ROOT_INFO

create
	make_with_arguments

feature {NONE} -- Initialization

	make_with_arguments (a_arguments: LINKED_LIST [STRING])
			-- Initialize `auto_test_arguments' with `a_arguments'.
		require
			a_arguments_attached: a_arguments /= Void
		do
			create {LINKED_LIST [STRING]} autofix_arguments.make
			a_arguments.do_all (agent autofix_arguments.extend)
		ensure
			arguments_set: autofix_arguments /= Void and then autofix_arguments.count = a_arguments.count
		end

feature -- Access

	autofix_arguments: LINKED_LIST [STRING];
			-- Arguments to AutoFix command line

feature -- Properties

	name: STRING
		do
			Result := "AutoFix"
		end

	help_message: STRING_GENERAL
		do
			Result := "AutoFix"
		end

	abbreviation: CHARACTER
		do
			Result := 'a'
		end

	execute
			-- Action performed when invoked from the
			-- command line.
		local
			l_parser: AFX_COMMAND_LINE_PARSER
			l_config: AFX_CONFIG
			l_session: AFX_SESSION
			l_initializer: AFX_INITIALIZER
			l_fix_proposer: AFX_IMPLEMENTATION_FIXER

			l_fixing_project_builder1: AFX_PROJECT_FOR_FIXING_IMPLEMENTATION_BUILDER
			l_fixing_project_builder2: AFX_PROJECT_FOR_FIXING_CONTRACTS_BUILDER
			l_contract_fixer: AFX_CONTRACT_FIXER
		do
			create l_parser.make_with_arguments (autofix_arguments, system)
			l_parser.parse
			l_config := l_parser.config

				-- Save configuration into the shared session object.
			create l_session.make (l_config)
			set_session (l_session)

				-- Initialize infrastructure.
			create l_initializer
			l_initializer.prepare (config)

			if is_fixing_contracts then
				if config.should_build_relaxed_test_cases then
					create l_fixing_project_builder2
					l_fixing_project_builder2.execute
				end
				if is_fixing_root_available then
					if not system.is_explicit_root (afx_project_root_class, afx_project_root_feature) then
						system.add_explicit_root ("project", afx_project_root_class, afx_project_root_feature)
					end

					create l_contract_fixer.make
					l_contract_fixer.execute

					system.remove_explicit_root(afx_project_root_class, afx_project_root_feature)
					system.make_update (False)
				else
					Io.put_string ("AutoFixing failed: Missing Project root for fixing.%N")
				end

			elseif is_fixing_implementation then
					-- Re-structure the project to include test cases.
				if config.should_build_test_cases then
					create l_fixing_project_builder1
					l_fixing_project_builder1.execute
				end

				if is_fixing_root_available then
					if not system.is_explicit_root (afx_project_root_class, afx_project_root_feature) then
						system.add_explicit_root ("project", afx_project_root_class, afx_project_root_feature)
					end

					create l_fix_proposer.make
					l_fix_proposer.execute

					system.remove_explicit_root(afx_project_root_class, afx_project_root_feature)
					system.make_update (False)
				else
					Io.put_string ("AutoFixing failed: Missing Project root for fixing.%N")
				end
			else
				perform_non_fixing_tasks()
			end
		end

	is_fixing_implementation: BOOLEAN
			-- Is the run for fixing?
		do
			Result := not session.config.is_fixing_contracts_enabled and then not session.config.is_for_postmortem_analysis
		end

	is_fixing_contracts: BOOLEAN
			--
		do
			Result := session.config.is_fixing_contracts_enabled
		end

	perform_non_fixing_tasks()
			-- Perform tasks other than fixing.
		local
			l_postmortem_analyzer: AFX_POSTMORTEM_ANALYZER
		do
			if session.config.is_for_postmortem_analysis then
				create l_postmortem_analyzer.make(session.config.postmortem_analysis_source)
				l_postmortem_analyzer.analyze()
				-- l_postmortem_analyzer.generate_report()
			end
		end

	is_fixing_root_available: BOOLEAN
			-- Is the project root for fixing available in the EIFGENs/Cluster directory?
		local
			l_eifgens_dir_path: STRING
			l_file: PLAIN_TEXT_FILE
			l_file_path: PATH
		do
			l_file_path := system.project_location.location.extended (afx_project_root_class.as_lower + ".e")
			create l_file.make_with_path (l_file_path)
			Result := l_file.exists
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
