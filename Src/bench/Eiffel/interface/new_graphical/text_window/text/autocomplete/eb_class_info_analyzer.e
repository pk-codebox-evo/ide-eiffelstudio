indexing
	description: "Objects that analyze class text to make it clickable and allow automatic completion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CLASS_INFO_ANALYZER

inherit
	ANY

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_TMP_SERVER
		export
			{NONE} all
		end

	SHARED_INST_CONTEXT
		export
			{NONE} all
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	PREFIX_INFIX_NAMES
		export
			{NONE} all
		end

	SHARED_RESCUE_STATUS
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	EB_TOKEN_TOOLKIT
		export
			{NONE} all
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature -- Access

	current_class_name: STRING
			-- name of analyzed class

	cluster_name: STRING
			-- name of cluster which contains analyzed class

	content: CLICKABLE_TEXT
			-- text currently displayed

	current_class_as: CLASS_AS
			-- CLASS_AS object corresponding to the edited class text

	last_syntax_error: SYNTAX_ERROR
			-- last syntax error (found by generate_ast)

feature -- Status report

	can_analyze_current_class: BOOLEAN
			-- can current class text be analyzed ?

	is_ready: BOOLEAN
		-- is the analysis completed ?


feature -- Basic operations

	stone_at_position (cursor: TEXT_CURSOR): STONE is
			-- Return stone associated with position pointed by `cursor', if any
		require
			cursor_not_void: cursor /= Void
		deferred
		end

feature -- Element change

	clear_syntax_error is
			-- wipe out `last_syntax_error'
		do
			last_syntax_error := Void
		end

feature -- Analysis preparation

	update is
		deferred
		end

feature -- Reinitialization

	reset is
			-- set class attributes to default values
		do
			current_class_i := Void
			--if Workbench.system_defined then
			--	System.set_current_class (Void)
			--end
			current_class_name := Void
			cluster_name := Void
			content := Void
			is_ready := False
			pos_in_file := 1
		end

	reset_after_search is
			-- set attributes related to search to default values
		do
			error := False
			current_token := Void
			searched_token := Void
			current_line := Void
			searched_line := Void
			current_class_i := Void
			--if Workbench.system_defined then
			--	System.set_current_class (Void)
			--end
			current_feature_as := Void
			found_class := Void
		end

feature {NONE} -- Private Access

	pos_in_file: INTEGER
			-- position in file of processed_token

	searched_token: EDITOR_TOKEN
			-- token which was clicked or which is to be completed

	searched_line: EDITOR_LINE
			-- line containing `searched_token'

	current_feature_as: FEATURE_AS
			-- `FEATURE_AS' corresponding to the feature containing `searched_token'

feature {EB_ADDRESS_MANAGER} -- Private Access

	current_token: EDITOR_TOKEN
			-- token being analyzed

	current_line: EDITOR_LINE
			-- line containing `current_token'

feature {NONE} -- Private Status

	error: BOOLEAN
			-- did an error occur ?

feature {NONE} -- Click ast exploration

	clickable_position_list: ARRAY [EB_CLICKABLE_POSITION]
			-- list of clickable positions

	make_click_list_from_ast is
			-- build the click list from information in the CLASS_C object.
		local
			pos, i, j, pos_in_txt, c: INTEGER
			a_click_ast: CLICK_AST
			clickable: CLICKABLE_AST
			clickable_position: EB_CLICKABLE_POSITION
			ast_list: CLICK_LIST
			a_class: CLASS_I
			prov_list: LINKED_LIST [EB_CLICKABLE_POSITION]
			f_name: FEATURE_NAME
			inherit_clauses: SORTABLE_ARRAY [INTEGER]
			parents: EIFFEL_LIST [PARENT_AS]
			class_name: STRING
			has_parents: BOOLEAN
		do
			initialize_context
			if current_class_i /= Void then
				parents := current_class_as.parents
				has_parents := parents /= Void
				if has_parents then
					create inherit_clauses.make (1, parents.count + 1)
					from
						parents.start
						i := 1
					until
						parents.after
					loop
						inherit_clauses.put (parents.item.start_position, i)
						parents.forth
						i := i + 1
					end
					inherit_clauses.put (current_class_as.inherit_clause_insert_position, i)
					inherit_clauses.sort
				end
				ast_list := current_class_as.click_list
				if ast_list /= Void then
					c := ast_list.count
					create prov_list.make
					from
						pos := 1
					until
						pos > c
					loop
						a_click_ast := ast_list.i_th (pos)
						clickable := a_click_ast.node
						if clickable.is_class or else clickable.is_precursor then
							a_class := clickable_info.associated_eiffel_class (current_class_i, clickable)
							if a_class /= Void then
								create clickable_position.make (a_click_ast.start_position, a_click_ast.end_position)
								clickable_position.set_class (a_class.name)
								prov_list.extend (clickable_position)
							end
						elseif clickable.is_feature then
							f_name ?= clickable
							class_name := Void
							if f_name /= Void and has_parents then
								pos_in_txt := a_click_ast.start_position
								if pos_in_txt < inherit_clauses @ i then
									from
										j := 1
									until
										j = i or else pos_in_txt < inherit_clauses @ j
									loop
										j := j + 1
									end
									if j /= 1 and then pos_in_txt < inherit_clauses @ j then
										a_class := clickable_info.
											associated_eiffel_class (current_class_i, parents.i_th (j - 1).type)
										if a_class /= Void then
											class_name := a_class.name
										else
											class_name := Void
										end
									end
								end
							end
							if class_name = Void then
								class_name := current_class_name
							end
							create clickable_position.make (a_click_ast.start_position, a_click_ast.end_position)
							clickable_position.set_feature (class_name, clickable.feature_name)
							prov_list.extend (clickable_position)
						end
						pos := pos + 1
					end
				end
				create clickable_position_list.make (1, prov_list.count)
				from
					prov_list.start
					pos := 1
				until
					prov_list.after
				loop
					clickable_position_list.put (prov_list.item, pos)
					pos := pos + 1
					prov_list.forth
				end
			end
		end

	generate_ast (c: CLASS_C; after_save: BOOLEAN) is
			-- Parse the text of the class `c'. Return True if could parse successfully,
			-- False otherwise
		require
			c_not_void: c /= Void
		local
			retried: BOOLEAN
			prev_class: CLASS_C
		do
			current_class_as := Void
			if retried then
				System.set_current_class (prev_class)
				last_syntax_error ?= Error_handler.error_list.first
				Error_handler.error_list.wipe_out
			else
				if not c.is_precompiled then
					if after_save then
						c.parse_ast
						last_syntax_error := c.last_syntax_error
						if last_syntax_error = Void then
							current_class_as := Tmp_ast_server.item (c.class_id)
						end
					else
						last_syntax_error := Void
						prev_class := System.current_class
						System.set_current_class (c)
							-- Build AST without doing a backup
						current_class_as := c.build_ast (False)
						System.set_current_class (prev_class)
					end
				else
					current_class_as := c.most_recent_ast
				end
			end

		rescue
			if Rescue_status.is_error_exception then
				Rescue_status.set_is_error_exception (False)
				retried := True
				retry
			end
		end

