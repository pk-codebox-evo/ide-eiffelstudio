indexing
	description: "Command that reads the description file generated by %
				% EiffelBench and fill the corresponding structures."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	IMPORT_APPLICATION_CLASS_CMD

inherit
	
	COMMAND

	EB_ENVIRONMENT

	SHARED_CLASS_IMPORTER

feature

	execute (arg: ANY) is
			-- Read the description file and fill the internal structure.
		local
			description_file: PLAIN_TEXT_FILE
			description_name: DIRECTORY_NAME
			line: STRING
		do
			!! description_name.make_from_string (Common_directory)
			description_name.extend (Description_file_name)
			!! description_file.make (description_name)
			if description_file.exists then
				description_file.open_read
				from
					description_file.start
					current_line := 0
				until
					description_file.end_of_file
				loop
					current_line := 1 + current_line
					description_file.read_line
					line := clone (description_file.last_string)
					process_line (line)
				end
				description_file.close
			end
		end

feature {NONE} -- Implementation

	process_line (a_line: STRING) is
			-- Add a command or a query, or create a new application class
			-- object according to the value of the line.
		local
			i: INTEGER
			key_value, value: STRING
		do
			if a_line.has (':') then
				a_line.prune_all (' ')
				i := a_line.index_of (':', 1)
				key_value := a_line.substring (1, i - 1)
				value := a_line.substring (i + 1, a_line.count)
				if key_value.substring_index (classname_keyword, 1) > 0 then
					process_class_name (value)
				elseif key_value.substring_index (query_keyword, 1) > 0 then
					process_query (value)
				elseif key_value.substring_index (command_keyword, 1) > 0 then
					process_command (value)
				elseif key_value.substring_index (routine_keyword, 1) > 0 then
					process_routine (value)
				end			
			end
		end

	process_class_name (class_name: STRING) is
			-- Create a new application class object and add into the list.
		local
			an_app_class: APPLICATION_CLASS
			cmd_list: LINKED_LIST [APPLICATION_COMMAND]
			app_routine: APPLICATION_ROUTINE
		do
			if class_name.has (':') or class_name.has ('(') or class_name.has (')') then
				display_error_message
			else
				if current_application_class /= Void and not class_list.empty then
					cmd_list := current_application_class.command_list
					from
						cmd_list.start
					until
						cmd_list.after
					loop
						!! app_routine.make_from_command (cmd_list.item)
						current_application_class.add_routine (app_routine)
						cmd_list.forth
					end
				end
				!! an_app_class.make (class_name)
				class_list.extend (an_app_class)
				class_list.finish
			end


		end

	process_command (signature: STRING) is
			-- Add a command to the currently edited APPLICATION_CLASS object.
		local
			an_app_command: APPLICATION_COMMAND
			lower, upper: INTEGER
			cmd_name, arg_name, arg_type: STRING
		do
			lower := 1
			upper := signature.index_of ('(', 1)
			if (upper <= 1) or (upper > (signature.count - 5)) then
				display_error_message
			else
				cmd_name := signature.substring (lower, upper - 1)
				lower := upper + 1
				upper := signature.index_of (':', lower)
				if (upper < lower) or (upper > (signature.count - 2)) then
					display_error_message
				else
					arg_name := signature.substring (lower, upper - 1)
					lower := upper + 1
					upper := signature.index_of (')', lower)
					if (upper < lower) or (upper /= signature.count) then
						display_error_message
					else
						arg_type := signature.substring (lower, upper - 1)
						!! an_app_command.make (cmd_name, arg_name, arg_type)
						current_application_class.add_command (an_app_command)
					end
				end
			end
		end

	process_query (declaration: STRING) is
			-- Add a query to the currently edited APPLICATION_CLASS object.
		local
			an_app_query: APPLICATION_QUERY
			i: INTEGER
			q_name, q_type: STRING
		do
			i := declaration.index_of (':', 1)
			if (i <= 1) or (i > (declaration.count - 2)) then
				display_error_message
			else
				q_name := declaration.substring (1, i - 1)
				q_type := declaration.substring (i + 1, declaration.count)
				if q_type.has ('(') or q_type.has (')') or q_type.has (':') or q_type.has (';') then
					display_error_message
				else
					!! an_app_query.make (q_name, q_type)
					current_application_class.add_query (an_app_query)
				end
			end
		end

	process_routine (signature: STRING) is
			-- Add a routine to currently edited APPLICATION_CLASS object.
		local
			app_routine: APPLICATION_ROUTINE
			lower, upper: INTEGER
			cmd_name, arg_type, arg_name: STRING
			arg_list: LINKED_LIST [APPLICATION_ARGUMENT]
			arg: APPLICATION_ARGUMENT
			finished, error: BOOLEAN
		do
			lower := 1
			upper := signature.index_of ('(', 1)
			if (upper <= 1) then
				upper := signature.index_of (')', 1)
				if upper >= 1 then
					display_error_message
				else
					cmd_name := signature.substring (lower, signature.count)
					cmd_name.prune_all (' ')
					!! arg_list.make
				end
			elseif (upper > (signature.count - 5)) then
				display_error_message
			else
				cmd_name := signature.substring (lower, upper - 1)
				!! arg_list.make
				from
				until
					finished or error
				loop
					lower := upper + 1
					upper := signature.index_of (':', lower)
					if (upper <= 1) or (upper > (signature.count - 2)) then
						display_error_message
						error := True
					else
						arg_name := signature.substring (lower, upper - 1)
						lower := upper + 1
						upper := signature.index_of (';', lower)
						if upper <= 1 then
							upper := signature.index_of (')', lower)
							if lower < upper then
								finished := True
							else
								display_error_message
								error := True
							end
						end
						if upper <= 1 then
							display_error_message
							error := True
						else
							arg_type := signature.substring (lower, upper - 1)
							!! arg.make (arg_name, arg_type)
							arg_list.extend (arg)
						end
					end
				end
			end
			if not error then
				!! app_routine.make (cmd_name, arg_list)
				current_application_class.add_routine (app_routine)
			end
		end

	display_error_message is
			-- Display Error message.
		do
			io.put_string ("Error in generated code at line")
			io.put_integer (current_line)
			io.new_line
		end

feature {NONE} -- Attribute

	current_application_class: APPLICATION_CLASS is
			-- Currently edited application class object 
		do
			Result := class_list.item
		end

	current_line: INTEGER
			-- Current line 

feature {NONE} -- Constants

	query_keyword: STRING is "<query>"
			-- Keyword "<query>"

	command_keyword: STRING is "<command>"
			-- Keyword "<command>"

	classname_keyword: STRING is "<class_name>"
			-- Keyword "<class_name>"

	routine_keyword: STRING is "<routine>"
			-- Keyword "<routine>"

end -- class IMPORT_APPLICATION_CLASS_CMD	
