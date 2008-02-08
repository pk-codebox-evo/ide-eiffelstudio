indexing
	description: "[
		Entry point for MSI based installations. 
		It cleans up the registry keys (removing the backslash), setups the
		Borland configuration files when Borland is selected as a C compiler.
		It also precompiles the chosen precompiled library.
		
		It is highly dependent on the MSI script for property names. Make sure to
		keep this file and the installer in sync.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	STUDIO_CUSTOM_ACTIONS

inherit
	MESSAGE_BOX_HELPER

feature -- Setting

	prepare_finalize_setup (a_handle: POINTER): INTEGER is
			-- Finish setup.
		require
			a_handle_not_null: a_handle /= default_pointer
		local
			retried: BOOLEAN
			l_api: MSI_API
			l_progress_record: POINTER
			l_precomp, l_compiler, l_installdir, l_platform: STRING
			l_ca_property: STRING
			l_has_dotnet: STRING
		do
			if not retried then
				create l_api

					-- Store data needed by `finalize_setup'. This is needed because `finalize_setup'
					-- is a deferred custom action and will not be able to access to the following
					-- properties.
				l_precomp := l_api.get_property (a_handle, "PRECOMPILE")
				l_compiler := l_api.get_property (a_handle, "SELECTEDCCOMPILER")
				l_installdir := l_api.get_property (a_handle, "INSTALLDIR")
				l_platform := l_api.get_property (a_handle, "ISEPLATFORM")
				l_has_dotnet := l_api.get_property (a_handle, "FXINSTALLROOT")
				if not l_api.get_boolean_property (a_handle, "CANCCOMPILE") then
						-- Forces skipping of precompilation
					l_precomp := "none"
				end
				l_ca_property := l_precomp.twin
				l_ca_property.append_string (delimiter)
				l_ca_property.append_string (l_compiler)
				l_ca_property.append_string (delimiter)
				l_ca_property.append_string (l_installdir)
				l_ca_property.append_string (delimiter)
				l_ca_property.append_string (l_platform)
				l_ca_property.append_string (delimiter)
				l_ca_property.append_string (l_has_dotnet)
				l_ca_property.append_string (delimiter)
				l_api.set_property (a_handle, "FinalizeSetup", l_ca_property)


					-- Initialize progress bar
				l_progress_record := l_api.new_record (3)
				l_api.record_set_integer (l_progress_record, 1, 3)
				l_api.record_set_integer (l_progress_record, 2, precompile_number (a_handle) * nb_ticks)
				l_api.record_set_integer (l_progress_record, 3, 0)

				l_api.process_message (a_handle, {MSI_CONSTANTS}.install_message_progress, l_progress_record)

				l_api.close_handle (l_progress_record)
			end
			Result := {MSI_API}.error_success
		rescue
			retried := True
			message_box ("Dll Failure occurred%N")
			retry
		end

	finalize_setup (a_handle: POINTER): INTEGER is
			-- Finish setup.
		require
			a_handle_not_null: a_handle /= default_pointer
		local
			retried: BOOLEAN
			l_api: MSI_API
			l_configurator: STUDIO_CONFIGURATOR
			l_precomp, l_compiler, l_installdir, l_platform: STRING
			l_action_record, l_progress_record: POINTER
			l_integer_cell: CELL [INTEGER]
			l_data: ARRAYED_LIST [STRING]
			l_has_dotnet: BOOLEAN
		do
			if not retried then
				create l_api
					-- Get Data
				l_data := split_data (l_api.get_property (a_handle, "CustomActionData"), delimiter)
				check
					l_data_count_valid: l_data.count = 5
				end
				l_precomp := l_data.i_th (1)
				l_compiler := l_data.i_th (2)
				l_installdir := l_data.i_th (3)
				l_platform := l_data.i_th (4)
				l_has_dotnet := not l_data.i_th (5).is_empty


					-- Prepare Progress Bar for Precompiles
				l_action_record := l_api.new_record (3)
				l_api.record_set_string (l_action_record, 1, "FinalizeSetup")
				l_api.record_set_string (l_action_record, 2, "Precompiling...")
				l_api.record_set_string (l_action_record, 3, "Incrementing tick [1] of [2]")
				l_api.process_message (a_handle, {MSI_CONSTANTS}.install_message_action_start, l_action_record)

				l_api.record_set_integer (l_action_record, 1, 1)
				l_api.record_set_integer (l_action_record, 2, 1)
				l_api.record_set_integer (l_action_record, 3, 0)
				l_api.process_message (a_handle, {MSI_CONSTANTS}.install_message_progress, l_action_record)

				l_progress_record := l_api.new_record (3)
				l_api.record_set_integer (l_progress_record, 1, 2)
				l_api.record_set_integer (l_progress_record, 2, nb_ticks)
				l_api.record_set_integer (l_progress_record, 3, 0)

				l_api.record_set_integer (l_action_record, 2, precompile_number (a_handle) * nb_ticks)

				create l_integer_cell.put (0)
				create l_configurator.make (l_precomp, l_compiler, l_installdir, l_platform, l_has_dotnet)
				l_configurator.execute (agent update_progress_bar (a_handle, l_action_record, l_progress_record, ?, l_integer_cell))

					-- Complete setup message.		
				update_progress_bar (a_handle, l_action_record, l_progress_record, "Installation done.", l_integer_cell)

				l_api.close_handle (l_action_record)
				l_api.close_handle (l_progress_record)
			end
			Result := {MSI_API}.error_success
		rescue
			retried := True
			message_box ("Dll Failure occurred%N")
			retry
		end

