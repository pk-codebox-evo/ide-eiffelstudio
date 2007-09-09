indexing
	description: "Objects that print class text for a test case"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_CASE_PRINTER

inherit

	CDD_CAPTURE_OBSERVER
		rename
			start as start_capturing,
			finish as finish_capturing
		end

	CDD_CLASS_PRINTER
		rename
			finish as finish_printing
		export
			{NONE} all
		end

	CDD_ROUTINES
		export
			{NONE} all
		end

	CDD_CONSTANTS

	EB_CLUSTER_MANAGER_OBSERVER
		rename
			manager as cluster_manager
		end

	SHARED_EIFFEL_PROJECT

create
	make

feature -- Initialization

	make (a_target: like target; a_test_suite: like test_suite) is
			-- Set `target' to `a_target'.
		require
			a_target_not_void: a_target /= Void
			a_test_suite_not_void: a_test_suite /= Void
		do
			target := a_target
			test_suite := a_test_suite
		ensure
			target_set: target = a_target
			test_suite_set: test_suite = a_test_suite
		end

feature -- Access

	is_initialized: BOOLEAN is
			--
		do
			Result := failed or else is_output_stream_valid
		end

	target: CONF_TARGET
			-- Target in which test cases will be created

	test_suite: CDD_TEST_SUITE
			-- Test suite containing current test cases

feature	-- Basic operations

	start_capturing (a_feature: E_FEATURE; a_class: CLASS_C; a_cs_uuid: UUID; a_cs_level: INTEGER) is
			-- Start capturing state for `a_feature' in `a_class'.
			-- `a_cs_uuid' is an ID for the call stack and `a_cs_level' is the
			-- index of the frame beeing captured.
		local
			l_prefix: STRING
			l_directory: KL_DIRECTORY
			l_output_file: KL_TEXT_OUTPUT_FILE
			i: INTEGER
		do
			failed := False
			printed_objects := 0

			-- From here
			current_cluster ?= a_class.group
			if current_cluster /= Void and then not current_cluster.is_readonly then
				create l_directory.make (current_cluster.location.build_path (tests_directory_name, ""))
				if not l_directory.exists then
					l_directory.create_directory
					if not l_directory.exists then
						failed := True
					end
				end
			else
				failed := True
			end

			if not failed then
				l_prefix := class_name_prefix + a_class.name + "_"
				from
					i := 1
				until
					l_output_file /= Void or i > 99
				loop
					create new_class_name.make_from_string (l_prefix)
					if i < 10 then
						new_class_name.append_character ('0')
					end
					new_class_name.append (i.out)
					create l_output_file.make (current_cluster.location.build_path (tests_directory_name, new_class_name.as_lower + ".e"))
					if l_output_file.exists then
						l_output_file := Void
					end
					i := i + 1
				end
				if l_output_file = Void then
					failed := True
				end
			end

			if not failed then
				l_output_file.open_write
				if not l_output_file.is_open_write then
					failed := True
				else
					-- To here...
					initialize (l_output_file)

						-- Print test class headers
					put_indexing (a_cs_uuid.out, a_cs_level)
					put_class_header

					put_set_up (a_feature, is_creation_feature (a_feature))
					put_access (a_class.name_in_upper, a_feature)
					put_context_header
				end
			end
		end

	put_object (an_id, a_type: STRING; an_inv: BOOLEAN; some_attributes: DS_LIST [STRING]) is
			-- Add a captured object of type `a_type' and attributes `some_attributes'.
			-- `an_id' is the associated id for reconstructing the state and `an_inv'
			-- indicated if the object has to fulfill its invariants.
		local
			l_attrs: STRING
			l_cursor: DS_LIST_CURSOR [STRING]
		do
			if not failed then
				if printed_objects > 0 then
					put_string (",%N")
				end
				printed_objects := printed_objects + 1
				create l_attrs.make_from_string ("<< ")
				l_cursor := some_attributes.new_cursor
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					l_attrs.append ("%"" + l_cursor.item + "%"")
					if not l_cursor.is_last then
						l_attrs.append (", ")
					end
					l_cursor.forth
				end
				l_attrs.append (" >>")
				put_string (indent)
				put_string ("[%"" + an_id + "%", %"" + a_type + "%", " + an_inv.out + ", " + l_attrs + "]")
			end
		rescue
			failed := True
			retry
		end

	finish_capturing is
			-- Set `output_stream' to `Void'.
		local
			l_tests_cluster: CONF_CLUSTER
			l_cluster_list: LIST [CONF_CLUSTER]
			l_directory: KL_DIRECTORY
		do
			if not failed then
				decrease_indent
				put_string ("%N")
				put_line (">>")
				decrease_indent
				put_line ("end")
				decrease_indent
				put_class_footer
				output_stream.flush
				output_stream.close
				finish_printing

				l_tests_cluster := eiffel_universe.cluster_of_name (current_cluster.cluster_name + cluster_name_suffix)
				if l_tests_cluster = Void Then
					create l_directory.make (current_cluster.location.build_path (tests_directory_name, ""))
					l_cluster_list := eiffel_universe.cluster_of_location (l_directory.name)
					if l_cluster_list.is_empty then
						cluster_manager.add_cluster (current_cluster.cluster_name + cluster_name_suffix, current_cluster, l_directory.name)
						eiffel_system.system.set_config_changed (True)
						l_tests_cluster := cluster_manager.last_added_cluster
					else
						l_tests_cluster := l_cluster_list.first
					end
				end
				cluster_manager.add_class_to_cluster (new_class_name.as_lower + ".e", l_tests_cluster, "")
				eiffel_system.system.set_rebuild (True)
			else
				if output_stream /= Void then
					output_stream.close
				end
				output_stream := Void
				failed := False
			end
		rescue
			failed := True
			retry
		end

