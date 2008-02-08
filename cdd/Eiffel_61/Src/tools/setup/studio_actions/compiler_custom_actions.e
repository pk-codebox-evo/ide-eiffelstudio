indexing
	description: "[
		Entry point for MSI based installations. 
		It's used to evalute external C/C++ compiler configurations
		
		It is highly dependent on the MSI script for property names. Make sure to
		keep this file and the installer in sync.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPILER_CUSTOM_ACTIONS

inherit
	SHARED_MSI_API
		export
			{NONE} all
			{ANY} is_valid_handle
		end

	MESSAGE_BOX_HELPER

feature -- Basic Operations

	evaluate_c_compiler (a_handle: POINTER): INTEGER is
			-- Checks end user's system for a C compiler and sets HAS_MSC_COMPILER and SELECTED_C_COMPILER
			-- accordingly.
		require
			is_valid_handle: is_valid_handle (a_handle)
		local
			l_manager: C_CONFIG_MANAGER
			l_has_compiler: BOOLEAN
			l_spec: STRING
			retried: BOOLEAN
		do
			if not retried then
				Result := {MSI_API}.error_success

				create l_manager.make (not {C_CONFIG_MANAGER}.is_windows_x64)
				l_has_compiler := l_manager.has_applicable_config
				if l_has_compiler then
					l_spec := msc_compiler
				else
					l_spec := bcb_compiler
				end

					-- Set state to indicate a MS compiler has been found.
				msi_api.set_boolean_property (a_handle, has_msc_compiler_property, l_has_compiler)
					-- Set selected c compile
				msi_api.set_property (a_handle, selected_c_compiler_property, l_spec)
			else
				Result := {MSI_API}.error_install_failure
				error_box ("Dll failure in routine `browse_for_projects_folder'")
			end
		rescue
			retried := True
			retry
		end

	show_c_compiler_how_to  (a_handle: POINTER): INTEGER is
			-- Displays "How To" instructions to users on installing a Microsoft C/C++ compiler
		require
			is_valid_handle: is_valid_handle (a_handle)
		local
			l_access: ENVIRONMENT_ACCESS
			l_url, l_cmd: STRING
			l_com_spec: STRING
			l_launcher: WEL_PROCESS_LAUNCHER
			retried: BOOLEAN
		do
			if not retried then
				Result := {MSI_API}.error_success

				l_com_spec := l_access.get ("COMSPEC")
				if l_com_spec = Void or else l_com_spec.is_empty then
					l_com_spec := "CMD.exe"
				end

				l_url := msi_api.get_property (a_handle, install_url_property)
				if l_url = Void or else l_url.is_empty then
						-- Fail safe
					l_url := default_c_compiler_how_to_url
				end
				create l_cmd.make (l_com_spec.count + 11 + l_url.count)
				l_cmd.append (l_com_spec)
				l_cmd.append (" /c start ")
				l_cmd.append (l_url)

				create l_launcher
				l_launcher.run_hidden
				l_launcher.spawn (l_cmd, Void)
			else
				Result := {MSI_API}.error_install_failure
				error_box ("Dll failure in routine `show_compiler_how_to_instructions'")
			end
		rescue
			retried := True
			retry
		end

	can_perform_c_compilation  (a_handle: POINTER): INTEGER is
			-- Determines if a C/C++ compilation can successfully be performed given the state of the environment defined in the
			-- current process.
		require
			is_valid_handle: is_valid_handle (a_handle)
		local
			l_access: ENVIRONMENT_ACCESS
			l_manager: C_CONFIG_MANAGER
			l_config: C_CONFIG
			l_compiler: STRING
			l_can_compile: BOOLEAN
			l_vars: STRING
			l_path: STRING
			l_result: like check_has_compiler
			retried: BOOLEAN
		do
			if not retried then
				Result := {MSI_API}.error_success

				l_compiler := msi_api.get_property (a_handle, selected_c_compiler_property)
				l_can_compile := l_compiler.is_case_insensitive_equal (bcb_compiler)
				if not l_can_compile then
					l_can_compile := l_compiler.is_case_insensitive_equal (msc_compiler)
					if l_can_compile then
						create l_manager.make (not {C_CONFIG_MANAGER}.is_windows_x64)
						l_can_compile := l_manager.has_applicable_config
						if l_can_compile then
							create l_access
							create l_vars.make (512)

								-- Retrieve full PATH list
							l_config := l_manager.best_configuration
							l_vars.append (l_config.path_var)
							l_path := l_access.get ("PATH")
							if l_path /= Void and then not l_path.is_empty then
								l_vars.append_character (';')
								l_vars.append (l_path)
							end

								-- Attempt to find a MSC compiler executable
							l_result := check_has_compiler (c_compiler_executable, l_vars)
							l_can_compile := l_result.found
							if not l_can_compile then
									-- Compilation cannot happen so set the error message
								msi_api.set_property (a_handle, can_c_compile_error_property, l_result.error)
							end
						else
							msi_api.set_property (a_handle, can_c_compile_error_property, "Unable to locate a compatible Microsoft C/C++ compiler.")
						end
					else
						message_box ("The selected C compiler has not been set correctly.%NC/C++ compilation will not succeed if attempted.")
					end
				end

					-- Set property
				msi_api.set_boolean_property (a_handle, can_c_compile_property, l_can_compile)
			else
				Result := {MSI_API}.error_install_failure
				error_box ("Dll failure in routine `can_perform_c_compilation'")
			end
		rescue
			retried := True
			retry
		end

	check_environment_variables  (a_handle: POINTER): INTEGER is
			-- Checks the system environment variables. If reserved variables are declared then display a warning to the user
		require
			is_valid_handle: is_valid_handle (a_handle)
		local
			l_env: ENVIRONMENT_ACCESS
			l_value: STRING
			l_defined: STRING
			retried: BOOLEAN
		do
			if not retried then
				Result := {MSI_API}.error_success

				create l_env
				create l_defined.make_empty

				l_value := l_env.get ("ISE_EIFFEL")
				if l_value /= Void then
					l_defined.append ("%TISE_EIFFEL: " + l_value + "%N")
				end
				l_value := l_env.get ("ISE_LIBRARY")
				if l_value /= Void then
					l_defined.append ("%TISE_LIBRARY: " + l_value + "%N")
				end
				l_value := l_env.get ("ISE_PRECOMP")
				if l_value /= Void then
					l_defined.append ("%TISE_PRECOMP: " + l_value + "%N")
				end
				l_value := l_env.get ("ISE_DOTNET_FRAMEWORK")
				if l_value /= Void then
					l_defined.append ("%TISE_DOTNET_FRAMEWORK: " + l_value + "%N")
				end
				l_value := l_env.get ("ISE_C_COMPILER")
				if l_value /= Void then
					l_defined.append ("%TISE_C_COMPILER: " + l_value + "%N")
				end
				if not l_defined.is_empty then
					message_box ("The " + msi_api.product_name (a_handle) + " installer has detected that the following environment variables have been defined: %N%N" + l_defined +
						"%NDefining these variable(s) may cause compilations to fail or the environment to behave in an unexpected manner." +
						"%NThese variables are automatically set up by the environment and do not require manual configuration. Please" +
						"%Nremove them before installing if they are not necessary.")
				end
			else
				Result := {MSI_API}.error_install_failure
				error_box ("Dll failure in routine `check_environment_variables'")
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	check_has_compiler (a_file_name: STRING; a_paths: STRING): TUPLE [found: BOOLEAN; error: STRING] is
			-- Determines if a pe file `a_file_name' exists in a path in semicolon delimited list `a_path'.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_paths_attached: a_paths /= Void
		local
			l_paths: LIST [STRING]
			l_path: STRING
			l_sep: CHARACTER
			l_has_file: BOOLEAN
			l_reason: STRING
		do
			l_sep := operating_environment.directory_separator
			l_paths := a_paths.split (';')
			from l_paths.start until l_paths.after or l_has_file loop
				l_path := l_paths.item
				if not l_path.is_empty then
					if l_path.item (l_path.count) /= l_sep  then
						l_path.append_character (l_sep)
					end
					l_path.append (a_file_name)
					l_has_file := (create {RAW_FILE}.make (l_path)).exists
					if l_has_file then
						inspect assembly_type (l_path)
						when x86_assembly_type then
							l_has_file := not {C_CONFIG_MANAGER}.is_windows_x64
							if not l_has_file then
								l_reason := "The located Microsoft C/C++ compiler is a 32 bit compiler. Please install the 64 bit (x64) C/C++ tools."
							end
						when x64_assembly_type then
							l_has_file := {C_CONFIG_MANAGER}.is_windows_x64
							if not l_has_file then
								l_reason := "The located Microsoft C/C++ compiler is a 64 bit compiler. Please install the 32 bit (x86) C/C++ tools."
							end
						else
								-- Not a valid PE file
							l_has_file := False
							l_reason := "The located Microsoft C/C++ compiler is not a valid executable file."
						end
					end
				end
				l_paths.forth
			end

			if not l_has_file and l_reason = Void then
				l_reason := "Unable to automatically locate a Microsoft C/C++ compiler. "
				if {C_CONFIG_MANAGER}.is_windows_x64 then
					l_reason.append ("Please ensure you have the 64 bit (x64) C/C++ tools installed.")
				else
					l_reason.append ("Please ensure you have the 32 bit (x86) C/C++ tools installed.")
				end
			elseif l_has_file then
				l_reason := Void
			end

			check
				l_reason_attached: not l_has_file implies l_reason /= Void
				not_l_reason_is_empty: not l_has_file implies not l_reason.is_empty
			end

			Result := [l_has_file, l_reason]
		ensure
			result_has_error: not Result.found implies (Result.error /= Void and then not Result.error.is_empty)
		end

	assembly_type (a_file_name: STRING): INTEGER is
			-- Determines the Windows assembly type of `a_file_name'
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: (create {RAW_FILE}.make (a_file_name)).exists
		local
			l_file: RAW_FILE
			l_offset: NATURAL_32
			retried: BOOLEAN
		do
			Result := unknown_assembly_type

			if not retried then
				create l_file.make_open_read (a_file_name)
				l_file.move (0x3c)

				l_file.read_natural_32 -- PE header (PEH) offset
				l_offset := l_file.last_natural_32 - 0x40
				if l_offset > 0 then
						-- Move pointer to optional header location
					l_file.move (l_offset.to_integer_32 + 0x18)

					l_file.read_natural_16 -- Read magic number (PE32 or PE32+)

					inspect l_file.last_natural_16
					when x86_assembly_type then
						Result := x86_assembly_type
					when x64_assembly_type then
						Result := x64_assembly_type
					else
						-- Do nothing, use default set Result
					end
				end
			end

			if l_file /= Void then
				l_file.close
			end
		ensure
			result_is_valid_assembly_type: is_valid_assembly_type (Result)
		rescue
			retried := True
			retry
		end

feature {NONE} -- Query

	is_valid_assembly_type (a_type: INTEGER): BOOLEAN is
			-- Detemines if `a_type' is a valid assembly type code
		do
			Result := a_type = unknown_assembly_type or
				a_type = x86_assembly_type or
				a_type = x64_assembly_type
		end

feature {NONE} -- Constants

	unknown_assembly_type: INTEGER = 0
	x86_assembly_type: INTEGER = 0x10B
	x64_assembly_type: INTEGER = 0x20B
			-- Windows assembly type codes returned from `assembly_type'

	msc_compiler: STRING = "msc"
	bcb_compiler: STRING = "bcb"
			-- Property values

	selected_c_compiler_property: STRING = "SELECTEDCCOMPILER"
	can_c_compile_property: STRING = "CANCCOMPILE"
	can_c_compile_error_property: STRING = "CANCCOMPILEERROR"
	install_url_property: STRING = "INSTALLCURL"
	has_msc_compiler_property: STRING = "HASMSCCOMPILER"
			-- Property names

	c_compiler_executable: STRING = "cl.exe"
	default_c_compiler_how_to_url: STRING = "http://eiffelsoftware.origo.ethz.ch/index.php/Installing_Microsoft_C_compiler"
			-- Default URL to launch for instructions on configuring a C/C++ compiler

end
