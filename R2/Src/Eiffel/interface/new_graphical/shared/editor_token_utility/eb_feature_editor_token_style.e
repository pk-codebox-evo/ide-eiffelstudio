note
	description: "Object that represents a style generator for feature item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_EDITOR_TOKEN_STYLE

inherit
	EB_EDITOR_TOKEN_STYLE

	SHARED_TEXT_ITEMS

	SHARED_SERVER

	EB_SHARED_FORMAT_TABLES

	EB_EDITOR_TOKEN_IDS

create
	default_create,
	make_with_feature,
	make_with_overload,
	make_as_invariant,
	make_with_ql_feature

feature{NONE} -- Initialization

	make_with_feature (a_feature: like e_feature)
			-- Initialize `e_feature' with `a_feature'.
		require
			a_feature_attached: a_feature /= Void
		do
			set_e_feature (a_feature)
		end

	make_with_overload (a_feature: like e_feature; a_overload_name: like overload_name)
			-- Initialize `e_feature' with `a_feature' and `overload_name' with `a_overload_name'
		require
			a_feature_attached: a_feature /= Void
			a_overload_name_attached: a_overload_name /= Void and then not a_overload_name.is_empty
		do
			make_with_feature (a_feature)
			set_overload_name (a_overload_name)
		end

	make_as_invariant (a_class: like class_c; a_written_class: like written_class)
			-- Initialize Current for an invariant feature.
		require
			a_class_attached: a_class /= Void
			a_written_class_attached: a_written_class /= Void
		do
			set_invariant (a_class, a_written_class)
		end

	make_with_ql_feature (a_ql_feature: QL_FEATURE)
			-- Initialize current using information from `a_ql_feature'.
		require
			a_ql_feature_attached: a_ql_feature /= Void
		do
			set_ql_feature (a_ql_feature)
		end