feature {NONE}-- Clickable/Editable implementation

	stone_in_click_ast (a_position: INTEGER): STONE is
			-- search in the click_ast for a stone to associate with `a_position' in text
		local
			index_min, index_max, middle: INTEGER
			position: INTEGER
			click_pos: EB_CLICKABLE_POSITION
			class_i: CLASS_I
			feat: E_FEATURE
		do
			if clickable_position_list /= Void then
				index_min := 1
				index_max := clickable_position_list.count
				if a_position >= (clickable_position_list @ 1).start then
						-- search in the list
					if a_position >= (clickable_position_list @ index_max).start then
						index_min := index_max
					else
						from

						until
							index_min >= index_max - 1
						loop
							middle := index_min + (index_max - index_min) // 2
							position := (clickable_position_list @ middle).start
							if position > a_position then
								index_max := middle
							else
								index_min := middle
							end
						end
					end
					click_pos := clickable_position_list @ index_min
					if a_position <= click_pos.stop then
						if click_pos.is_feature then
							class_i := Universe.class_named (click_pos.class_name, Universe.cluster_of_name (cluster_name))
							if class_i /= Void and then class_i.compiled and then class_i.compiled_class.has_feature_table then
								feat := class_i.compiled_class.feature_with_name (click_pos.feature_name)
								if feat /= Void then
									create {FEATURE_STONE} Result.make (feat)
								end
							end
						elseif click_pos.is_class then
							class_i := Universe.class_named (click_pos.class_name, Universe.cluster_of_name (cluster_name))
							if class_i /= Void then
								if class_i.compiled then
									create {CLASSC_STONE} Result.make (class_i.compiled_class)
								else
									create {CLASSI_STONE} Result.make (class_i)
								end
							end
						end
					end
				end
			end
		end

	described_feature (token: EDITOR_TOKEN; line: EDITOR_LINE; ft: FEATURE_AS): E_FEATURE is
			-- search in feature represented by `ft' the feature associated with `token' if any
		require
			token_not_void: token /= Void
			line_not_void: line /= Void
			token_in_line: line.has_token (token)
		do
			initialize_context
			if current_class_i /= Void and current_class_i.is_compiled then
				if not token_image_is_in_array (token, unwanted_symbols) then
					current_feature_as := ft
					current_token := token
					searched_token := token
					current_line := line
					searched_line := line
					error := False
					find_expression_start
					if not error then
						Result := searched_feature
					end
				end
			end
		end

	searched_feature: E_FEATURE is
			-- analyze class text from `current_token' to find feature associated with `searched_token'
		require
			current_class_i_not_void: current_class_i /= Void
			current_class_i_compiled: current_class_i.is_compiled
		local
			exp: LINKED_LIST [EDITOR_TOKEN]
			name: STRING
			par_cnt: INTEGER
			processed_type: TYPE_A
			processed_class: CLASS_C
			type: TYPE_A
			formal: FORMAL_A
			l_current_class_c: CLASS_C
		do
			from
				l_current_class_c := current_class_i.compiled_class
				processed_type := l_current_class_c.actual_type
				if token_image_is_same_as_word (current_token, Create_word) then
					go_to_next_token
					error := not token_image_is_same_as_word (current_token, Opening_brace)
					if not error then
						go_to_next_token
						error := current_token = Void
						if not error then
							processed_type := type_of_class_corresponding_to_current_token
							skip_parenthesis ('{', '}')
						end
					end
				elseif token_image_is_same_as_word (current_token, Opening_parenthesis) then
						-- if we find a closing parenthesis, we go directly to the corresponding
						-- opening parenthesis
					par_cnt:= 1
					from
						create exp.make
					until
						par_cnt = 0 or else current_token = Void
					loop
						go_to_next_token
						exp.extend (current_token)
						if token_image_is_same_as_word (current_token, Closing_parenthesis) then
							par_cnt:= par_cnt - 1
						elseif token_image_is_same_as_word (current_token, Opening_parenthesis) then
							par_cnt:= par_cnt + 1
						end
					end
					if current_token = Void then
						error := True
					else
						if exp.count > 0 then
							exp.finish
							exp.remove
						end
						processed_type := complete_expression_type (exp)
					end
				else
					name := current_token.image.as_lower
					if name.is_equal (Precursor_word) then
						go_to_next_token
						if token_image_is_same_as_word (current_token, Opening_brace) then
							go_to_next_token
							error := error or else current_token = Void
							if not error then
								processed_type := type_of_class_corresponding_to_current_token
								skip_parenthesis ('{', '}')
								if processed_type /= Void and then processed_type.associated_class /= Void then
									if processed_type.associated_class.has_feature_table then
										Result := processed_type.associated_class.feature_with_name (current_feature_as.feature_name)
									end
								end
							end
						else
							go_to_previous_token
							if current_feature_as /= Void and then l_current_class_c.parents /= Void then
								from
									l_current_class_c.parents.start
								until
									Result /= Void or else l_current_class_c.parents.after
								loop
									type := l_current_class_c.parents.item
									if type.associated_class /= Void and then type.associated_class.has_feature_table then
										Result := type.associated_class.feature_with_name (current_feature_as.feature_name)
									end
									l_current_class_c.parents.forth
								end
							end
						end
					elseif l_current_class_c.has_feature_table then
						Result := l_current_class_c.feature_with_name (name)
					end
					if Result = Void then
						processed_type := type_of_local_entity_named (name)
						if processed_type = Void then
							processed_type := type_of_constants_or_reserved_word (current_token)
						end
					else
						error := True
						if Result.type /= Void then
							type := Result.type
							if type.is_formal then
								formal ?= type
								if
									processed_type /= Void and then
									processed_type.has_generics and then
									processed_type.generics.valid_index (formal.position)
								then
									processed_type := processed_type.generics @ (formal.position)
									error := False
								end
							else
								processed_type := type
								error := False
							end
						else
							error := current_token /= searched_token
						end
					end
				end
				go_to_next_token
				if not error and then token_image_is_same_as_word (current_token, Opening_parenthesis) then
					skip_parenthesis ('(', ')')
					go_to_next_token
				end
				if not error then
					if after_searched_token then
						error := error or else processed_type = Void
					else
						error := error or else processed_type = Void or else not token_image_is_in_array (current_token, feature_call_separators)
						go_to_next_token
					end
				end
			until
				error or else after_searched_token
			loop
				name := current_token.image.as_lower
				processed_class := processed_type.associated_class
				error := True
				if processed_class /= Void  and then processed_class.has_feature_table then
					Result := processed_class.feature_with_name (name)
					if Result /= Void then
						if Result.type /= Void then
							type := Result.type
							if type.is_formal then
								formal ?= type
								if
									processed_type /= Void and then
									processed_type.has_generics and then
									processed_type.generics.valid_index (formal.position)
								then
									processed_type := processed_type.generics @ (formal.position)
									error := False
								end
							else
								processed_type := type
								error := False
							end
						else
							error := current_token /= searched_token
						end
					end
				end
				go_to_next_token
				if token_image_is_same_as_word (current_token, Opening_parenthesis) then
					skip_parenthesis ('(', ')')
					go_to_next_token
				end
				error := error or else not (after_searched_token or else token_image_is_same_as_word (current_token, Period))
				go_to_next_token
			end
			if error then
				Result := Void
			end
		end

