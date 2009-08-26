indexing
	description: "Summary description for {JS_SPEC_GENERATOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JS_SPEC_GENERATOR

inherit
	SHARED_SERVER

	DOCUMENTATION_EXPORT

	JS_HELPER_ROUTINES

create
	make

feature

	make
		do
			create output.make
			create predicate_definition_parser.make
			create assertion_parser.make
			create spec_adapter.make
			create spec_printer.make
		end

	process_class (a_class: !CLASS_C)
		local
			l_supplier: CLASS_C
			considered: HASH_TABLE [BOOLEAN, INTEGER]
				-- The keys are class ids. This makes sure that no class is emitted twice.
		do
			output.reset

			create considered.make (10)
			considered.put (True, a_class.class_id)
				-- First collect specs from supplier classes of `a_class' (excluding `a_class' itself) that are not expanded or external (e.g. INTEGER_32).
			from
				a_class.suppliers.start
			until
				a_class.suppliers.off
			loop
				l_supplier := a_class.suppliers.item.supplier
				process_class_if_needed (l_supplier, considered)
				a_class.suppliers.forth
			end
				-- Next: collect specs from ancestor classes that are not expanded or external.
				-- TODO: non-conforming ancestors.
			considered.remove (a_class.class_id)
			process_class_and_parents_if_needed (a_class, considered, create {HASH_TABLE [BOOLEAN, INTEGER]}.make (10))
		end

	generated_specs: !STRING
		do
			Result := output.string
		end

