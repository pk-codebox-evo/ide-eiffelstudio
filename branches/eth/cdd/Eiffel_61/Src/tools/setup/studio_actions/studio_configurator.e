indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	STUDIO_CONFIGURATOR

create
	make

feature {NONE} -- Initialization

	make (a_precomp, a_c_compiler, a_installdir, a_platform: STRING; a_has_dotnet: BOOLEAN) is
			-- Creation procedure.
		require
			a_precomp_not_void: a_precomp /= Void
			a_c_compiler_not_void: a_c_compiler /= Void
			a_installdir_not_void: a_installdir /= Void
			a_platform_not_void: a_platform /= Void
		do
			create exec_env
			precompilation := a_precomp
			c_compiler := a_c_compiler
			install_dir := a_installdir
			ise_platform := a_platform
			has_dotnet := a_has_dotnet
		ensure
			precompilation_set: precompilation = a_precomp
			c_compiler_set: c_compiler = a_c_compiler
			install_dir_set: install_dir = a_installdir
			ise_platform_set: ise_platform = a_platform
			has_dotnet_set: has_dotnet = a_has_dotnet
		end

feature -- Setup

	execute (an_action: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- performs operations, after argument parsing.
		require
			an_action_not_void: an_action /= Void
		do
			update_registry
			initialize_borland
			precompile_libraries (an_action)
		end

feature {NONE} -- Actions

	initialize_borland is
			-- Create the bcc32.cfg and ilink32.cfg files needed by the Borland compiler, if needed.
		local
			f: PLAIN_TEXT_FILE
			fn1, fn2: FILE_NAME
			txt: STRING
			retried: BOOLEAN
		do
			if not retried and then c_compiler.is_equal ("bcb") then
				debug
					io.put_string ("Configuring the Borland compiler%N")
				end
				create fn1.make_from_string (install_dir)
				fn1.extend ("BCC55")
				fn1.extend ("Bin")
				if (create {DIRECTORY}.make (fn1)).exists then
						-- bcc32.cfg file.
					fn2 := fn1.twin
					fn2.set_file_name ("bcc32.cfg")
					txt := "[
						-I"$(ISE_EIFFEL)\BCC55\include" -L"$(ISE_EIFFEL)\BCC55\lib"
						-L"$(ISE_EIFFEL)\BCC55\lib\PSDK"
						]"
					create f.make_open_write (fn2)
					f.put_string (txt)
					f.close

						-- ilink32.cfg file.
					fn2 := fn1.twin
					fn2.set_file_name ("ilink32.cfg")
					txt := "[
						-L"$(ISE_EIFFEL)\BCC55\lib" -L"$(ISE_EIFFEL)\BCC55\lib\PSDK"
						]"
					create f.make_open_write (fn2)
					f.put_string (txt)
					f.close
				end
			end
		rescue
			retried := True
			retry
		end

	precompile_libraries (an_action: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- Invoke the batch file that precompiles the selected libraries.
		require
			an_action_not_void: an_action /= Void
		do
			if not precompilation.is_equal ("none") then
				if precompilation.is_equal ("base") then
					precompile (an_action, "base")
				elseif precompilation.is_equal ("wel") then
					precompile (an_action, "base")
					precompile (an_action, "wel")
				elseif precompilation.is_equal ("vision2") then
					precompile (an_action, "base")
					precompile (an_action, "wel")
					precompile (an_action, "vision2")
				end
			end
		end

	update_registry is
			-- Update ISE_EIFFEL in registry so that last `\' character is
			-- removed. And change long path names into short ones.
		local
			reg: WEL_REGISTRY
			p: POINTER
			key: WEL_REGISTRY_KEY_VALUE
			new_key_val: STRING
		do
			new_key_val := updated_install_dir
			create key.make ({WEL_REGISTRY_KEY_VALUE_TYPE}.Reg_sz, new_key_val)

			create reg
			p := reg.open_key_with_access ("hkey_local_machine\Software\ISE\Eiffel61cdd",
				{WEL_REGISTRY_ACCESS_MODE}.key_all_access)
			if p /= default_pointer then
				reg.set_key_value (p, "ISE_EIFFEL", key)
				reg.close_key (p)
			end
		end

feature {NONE} -- Implementation: Access

	precompilation: STRING
			-- Name of precompilation that needs to be done.

	install_dir: STRING
			-- Installation directory.

	c_compiler: STRING
			-- C compiler used by Eiffel (msc or bcb).

	ise_platform: STRING
			-- Value for ISE_PLATFORM in package.

	exec_env: EXECUTION_ENVIRONMENT
			-- Environment used to perform calls and get/set environment variables.

	internal_updated_install_dir: STRING
			-- Short path name corresponding to install_dir.

	has_dotnet: BOOLEAN
			-- Is .NET installed on this machine?

feature {NONE} -- Implementation: helpers

	precompile (an_action: PROCEDURE [ANY, TUPLE [STRING]]; a_library: STRING) is
			-- Precompile `a_library'.
		require
			an_action_not_void: an_action /= Void
			a_library_not_void: a_library /= Void
			a_library_not_empty: not a_library.is_empty
		local
			l_dir, l_updated_install_dir: STRING
			l_library: STRING
			l_launcher: WEL_PROCESS_LAUNCHER
		do
			l_dir := exec_env.current_working_directory
			l_updated_install_dir := updated_install_dir.twin
			l_library := a_library.twin
			l_library.put (l_library.item (1).upper, 1)

				-- Reset values of ISE_EIFFEL environment variable in
				-- case it is set by the user to ensure that precompiles
				-- are done using the right settings.
			exec_env.put (l_updated_install_dir, "ISE_EIFFEL")
			exec_env.put (l_updated_install_dir, "ISE_LIBRARY")
			exec_env.put (ise_platform, "ISE_PLATFORM")
			exec_env.put (c_compiler, "ISE_C_COMPILER")
			if c_compiler.is_equal ("msc") then
					-- This is a hack to disable the `-Zi' option which would
					-- fail with VC++ 2005 when run under the SYSTEM account
					-- because of a Microsoft bug. Microsoft has a fix but it
					-- will only be included in the SP1 of 2005, and this is not yet
					-- available.
				exec_env.put ("-Z7", "ISE_CFLAGS")
			else
				exec_env.put ("", "ISE_CFLAGS")
			end
			exec_env.put ("", "ISE_SHAREDLIBS")

				-- Display message
			an_action.call (["Precompiling " + l_library + "..."]);

				-- Perform precompilation
			exec_env.change_working_directory (l_updated_install_dir + "\precomp\spec\" + ise_platform)

			create l_launcher
			l_launcher.run_hidden
			l_launcher.launch ("%"" + l_updated_install_dir + "\studio\spec\" + ise_platform +
				"\bin\ec.exe%" -precompile -config " + a_library + ".ecf -batch -c_compile -clean", Void, Void)

			if has_dotnet then
					-- Perform .NET precompilation
				exec_env.change_working_directory (l_updated_install_dir + "\precomp\spec\"  + ise_platform + "-dotnet")

				create l_launcher
				l_launcher.run_hidden
				l_launcher.launch ("%"" + l_updated_install_dir + "\studio\spec\" + ise_platform +
					"\bin\ec.exe%" -precompile -config " + a_library + ".ecf -batch -c_compile -clean", Void, Void)
			end

			exec_env.change_working_directory (l_dir)
		end

	updated_install_dir: STRING is
			-- Short path name corresponding to install_dir.
		require
			install_dir_initialized: install_dir /= Void
		do
			if internal_updated_install_dir = Void then
				internal_updated_install_dir := install_dir.twin
				if internal_updated_install_dir.item (internal_updated_install_dir.count) = '\' then
					internal_updated_install_dir.remove_tail (1)
				end
			end
			Result := internal_updated_install_dir
		ensure
			updated_install_dir_not_void: Result /= Void
			updated_install_dir_not_terminated_by_backslash:
				Result.item (Result.count) /= '\'
		end

invariant
	precompilation_not_void: precompilation /= Void
	install_dir_not_void: install_dir /= Void
	c_compiler_not_void: c_compiler /= Void
	ise_platform_not_void: ise_platform /= Void

end -- class STUDIO_CONFIGURATOR