feature {NONE}-- Implementation

	feature_part_at (a_token: EDITOR_TOKEN; a_line: EDITOR_LINE): INTEGER is
			-- find in which part of the feature body `a_token' is
		local
			found: BOOLEAN
			token: EDITOR_TOKEN
			line: EDITOR_LINE
		do
			Result := no_interesting_part
			from
				token := a_token
				line := a_line
			until
				token = Void or found
			loop
				if is_keyword (token) then
					if token_image_is_in_array (token, feature_body_keywords) then
						found := True
						if token_image_is_in_array (token, feature_contract_keywords) then
							Result := assertion_part
						elseif token_image_is_in_array (token, feature_executable_keywords) then
							Result := instruction_part
						elseif token_image_is_in_array (token, feature_local_keywords) then
							Result := local_part
						end
					end
				end
				if token = line.first_token then
					if line.previous = Void then
						token := Void
					else
						line := line.previous
						token := line.eol_token
					end
				else
					token := token.previous
				end
			end
		end

	assertion_part: INTEGER is unique

	instruction_part: INTEGER is unique

	local_part: INTEGER is unique

	no_interesting_part: INTEGER is unique

	find_expression_start is
			-- find where to begin the analysis (set current_token/line)
		local
			par_cnt: INTEGER
			stop, stop_loop: BOOLEAN
		do
			go_to_previous_token
			if current_token /= Void then
				if
						-- not the "~feature" case
					current_token.image.is_empty
						or else
					current_token.image @ 1 /= '%L'
						or else
					not is_beginning_of_expression (current_token.previous)
				then
					from
					until
						error or stop_loop or else not token_image_is_in_array (current_token, feature_call_separators)
					loop
						go_to_previous_token
						stop := False
						if token_image_is_same_as_word (current_token, Closing_parenthesis) then
								-- if we find a closing parenthesis, we go directly to the corresponding
								-- opening parenthesis
							from
								par_cnt:= - 1
							until
								par_cnt = 0 or else current_token = Void
							loop
								go_to_previous_token
								if token_image_is_same_as_word (current_token, Closing_parenthesis) then
									par_cnt:= par_cnt - 1
								elseif token_image_is_same_as_word (current_token, Opening_parenthesis) then
									par_cnt:= par_cnt + 1
								end
							end
							error := current_token = Void
								-- we reached the closing parenthesis
								-- we go back one token further if parenthesis seem to be arguments
							go_to_previous_token
							stop := token_image_is_in_array (current_token, closing_separators) or else
								token_image_is_in_array (current_token, parenthesis) or else
									(is_keyword (current_token) and then not token_image_is_in_array (current_token, special_keywords))
						end
						if not stop then
								-- special case with "create" and "Precursor"
							if token_image_is_same_as_word (current_token, Closing_brace) then
								from
									par_cnt:= - 1
								until
									par_cnt = 0 or else current_token = Void
								loop
									go_to_previous_token
									if token_image_is_same_as_word (current_token, Closing_brace) then
										par_cnt:= par_cnt - 1
									elseif token_image_is_same_as_word (current_token, Opening_brace) then
										par_cnt:= par_cnt + 1
									end
								end
								go_to_previous_token
								error := current_token = Void or else not token_image_is_in_array (current_token, special_keywords)
							end
							go_to_previous_token
						end
					end
				end
					-- loop stopped : we went one token too far
				go_to_next_token
			end
			error := current_token = Void or else error
		end

	complete_expression_type (exp: LINKED_LIST[EDITOR_TOKEN]): TYPE_A is
			-- analyze expression represented by list of token `exp'
		require
			exp_not_void: exp /= Void
			current_class_i_not_void: current_class_i /= Void
			current_class_i_compiled: current_class_i.is_compiled
		local
			sub_exp: like exp
			infix_expected: BOOLEAN
			infix_list: ARRAYED_LIST[STRING]
			expression_table: ARRAYED_LIST [LINKED_LIST[EDITOR_TOKEN]]
			type_list: LINKED_LIST [TYPE_A]
			par_cnt: INTEGER
			stop: BOOLEAN
		do
				-- first, we check that the expression can be analyzed, i.e. there is a sequence
				-- sub_expression infix sub_expression ...
				-- we store those sub_expression in `expression_table'
			from
				exp.start
				create infix_list.make(0)
				create expression_table.make(0)
			until
				exp.after or else error
			loop
				if infix_expected then
						-- the infix must be in our list
						-- otherwise, we will not analyze this expression
					if is_known_infix (exp.item) then
						infix_list.extend (exp.item.image)
					else
						error := True
					end
					exp.forth
					infix_expected := False
				else
					from
					until
						exp.after or else not is_known_prefix (exp.item)
					loop
--| FIXME ? 						-- as for all known prefix the returned type equals to the base type,
							-- we forget about them
						exp.forth
					end
					create sub_exp.make
					stop := False
					error := exp.after
					if not error then
						if token_image_is_same_as_word (exp.item, Opening_parenthesis) then
								-- if there is a parenthesis, we fill the new `sub_exp' with what's inside
							from
								par_cnt := 1
								sub_exp.extend (exp.item)
							until
								par_cnt = 0 or else exp.after
							loop
								exp.forth
								if not exp.after then
									sub_exp.extend (exp.item)
									if token_image_is_same_as_word (exp.item, Closing_parenthesis) then
										par_cnt := par_cnt - 1
									elseif token_image_is_same_as_word (exp.item, Opening_parenthesis) then
										par_cnt := par_cnt + 1
									end
								end
							end
							if exp.after or else sub_exp.count < 1 then
								error := True
							else
								exp.forth
									-- we now look if there is a feature call after closing parenthesis
								if not exp.after then
									if token_image_is_in_array (exp.item, feature_call_separators) then
										sub_exp.extend (exp.item)
										exp.forth
										if exp.after then
											error := True
										end
									else
										stop := True
									end
								end
							end
						end
					end
					from

					until
						error or else exp.after or else stop
					loop
						sub_exp.extend (exp.item)
						exp.forth
							-- if it is a function, we skip the arguments
							-- we do not need them to knw the returned type
						if not exp.after then
							if token_image_is_same_as_word (exp.item, Opening_parenthesis) then
								from
									par_cnt := 1
								until
									par_cnt = 0 or else exp.after
								loop
									exp.forth
									if token_image_is_same_as_word (exp.item, Closing_parenthesis) then
										par_cnt := par_cnt - 1
									elseif token_image_is_same_as_word (exp.item, Opening_parenthesis) then
										par_cnt := par_cnt + 1
									end
								end
								if exp.after then
									error := True
								else
									exp.forth
								end
							end
							if not exp.after then
								if token_image_is_in_array (exp.item, feature_call_separators) then
									sub_exp.extend (exp.item)
									exp.forth
									if exp.after then
										error := True
									end
								else
									stop := True
								end
							end
						end
					end
					if not error then
						expression_table.extend (sub_exp)
						infix_expected := True
					end
				end
			end
			error := error or else not infix_expected
			if not error then
				type_list := corresponding_type_list (expression_table)
				if type_list /= Void then
					if type_list.count = 1 then
						Result := type_list.first
					elseif type_list.count = infix_list.count + 1 then
						Result := expression_type (type_list, infix_list)
					end
				end
			end
		end

	expression_type (type_list: LINKED_LIST [TYPE_A]; infix_list: ARRAYED_LIST[STRING]): TYPE_A is
			-- find type of expression represented by the list of operands type `type_list' and list of operators `infix_list'
		require
			infix_list_not_void: infix_list /= Void
			type_list_not_void: type_list /= Void
			current_class_i_not_void: current_class_i /= Void
			current_class_i_compiled: current_class_i.is_compiled
		local
			priority: LINKED_LIST[INTEGER]
			index: INTEGER
		do
			create priority.make
			from
				infix_groups.start
			until
				infix_groups.after
			loop
				infix_groups.item.compare_objects
				from
					infix_list.start
				until
					infix_list.after
				loop
					if infix_groups.item.has (infix_list.item) then
						priority.extend (infix_list.index)
					end
					infix_list.forth
				end
				infix_groups.forth
			end
			from

			until
				error or priority.is_empty
			loop
				priority.start
				type_list.start
				index := priority.item
				priority.remove
				from
					priority.start
				until
					priority.after
				loop
					if priority.item > index then
						priority.replace(priority.item - 1)
					end
					priority.forth
				end
				type_list.go_i_th (index)
				infix_list.go_i_th (index)
				Result := type_returned_by_infix (type_list.item, infix_list.item)
				if Result = Void then
					error := True
				else
					type_list.remove
					type_list.replace (Result)
					infix_list.remove
				end
			end
			if error then
				Result := Void
			end
		end

	corresponding_type_list (expression_table: ARRAYED_LIST [LINKED_LIST[EDITOR_TOKEN]]): LINKED_LIST [TYPE_A] is
			-- create list of type from a list of expression (represented by lists of tokens)
		require
			expression_table_not_void: expression_table /= Void
			current_class_i_not_void: current_class_i /= Void
			current_class_i_compiled: current_class_i.is_compiled
		local
			sub_exp, recur_exp: LINKED_LIST[EDITOR_TOKEN]
			type: TYPE_A
			par_cnt: INTEGER
			name: STRING
			processed_class: CLASS_C
			processed_feature: E_FEATURE
			formal: FORMAL_A
			l_current_class_c: CLASS_C
		do
			l_current_class_c := current_class_i.compiled_class
			create Result.make
			from
				expression_table.start
			until
				error or else expression_table.after
			loop
				sub_exp := expression_table.item
				expression_table.forth
				from
					sub_exp.start
					if token_image_is_same_as_word (sub_exp.item, Opening_parenthesis) then
							-- Arguments have not been inserted in this list.
							-- If there are parenthesis, it is an independent expression
						create recur_exp.make
						from
							par_cnt := 1
						until
							par_cnt = 0 or else sub_exp.after
						loop
							sub_exp.forth
							if not sub_exp.after then
								recur_exp.extend (sub_exp.item)
								if token_image_is_same_as_word (sub_exp.item, Closing_parenthesis) then
									par_cnt := par_cnt - 1
								elseif token_image_is_same_as_word (sub_exp.item, Opening_parenthesis) then
									par_cnt := par_cnt + 1
								end
							end
						end
						if sub_exp.after or else recur_exp.count < 1 then
							error := True
						else
								-- recur_exp contains the closing parenthesis. We remove it.
							recur_exp.finish
							recur_exp.remove
							type := complete_expression_type (recur_exp)
						end
					else
							-- type is Void
						name := sub_exp.item.image.as_lower
						if l_current_class_c.has_feature_table then
							processed_feature := l_current_class_c.feature_with_name (name)
						end
						if processed_feature /= Void then
							if processed_feature.type /= Void then
								if processed_feature.type.is_formal then
									formal ?= processed_feature.type
									type := l_current_class_c.actual_type
									if
										type /= Void and then
										type.has_generics and then
										type.generics.valid_index (formal.position)
									then
										type := type.generics @ (formal.position)
										error := False
									end
								else
									type := processed_feature.type
								end
							end
						else
							type := type_of_local_entity_named (name)
							if type = Void then
								type := type_of_constants_or_reserved_word (sub_exp.item)
							end
						end
						error := type = Void
					end
					sub_exp.forth
				until
					error or else sub_exp.after
				loop
					if token_image_is_in_array (sub_exp.item, feature_call_separators) then
						sub_exp.forth
						if sub_exp.after then
							error := True
						else
							name := sub_exp.item.image.as_lower
							processed_class := type.associated_class
							type := Void
							if processed_class /= Void and then processed_class.has_feature_table then
								processed_feature := processed_class.feature_with_name (name)
								if processed_feature /= Void and then processed_feature.type /= Void then
									if processed_feature.type.is_formal then
										formal ?= processed_feature.type
										if
											type /= Void and then
											type.has_generics and then
											type.generics.valid_index (formal.position)
										then
											type := type.generics @ (formal.position)
										end
									else
										type := processed_feature.type
									end
								end
							end
							sub_exp.forth
						end
					else
						type := Void
					end
					error := type = Void
				end
				if not error then
					Result.extend (type)
				end
			end
			if error then
				Result := Void
			end
		end

	type_of_class_corresponding_to_current_token: TYPE_A is
		local
			cc_stone: CLASSC_STONE
			image: STRING
			class_i: CLASS_I
		do
			found_class := Void
			cc_stone ?= stone_in_click_ast (current_token.pos_in_text)
			if cc_stone /= Void and then cc_stone.e_class /= Void then
				found_class := cc_stone.e_class
				Result := found_class.actual_type
			end
			if Result = Void then
				image := current_token.image.as_upper
				class_i := Universe.class_named (image, Universe.cluster_of_name (cluster_name))
				if class_i /= Void and then class_i.compiled then
					found_class := class_i.compiled_class
					Result := found_class.actual_type
				end
			end
		end

	found_class: CLASS_C

	type_returned_by_infix (a_type: TYPE_A; a_name: STRING): TYPE_A is
			-- type returned by operator named `name' applied on type `a_type'
		require
			a_type_not_void: a_type /= Void
			a_name_not_void: a_name /= Void
			current_class_i_not_void: current_class_i /= Void
			current_class_i_compiled: current_class_i.is_compiled
		local
			name: STRING
			feat: E_FEATURE
			cls_c: CLASS_C
			formal: FORMAL_A
		do
			name := a_name.as_lower
			if name.is_equal (Equal_sign) or name.is_equal (Different_sign) then
				create {BOOLEAN_A} Result
			else
				cls_c := a_type.associated_class
				if cls_c /= Void and then cls_c.has_feature_table then
					feat := cls_c.feature_with_name (infix_feature_name_with_symbol (name))
					if feat /= Void and then feat.type /= Void then
						Result := feat.type
						if Result.is_formal then
							formal ?= Result
							if formal /= Void and then a_type.has_generics and then a_type.generics.valid_index (formal.position) then
								Result := a_type.generics @ (formal.position)
							end
						end
					end
				end
			end
		end

	type_of_local_entity_named (name: STRING): TYPE_A is
			-- return type of argument or local variable named `name' found in `current_feature_as'
			-- Void if there is none
		require
			current_class_i_not_void: current_class_i /= Void
			current_class_i_compiled: current_class_i.is_compiled
		local
			current_feature: E_FEATURE
			entities_list: EIFFEL_LIST [TYPE_DEC_AS]
			id_list: ARRAYED_LIST [INTEGER]
			stop: BOOLEAN
			name_id: INTEGER
			retried: BOOLEAN
			l_current_class_c: CLASS_C
		do
			if retried then
				Result := Void
			else
				if current_feature_as /= Void then
					l_current_class_c := current_class_i.compiled_class
					if l_current_class_c.has_feature_table then
						current_feature := l_current_class_c.feature_with_name (current_feature_as.feature_name)
					end

					if current_feature /= Void then
						if current_token /= Void and then current_line /= Void then
							set_up_local_analyzer (current_line, current_token)
							entities_list := local_analyzer.found_locals_list

							name_id := Names_heap.id_of (name)
							if name_id > 0 and not entities_list.is_empty then
									-- There is a `name_id' corresponding to `name' so let's
									-- look further.
								from
									entities_list.start
								until
									entities_list.after or stop
								loop
									from
										id_list := entities_list.item.id_list
										id_list.start
									until
										id_list.after or stop
									loop
										if name_id = id_list.item then
											stop := True
												-- Compute actual type for local
											Result := local_evaluated_type (name_id,
												entities_list.item.type, l_current_class_c,
												current_feature_as.feature_name)
										end
										id_list.forth
									end
									entities_list.forth
								end
							end
						end
					end
				end
			end
		rescue
			retried := True
			retry
		end

	type_of_constants_or_reserved_word (token: EDITOR_TOKEN): TYPE_A is
			-- return type associated with `token' if it represents a constant
			-- or a reserved word. If not, return Void
		require
			current_class_i_not_void: current_class_i /= Void
			current_class_i_compiled: current_class_i.is_compiled
		local
			nb: EDITOR_TOKEN_NUMBER
			ch: EDITOR_TOKEN_CHARACTER
			current_feature: E_FEATURE
			formal: FORMAL_A
			l_current_class_c: CLASS_C
		do
			if is_keyword (token) then
				l_current_class_c := current_class_i.compiled_class
				if token_image_is_same_as_word (token, Current_word) then
					Result := l_current_class_c.actual_type
				elseif
					token_image_is_same_as_word (token, Result_word) and then
					current_feature_as /= Void and then l_current_class_c.has_feature_table
				then
					current_feature := l_current_class_c.feature_with_name (
						current_feature_as.feature_name)
					if current_feature /= Void then
						Result := current_feature.type
						if Result /= Void and then Result.is_formal then
							formal ?= Result
							Result := l_current_class_c.constraint (formal.position)
						end
					end
				elseif token_image_is_in_array (token, boolean_values) then
					create {BOOLEAN_A} Result
				end
			else
				nb ?= token
				if nb /= Void then
					if nb.image.occurrences('.') > 0 then
						create {REAL_64_A} Result
					else
						create {INTEGER_A} Result.make (8)
					end
				else
					ch ?= token
					if ch /= Void then
						create {CHARACTER_A} Result.make (False)
					end
				end
			end
--| FIXME: Missing manifest arrays and strings
		end

feature {NONE}-- Implementation

	local_evaluated_type (a_local_name_id: INTEGER; a_type: TYPE_AS; a_current_class: CLASS_C; a_feature_name: STRING): TYPE_A is
			-- Given `a_type' from AST resolve its type in `a_current_class' for feature called
			-- `a_feature_name'.
		require
			a_local_name_id_positive: a_local_name_id > 0
			a_type_not_void: a_type /= Void
			a_current_class_not_void: a_current_class /= Void
			a_current_class_has_feature_table: a_current_class.has_feature_table
			a_feature_name_not_void: a_feature_name /= Void
		local
			l_feat: FEATURE_I
			retried: BOOLEAN
			l_cluster: CLUSTER_I
			l_class_c: CLASS_C
		do
			if not retried then
					-- Save compiler context
				l_class_c := system.current_class
				l_cluster := inst_context.cluster

					-- Set new compiler context
				system.set_current_class (a_current_class)
				inst_context.set_cluster (a_current_class.cluster)

					-- Resolve local's type
				check
					no_errors: not error_handler.has_error
				end
				error_handler.mark
				l_feat := a_current_class.feature_named (a_feature_name)
				type_checker.init (l_feat, a_current_class)
				Result := type_checker.solved_type (a_type)
			end
				-- After a crash or after the end of a normal execution
				-- we need to restore compiler context.
			system.set_current_class (l_class_c)
			inst_context.set_cluster (l_cluster)
		rescue
			retried := True
				-- We do not care about errors here, so we get rid of it.
			if error_handler.new_error then
				error_handler.wipe_out
			end
			retry
		end

	after_searched_token: BOOLEAN is
			-- is `current_token' after `searched_token' ?
			-- True if current_token is Void
		do
			if current_token = Void then
				Result := True
			else
				Result := (current_line.index > searched_line.index) or else
					((current_line.index = searched_line.index) and then (current_token.position > searched_token.position))
			end
		end

	go_to_previous_token is
			-- move current token backward if possible
		local
			found: BOOLEAN
			uncomplete_string: BOOLEAN
		do
			if current_token /= Void then
				from
					if is_string (current_token) and then not current_token.image.is_empty then
							-- we check if there is a string split on several lines
						if current_token.image @ 1 = '%%' then
							uncomplete_string := True
						end
					end
						-- we move to previous token, if  there is one
					if current_token /= current_line.first_token then
						current_token := current_token.previous
					elseif current_line.previous /= Void then
						current_line := current_line.previous
						current_token := current_line.eol_token
					else
						current_token := Void
					end
						-- we will go backward until current_token is text (not comment, string, blank or eol)
				until
					current_token = Void or found
				loop
					if current_token.is_text and then not is_comment (current_token) then
							-- it is a text token

						if uncomplete_string then
								-- a string is split on several lines
								-- we skip its beginning
							if is_string (current_token) then
								uncomplete_string := False
							end
							if current_token /= current_line.first_token then
								current_token := current_token.previous
							elseif current_line.previous /= Void then
								current_line := current_line.previous
								current_token := current_line.eol_token
							else
								current_token := Void
							end
						else
							if is_string (current_token) and then not current_token.image.is_empty then
									-- we check if a string is split on several lines
								if current_token.image @ 1 = '%%' then
									uncomplete_string := True
								else
										-- if the string is on one lines, we skip it
									if current_token /= current_line.first_token then
										current_token := current_token.previous
									elseif current_line.previous /= Void then
										current_line := current_line.previous
										current_token := current_line.eol_token
									else
										current_token := Void
									end
								end
							else
									-- if current_token is text but not comment or string, it is interesting
									-- we stop
								found := true
							end
						end
					else
							-- we skip all the token which are not interesting
						if current_token /= current_line.first_token then
								current_token := current_token.previous
							elseif current_line.previous /= Void then
								current_line := current_line.previous
								current_token := current_line.eol_token
						else
							current_token := Void
						end
					end
				end
			end
			if current_token = Void then
				current_line := Void
			end
		end

	go_to_next_token is
			-- move current token forward if possible
		local
			found: BOOLEAN
			uncomplete_string: BOOLEAN
		do
			if current_token /= Void then
				from
					if is_string (current_token) and then not current_token.image.is_empty then
							-- we check if there is a string split on several lines
						if current_token.image @ current_token.image.count = '%%' then
							uncomplete_string := True
						end
					end
						-- we move to previous token, if there is one
					if current_token.next /= Void then
						current_token := current_token.next
					elseif current_line.next /= Void then
						current_line := current_line.next
						current_token := current_line.first_token
					else
						current_token := Void
					end
						-- we will go backward until current_token is text (not comment, string, blank or eol)
				until
					current_token = Void or found
				loop
					if current_token.is_text and then not is_comment (current_token) then
							-- it is a text token
						if uncomplete_string then
								-- a string is split on several lines
								-- we skip its beginning
							if is_string (current_token) then
								uncomplete_string := False
							end
							if current_token.next /= Void then
								current_token := current_token.next
							elseif current_line.next /= Void then
								current_line := current_line.next
								current_token := current_line.first_token
							else
								current_token := Void
							end
						else
							if is_string (current_token) and then not current_token.image.is_empty then
									-- we check if a string is split on several lines
								if current_token.image @ 1 = '%%' then
									uncomplete_string := True
								else
										-- if the string is on one lines, we skip it
									if current_token.next /= Void then
										current_token := current_token.next
									elseif current_line.next /= Void then
										current_line := current_line.next
										current_token := current_line.first_token
									else
										current_token := Void
									end
								end
							else
									-- if current_token is text but not comment or string, it is interesting
									-- we stop
								found := true
							end
						end
					else
							-- we skip all tokens which are not interesting
						if current_token.next /= Void then
							current_token := current_token.next
						elseif current_line.next /= Void then
							current_line := current_line.next
							current_token := current_line.first_token
						else
							current_token := Void
						end
					end
				end
			end
			if current_token = Void then
				current_line := Void
			end
		end

	skip_parenthesis (opening_char, closing_char: CHARACTER) is
		local
			op, cl: STRING
			par_cnt: INTEGER
		do
			op := opening_char.out
			cl := closing_char.out
			from
				par_cnt:= 1
			until
				par_cnt = 0 or else current_token = Void
			loop
				go_to_next_token
				if token_image_is_same_as_word (current_token, cl) then
					par_cnt:= par_cnt - 1
				elseif token_image_is_same_as_word (current_token, op) then
					par_cnt:= par_cnt + 1
				end
			end
			error := error or else current_token = Void
		end

