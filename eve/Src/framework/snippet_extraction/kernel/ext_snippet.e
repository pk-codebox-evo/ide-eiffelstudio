note
	description: "Class that represents an extracted snippet"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXT_SNIPPET

inherit
	KL_SHARED_STRING_EQUALITY_TESTER

	EPA_SHARED_EQUALITY_TESTERS

	HASHABLE

	DEBUG_OUTPUT

create
	make

feature{NONE} -- Initialization

	make (a_operands: like operands; a_content: like content; a_holes: like holes; a_source: STRING)
			-- Initialize Current.
		require
			not_a_content_is_empty: not a_content.is_empty
		do
			create operands.make (a_operands.count)
			operands.set_key_equality_tester (string_equality_tester)
			operands.set_equality_tester (type_name_equality_tester)
			a_operands.do_all_with_key (agent operands.force_last)

			content := a_content.twin
			source := a_source.twin

			build_debug_output
			hash_code := debug_output.hash_code
		end

feature -- Access

	operands: DS_HASH_TABLE [TYPE_A, STRING]
			-- Operands appearing in current snippet
			-- Keys are variable names (in lower case), values are types of those
			-- variables.

	holes: DS_HASH_TABLE [EXT_HOLE, STRING]
			-- Set of holes in current snippet
			-- Keys are names of holes, values are the holes.

	content: STRING
			-- Textual representation of current snippet.
			-- The content should be a parse-able string.

	source: STRING
			-- The source where current snippet come from
			-- Format: file@revision@line

	ast: detachable AST_EIFFEL
			-- AST representation of `content'
		do
			if ast_internal = Void then
				parser.parse_from_ascii_string (dummy_feature_for_content, Void)
				if attached {FEATURE_AS} parser.feature_node as l_feat then
					if attached {BODY_AS} l_feat.body as l_body then
						if attached {ROUTINE_AS} l_body.content as l_routine then
							if attached {DO_AS} l_routine.routine_body as l_do then
								ast_internal := l_do.compound
							end
						end
					end
				end
			end
			Result := ast_internal
		end

	hash_code: INTEGER
			-- Hash code value

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.

feature{NONE} -- Implementation

	ast_internal: detachable like ast
			-- Cache for `ast'

	parser: EPA_EIFFEL_PARSER
			-- Parser used for parsing expressions
		once
			create Result.make_with_factory (create {EPA_EXPRESSION_AST_FACTORY})
			Result.set_expression_parser
		end

	dummy_feature_for_content: STRING
			-- Dummy feature for `content'
		do
			create Result.make (content.count + 20)
			Result.append (once "feature dummy_feature do%N")
			Result.append (content)
			Result.append_character ('%N')
			Result.append (once "end")
		end

	build_debug_output
			-- Build `debug_output'.
		local
			l_cursor: like operands.new_cursor
			l_output: STRING
		do
			create debug_output.make (128)
			l_output := debug_output

				-- Build operands and their types.
			from
				l_cursor := operands.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_output.append (l_cursor.key)
				l_output.append_character (':')
				l_output.append_character (' ')
				l_output.append (output_type_name (l_cursor.item.name))
				l_output.append_character ('%N')
				l_cursor.forth
			end
			l_output.append_character ('%N')

				-- Build `content'.
			l_output.append (content)
			l_output.append_character ('%N')
			l_output.append_character ('%N')

				-- Build `source'.
			l_output.append (source)
		end

end
