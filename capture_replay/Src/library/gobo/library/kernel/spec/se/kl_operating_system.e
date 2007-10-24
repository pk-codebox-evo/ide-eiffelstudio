indexing

	description:

		"Underlying operating systems"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001-2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class KL_OPERATING_SYSTEM

inherit

	ANY -- Needed for SE 2.1b1.

feature -- Status report

	is_windows: BOOLEAN is
			-- Is underlying operating system Windows-like?
		local
			cwd: STRING
			gobo_os, os: STRING
		once
			gobo_os := variable_value ("GOBO_OS")
			if gobo_os /= Void and then gobo_os.count > 0 then
				if gobo_os.is_equal ("windows") then
					Result := True
				end
			else
				os := variable_value ("OS")
				if os /= Void and then os.is_equal ("Windows_NT") then
					Result := True
				else
					cwd := current_working_directory
					if cwd.count >= 3 then
						if (cwd.item (2) = ':' and cwd.item (3) = '\') then
							Result := True
						elseif (cwd.item (1) = '\' and cwd.item (2) = '\') then
							Result := True
						end
					end
				end
			end
		end

	is_unix: BOOLEAN is
			-- Is underlying operating system Unix-like?
		local
			cwd: STRING
			gobo_os: STRING
		once
			gobo_os := variable_value ("GOBO_OS")
			if gobo_os /= Void and then gobo_os.count > 0 then
				if gobo_os.is_equal ("unix") then
					Result := True
				end
			else
				cwd := current_working_directory
				if cwd.count > 0 then
					Result := cwd.item (1) = '/'
				end
			end
		end

	is_dotnet: BOOLEAN is
			-- Has this application been compiled with Eiffel for .NET?







		once
			Result := False

		end

feature {NONE} -- Implementation

	current_working_directory: STRING is
			-- Name of current working directory;
			-- Return absolute pathname with the naming 
			-- convention of the underlying file system
			-- (Return a new object at each call.)
		do

			basic_directory.connect_to_current_working_directory
			Result := basic_directory.last_entry.twin
			basic_directory.disconnect







		ensure
			current_working_directory_not_void: Result /= Void
		end

	variable_value (a_variable: STRING): STRING is
			-- Value of environment variable `a_variable',
			-- Void if `a_variable' has not been set
		require
			a_variable_not_void: a_variable /= Void











		do
			Result := environment_impl.get_environment_variable (a_variable)

		end


	basic_directory: BASIC_DIRECTORY
			-- Implementation

	environment_impl: SYSTEM
			-- Execution environment implementation






















end
