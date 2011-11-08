indexing
	description:
		"[
			Parser for Boogie output.
			TODO: It's not nice that this class adds stuff to the output panel. 
			      It should just parse it and give parsed information to someone else.
		]"
	date: "$Date$"
	revision: "$Revision$"

class EP_BOOGIE_OUTPUT_PARSER

inherit

	SHARED_EP_ENVIRONMENT
		export {NONE} all end

	SHARED_WORKBENCH
		export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make (a_boogie_input, a_boogie_output: STRING)
			-- Initialize output parser with input given to Boogie and produced output.
		require
			a_boogie_input_not_void: a_boogie_input /= Void
			a_boogie_output_not_void: a_boogie_output /= Void
		do
			input_lines := a_boogie_input.split ('%N')
			output_lines := a_boogie_output.split ('%N')
		end

feature -- Basic operations

	parse
			-- Parse Boogie output.
		local
			l_line: STRING
		do
			from
				output_lines.start
			until
				output_lines.after
			loop
				l_line := output_lines.item
				l_line.right_adjust

				if not l_line.is_empty then
					if version_regexp.matches (l_line) then
						handle_version (version_regexp.captured_substring (1))
					elseif finished_regexp.matches (l_line) then
						handle_finished (
							finished_regexp.captured_substring (1),
							finished_regexp.captured_substring (2))
					elseif verifying_regexp.matches (l_line) then
						handle_verifying (
							verifying_regexp.captured_substring (1),
							verifying_regexp.captured_substring (2),
							verifying_regexp.captured_substring (3))
					elseif verified_regexp.matches (l_line) then
						handle_verified (
							verified_regexp.captured_substring (1),
							verified_regexp.captured_substring (2))
					elseif error_regexp.matches (l_line) then
						handle_error (
							error_regexp.captured_substring (1),
							error_regexp.captured_substring (2),
							error_regexp.captured_substring (3),
							error_regexp.captured_substring (4),
							error_regexp.captured_substring (5))
					elseif related_regexp.matches (l_line) then
						handle_related (
							related_regexp.captured_substring (1),
							related_regexp.captured_substring (2),
							related_regexp.captured_substring (3),
							related_regexp.captured_substring (4))
					elseif syntax_error_regexp.matches (l_line) then
						handle_syntax_error (
							syntax_error_regexp.captured_substring (1),
							syntax_error_regexp.captured_substring (2),
							syntax_error_regexp.captured_substring (3),
							syntax_error_regexp.captured_substring (4))
					elseif semantic_error_regexp.matches (l_line) then
						handle_syntax_error (
							semantic_error_regexp.captured_substring (1),
							semantic_error_regexp.captured_substring (2),
							semantic_error_regexp.captured_substring (3),
							semantic_error_regexp.captured_substring (4))
					else
						-- Ignored line
					end
				end

				output_lines.forth
			end
		end

feature {NONE} -- Implementation

	input_lines: LIST [STRING]
			-- Boogie input lines

	output_lines: LIST [STRING]
			-- Boogie output lines

	last_error: EP_ERROR
			-- Last verification error

	current_class: CLASS_C
			-- Current class

	current_feature: FEATURE_I
			-- Current feature

	current_feature_errors: LIST [EP_ERROR]
			-- List of errors of current feature	

