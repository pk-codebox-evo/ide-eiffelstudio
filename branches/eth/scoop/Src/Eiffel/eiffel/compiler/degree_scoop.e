indexing
	description: "Summary description for {DEGREE_SCOOP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEGREE_SCOOP

inherit
	DEGREE
		redefine
			make
		end
	SHARED_SERVER

create

	make

feature

	make
			-- Create new degree SCOOP
		local
			tmp_system: SYSTEM_I
			tmp_worbench: SCOOP_WORKBENCH
			l_shared_scoop_workbench: SHARED_SCOOP_WORKBENCH
		do
			Precursor

			-- create a scoop workbench
			create l_scoop_workbench

			-- create shared scoop workbench
			create l_shared_scoop_workbench
			l_shared_scoop_workbench.setup_shared_scoop_workbench (l_scoop_workbench, system)

			-- call once routines
			tmp_system := l_shared_scoop_workbench.system
			tmp_worbench := l_shared_scoop_workbench.shared_scoop_workbench
		end

feature -- Degree handling

	Degree_number: INTEGER is 7
			-- Degree number

	is_degree_scoop_needed: BOOLEAN is
			-- checks project if there is a separate keyword
		local
			i: INTEGER
			is_separate: BOOLEAN
			a_class: CLASS_C
			l_classes: ARRAY [CLASS_C]
			l_system: like system
		do
			l_system := system
			l_classes := l_system.classes

			is_separate := False

			from i := 1 until i > l_classes.count loop
				a_class := l_classes.item (i)
				if a_class /= Void then -- and then a_class.degree_scoop_needed then
					if a_class.is_separate_client then
						is_separate := True
					end
				end
				i := i + 1
			end

			debug ("SCOOP")
				if is_separate then
					io.error.put_string ("SCOOP: keyword 'separate' found, start class creation.")
				else
					io.error.put_string ("SCOOP: keyword 'separate' not found, next: degree 4.")
				end
				io.error.put_new_line
			end

			Result := is_separate
		end

	set_degree_5 (a_degree_5: DEGREE_5) is
			-- set current degree 5
		require
			a_degree_5 /= Void
		do
			l_degree_5 := a_degree_5
		end

feature -- Processing

	execute is
			-- Process all classes.
		local
			i: INTEGER
			a_class: CLASS_C
			l_classes: ARRAY [CLASS_C]
			l_degree_output: like degree_output
			l_system: like system
			l_path, l_orig_path: DIRECTORY_NAME
		do
			l_degree_output := Degree_output
			l_degree_output.put_start_degree (Degree_number, count)

			l_system := system
			l_classes := l_system.classes

			debug ("SCOOP")
				io.error.put_string ("SCOOP: Processing 'execute'.")
				io.error.put_new_line
			end

			-- collect classes which should become client and proxy code.
			collect_needed_classes

			-- create home directory
			create l_path.make_from_string (universe.project_location.eifgens_path.string)
			l_path.set_subdirectory (universe.target_name)
			l_path.set_subdirectory ("cluster")
			create scoop_directory.make (l_path)
			if not scoop_directory.exists then
				scoop_directory.create_dir
			end

			-- create original classes directory
			create l_orig_path.make_from_string (scoop_directory.name)
			create original_directory.make (l_orig_path)
			if not original_directory.exists then
				original_directory.create_dir
			else
				if not original_directory.is_empty then
				--original_directory.delete_content
				end
			end

			debug ("SCOOP")
				io.error.put_string ("SCOOP: Processing classes.")
			end

			from i := 1 until i > l_scoop_workbench.scoop_classes.count loop
				a_class := l_scoop_workbench.scoop_classes.item (i)

				debug ("SCOOP")
					io.error.put_string ("SCOOP: Processing class '" + a_class.name + "'.")
					io.error.put_new_line
				end

					-- set current processed class
				l_scoop_workbench.set_current_class_c (a_class)
				l_scoop_workbench.set_current_class_as (a_class.ast)

					-- set feature table
					-- was computed in degree 4.
				if a_class.feature_table /= Void then
					a_class.ast.set_feature_table (a_class.feature_table)
				end

				-- create original classes
				process_separate_client_creation (a_class)

				-- creation of proxy classes
				process_separate_proxy_creation (a_class)

				-- Mark the class syntactically changed
			--	a_class.set_changed (True)

				i := i + 1
			end
			l_degree_output.put_end_degree
		end