feature {NONE} -- Implementation

	failed: BOOLEAN
			-- Has `Current' raised any exception since last call to `start_capturing'?

	current_cluster: CLUSTER_I
			-- Cluster which contains class under test

	new_class_name: STRING
			-- Class name of the new test case

	printed_objects: INTEGER
			-- Number of objects printed to context since last `start_capturing'

	put_indexing (an_uuid: STRING; an_index: INTEGER) is
			-- Append indexing clause using `an_uuid' for call
			-- stack id and `an_index' for call stack index.
		require
			initialized: is_initialized
			an_uuid_not_empty: an_uuid /= Void and then not an_uuid.is_empty
			an_index_positive: an_index > 0
		do
			put_line ("indexing%N")
			increase_indent
			put_line ("description: %"Objects that represent a cdd test case%"")
			put_line ("call_stack_uuid: %"" + an_uuid + "%"")
			put_line ("call_stack_index: " + an_index.out + "")
			put_line ("author: %"CDD Tool%"")
			put_line ("date: %"$Date$%"")
			put_line ("revision: %"$Revision$%"")
			decrease_indent
			put_line ("")
		end

	put_class_header is
			-- Append cdd test case class header with name `a_class_name' for testing `a_cut_name'.
			-- The feature under test takes the arguments listed in `a_arg_list'.
		require
			initialized: is_initialized
		do
			put_line ("class")
			increase_indent
			put_line (new_class_name + "%N")
			decrease_indent
			put_line ("inherit")
			increase_indent
			put_line ("CDD_EXTRACTED_TEST_CASE%N")
			decrease_indent
		end

	put_set_up (a_feature: E_FEATURE; an_is_creation_call: BOOLEAN) is
			-- Append class header text for 'test_class_name'
		require
			initialized: is_initialized
			a_feature_not_void: a_feature /= Void
		local
			i: INTEGER
			l_agent, l_class: STRING
			l_is_fix: BOOLEAN
			l_ops: DS_LINKED_LIST [STRING]
			l_cursor: DS_LINKED_LIST_CURSOR [STRING]
		do
			put_line ("feature {NONE} -- Initialization%N")
			increase_indent
			put_line ("set_up_routine is")
			increase_indent
			put_comment ("Initialize agent that calls feature under test")
			put_line ("do")
			increase_indent
			l_class := a_feature.associated_class.name_in_upper
			l_agent := "routine_under_test := agent"
			l_is_fix := a_feature.is_infix or a_feature.is_prefix
			if an_is_creation_call or l_is_fix then
				create l_ops.make
				if a_feature.argument_count > 0 or l_is_fix then
					if l_is_fix then
						l_ops.put_last (l_class)
					end
					from
						i := 1
					until
						i > a_feature.argument_count
					loop
						l_ops.put_last (a_feature.arguments.i_th (i).associated_class.name_in_upper)
						i := i + 1
					end

					create l_cursor.make (l_ops)
					l_agent.append (" (")
					from
						l_cursor.start
					until
						l_cursor.after
					loop
						l_agent.append ("an_arg" + l_cursor.index.out + ": " + l_cursor.item)
						if not l_cursor.is_last then
							l_agent.append ("; ")
						end
						l_cursor.forth
					end
					l_agent.append (")")
				end
				if a_feature.has_return_value then
					l_agent.append (": " + a_feature.associated_class.name_in_upper)
				else
					l_agent.append (": " + l_class)
				end
				put_line (l_agent)
				increase_indent
				put_line ("do")
				increase_indent
				if an_is_creation_call then
					l_agent := "Result := create {" + l_class + "}." + a_feature.name
					if a_feature.argument_count > 0 then
						l_agent.append (" (")
						from
							i := 1
						until
							i > a_feature.argument_count
						loop
							l_agent.append ("an_arg" + i.out)
							if i < a_feature.argument_count then
								l_agent.append (", ")
							end
							i := i + 1
						end
						l_agent.append (")")
					end
				elseif a_feature.is_infix then
					l_agent := "Result := an_arg1 " + a_feature.infix_symbol + " an_arg2"
				else
					l_agent := "Result := " + a_feature.prefix_symbol + "an_arg1"
				end
				put_line (l_agent)
				decrease_indent
				put_line ("end")
				decrease_indent
			else
				put_line (l_agent + " {" + l_class + "}." + a_feature.name)
			end
			decrease_indent
			put_line ("end%N")
			decrease_indent
			decrease_indent
		end

	put_context_header is
			-- Print feature definition for context.
		require
			initialized: is_initialized
		do
			put_line ("feature -- Context%N")

				-- Context
			increase_indent
			put_line ("context: ARRAY [TUPLE [STRING, STRING, BOOLEAN, ARRAY [STRING]]] is")
			increase_indent
			put_comment ("Context for executing test case")
			put_comment ("NOTE: by definition first element is operand for calling `routine_under_test'")
			put_line ("once")
			increase_indent
			put_line ("Result := <<")
			increase_indent
		end


	put_access (a_cut_name: STRING; a_feature: E_FEATURE) is
			-- Append class header text for `test_class_name'.
		require
			initialized: is_initialized
			a_cut_name_not_empty: a_cut_name /= Void and then not a_cut_name.is_empty
			a_feature_not_void: a_feature /= Void
		local
			l_feature_name: STRING
		do
			put_line ("feature -- Access%N")
			increase_indent
			put_line ("class_under_test: STRING is %"" + a_cut_name + "%"")
			put_comment ("Name of the class beeing tested%N")
			if a_feature.is_infix then
				l_feature_name := "infix %%%"" + a_feature.infix_symbol + "%%%""
			elseif a_feature.is_prefix then
				l_feature_name := "prefix %%%"" + a_feature.prefix_symbol + "%%%""
			else
				l_feature_name := a_feature.name
			end
			put_line ("feature_under_test: STRING is %"" + l_feature_name + "%"")
			put_comment ("Name of the feature beeing tested%N")
			decrease_indent
		end

	put_class_footer is
			-- Append class footer for test_class_name.
		do
			put_string ("%N%Nend -- class %N%N")
		end

invariant
	initialized_implies_valid_class_name: is_initialized implies new_class_name /= Void
	initialized_implies_cluster_not_void: is_initialized implies current_cluster /= Void

end