feature {NONE} -- Implementation

	handle_version (a_version: STRING)
			-- Handle version information.
		do
			eve_proofs.put_output_message (names.message_boogie_version (a_version))
		end

	handle_finished (a_verified, a_errors: STRING)
			-- Handle verification finished information.
		do
			eve_proofs.put_output_message (names.message_boogie_finished (a_verified, a_errors))
		end

	handle_verifying (a_type, a_class, a_feature: STRING)
			-- Handle verifying information.
		local
			l_class: CLASS_I
			l_feature: E_FEATURE
			l_feature_name: STRING
		do
			l_class := universe.classes_with_name (a_class).first

			if a_feature.has ('$') then
					-- It's a mangled operator
				l_feature_name := name_generator.feature_name_for_mangled_operator (a_feature)
			else
				l_feature_name := a_feature
			end

			l_feature := l_class.compiled_class.feature_with_name (l_feature_name)

			current_class := l_class.compiled_class
			current_feature := current_class.feature_named (l_feature_name)

			check current_class /= Void end
			check current_feature /= Void end

			create {LINKED_LIST [EP_ERROR]}current_feature_errors.make
		end

	handle_verified (a_time, a_result: STRING)
			-- Handle verified information.
		local
			l_milliseconds: NATURAL
		do
			if a_time.is_real then
				l_milliseconds := (a_time.to_real * 1000.0).truncated_to_integer.to_natural_32
			end
			if a_result.is_equal ("error") or a_result.is_equal ("errors") then
				check not current_feature_errors.is_empty end

				event_handler.add_proof_failed_event (current_class, current_feature, current_feature_errors, l_milliseconds)
			else
				check a_result.is_equal ("verified") end

				event_handler.add_proof_successful_event (current_class, current_feature, l_milliseconds)
			end
			last_error := Void
		end


	handle_error (a_file, a_line, a_column, a_error, a_message: STRING)
			-- Handle error output.
		local
			l_source_line: STRING
		do
			l_source_line := input_lines.i_th (a_line.to_integer)
			if a_error.is_equal ("BP5001") then
				handle_assertion_error (a_line.to_integer, l_source_line)
			elseif a_error.is_equal ("BP5002") then
				handle_precondition_error (a_line.to_integer)
			elseif a_error.is_equal ("BP5003") then
				handle_postcondition_error (a_line.to_integer)
			else
				create {EP_GENERAL_ERROR} last_error.make (names.error_unknown_verification_error)
				last_error.set_description (names.description_unknown_verification_error)
				errors.extend (last_error)
			end
		end

	handle_assertion_error (a_source_line_number: INTEGER; a_source_line: STRING)
			-- Handle assertion error.
		local
			l_type: STRING
			l_verification_error: EP_VERIFICATION_ERROR
		do
			if assert_regexp.matches (a_source_line) then
				l_type := assert_regexp.captured_substring (2)
				if l_type.is_equal ("check") then
					create l_verification_error.make (names.error_check_violation)
					l_verification_error.set_description (names.description_check_violation)
					l_verification_error.set_class (current_class)
					l_verification_error.set_feature (current_feature)
				elseif l_type.is_equal ("loop") then
					create l_verification_error.make (names.error_loop_invariant_violation)
					l_verification_error.set_description (names.description_loop_invariant_violation)
					l_verification_error.set_class (current_class)
					l_verification_error.set_feature (current_feature)
				elseif l_type.is_equal ("attached") then
						-- TODO: internationalization
					create l_verification_error.make ("Target may not be attached")
					l_verification_error.set_description ("Target of feature call may not be attached")
					l_verification_error.set_class (current_class)
					l_verification_error.set_feature (current_feature)
					l_verification_error.set_position (instruction_line_position (a_source_line_number), 0)
				else
					check false end
				end
				if assert_regexp.captured_substring (4).is_integer then
					l_verification_error.set_position (assert_regexp.captured_substring (4).to_integer, 0)
				end
				if assert_regexp.match_count > 5 then
					l_verification_error.set_tag (assert_regexp.captured_substring (6))
				end
				last_error := l_verification_error
				current_feature_errors.extend (l_verification_error)
			else
				check false end
			end

			errors.extend (last_error)
		end

	handle_precondition_error (a_source_line_number: INTEGER)
			-- Handle precondition error.
		do
			create {EP_VERIFICATION_ERROR} last_error.make (names.error_precondition_violation)
			last_error.set_description (names.description_precondition_violation)
			last_error.set_class (current_class)
			last_error.set_feature (current_feature)
			last_error.set_position (instruction_line_position (a_source_line_number), 0)
			current_feature_errors.extend (last_error)
			errors.extend (last_error)
		end

	handle_postcondition_error (a_source_line_number: INTEGER)
			-- Handle postcondition error.
		do
				-- We have to look at the related section to know what happened
		end

	handle_related (a_file, a_line, a_column, a_message: STRING)
			-- Handle related information of an error.
		local
			l_type, l_tag: STRING
			l_verification_error: EP_VERIFICATION_ERROR
		do
			if assert_regexp.matches (input_lines.i_th (a_line.to_integer)) then

				if assert_regexp.match_count > 5 then
					l_tag := assert_regexp.captured_substring (6)
				end

				l_type := assert_regexp.captured_substring (2)
				if l_type.is_equal ("pre") then
					l_verification_error ?= last_error
					check l_verification_error /= Void end

					if assert_regexp.captured_substring (4).is_integer then
							-- Assertion has line number of precondition (it's generated automatically)
						l_verification_error.set_associated_feature (feature_at_position (a_line.to_integer))
					elseif assert_regexp.captured_substring (4).is_equal ("combined") then
							-- It's a weakend precondition
						l_verification_error.set_associated_feature (feature_at_position (a_line.to_integer))
							-- TODO: internationalization + better description
						l_tag := "weakend precondition"
					elseif assert_regexp.captured_substring (4).is_equal ("predicate") then
							-- It's the precondition predicate
						l_verification_error.set_associated_feature (feature_at_position (a_line.to_integer))
					else
							-- Assertion has feature name of precondition (it's part of the theory)
						l_verification_error.set_associated_feature (feature_with_name (assert_regexp.captured_substring (3), assert_regexp.captured_substring (4)))
					end
					if l_tag /= Void then
						l_verification_error.set_tag (l_tag)
					end
				elseif l_type.is_equal ("post") then
					create l_verification_error.make (names.error_postcondition_violation)
					l_verification_error.set_description (names.description_postcondition_violation)
					l_verification_error.set_class (current_class)
					l_verification_error.set_feature (current_feature)
					l_verification_error.set_position (assert_regexp.captured_substring (4).to_integer, 0)
					if l_tag /= Void then
						l_verification_error.set_tag (l_tag)
					end
					current_feature_errors.extend (l_verification_error)
					errors.extend (l_verification_error)
					last_error := l_verification_error
				elseif l_type.is_equal ("inv") then
					create l_verification_error.make (names.error_invariant_violation)
					l_verification_error.set_description (names.description_invariant_violation)
					l_verification_error.set_class (current_class)
					l_verification_error.set_feature (current_feature)
					l_verification_error.set_position (assert_regexp.captured_substring (4).to_integer, 0)
					if l_tag /= Void then
						l_verification_error.set_tag (l_tag)
					end
					current_feature_errors.extend (l_verification_error)
					errors.extend (l_verification_error)
					last_error := l_verification_error
				elseif l_type.is_equal ("frame") then
					create {EP_FRAME_ERROR} last_error.make
					last_error.set_class (current_class)
					last_error.set_feature (current_feature)
					current_feature_errors.extend (last_error)
					errors.extend (last_error)
				else
					check false end
				end
			else
				check false end
			end
		end

	handle_syntax_error (a_file, a_line, a_column, a_message: STRING)
			-- Handle syntax error.
		local
			l_error: EP_GENERAL_ERROR
		do
			create l_error.make (names.error_syntax_error)
			l_error.set_description (names.description_syntax_error)

			errors.extend (l_error)
		end

	instruction_line_position (a_source_line_number: INTEGER): INTEGER
			-- Line position of instruction at `a_source_line_number'
		local
			l_found: BOOLEAN
		do
			from
				input_lines.go_i_th (a_source_line_number)
			until
				l_found
			loop
				if instruction_location_regexp.matches (input_lines.item) then
					Result := instruction_location_regexp.captured_substring (3).to_integer
					l_found := True
				end
				input_lines.back
			end
		end

	feature_at_position (a_source_line_number: INTEGER): FEATURE_I
			-- Feature at the source line location `a_source_line_number'
		local
			l_found: BOOLEAN
		do
			from
				input_lines.go_i_th (a_source_line_number)
			until
				l_found
			loop
				if procedure_name_regexp.matches (input_lines.item) then
					Result := feature_with_name (procedure_name_regexp.captured_substring (2), procedure_name_regexp.captured_substring (3))
					l_found := True
				end
				input_lines.back
			end
		end

	feature_with_name (a_class_name, a_feature_name: STRING): FEATURE_I
			-- Feature with name `a_feature_name' in class `a_class_name'
		require
			a_class_name_not_void: a_class_name /= Void
			a_feature_name_not_void: a_feature_name /= Void
		local
			l_class: CLASS_C
		do
			l_class := system.universe.classes_with_name (a_class_name).first.compiled_class
			check l_class /= Void end
			Result := l_class.feature_named (a_feature_name)
			check Result /= Void end
		end

feature {NONE} -- Regular expressions

	version_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression for version information line.
		once
			create Result.make
			Result.compile ("^Boogie program verifier version ([^,]*).*$")
		end

	finished_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression for finsihed line.
		once
			create Result.make
			Result.compile ("^Boogie program verifier finished with ([0-9]*) verified, ([0-9]*) errors?$")
		end

	verifying_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression for verifying section.
		once
			create Result.make
			Result.compile ("^Verifying\s*(\w+)\.(\w+)\.([\w$]+).*$")
		end

	verified_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression for verified information line.
		once
			create Result.make
			Result.compile ("^\s*\[([0-9.]*)\s*s\]\s*(\w+)\s*$")
		end

	error_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression for error line.
		once
			create Result.make
			Result.compile ("^(.*)\(([0-9]*),([0-9]*)\): Error (.*): (.*)$")
		end

	related_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression for related information line.
		once
			create Result.make
			Result.compile ("^(.*)\(([0-9]*),([0-9]*)\): Related location: (.*)$")
		end

	syntax_error_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression syntax error line.
		once
			create Result.make
			Result.compile ("^(.*)\(([0-9]*),([0-9]*)\): syntax error: (.*)$")
		end

	semantic_error_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression for error line.
		once
			create Result.make
			Result.compile ("^(.*)\(([0-9]*),([0-9]*)\): Error: (.*)$")
		end

	assert_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression assertion information in Boogie source.
		once
			create Result.make
			Result.compile ("^(.*)// (\w+) (\w+):(\w+)(\s*tag:(\w*))?$")
		end

	instruction_location_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression assertion for instruction location in Boogie source.
		once
			create Result.make
			Result.compile ("^\s*// (.*) --- (.*):(\d+)$")
		end

	procedure_name_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Regular expression assertion for instruction location in Boogie source.
		once
			create Result.make
			Result.compile ("^procedure (proc|create)\.(\w*)\.(\w*)\(.*$")
		end

end