feature {NONE} -- Implementation

	initialize_context is
			-- Initialize `current_class_i'.
		require
			current_class_name_is_not_void: current_class_name /= Void
			cluster_name_is_not_void: cluster_name /= Void
			workbench_is_not_compiling: not workbench.is_compiling
		local
			l_cluster: CLUSTER_I
		do
				-- Check if we can find the cluster (this happens if a class text is being loaded
				-- while starting a compilation, i.e. loading while degree 6 is actually computing
				-- the cluster hierarchy and `cluster_name' might not be found)
			l_cluster := Universe.cluster_of_name (cluster_name)
			if l_cluster /= Void then
				current_class_i := universe.class_named (current_class_name, l_cluster)
			end
		end

	current_class_i: CLASS_I
			-- current class

	platform_is_windows: BOOLEAN is
			-- Is the current platform Windows?
		once
			Result := (create {PLATFORM_CONSTANTS}).is_windows
		end

	local_analyzer: EB_LOCAL_ENTITIES_FINDER is
			--
		do
			Result := local_analyzer_cell.item
		ensure
			local_analyzer_not_void: Result /= Void
		end

	local_analyzer_cell: CELL [EB_LOCAL_ENTITIES_FINDER] is
		local
			l_analyzer: EB_LOCAL_ENTITIES_FINDER_FROM_TEXT
		once
			create Result
			create l_analyzer.make
			Result.put (l_analyzer)
		end

	set_up_local_analyzer (a_line: EDITOR_LINE; a_token: EDITOR_TOKEN) is
			-- Set up local analyzer.
		local
			l_analyzer: EB_LOCAL_ENTITIES_FINDER_FROM_TEXT
		do
			l_analyzer ?= local_analyzer
			if l_analyzer = Void then
				create l_analyzer.make
				local_analyzer_cell.put (l_analyzer)
			end
			l_analyzer.build_entities_list (a_line, a_token)
		end

