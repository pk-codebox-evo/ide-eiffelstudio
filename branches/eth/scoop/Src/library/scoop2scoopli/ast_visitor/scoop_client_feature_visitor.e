indexing
	description: "Summary description for {SCOOP_CLIENT_FEATURE_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_CLIENT_FEATURE_VISITOR

inherit
	SCOOP_CLIENT_CONTEXT_AST_PRINTER
		redefine
			process_feature_as,
			process_keyword_as
		end
	SCOOP_BASIC_TYPE

create
	make_with_context

feature {NONE} -- Initialisation

	make_with_context(a_context: ROUNDTRIP_CONTEXT)
			-- Initialise and reset flags
		require
			a_context_not_void: a_context /= Void
		do
			context := a_context
		end

feature -- Access

	process_feature(l_as: FEATURE_AS) is
			-- Process `l_as'.
		do
			safe_process (l_as)
		end

feature {NONE} -- Visitor implementation

	process_feature_as (l_as: FEATURE_AS) is
		local
			i, nb: INTEGER
			is_separate: BOOLEAN
			l_feature_object: SCOOP_CLIENT_FEATURE_OBJECT
			l_feature_name_visitor: SCOOP_FEATURE_NAME_VISITOR
			l_argument_visitor: SCOOP_CLIENT_ARGUMENT_VISITOR
			l_feature_assertion_visitor: SCOOP_CLIENT_FEATURE_ASSERTION_VISITOR
			l_feature_lr_visitor: SCOOP_CLIENT_FEATURE_LR_VISITOR
			l_feature_er_visitor: SCOOP_CLIENT_FEATURE_ER_VISITOR
			l_feature_wc_visitor: SCOOP_CLIENT_FEATURE_WC_VISITOR
			l_feature_nsp_visitor: SCOOP_CLIENT_FEATURE_NSP_VISITOR
			l_feature_sp_visitor: SCOOP_CLIENT_FEATURE_SP_VISITOR
		do
			set_current_feature_as (l_as)

			if l_as.is_attribute or l_as.is_constant then
				last_index := l_as.start_position - 1
				context.add_string ("%N%N%T")
				safe_process (l_as.feature_names)
				safe_process (l_as.body)
			else -- routine

					-- create feature object
				create l_feature_object
				set_feature_object (l_feature_object)

					-- create feature name visitor
				create l_feature_name_visitor.make
				l_feature_name_visitor.setup (parsed_class, match_list, true, true)

				-- create for each feature name a new body
				-- (and also for the other SCOOP routines)
				from
					i := 1
					nb := l_as.feature_names.count
				until
					i > nb
				loop
					is_separate := false
					-- check if there are separate arguments
					if l_as.body /= Void and then l_as.body.internal_arguments /= void then
						create l_argument_visitor
						l_argument_visitor.setup (parsed_class, match_list, true, true)
						l_feature_object.set_arguments (l_argument_visitor.process_arguments (l_as.body.internal_arguments))

						if l_feature_object.arguments.has_separate_arguments then
							is_separate := true
						end
					end

					-- identify frozen key word
					last_index := l_as.feature_names.i_th (i).start_position
					if not l_as.feature_names.i_th (i).frozen_keyword_index.is_equal (0) then
						l_feature_object.is_feature_frozen.set_item (true)
					end

					-- process name
					l_feature_name_visitor.process_feature_name (l_as.feature_names.i_th (i), false)
					l_feature_object.set_feature_name (l_feature_name_visitor.get_feature_name)
					l_feature_name_visitor.process_feature_declaration_name (l_as.feature_names.i_th (i))
					l_feature_object.set_feature_declaration_name (l_feature_name_visitor.get_feature_name)

					if is_separate then

						-- assertion visitor
						create l_feature_assertion_visitor.make_with_context (context)
						l_feature_assertion_visitor.setup (parsed_class, match_list, true, true)
						l_feature_assertion_visitor.process_feature_body (l_as.body, l_feature_object)

						-- get result objects
						l_feature_object.set_preconditions (l_feature_assertion_visitor.get_preconditions)
						l_feature_object.set_postconditions (l_feature_assertion_visitor.get_postconditions)

						-- locking request body (feature, procedure, deferred routines)
						create l_feature_lr_visitor.make_with_context (context)
						l_feature_lr_visitor.setup (parsed_class, match_list, true, true)
						l_feature_lr_visitor.process_feature_body (l_as.body, l_feature_object)

						-- enclosing routine body (feature, procedure, deferred routines)
						create l_feature_er_visitor.make_with_context (context)
						l_feature_er_visitor.setup (parsed_class, match_list, true, true)
						l_feature_er_visitor.process_feature_body (l_as.body, l_feature_object)

						-- wait condition wrapper (feature, procedure, deferred routines)
						create l_feature_wc_visitor.make_with_context (context)
						l_feature_wc_visitor.setup (parsed_class, match_list, true, true)
						l_feature_wc_visitor.process_feature_body (l_as.body, l_feature_object)

						-- postcondition processing
						if not l_feature_object.postconditions.separate_postconditions.is_empty then

							-- unseparated postcondition attribute
							create_unseparated_postcondition_attribute (l_feature_object)
						end

						if not l_feature_object.postconditions.non_separate_postconditions.is_empty then
							-- non separate postcondition clauses wrapper
							create l_feature_nsp_visitor.make_with_context (context)
							l_feature_nsp_visitor.setup (parsed_class, match_list, true, true)
							l_feature_nsp_visitor.process_feature_body (l_as.body, l_feature_object)
						end

						if not l_feature_object.postconditions.separate_postconditions.is_empty then
							-- separate postcondition clauses wrapper
							create l_feature_sp_visitor.make_with_context (context)
							l_feature_sp_visitor.setup (parsed_class, match_list, true, true)
							l_feature_sp_visitor.process_feature_body (l_as.body, l_feature_object)
						end

						-- postcondition processing
						if not l_feature_object.postconditions.separate_postconditions.is_empty then

							-- wrappers for individual separate postcondition clauses
							create_separate_postcondition_wrapper (l_feature_object)
						end

					else
						-- print original feature
						context.add_string ("%N%N%T")
						if l_feature_object.is_feature_frozen then
							context.add_string ("frozen ")
						end
						context.add_string (l_feature_object.feature_declaration_name + " ")
						last_index := l_as.body.start_position - 1

						safe_process (l_as.body)
					end

					i := i + 1
				end

			end

			-- invalidate workbench access
			set_current_feature_as_void
		end

	process_keyword_as (l_as: KEYWORD_AS) is
			-- Process `l_as'.
		do
			if l_as.is_frozen_keyword then
				Precursor (l_as)
				-- add a space after the frozen keyword before printing the feature name
				context.add_string (" ")
			else
				Precursor (l_as)
			end
		end

