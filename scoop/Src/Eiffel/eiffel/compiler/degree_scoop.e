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

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

create

	make

feature {NONE} -- Initialisation

	make
			-- Create new degree SCOOP
		local
			tmp_system: SYSTEM_I
			tmp_worbench: SCOOP_WORKBENCH
			l_shared_scoop_workbench: SHARED_SCOOP_WORKBENCH
		do
			Precursor

			-- create a scoop workbench
			create scoop_workbench

			-- create shared scoop workbench
			create l_shared_scoop_workbench
			l_shared_scoop_workbench.setup_shared_scoop_workbench (scoop_workbench, system)

			-- call once routines
			tmp_system := l_shared_scoop_workbench.system
			tmp_worbench := l_shared_scoop_workbench.shared_scoop_workbench

			-- create directory name
			create_directory_name

			-- create name prefix
			create scoop_proxy_prefix.make_from_string ("scoop_separate__")
		end

feature -- Access

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

				-- iterate over all classes in the system
				-- and check the already processed 'is_separate_client' value.
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
			degree_5 := a_degree_5
		end

feature {SYSTEM_I} -- Processing

	execute is
			-- Process all classes.
		local
			i: INTEGER
			a_class: CLASS_C
			l_degree_output: like degree_output
		do
			-- set degree values.
			l_degree_output := Degree_output
			l_degree_output.put_start_degree (Degree_number, count)

			debug ("SCOOP")
				io.error.put_string ("SCOOP: Processing 'execute'.")
				io.error.put_new_line
			end

			-- create cluster
			if not scoop_directory.exists then
				-- create directory
				create_directory
			end

			-- Collect classes which should become client and proxy code.
			collect_needed_classes

			debug ("SCOOP")
				io.error.put_string ("SCOOP: Processing classes.")
			end

			-- iterate over all classes and create the new proxy- and client classes.
			from i := 1 until i > scoop_workbench.scoop_classes.count loop
				a_class := scoop_workbench.scoop_classes.item (i)

				l_degree_output.put_degree_scoop (a_class, count - i + 1)

				debug ("SCOOP")
					io.error.put_string ("SCOOP: Processing class '" + a_class.name + "'.")
					io.error.put_new_line
				end

					-- set current processed class in workbench
				scoop_workbench.set_current_class_c (a_class)
				scoop_workbench.set_current_class_as (a_class.ast)

					-- set feature table in workbench
					-- was computed in degree 4.
				if a_class.feature_table /= Void then
					a_class.ast.set_feature_table (a_class.feature_table)
				end

				-- create original classes
				process_separate_client_creation (a_class)

				-- creation of proxy classes
				process_separate_proxy_creation (a_class)

				-- force system to check class again
				workbench.add_class_to_recompile (a_class.original_class)
				a_class.set_changed (True)

				i := i + 1
			end

				-- degree output
			l_degree_output.put_end_degree
		end

feature {SYSTEM_I} -- SYSTEM_I support

	is_missing_class_ignored (a_class_name: STRING): BOOLEAN is
			-- returns true if a missing class message should be ignored.
		do
			if a_class_name.is_equal ("PROCESSOR") then
				Result := true
			else
				Result := false
			end
		end

	reset_scoop_processing is
			-- reset SCOOP processing environment
		do
			-- delete old generated classes
			delete_scoop_cluster_content
		end

	get_scoop_cluster_path: STRING is
			-- returns the path of the scoop cluster as string
		do
			Result := get_cluster_path.string
		end

	remove_scoop_classes (a_class_name: STRING) is
			-- removes scoop client and proxy class from cluster if there are any
		local
			l_file_name: FILE_NAME
			file: PLAIN_TEXT_FILE
		do
				-- prepare path
			create l_file_name.make
			l_file_name.set_directory (scoop_directory.name)
			l_file_name.add_extension ("e")

			-- delete client class
			l_file_name.set_file_name (a_class_name.as_lower)
			create file.make (l_file_name.string)
			if file.exists then
				file.delete
			end

			-- delete proxy class
			l_file_name.set_file_name (scoop_proxy_prefix + a_class_name)
			create file.make (l_file_name.string)
			if file.exists then
				file.delete
			end
		end