feature -- Folder handling

	delete_scoop_cluster is
			-- delete scoop project cluster
		local
			l_path: DIRECTORY_NAME
			l_directory: DIRECTORY
		do
			create l_path.make_from_string (universe.project_location.eifgens_path.string)
			l_path.set_subdirectory (universe.target_name)
			l_path.set_subdirectory ("cluster")
			create l_directory.make (l_path)
			if l_directory.exists then
				l_directory.delete_content

			end
		end

feature -- Element change

	insert_class (a_class: CLASS_C) is
			-- Add `a_class' to be processed.
		do
			a_class.add_to_degree_scoop
			count := count + 1
		end

feature -- Removal

	remove_class (a_class: CLASS_C) is
			-- Remove `a_class'.
		do
			a_class.remove_from_degree_scoop
			count := count - 1
		end

	wipe_out is
			-- Remove all classes.
		local
			i, nb: INTEGER
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
		do
			from
				i := 1
				nb := count
				classes := System.classes
			until
				nb = 0
			loop
				a_class := classes.item (i)
				if a_class /= Void then
					a_class.remove_from_degree_scoop
					nb := nb - 1
				end
				i := i + 1
			end
			count := 0
		end

feature {NONE} -- Processing

	collect_needed_classes() is
			-- visitor flags corresponding classes with the flag degree_scoop_needed
			--	A SCOOP client and proxy class for class C should only be generated if
			--	1) A separate type occures in C
			--	2) C occures as separate type in an other class
			--	3) D inherits from C and D occurs as separate type in another class.
			--	4) D inherits from C and in C occures a separate type
		local
			i: INTEGER
			l_str: STRING
			l_classes: ARRAY [CLASS_C]
			l_class: CLASS_C
			l_system: like system
			l_match_list: LEAF_AS_LIST
			class_list_1, class_list_2, l_scoop_classes: SCOOP_SEPARATE_CLASS_LIST
			l_separate_class_visitor: SCOOP_SEPARATE_CLASS_VISITOR
		do
			l_system := system
			l_classes := l_system.classes
			create class_list_1.make
			create l_separate_class_visitor.make_with_separate_class_list (class_list_1)

			from i := 1 until i > l_classes.count loop
				l_class := l_classes.item (i)

				if l_class /= Void and then l_class.is_separate_client then
					-- class contains separate keyword

						-- case 1)
					if not class_list_1.has (l_class.name_in_upper) then
						create l_str.make_from_string (l_class.name_in_upper)
						class_list_1.extend (l_class)
					end

						-- case 2)
					l_match_list := match_list_server.item (l_class.class_id)
					l_separate_class_visitor.setup (l_class.ast, l_match_list, true, true)
					l_separate_class_visitor.process_class_as (l_class.ast)
				end

				i := i + 1
			end

				-- case 3) add all parents
			create class_list_2.make
			from until class_list_1.is_empty loop
				l_class := class_list_1.first
				class_list_1.remove_first

					-- insert current class
				if not class_list_2.has_class (l_class) then
					class_list_2.extend (l_class)
				end

					-- insert all not already processed parents in list 1
				from i := 1 until i > l_class.parents_classes.count loop
					if not class_list_2.has_class (l_class.parents_classes.i_th (i)) and then
					   not class_list_1.has_class (l_class.parents_classes.i_th (i)) then
						class_list_1.extend (l_class.parents_classes.i_th (i))
					end

					i := i + 1
				end
			end

				-- case 4) add all descendants
			create l_scoop_classes.make
			from until class_list_2.is_empty loop
				l_class := class_list_2.first
				class_list_2.remove_first

					-- insert current class
				if not l_scoop_classes.has_class (l_class) then
					l_scoop_classes.extend (l_class)
				end

					-- insert all not already processed descendants in list 2
				from i := 1 until i > l_class.direct_descendants.count loop
					if not l_scoop_classes.has_class (l_class.direct_descendants.i_th (i)) and then
					   not class_list_2.has_class (l_class.direct_descendants.i_th (i)) then
						class_list_2.extend (l_class.direct_descendants.i_th (i))
					end

					i := i + 1
				end

				l_scoop_workbench.set_scoop_classes (l_scoop_classes)
			end

			debug ("SCOOP")
				io.error.put_string ("SCOOP: Processing following classes:")
				io.error.put_new_line
				l_scoop_classes.print_all
			end
		end

	process_separate_client_creation (a_class_c: CLASS_C) is
			-- Process client class of input class.
		local
			l_match_list: LEAF_AS_LIST
			l_printer: SCOOP_SEPARATE_CLIENT_PRINTER
		do
			debug ("SCOOP")
				io.error.put_string ("SCOOP: Client class of class '" + a_class_c.name_in_upper + "'.")
				io.error.put_new_line
			end

				-- create proxy visitor to process.
			l_match_list := match_list_server.item (a_class_c.class_id)
			create l_printer.make_with_default_context
			l_printer.setup (a_class_c.ast, l_match_list, True, True)
			l_printer.process_class

			debug ("SCOOP")
				io.error.put_string (l_printer.text)
				io.error.put_new_line
			end

				-- print_content to file.
			print_to_file (l_printer.text, a_class_c, true)
		end

	process_separate_proxy_creation (a_class_c: CLASS_C) is
			-- Create proxy class of input class.
		local
			l_match_list: LEAF_AS_LIST
			l_printer: SCOOP_SEPARATE_PROXY_PRINTER
		do
			debug ("SCOOP")
				io.error.put_string ("SCOOP: Proxy class of class '" + a_class_c.name_in_upper + "'.")
				io.error.put_new_line
			end

				-- create proxy visitor to process.
			l_match_list := match_list_server.item (a_class_c.class_id)
			create l_printer.make_with_default_context (system, l_scoop_workbench.scoop_classes)
			l_printer.setup (a_class_c.ast, l_match_list, True, True)
			l_printer.process

			debug ("SCOOP")
				io.error.put_string (l_printer.get_context)
				io.error.put_new_line
			end

				-- print_content to file.
			print_to_file (l_printer.text, a_class_c, false)
		end

	print_to_file (a_context: STRING; a_class_c: CLASS_c; is_client_and_not_proxy: BOOLEAN) is
			-- Print text of a_class_node.
		local
			file: PLAIN_TEXT_FILE
			l_file_name: STRING
		do
				-- prepare path
			create l_file_name.make_from_string (scoop_directory.name)
			l_file_name.append ("\")
			if not is_client_and_not_proxy then
				l_file_name.append ("SCOOP_SEPARATE__")
			end
			l_file_name.append (a_class_c.name.as_lower)
			l_file_name.append (".e")
			l_file_name.to_lower

				-- create file
			create file.make_create_read_write (l_file_name)
			file.put_string (a_context.string_representation)
			file.close

			debug ("SCOOP")
				io.error.put_string ("SCOOP: Proxy class '")
				if not is_client_and_not_proxy then
					io.error.put_string ("SCOOP_SEPARATE__")
				end
				io.error.put_string (a_class_c.name.as_lower + "' saved in '" + l_file_name + "'.")
				io.error.put_new_line
			end
		end

feature {NONE} -- Implementation

	scoop_directory: DIRECTORY
		-- SCOOP directory in EIFGENs folder

	original_directory: DIRECTORY
			-- SCOOP directory in EIFGENs folder for original classes

	l_degree_5: DEGREE_5
			-- reference to degree 5

	l_scoop_workbench: SCOOP_WORKBENCH
			-- reference to current workbench

end
