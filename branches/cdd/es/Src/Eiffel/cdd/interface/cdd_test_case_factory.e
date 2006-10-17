indexing
	description: "Singleton for creating and removing test cases"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_CASE_FACTORY

inherit

	CDD_CONSTANTS

	EB_CLUSTER_MANAGER_OBSERVER
		export
			{NONE} all
		end

	SHARED_EIFFEL_PARSER
		export
			{NONE} all
		end

feature -- Access

	last_created_test_case: CDD_TEST_CASE

feature {CDD_MANAGER} -- Element change

	create_from_class (a_class: EIFFEL_CLASS_I; a_universe: UNIVERSE_I) is
			-- Create a new test case instance for test class 'a_class' and assign
			-- 'last_created_test_case' to created instance.
			-- Retrieve the class and cluster under test from 'a_universe'.
			-- NOTE: a_class must be a test class in the cdd tests cluster.
			-- If creation failed, 'last_created_test_case' is Void.
		require
			a_class_not_void: a_class /= Void
			a_universe_not_void: a_universe /= Void
		local
			l_file: KL_BINARY_INPUT_FILE
			l_ast: CLASS_AS
			l_ilist: INDEXING_CLAUSE_AS
			l_item: INDEX_AS

			l_name, l_icluster, l_iclass, l_ifeature: STRING
			l_class: EIFFEL_CLASS_C
			l_feature: E_FEATURE
			l_tc: CDD_TEST_CASE
			l_group: CONF_GROUP
		do
			last_created_test_case := Void
			create l_file.make (a_class.file_name)
			if l_file.exists then
				if not a_class.is_compiled then
					if l_file.is_readable then
						l_file.open_read
						eiffel_parser.parse (l_file)
						l_file.close
						l_ast := eiffel_parser.root_node
					end
				else
					l_ast := a_class.compiled_class.ast
				end
				if l_ast /= Void then
					l_ilist := l_ast.top_indexes
					from
						l_ilist.start
					until
						l_ilist.after
					loop
						l_item := l_ilist.item
						l_name := l_item.tag
						if l_name.is_equal ("cdd_cluster") then
							l_icluster := parse_indexing_item (l_item)
						elseif l_name.is_equal ("cdd_class") then
							l_iclass := parse_indexing_item (l_item)
						elseif l_name.is_equal ("cdd_feature") then
							l_ifeature := parse_indexing_item (l_item)
						end
						l_ilist.forth
					end
					if l_icluster /= Void and l_iclass /= Void and l_ifeature /= Void then
						l_group := eiffel_universe.group_of_name (l_icluster)
						if l_group /= Void then
							l_class ?= a_universe.class_named (l_iclass, l_group).compiled_class
						end
						if l_class /= Void then
							l_feature := l_class.feature_with_name (l_ifeature)
							if l_feature /= Void then
								create l_tc.make (l_class.original_class, l_feature, a_class)
								last_created_test_case := l_tc
							end
						end
					end
				end
			end
		end

	create_with_reflection (a_reflection: CDD_REFLECTION; a_cluster: CLUSTER_I) is
			-- Create a new test case from 'a_reflection'. Write test class into 'a_cluster'.
			-- Assign 'last_created_test_case' with created test case.
		require
			valid_reflection: a_reflection /= Void and then a_reflection.reflection_succeded
			a_cluster_not_void: a_cluster /= Void
		local
			l_file_name,l_class_name: STRING
			l_cud: EIFFEL_CLASS_I
			l_test_class: CLASS_I
			l_tc: CDD_TEST_CASE
		do
			last_created_test_case := Void
			l_file_name := new_file_name (a_reflection.root_object.dynamic_type, a_cluster)
			l_class_name := l_file_name.as_upper
			l_class_name.remove_tail (2)
			create_test_class (l_file_name, l_class_name, a_reflection, a_cluster)
			if was_last_create_successful then
				manager.add_class_to_cluster (l_file_name, a_cluster, "")
				l_test_class := manager.last_added_class
				l_cud := a_reflection.root_object.dynamic_type.original_class
				create l_tc.make (l_cud, a_reflection.called_feature, l_test_class)
				last_created_test_case := l_tc
			end
		ensure
			created: last_created_test_case /= Void
		end

	remove (a_tc: CDD_TEST_CASE) is
			-- Remove test class for 'a_tc' and notify cluster and window manager.
		require
			a_tc /= Void
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make (a_tc.test_class.file_name)
			if l_file.exists and l_file.is_writable then
				l_file.delete
			end
			manager.remove_class (a_tc.test_class)
		end

feature {NONE} -- Implementation

	parse_indexing_item (an_item: INDEX_AS): STRING is
			-- Joined string values stored in 'an_item'
		require
			an_item_not_void: an_item /= Void
		local
			l_list: EIFFEL_LIST [ATOMIC_AS]
		do
			l_list := an_item.index_list
			if not l_list.is_empty then
				create Result.make_empty
				from
					l_list.start
				until
					l_list.after
				loop
					Result.append (l_list.item.string_value)
					l_list.forth
				end
				Result.prune_all_leading ('"')
				Result.prune_all_trailing ('"')
			end
		end

	new_file_name (a_cud: EIFFEL_CLASS_C; a_cluster: CLUSTER_I): STRING is
			-- New unique file name for a new test class where 'a_cud' is the class under test.
		require
			a_cud_not_void: a_cud /= Void
			a_cluster_not_void: a_cluster /= Void
		local
			l_prefix: STRING
			l_file: PLAIN_TEXT_FILE
			i: INTEGER
		do
			l_prefix := "cdd_test_" + a_cud.name.as_lower + "_"
			from
				i := 1
			until
				Result /= Void
			loop
				create Result.make_from_string (l_prefix)
				if i < 10 then
					Result.append_character ('0')
				end
				Result.append (i.out + ".e")
				create l_file.make (a_cluster.location.build_path ("", Result))
				if l_file.exists then
					Result := Void
				end
				i := i + 1
			end
		ensure
			valid_result: Result /= Void and then not Result.is_empty
		end

	create_test_class (a_file_name, a_class_name: STRING; a_reflection: CDD_REFLECTION; a_cluster: CLUSTER_I) is
			-- Create new test class in 'a_test_suite' with name 'a_name', which uses
			-- 'a_reflection' to restore the the state of the object
		require
			valid_file_name: a_file_name /= Void and then not a_file_name.is_empty
			valid_class_name: a_class_name /= Void and then not a_class_name.is_empty
			valid_reflection: a_reflection /= Void and a_reflection.reflection_succeded
			a_cluster_not_void: a_cluster /= Void
		local
			l_path: STRING
			l_file: KL_TEXT_OUTPUT_FILE
		do
			l_path := a_cluster.location.build_path ("", a_file_name)
			create l_file.make (l_path)
			l_file.open_write
			was_last_create_successful := False
			if l_file.is_open_write then
				was_last_create_successful := True
				printer.print_test_case (a_reflection, a_class_name, l_file)
				if not l_file.is_closed  then
					l_file.close
				end
			end
		end

	was_last_create_successful: BOOLEAN
			-- Were we able to write last test case to file?

feature {NONE} -- Implementation

	printer: CDD_TEST_CASE_PRINTER is
			-- Printer for writing class text to disc
		once
			create Result
		end

end