feature {NONE} -- Implementation

	is_sorted (positions: ARRAY [EB_CLICKABLE_POSITION]): BOOLEAN is
			-- is `positions' sorted ?
			-- for check purpose only
		local
			i: INTEGER
			count: INTEGER
		do
			from
				i := 2
				count := positions.count
				Result := True
			until
				(not Result) or else  i > positions.count
			loop
				Result := positions.item (i - 1) < positions.item (i)
				i := i + 1
			end
		end

	item_greater_than (i: INTEGER; table: ARRAY[INTEGER]): INTEGER is
			-- search in `table', which has to be sorted, the index of the first
			-- item greater than `i'
			-- returns 0 if there is none
		local
			index_min, index_max, middle: INTEGER
			position: INTEGER
		do
			index_min := 1
			index_max := table.count
			if i >= table @ 1 then
					-- search in the list
				if i >= table @ index_max then
					index_min := index_max
				else
					from

					until
						index_min >= index_max - 1
					loop
						middle := index_min + (index_max - index_min) // 2
						position := table @ middle
						if position > i then
							index_max := middle
						else
							index_min := middle
						end
					end
				end
				Result := index_min
			end
		end

feature {SMART_TEXT} -- Constants

	boolean_values: ARRAY [STRING] is
		once
			Result := <<"True", "False">>
		end

	feature_call_separators: ARRAY [STRING] is
		once
			Result := <<".", "~">>
		end

	unwanted_symbols: ARRAY [STRING] is
		once
			Result := <<".", "(", "{", "[", "]", "}", ")", "$">>
		end

	feature_body_keywords: ARRAY [STRING] is
		once
			Result := <<"obsolete", "require", "local", "do", "once", "deferred", "ensure", "recue", "unique", "is">>
		end

	feature_contract_keywords: ARRAY [STRING] is
		once
			Result := <<"require", "ensure">>
		end

	feature_executable_keywords: ARRAY [STRING] is
		once
			Result := <<"do", "once", "rescue">>
		end

	feature_local_keywords: ARRAY [STRING] is
		once
			Result := <<"local">>
		end


	special_keywords: ARRAY [STRING] is
		once
			Result := <<"create", "precursor">>
		end

	parenthesis: ARRAY [STRING] is
		once
			Result := <<"(", ")">>
		end

	closing_separators: ARRAY [STRING] is
		once
			Result := <<":=", "?=", ";", ",">>
		end

	infix_groups: LINKED_LIST[ARRAY[STRING]] is
			-- list of operators groups, sorted by priority
		once
			create Result.make
			Result.extend (<<"@">>)
			Result.extend (<<"^">>)
			Result.extend (<<"*", "/", "//", "\\">>)
			Result.extend (<<"+", "-">>)
			Result.extend (<<"/=", "=", ">", ">=", "<", "<=">>)
			Result.extend (<<"and">>)
			Result.extend (<<"xor">>)
			Result.extend (<<"or">>)
			Result.extend (<<"implies">>)
		end

invariant

	current_token_in_current_line: (current_line = Void and current_token = Void) or else (current_line /= Void and then current_line.has_token (current_token))


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_CLASS_INFO_ANALYZER