feature {NONE} -- Implementation	

	create_unseparated_postcondition_attribute (a_fo: SCOOP_CLIENT_FEATURE_OBJECT) is
			-- Generate list of unseparated postconditions.
			-- Unseparated postconditions are separate postcondition that
			-- involve a non-separate object at run time. They are treated as
			-- non-separate postconditions.
		require
			a_fo_not_void: a_fo /= Void
		do
			context.add_string ("%N%N%T" + a_fo.feature_name + "_scoop_separate_" + class_c.name.as_lower +
								"_unseparated_postconditions: LINKED_LIST [ROUTINE [ANY, TUPLE]]")
			context.add_string ("%N%T%T-- Precondition clauses of `" + a_fo.feature_name + "' that seem to be separate but are not.")
			context.add_string ("%N%T%T-- They have to be processed as correctness conditions.")
		end

	create_separate_postcondition_wrapper  (a_fo: SCOOP_CLIENT_FEATURE_OBJECT) is
			-- Generate wrappers for individual separate postcondition clauses.
		require
			a_fo_not_void: a_fo /= Void
		local
			i: INTEGER
			an_assertion: SCOOP_CLIENT_ASSERTION_OBJECT
			l_feature_isp_visitor: SCOOP_CLIENT_FEATURE_ISP_VISITOR
		do
			-- create visitor for individual separate postcondition clauses.
			create l_feature_isp_visitor.make_with_context (context)
			l_feature_isp_visitor.setup (parsed_class, match_list, true, true)

			-- iterate over all separate postconditions
			from
				i := 1
			until
				i > a_fo.postconditions.separate_postconditions.count
			loop
				-- get assertion
				an_assertion := a_fo.postconditions.separate_postconditions.i_th (i)

				-- process feature
				l_feature_isp_visitor.process_individual_separate_postcondition (i, an_assertion, a_fo)

				i := i + 1
			end
		end

end