feature -- Access

	e_feature: E_FEATURE
			-- Feature associated with Current

	overload_name: STRING_32
			-- Overload name

	class_c: CLASS_C
			-- Class associated with `e_feature' or invariant

	written_class: CLASS_C
			-- Written class associated with `e_feature' or invariant

	text: LIST [EDITOR_TOKEN]
			-- Editor token text generated by `Current' style
		local
			l_writer: like token_writer
			l_constant_as: CONSTANT_AS
			l_output_strategy: like output_strategy
			l_class_c: CLASS_C
		do
			if is_comment_enabled and then e_feature /= Void then
				Result := feature_comment (e_feature)
			else
				l_writer := token_writer
				l_writer.new_line
				if is_class_enabled then
					append_class (l_writer, class_c)
				elseif is_written_class_enabled then
					append_class (l_writer, written_class)
				end
				append_feature_name (l_writer)
				if not is_for_invariant then
					if is_argument_enabled then
						e_feature.append_arguments (l_writer)
					end
					if is_return_type_enabled then
						e_feature.append_just_type (l_writer)
					end
					if is_value_for_constant and then e_feature.is_constant then
						l_constant_as ?= e_feature.ast.body.content
						if l_constant_as /= Void then
							l_output_strategy := output_strategy (class_c)
							l_output_strategy.set_current_class (class_c)
							l_output_strategy.set_source_class (written_class)
							l_class_c := system.current_class
							system.set_current_class (class_c)
							l_constant_as.process (l_output_strategy)
							system.set_current_class (l_class_c)
						end
					end
				end
				Result := l_writer.last_line.content
			end
		end

feature -- Status report

	is_for_invariant: BOOLEAN
			-- Is `Current' for an invariant feature?
		do
			Result := e_feature = Void
		end

	is_overload_name_used: BOOLEAN
			-- Is overload name used?
			-- If True, name of associated feature will use `overload_name' instead of its own name
			-- Has effect if `e_feature' is set.

	is_argument_enabled: BOOLEAN
			-- Should arguments (if any) be displayed
			-- Has effect if `e_feature' is set.

	is_return_type_enabled: BOOLEAN
			-- Should return type (if any) be displayed
			-- Has effect if `e_feature' is set.

	is_class_enabled: BOOLEAN
			-- Should associated class of `e_feature' be displayed?
			-- If True, `text' will be in form of {CLASS}.feature_name.
			-- Cannot be set to True if `is_written_class_enabled' is True.

	is_written_class_enabled: BOOLEAN
			-- Should written class of `e_feature' be displayed?
			-- If True, `text' will be in form of {CLASS}.feature_name.
			-- Cannot be set to True if `is_class_enabled' is True.

	is_comment_enabled: BOOLEAN
			-- Should current display feature comment?
			-- Has effect if `e_feature' is set.
			-- If True, only comment will be displayed.

	is_text_ready: BOOLEAN
			-- Is `text' ready to be displayed?
		do
			Result := e_feature /= Void or else class_c /= Void
		end

	is_value_for_constant: BOOLEAN
			-- If `e_feature' is a constant,
			-- should its specified value be displayed?

	is_quote_enabled: BOOLEAN
			-- Is quote around feature name enabled?

feature -- Setting

	set_overload_name (a_name: like overload_name)
			-- Set `overload_name' with `a_name'.			
		do
			if a_name = Void then
				overload_name := Void
			else
				create overload_name.make_from_string (a_name)
			end
		ensure
			overload_name_is_set: (a_name = Void implies overload_name = Void) and
								(a_name /= Void implies overload_name.is_equal (a_name))
		end

	set_e_feature (a_feature: like e_feature)
			-- Set `e_feature' with `a_feature'.
		do
			e_feature := a_feature
			if a_feature = Void then
				class_c := Void
				written_class := Void
			else
				class_c := e_feature.associated_class
				written_class := e_feature.written_class
			end
		ensure
			e_feature_set: e_feature = a_feature
		end

	set_invariant (a_class_c: like class_c; a_written_class: like written_class)
			-- Set current to represent invariant in `a_class_c'.
		require
			a_class_c_attached: a_class_c /= Void
			a_written_class_attached: a_written_class /= Void
		do
			set_e_feature (Void)
			set_overload_name (Void)
			class_c := a_class_c
			written_class := a_written_class
		ensure
			class_c_set: class_c = a_class_c
			written_class_set: written_class = a_written_class
		end

	set_ql_feature (a_ql_feature: QL_FEATURE)
			-- Set `e_feature' with information in `a_ql_feature'.
		require
			a_ql_feature_attached: a_ql_feature /= Void
		do
			if a_ql_feature.is_real_feature then
				set_e_feature (a_ql_feature.e_feature)
			else
				set_invariant (a_ql_feature.class_c, a_ql_feature.written_class)
			end
		end

	enable_use_overload_name
			-- Enable use of `overload_name'.
		do
			is_overload_name_used := True
		ensure
			overload_name_used: is_overload_name_used
		end

	disable_use_overload_name
			-- Disable use of `overload_name'.
		do
			is_overload_name_used := False
		ensure
			overload_name_not_used: not is_overload_name_used
		end

	enable_argument
			-- Enable display of arguments.
			-- See `is_argument_enabled' for more information.
		do
			is_argument_enabled := True
		ensure
			argument_enalbed: is_argument_enabled
		end

	disable_argument
			-- Disable display of arguments.
			-- See `is_argument_enabled' for more information.
		do
			is_argument_enabled := False
		ensure
			argument_enalbed: not is_argument_enabled
		end

	enable_return_type
			-- Enable display of return type.
			-- See `is_return_type_enabled' for more information.
		do
			is_return_type_enabled := True
		ensure
			return_type_enalbed: is_return_type_enabled
		end

	disable_return_type
			-- Disable display of return type.
			-- See `is_return_type_enabled' for more information.
		do
			is_return_type_enabled := False
		ensure
			return_type_disalbed: not is_return_type_enabled
		end

	enable_class
			-- Enable display of classs.
			-- See `is_class_enabled' for more information.
		require
			written_class_disabled: not is_written_class_enabled
		do
			is_class_enabled := True
		ensure
			class_enalbed: is_class_enabled
		end

	disable_class
			-- Disable display of classs.
			-- See `is_class_enabled' for more information.
		do
			is_class_enabled := False
		ensure
			class_disalbed: not is_class_enabled
		end

	enable_written_class
			-- Enable display of written_classs.
			-- See `is_written_class_enabled' for more information.
		require
			class_disabled: not is_class_enabled
		do
			is_written_class_enabled := True
		ensure
			written_class_enalbed: is_written_class_enabled
		end

	disable_written_class
			-- Disable display of written_classs.
			-- See `is_written_class_enabled' for more information.
		do
			is_written_class_enabled := False
		ensure
			written_class_disalbed: not is_written_class_enabled
		end

	enable_comment
			-- Enable display of comments.
			-- See `is_comment_enabled' for more information.
		do
			is_comment_enabled := True
		ensure
			comment_enalbed: is_comment_enabled
		end

	disable_comment
			-- Disable display of comments.
			-- See `is_comment_enabled' for more information.
		do
			is_comment_enabled := False
		ensure
			comment_disalbed: not is_comment_enabled
		end

	enable_value_for_constant
			-- Enable to display value if `e_feature' is a constant.
			-- See `is_value_for_constant' for more information?
		do
			is_value_for_constant := True
		ensure
			value_for_constant_enabled: is_value_for_constant
		end

	disable_value_for_constant
			-- Disable to display value if `e_feature' is a constant.
			-- See `is_value_for_constant' for more information?
		do
			is_value_for_constant := False
		ensure
			value_for_constant_disabled: not is_value_for_constant
		end

	enable_quote
			-- Enable quote arround feature name.
		do
			is_quote_enabled := True
		ensure
			quote_enabled: is_quote_enabled
		end

	disable_quote
			-- Disable quote arround feature name.
		do
			is_quote_enabled := False
		ensure
			quote_disabled: not is_quote_enabled
		end