feature {NONE}

	output: !JS_OUTPUT_BUFFER

	match_list: LEAF_AS_LIST

	predicate_definition_parser: JS_PREDICATE_DEFINITION_PARSER

	assertion_parser: JS_ASSERTION_PARSER

	spec_adapter: JS_SPEC_ADAPTER

	spec_printer: JS_SPEC_PRINTER

	process_class_and_parents_if_needed (a_class: CLASS_C; emitted: HASH_TABLE [BOOLEAN, INTEGER]; visited: HASH_TABLE [BOOLEAN, INTEGER])
		do
			if not visited.has_key (a_class.class_id) then
				visited.put (True, a_class.class_id)
				from
					a_class.conforming_parents.start
				until
					a_class.conforming_parents.off
				loop
					process_class_and_parents_if_needed (a_class.conforming_parents.item.associated_class, emitted, visited)
					a_class.conforming_parents.forth
				end
				process_class_if_needed (a_class, emitted)
			end
		end

	process_class_if_needed (a_class: CLASS_C; considered: HASH_TABLE [BOOLEAN, INTEGER])
		do
			if
				a_class /= Void and then
				not a_class.is_expanded and then
				not a_class.is_external and then
				not a_class.is_class_any and then
				not a_class.is_class_none and then
				not considered.has_key (a_class.class_id)
			then
				considered.put (True, a_class.class_id)
				collect_spec_of_class (a_class)
			end
			-- TODO: Specs of ANY
		end

	collect_spec_of_class (a_class: !CLASS_C)
			-- Collects the shallow spec of a class, i.e. the suppliers of `a_class' are not considered.
		do
			-- TODO: issue a warning if a_class uses inheritance

			match_list := match_list_server.item (a_class.class_id)

			output.put_line ("class " + a_class.name_in_upper)
			output.put_line ("{")

			output.indent

			collect_predicates (a_class.ast.top_indexes)
			collect_predicates (a_class.ast.bottom_indexes)

			collect_specs_of_creation_routines (a_class)

			collect_specs_of_normal_routines (a_class)

			output.unindent

			output.put_line ("}%N")
		end

	collect_predicates (a_indexing_clause: INDEXING_CLAUSE_AS)
		local
			l_content: STRING
			l_predicate_def: JS_SPEC_NODE
			predicate_tags: ARRAY [STRING]
			qualifier: STRING
		do
			predicate_tags := <<"SL_PREDICATE", "SL_PREDICATE_DEFINE", "SL_PREDICATE_EXPORT">>
			predicate_tags.compare_objects

			if a_indexing_clause /= Void then
				from
					a_indexing_clause.start
				until
					a_indexing_clause.off
				loop
					if
						{l_index_as: !INDEX_AS} a_indexing_clause.item and then
						predicate_tags.has (l_index_as.tag.name.as_upper)
					then
						l_content := l_index_as.content_as_string
						l_content := l_content.substring (2, l_content.count - 1)
						predicate_definition_parser.reset
						predicate_definition_parser.set_input_buffer (create {YY_BUFFER}.make (l_content))
						predicate_definition_parser.parse
						if predicate_definition_parser.error_count = 0 then
							l_predicate_def := predicate_definition_parser.predicate_definition

							-- Substitute types and Void.
							spec_adapter.with_class_context
							l_predicate_def.accept (spec_adapter)

							-- Now output the pretty printed definition
							spec_printer.reset
							l_predicate_def.accept (spec_printer)
							if equal (l_index_as.tag.name.as_upper, "SL_PREDICATE_EXPORT") then
								qualifier := "export"
							else
								qualifier := "define"
							end
							output.put_line (qualifier + " " + spec_printer.output + ";%N")
						else
							error ("Error parsing predicate definition: " + l_content)
						end
					end
					a_indexing_clause.forth
				end
			end
		end

	collect_spec_of_routine (as_creation_procedure: BOOLEAN; a_feature_as: !FEATURE_AS; a_feature_i: !FEATURE_I)
		local
			where: STRING
			precond_comments: EIFFEL_COMMENTS
			postcond_comments: EIFFEL_COMMENTS
			region: ERT_TOKEN_REGION
			static_spec: STRING
			dynamic_spec: STRING
		do
			where := a_feature_i.written_class.name_in_upper + "." + a_feature_i.feature_name

			if {b: !BODY_AS} a_feature_as.body and then {r: !ROUTINE_AS} b.content then

					-- Get the precondition comments
				if {pre: !REQUIRE_AS} r.precondition then
					create region.make (pre.first_token (match_list).index, r.routine_body.first_token (match_list).index)
					precond_comments := match_list.extract_comment (region)
				else
					error (where + ": precondition missing")
				end

					-- Get the postcondition comments
				if {post: !ENSURE_AS} r.postcondition then
					create region.make (post.first_token (match_list).index, r.end_keyword.first_token (match_list).index)
					postcond_comments := match_list.extract_comment (region)
				else
					error (where + ": postcondition missing")
				end
			else
				error (where + ": spec missing")
			end

			static_spec := static_spec_of_routine (precond_comments, postcond_comments, where, a_feature_i).string
			dynamic_spec := dynamic_spec_of_routine (precond_comments, postcond_comments, where, a_feature_i).string

			if equal (static_spec, "") and then equal (dynamic_spec, "") then
				error (where + ": spec missing")
			else
				if not equal (static_spec, "") then
					output.put_line ("static " + routine_signature (as_creation_procedure, a_feature_i) + " :")
					output.indent
					output.append_lines (static_spec + ";")
					output.unindent
				end
				if not equal (dynamic_spec, "") then
					output.put_line (routine_signature (as_creation_procedure, a_feature_i) + " :")
					output.indent
					output.append_lines (dynamic_spec + ";")
					output.unindent
				end
			end

		end

	static_spec_of_routine (pre: EIFFEL_COMMENTS; post: EIFFEL_COMMENTS; where: STRING; a_feature_i: !FEATURE_I): JS_OUTPUT_BUFFER
		do
			Result := spec_from_comments ("SLS", pre, post, where, a_feature_i)
		end

	dynamic_spec_of_routine (pre: EIFFEL_COMMENTS; post: EIFFEL_COMMENTS; where: STRING; a_feature_i: !FEATURE_I): JS_OUTPUT_BUFFER
		local
			sl_spec: JS_OUTPUT_BUFFER
			sld_spec: JS_OUTPUT_BUFFER
		do
			sl_spec := spec_from_comments ("SL", pre, post, where, a_feature_i)
			sld_spec := spec_from_comments ("SLD", pre, post, where, a_feature_i)
			if sl_spec.string.is_empty then
				Result := sld_spec
			elseif sld_spec.string.is_empty then
				Result := sl_spec
			else
				sl_spec.append_lines ("andalso " + sld_spec.string)
				Result := sl_spec
			end
		end

	spec_from_comments (tag: STRING; pre: EIFFEL_COMMENTS; post: EIFFEL_COMMENTS; where: STRING; a_feature_i: !FEATURE_I): JS_OUTPUT_BUFFER
		local
			i: INTEGER
			comment_tag_list: LINKED_LIST [STRING]
			comment_tag: STRING
			pre_with_comment_tag: STRING
			post_with_comment_tag: STRING
			is_spec_empty: BOOLEAN
		do
			create Result.make
			is_spec_empty := True

			create comment_tag_list.make
			from i := 9 until i = 0 loop
				comment_tag_list.put_front (tag.twin + i.out)
				i := i - 1
			end
			comment_tag_list.put_front (tag.twin)

			from
				comment_tag_list.start
			until
				comment_tag_list.off
			loop
				comment_tag := comment_tag_list.item
				pre_with_comment_tag := assertion_from_comments (comment_tag, pre, where.twin + " " + comment_tag + " precondition", a_feature_i)
				post_with_comment_tag := assertion_from_comments (comment_tag, post, where.twin + " " + comment_tag + " postcondition", a_feature_i)

				if pre_with_comment_tag.is_empty and then post_with_comment_tag.is_empty then
					-- Do nothing: the most common case
				elseif not pre_with_comment_tag.is_empty and then not post_with_comment_tag.is_empty then
					if not is_spec_empty then
						Result.put_new_line
						Result.put_indentation
						Result.put ("andalso ")
					else
						is_spec_empty := False
						Result.put_indentation
					end
					Result.put ("{" + pre_with_comment_tag + "}")
					Result.put_new_line
					Result.put_indentation
					Result.put ("{" + post_with_comment_tag + "}")
				elseif pre_with_comment_tag.is_empty then
					error (where.twin + " " + comment_tag + " precondition missing")
				elseif post_with_comment_tag.is_empty then
					error (where.twin + " " + comment_tag + " postcondition missing")
				end

				comment_tag_list.forth
			end
		end

	assertion_from_comments (comment_tag: STRING; a_comments: EIFFEL_COMMENTS; what: STRING; where: !FEATURE_I): STRING
		local
			sl_prefix: STRING
			l_string: STRING
			sl_assertion: STRING
			l_assertion: JS_ASSERTION_NODE
			l_final_assertion: JS_ASSERTION_NODE
		do
			sl_prefix := comment_tag.twin + "--"

			from
				a_comments.start
				l_final_assertion := Void
			until
				a_comments.off
			loop
				l_string := a_comments.item.content
				if l_string.count >= sl_prefix.count and then equal (l_string.substring (1, sl_prefix.count), sl_prefix) then
					sl_assertion := l_string.substring (sl_prefix.count + 1, l_string.count)

					assertion_parser.reset
					assertion_parser.set_input_buffer (create {YY_BUFFER}.make (sl_assertion))
					assertion_parser.parse
					if assertion_parser.error_count = 0 then
						l_assertion := assertion_parser.assertion

						-- Substitute variables, types & void
						spec_adapter.with_feature_context (where)
						l_assertion.accept (spec_adapter)

						if l_final_assertion = Void then
							l_final_assertion := l_assertion
						else
							l_final_assertion := create {JS_STAR_NODE}.make (l_final_assertion, l_assertion)
						end

					else
						error ("Error parsing " + what + ": " + sl_assertion)
					end
				end
				a_comments.forth
			end

			if l_final_assertion /= Void then
				-- Now pretty print the AST
				spec_printer.reset
				l_final_assertion.accept (spec_printer)
				Result := spec_printer.output
			else
				Result := ""
			end
		end

	collect_specs_of_normal_routines (a_class: !CLASS_C)
		local
			l_feature: FEATURE_I
			l_attached_feature: !FEATURE_I
		do
			if a_class.has_feature_table then
				from
					a_class.feature_table.start
				until
					a_class.feature_table.after
				loop
					l_feature := a_class.feature_table.item_for_iteration
					check l_feature /= Void end
					l_attached_feature := l_feature

						-- Only write routines which are written in that class, and that are not creation routines
					if l_feature.is_routine and then l_feature.written_in = a_class.class_id and {body: !FEATURE_AS} l_attached_feature.body then
						if (a_class.creators = Void) or else (not a_class.creators.has_key (l_attached_feature.feature_name)) then
							collect_spec_of_routine (False, body, l_attached_feature)
						end
					end

					a_class.feature_table.forth
				end
			end
		end

	collect_specs_of_creation_routines (a_class: !CLASS_C)
		local
			l_creator_name: STRING
			l_feature: FEATURE_I
			l_attached_feature: !FEATURE_I
			l_feature_body: FEATURE_AS
			l_attached_feature_body: !FEATURE_AS
		do
			if a_class.creators /= Void then
				from
					a_class.creators.start
				until
					a_class.creators.after
				loop
					l_creator_name := a_class.creators.key_for_iteration

					l_feature := a_class.feature_named (l_creator_name)
					check l_feature /= Void end
					l_attached_feature := l_feature

					l_feature_body := l_attached_feature.body
					check l_feature_body /= Void end
					l_attached_feature_body := l_feature_body

						-- Check if creation routine is not yet generated. This can happen if a subclass
						-- uses the same feature as a creation routine as the parent.
					--if not feature_list.is_creation_routine_already_generated (l_attached_feature) then
						collect_spec_of_routine (True, l_attached_feature_body, l_attached_feature)
					--end

					a_class.creators.forth

				end
			end
		end

end