feature {NONE} -- Implementation

	nb_ticks: INTEGER is 15000000
			-- Number of ticks for progress

	delimiter: STRING is "X|@@@@|X"
			-- Delimiter for combining strings

	precompile_number (a_handle: POINTER): INTEGER is
			-- Number of precompiles requested in installation.
		require
			a_handle_not_null: a_handle /= default_pointer
		local
			l_precomp, l_dotnet: STRING
			l_api: MSI_API
		do
			create l_api
			l_precomp := l_api.get_property (a_handle, "PRECOMPILE")
			l_dotnet := l_api.get_property (a_handle, "FXINSTALLROOT")
			if l_precomp.is_equal ("base") then
				Result := 1
			elseif l_precomp.is_equal ("wel") then
				Result := 2
			elseif l_precomp.is_equal ("vision2") then
				Result := 3
			end
			if not l_dotnet.is_empty then
					-- Twice the amount of precompiled libraries needs to be done.
				Result := Result * 2
			end
				-- We do +1 so that when displaying that we are processing the
				-- last precompile we do not reach the end of the progress bar.
			Result := Result + 1
		ensure
			precompile_number_non_negative: Result >= 0
		end

	update_progress_bar (
			a_handle, an_action_record, a_progress_record: POINTER;
			s: STRING; a_cell: CELL [INTEGER])
		is
			-- Update progress bar
		require
			s_not_void: s /= Void
			a_cell_not_void: a_cell /= Void
			a_cell_item_non_negative: a_cell.item >= 0
		local
			l_api: MSI_API
		do
			create l_api

				-- Update text for progress.
			l_api.record_set_string (an_action_record, 2, s)
			l_api.process_message (a_handle, {MSI_CONSTANTS}.install_message_action_start, an_action_record)

				-- Update progress value
			l_api.record_set_integer (an_action_record, 1, a_cell.item * nb_ticks)

			l_api.process_message (a_handle, {MSI_CONSTANTS}.install_message_action_data, an_action_record)
			l_api.process_message (a_handle, {MSI_CONSTANTS}.install_message_progress, a_progress_record)

			a_cell.put (a_cell.item + 1)
		end

	split_data (a_str, a_delimiter: STRING): ARRAYED_LIST [STRING] is
			-- Split `a_str' using `a_delimiter'.
		require
			a_str_not_void: a_str /= Void
			a_delimiter_not_void: a_delimiter /= Void
			a_delimiter_not_empty: not a_delimiter.is_empty
		local
			i, j: INTEGER
			done: BOOLEAN
		do
			create Result.make (1)
			from
				i := 1
			until
				done
			loop
				j := a_str.substring_index (a_delimiter, i)
				if j > 0 then
					Result.extend (a_str.substring (i, j - 1))
					i := j + a_delimiter.count
					done := i >= a_str.count
				else
					Result.extend (a_str.substring (i, a_str.count))
					done := True
				end
			end
		ensure
			split_data_not_void: Result /= Void
		end

end
