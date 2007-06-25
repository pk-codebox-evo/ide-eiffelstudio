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

create
	make_with_cluster

feature -- Initialization

	make_with_cluster, set_cluster (a_cluster: like cluster) is
			-- Set `a_cluster' to cluster
		require
			a_cluster_not_void: a_cluster /= Void
		do
			cluster := a_cluster
		ensure
			cluster_set: cluster = a_cluster
		end

feature -- Access

	is_initialized: BOOLEAN is
			--
		do
			Result := failed or else is_output_stream_valid
		end

	cluster: CLUSTER_I
			-- Cluster in which test cases will be created

feature	-- Basic operations

	start_capturing (a_feature: E_FEATURE; a_class: CLASS_C; a_cs_uuid: UUID; a_cs_level: INTEGER) is
			-- Start capturing state for `a_feature' in `a_class'.
			-- `a_cs_uuid' is an ID for the call stack and `a_cs_level' is the
			-- index of the frame beeing captured.
		local
			l_class_name: STRING
			an_output_file: KL_TEXT_OUTPUT_FILE
		do
			failed := False
			printed_objects := 0
			l_class_name := new_class_name (a_class)
			if l_class_name = Void then
				failed := True
			else
				create an_output_file.make (l_class_name.as_lower + ".e")
				an_output_file.open_write
				if not an_output_file.is_open_write then
					failed := True
				else
					initialize (an_output_file)

						-- Print test class headers
					put_indexing (a_cs_uuid.out, a_cs_level)
					put_class_header (l_class_name)

					put_set_up (a_feature, is_creation_feature (a_feature))
					put_access (a_class.name_in_upper, a_feature.name)

					put_string ("feature -- Context%N%N")

						-- Context
					put_string ("%Tcontext: ARRAY [TUPLE [STRING, STRING, ARRAY [STRING]]] is%N")
					put_string ("%T%T%T-- Context for executing test case%N")
					put_string ("%T%T%T-- NOTE: by definition first element are arguments, second the object itself%N")
					put_string ("%T%Tonce%N")
					put_string ("%T%T%TResult := <<%N")
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
				put_string ("[%"" + an_id + "%", %"" + a_type + "%", " + an_inv.out + ", " + l_attrs + "]")
			end
		rescue
			failed := True
			retry
		end

	finish_capturing is
			-- Set `output_stream' to `Void'.
		do
			put_string ("%N%T%T%T%T>>%N%T%Tend%N%N")
			put_class_footer
			finish_printing
		rescue
			failed := True
			retry
		end