feature{NONE} -- Implementation

	invariant_name: STRING_32
			-- Name of current item
		once
			create Result.make_from_string ("invariant")
		ensure then
			good_result: Result /= Void and then Result.is_equal ("invariant")
		end

	append_class (a_writer: like token_writer; a_class: CLASS_C)
			-- Append name of `a_class' into last line of `a_writer'.
		require
			a_writer_attached: a_writer /= Void
			class_c_attached: class_c /= Void
		do
			a_writer.process_symbol_text (ti_l_curly)
			a_class.append_name (a_writer)
			a_writer.process_symbol_text (ti_r_curly)
			a_writer.process_symbol_text (ti_dot)
		end

	append_feature_name (a_writer: like token_writer)
			-- Append name of `e_feature' or "invariant" into last line of `a_writer'.
		require
			a_writer_attached: a_writer /= Void
			class_c_attached: class_c /= Void
		local
			l_inv: INVARIANT_AS
		do
			if is_overload_name_used and then overload_name /= Void then
				if is_for_invariant then
					a_writer.add_string (overload_name)
				else
					a_writer.process_feature_text (overload_name, e_feature, is_quote_enabled)
				end
			else
				if is_for_invariant then
					l_inv := written_class.invariant_ast
					if l_inv /= Void then
						a_writer.process_ast (invariant_name, l_inv, written_class, feature_appearance, False, cursors.cur_feature, cursors.cur_x_feature)
					else
						a_writer.add_string (invariant_name)
					end
				else
					e_feature.append_full_name (a_writer)
				end
			end
		end

	feature_comment (a_feature: E_FEATURE): ARRAYED_LIST [EDITOR_TOKEN]
			-- Editor token representation of comment of `a_feature'.
		require
			a_feature_attached: a_feature /= Void
		local
			l_comments: EIFFEL_COMMENTS
			l_tokens: LINKED_LIST [EDITOR_TOKEN]
			l_comment: STRING_32
			l_feature_text_formatter: DOTNET_FEAT_TEXT_FORMATTER_DECORATOR
			l_classi: CLASS_I
			l_consumed_type: CONSUMED_TYPE
			l_ext_class: EXTERNAL_CLASS_I
			l_lines: LIST [EIFFEL_EDITOR_LINE]
			l_line: LIST [EDITOR_TOKEN]
		do
			create Result.make (128)
			if a_feature.is_il_external then
					-- For .NET external features
				l_classi := a_feature.written_class.original_class
				if consumed_types.has (l_classi.name) then
					l_consumed_type := consumed_types.item (l_classi.name)
				else
					l_ext_class ?= l_classi
					check
						l_ext_class_not_void: l_ext_class /= Void
					end
					l_consumed_type := l_ext_class.external_consumed_type
					if l_consumed_type /= Void then
						consumed_types.put (l_consumed_type, l_classi.name)
					end
				end
				token_writer.enable_multiline
				create l_feature_text_formatter.make (a_feature, l_consumed_type, token_writer)
				l_feature_text_formatter.prepare_for_feature (l_feature_text_formatter.current_feature)
				l_feature_text_formatter.put_comments
				token_writer.new_line
				l_lines := token_writer.lines
				from
					l_lines.start
				until
					l_lines.after
				loop
					l_line := l_lines.item.content
					from
						l_line.start
						if not l_line.after and l_line.item.is_tabulation then
							l_line.remove
						end
					until
						l_line.after
					loop
						if l_line.index = 1 and then l_line.item.is_text then
							if l_line.item.wide_image.substring (1, 2).is_equal (once "--") then
								l_line.item.wide_image.keep_tail (l_line.item.wide_image.count - 2)
							end
						end
						l_line.item.update_width
						Result.extend (l_line.item)
						l_line.forth
					end
					if l_lines.item /= l_lines.last and l_line.count > 0 then
						Result.extend (create{EDITOR_TOKEN_EOL}.make)
					end
					l_lines.forth
				end
				token_writer.wipe_out_lines
				token_writer.disable_multiline
			else
					-- For normal features
				token_writer.new_line
				if attached a_feature as l_feat then
					l_comments :=  (create {COMMENT_EXTRACTOR}).feature_comments (l_feat)

					if l_comments /= Void and then l_comments.count > 0 then
						create l_tokens.make
						token_writer.set_comment_context_class (a_feature.associated_class)
						from
							l_comments.start
						until
							l_comments.after
						loop
							token_writer.new_line
							l_comment := l_comments.item.content_32
							if l_comment.count > 1 and then l_comment.item (1).is_character_8 and then l_comment.item (1).is_space then
								l_comment.remove (1)
							end
							token_writer.add_comment_text (l_comment)
							l_tokens.fill (token_writer.last_line.content)
							l_tokens.extend (create{EDITOR_TOKEN_EOL}.make)
							l_comments.forth
						end
						from
							l_tokens.start
						until
							l_tokens.after
						loop
							l_tokens.item.update_width
							Result.extend (l_tokens.item)
							l_tokens.forth
						end
					end
				end
			end
		end

	output_strategy (a_class: CLASS_C): AST_DECORATED_OUTPUT_STRATEGY
			-- Outputer used to print constant values.
		require
			a_class_c_attached: a_class /= Void
		do
			create Result.make (create {FEAT_TEXT_FORMATTER_DECORATOR}.make (a_class, token_writer))
		ensure
			result_attached: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
