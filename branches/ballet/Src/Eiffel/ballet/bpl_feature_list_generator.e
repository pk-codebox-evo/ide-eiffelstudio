indexing
	description: "The usage analyser goes through the AST of the compiled classes and generates a list of defined feature."
	author: "Bernd Schoeller"
	date: "$Date$"
	revision: "$Revision$"

class
	BPL_FEATURE_LIST_GENERATOR

inherit
	BPL_VISITOR
		redefine
			make,
			process_feature_as
		end

create
	make

feature{NONE} -- Initialization

	make (a_class: CLASS_C) is
			-- Default creation
		do
			Precursor{BPL_VISITOR} (a_class)
			create {ARRAYED_LIST [FEATURE_AS]}command_list.make (1)
			create {ARRAYED_LIST [FEATURE_AS]}query_list.make (1)
			create {ARRAYED_LIST [FEATURE_AS]}deferred_command_list.make (1)
			create {ARRAYED_LIST [FEATURE_AS]}deferred_query_list.make (1)
			create {ARRAYED_LIST [FEATURE_AS]}attribute_list.make (1)
			create {ARRAYED_LIST [FEATURE_AS]}function_list.make (1)
			create {ARRAYED_LIST [FEATURE_AS]}procedure_list.make (1)
		end

feature -- Analyse

	analyse is
			-- Do the analysis of the class.
		do
			safe_process (current_class.ast)
		end

feature -- Access

	command_list: LIST [FEATURE_AS]
		-- List of all commands in the class

	query_list: LIST [FEATURE_AS]
		-- List of all queries in the class

	deferred_query_list: LIST [FEATURE_AS]
		-- List of deferred queries

	deferred_command_list: LIST [FEATURE_AS]
		-- List of deferred commands

	attribute_list: LIST [FEATURE_AS]
		-- List of all attributes in the class (queries as attributes)

	function_list: LIST [FEATURE_AS]
		-- List of all functions in the class (queries with implementation)

	procedure_list: LIST [FEATURE_AS]
		-- List of all procedures in the class (command with implementation)

feature -- Processing

	process_feature_as (l_as: FEATURE_AS) is
			-- Process a feature to record it in the lists.
		do
			Precursor {BPL_VISITOR}(l_as)
			if l_as.is_attribute or l_as.is_function then
				query_list.extend (l_as)
			else
				command_list.extend (l_as)
			end
			if l_as.is_attribute then
				attribute_list.extend (l_as)
			elseif l_as.is_deferred then
				if l_as.is_function then
					deferred_query_list.extend (l_as)
				else
					deferred_command_list.extend (l_as)
				end
			else
				if l_as.is_function then
					function_list.extend (l_as)
				else
					procedure_list.extend (l_as)
				end
			end


		end

invariant
	command_list_not_void: command_list /= Void
	query_list_not_void: query_list /= Void
	attribute_list_not_void: attribute_list /= Void
	function_list_not_void: function_list /= Void
	procedure_list_not_void: procedure_list /= Void
end