feature {NONE} -- Implementation

	failed: BOOLEAN
			-- Has `Current' raised any exception since last call to `start_capturing'?

	printed_objects: INTEGER
			-- Number of objects printed to context since last `start_capturing'

	new_class_name (a_cud: CLASS_C): STRING is
			-- New unique test class name for testing `a_cud' in `a_cluster'.
			-- Note: Result is Void if there are already 99 test classes for `a_cud'.
		require
			a_cud_not_void: a_cud /= Void
		local
			l_prefix: STRING
			l_file: KL_TEXT_INPUT_FILE
			i: INTEGER
		do
			l_prefix := "CDD_TEST_" + a_cud.name + "_"
			from
				i := 1
			until
				Result /= Void or i > 99
			loop
				create Result.make_from_string (l_prefix)
				if i < 10 then
					Result.append_character ('0')
				end
				--Result.append (i.out + ".e")
				create l_file.make (cluster.location.build_path ("", Result.as_lower + ".e"))
				if l_file.exists then
					Result := Void
				end
				i := i + 1
			end
		ensure
			not_empty: Result = Void or else not Result.is_empty
		end

	put_indexing (an_uuid: STRING; an_index: INTEGER) is
			-- Append indexing clause using `an_uuid' for call
			-- stack id and `an_index' for call stack index.
		require
			initialized: is_initialized
			an_uuid_not_empty: an_uuid /= Void and then not an_uuid.is_empty
			an_index_positive: an_index > 0
		do
			put_string ("indexing%N")
			put_string ("%Tdescription: %"Objects that represent a cdd test case%"%N")
			put_string ("%Tcall_stack_uuid: %"" + an_uuid + "%"%N")
			put_string ("%Tcall_stack_index: " + an_index.out + "%N")
			-- NOTE: not sure if class/feature information is needed by manager
			-- since it is part of the test case class text -Arno
			--put_string ("%Tcdd_cluster: %"" + l_class.cluster.cluster_name + "%"%N")
			--put_string ("%Tcdd_class: %"" + l_class.name_in_upper + "%"%N")
			--put_string ("%Tcdd_feature: %"" + a_name + "%"%N")
			put_string ("%Tauthor: %"CDD_TEST_CASE_PRINTER%"%N")
			put_string ("%Tdate: %"$Date$%"%N")
			put_string ("%Trevision: %"$Revision$%"%N%N")
		end

	put_class_header (a_class_name: STRING) is
			-- Append cdd test case class header with name `a_class_name' for testing `a_cut_name'.
			-- The feature under test takes the arguments listed in `a_arg_list'.
		require
			initialized: is_initialized
			a_class_name_not_empty: a_class_name /= Void and then not a_class_name.is_empty
		do
			put_string ("class%N%T" + a_class_name + "%N%N")
			put_string ("inherit%N%TCDD_TEST_CASE%N%N")
			put_string ("%N%Ncreate%N%Tmake%N%N")
		end

	put_set_up (a_feature: E_FEATURE; an_is_creation_call: BOOLEAN) is
			-- Append class header text for 'test_class_name'
		require
			initialized: is_initialized
			a_feature_not_void: a_feature /= Void
		local
			i: INTEGER
		do
			put_string ("feature {NONE} -- Initialization%N%N")
			put_string ("%Tset_up_routine is%N")
			put_string ("%T%T%T-- Initialize agent that calls feature under test%N")
			put_string ("%T%Tdo%N")
			put_string ("%T%T%Troutine_under_test := agent ")
			if an_is_creation_call then
				if a_feature.argument_count > 0 then
					put_string ("(")
					from
						i := 1
					until
						i > a_feature.argument_count
					loop
						put_string ("an_arg" + i.out + ": " + a_feature.arguments.i_th (i).dump)
						if i < a_feature.argument_count then
							put_string ("; ")
						end
						i := i + 1
					end
					put_string (")")
				end
				put_string ("%N%T%T%T%Tdo%N%T%T%T%T%T")
				put_string ("create object_under_test." + a_feature.name)
				if a_feature.argument_count > 0 then
					put_string ("(")
					from
						i := 1
					until
						i > a_feature.argument_count
					loop
						put_string ("an_arg" + i.out)
						if i < a_feature.argument_count then
							put_string (", ")
						end
						i := i + 1
					end
					put_string (")")
				end
				put_string ("%N%T%T%T%Tend")
			else
				put_string ("object_under_test." + a_feature.name)
			end
			put_string ("%N%T%Tend%N%N")
		end

	put_access (a_cut_name, a_feature_name: STRING) is
			-- Append class header text for `test_class_name'.
		require
			initialized: is_initialized
			a_cut_name_not_empty: a_cut_name /= Void and then not a_cut_name.is_empty
			a_feature_name_not_empty: a_feature_name /= Void and then not a_feature_name.is_empty
		do
			put_string ("feature -- Access%N%N")
			put_string ("%Tclass_under_test: STRING is %"" + a_cut_name + "%"%N")
			put_string ("%T%T%T-- Name of the class beeing tested%N%N")
			put_string ("%Tfeature_under_test: STRING is %"" + a_feature_name + "%"%N")
			put_string ("%T%T%T-- Name of the feature beeing tested%N%N")
		end

	put_class_footer is
			-- Append class footer for test_class_name.
		do
			put_string ("%N%Nend -- class %N%N")
		end

end