feature {NONE} -- Cluster handling implementation

	create_directory_name is
			-- creates the scoop directory cluster name
		do
			create scoop_directory.make (get_scoop_cluster_path.string)
		end

	create_directory is
			-- creates the scoop directory reference
		require
			scoop_directory_name_not_void: scoop_directory /= Void
		do
			-- create folder in system
			if not scoop_directory.exists then
				scoop_directory.create_dir
			end
		ensure
			scoop_directory_not_void: scoop_directory /= void
		end

	get_cluster_path: DIRECTORY_NAME is
			-- returns the path of the scoop cluster
		local
			l_scoop_path: DIRECTORY_NAME
		do
			-- create with home directory
			create l_scoop_path.make_from_string (workbench.project_location.eifgens_path.string)
			-- add project target cluster
			l_scoop_path.set_subdirectory (workbench.project_location.target)
			-- add cluster 'cluster'
			l_scoop_path.set_subdirectory ("scoop_cluster")

			Result := l_scoop_path
		end

	group_exists (a_group: STRING; a_target: CONF_TARGET): BOOLEAN is
			-- Check if 'a_target' or any child of 'a_target' already has 'a_group'.
		require
			a_group_ok: a_group /= Void and then not a_group.is_empty
		local
			l_groups: HASH_TABLE [CONF_GROUP, STRING_8]
		do
			l_groups := a_target.groups
			Result := l_groups.has_key (a_group.as_lower) and then l_groups.found_item.name.is_equal (a_group.as_lower)
			if not Result then
				Result := a_target.child_targets.there_exists (agent group_exists(a_group.as_lower, ?))
			end
		end

	delete_scoop_cluster_content is
			-- delete the content of the project cluster
		require
			scoop_directory_name_not_void: scoop_directory /= Void
		do
			if scoop_directory.exists and then not scoop_directory.is_empty then
				scoop_directory.delete_content
			end
		end

feature -- Element Change and Removal

	insert_class (a_class: CLASS_C) is
			-- Add `a_class' to be processed.
		do
			a_class.add_to_degree_scoop
			count := count + 1
		end

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

feature {NONE} -- Implementation

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

				-- set the classes in the workbench
				scoop_workbench.set_scoop_classes (l_scoop_classes)

				-- set count
				count := l_scoop_classes.count
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
				io.error.put_string (l_printer.get_context)
				io.error.put_new_line
			end

				-- print_content to file.
			print_to_file (l_printer.get_context, a_class_c, true)
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
			create l_printer.make_with_default_context
			l_printer.setup (a_class_c.ast, l_match_list, True, True)
			l_printer.process

			debug ("SCOOP")
				io.error.put_string (l_printer.get_context)
				io.error.put_new_line
			end

				-- print_content to file.
			print_to_file (l_printer.get_context, a_class_c, false)
		end

	print_to_file (a_context: STRING; a_class_c: CLASS_c; is_client_and_not_proxy: BOOLEAN) is
			-- Print text of a_class_node.
		local
			file: PLAIN_TEXT_FILE
			l_local_file_name : STRING
			l_file_name: FILE_NAME
		do
				-- prepare path
			create l_file_name.make

			l_file_name.set_directory (scoop_directory.name)
			l_local_file_name := a_class_c.name.as_lower

			if not is_client_and_not_proxy then
				l_local_file_name := scoop_proxy_prefix + l_local_file_name
			end
			l_file_name.set_file_name (l_local_file_name)
			l_file_name.add_extension ("e")

				-- create file
			create file.make_create_read_write (l_file_name.string)

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

	degree_5: DEGREE_5
			-- reference to degree 5

	scoop_workbench: SCOOP_WORKBENCH
			-- reference to current workbench

	scoop_proxy_prefix: STRING
			-- name prefix for proxy classes

invariant
	scoop_directory_not_void: scoop_directory /= Void
	scoop_workbench_not_void: scoop_workbench /= Void

end
