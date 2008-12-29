note
	description: "Permits argument-based formatting of {STRING} instances."
	legal      : "See notice at end of class."
	status     : "See notice at end of class."
	date       : "$Date$"
	revision   : "$Revision$"

class
	STRING_FORMATTER

inherit
	ANY

	EXCEPTIONS
		export
			{NONE} all
		end

feature -- Formatting

	format (a_str: !READABLE_STRING_GENERAL; a_args: !TUPLE): !STRING
			-- Replaces each format item in `a_str' with the text equivalent of a corresponding to
			-- and object's value at `a_args' @ i.
			--
			-- Example:
			--     format ("Hello there {1}", ["Mr. Dobbs"])
			-- Yields:
			--     Hello there Mr. Dobbs.
			--
			-- The '{' '}' are defined by `open_char' and `close_char' respectivly. To escape open and close
			-- parameters qualifiers simply double them up.
			--
			-- Example:
			--     format ("He}}llo there {{", ["Mr. Dobbs"])
			-- Yields:
			--     He}llo there {
		require
			not_a_str_is_empty: not a_str.is_empty
			not_a_args_is_empty: not a_args.is_empty
		do
			create Result.make_from_string (format_unicode (a_str, a_args))
		ensure
			not_result_is_empty: not Result.is_empty
		end

	format_unicode (a_str: !READABLE_STRING_GENERAL; a_args: !TUPLE): !STRING_32
			-- Replaces each format item in `a_str' with the text equivalent of a corresponding to
			-- and object's value at `a_args' @ i.
			--
			-- Example:
			--     format ("Hello there {1}", ["Mr. Dobbs"])
			-- Yields:
			--     Hello there Mr. Dobbs.
			--
			-- The '{' '}' are defined by `open_char' and `close_char' respectivly. To escape open and close
			-- parameters qualifiers simply double them up.
			--
			-- Example:
			--     format ("He}}llo there {{", ["Mr. Dobbs"])
			-- Yields:
			--     He}llo there {
		require
			not_a_str_is_empty: not a_str.is_empty
			not_a_args_is_empty: not a_args.is_empty
		local
			l_str: STRING_32
			l_count: INTEGER
			l_arg_count: INTEGER
			l_arg: ANY
			l_match: BOOLEAN
			l_skip: BOOLEAN
			l_digit: !STRING_32
			l_index: INTEGER
			i: INTEGER
			c, n: CHARACTER_32
			o, cl: CHARACTER_32
		do
			if {l_str32: READABLE_STRING_32} a_str then
				l_str := l_str32
			else
				create l_str.make (a_str.count)
				l_str.append_string_general (a_str)
			end
			l_count := l_str.count
			l_arg_count := a_args.count
			o := open_char
			cl := close_char

			create l_digit.make (2)
			create Result.make (l_count * 2)

			from
				i := 1
			until
				i > l_count
			loop
				c := l_str.item (i)
				if i < l_count then
					n := l_str.item (i + 1)
				end
				if c = o then
					if i < l_count then
						l_match := n /= o
						if not l_match then
							i := i + 1
							Result.append_character (n)
						end
					end
				elseif c = cl then
					l_skip := False
					if i < l_count then
						if n = cl then
							Result.append_character (n)
							i := i + 1
							l_skip := True
						end
					end
					if l_match and not l_skip then
						l_match := False
						if l_digit.is_integer then
							l_index := l_digit.to_integer
							if l_index > 0 and l_index <= l_arg_count then
								l_arg := a_args [l_index]
								if l_arg /= Void then
									Result.append (l_arg.out)
								end
							end
						end
						l_digit.wipe_out
					end
				elseif l_match then
					l_digit.append_character (c)
				else
					Result.append_character (c)
				end
				i := i + 1
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	ellipse (a_str: !READABLE_STRING_GENERAL; a_max_len: INTEGER): !STRING
			-- If `a_str' is bigger than `ellipse_threshold'
		require
			a_str_attached: a_str /= Void
			not_a_str_is_empty: not a_str.is_empty
			a_max_len_big_enough: a_max_len > 3
		do
			create Result.make (a_str.count)
			Result.append_string_general (a_str)
			if Result.count > a_max_len then
				Result.keep_head (a_max_len - 3)
				Result.append (once "...")
			end
		ensure
			not_result_is_empty: not Result.is_empty
			result_ellipsed: Result.count <= a_max_len
		end

	ellipse_unicode (a_str: !READABLE_STRING_GENERAL; a_max_len: INTEGER): !STRING_32
			-- If `a_str' is bigger than `ellipse_threshold'
		require
			not_a_str_is_empty: not a_str.is_empty
			a_max_len_big_enough: a_max_len > 3
		do
			create Result.make (a_str.count)
			Result.append_string_general (a_str)
			if Result.count > a_max_len then
				Result.keep_head (a_max_len - 3)
				Result.append (once "...")
			end
		ensure
			not_result_is_empty: not Result.is_empty
			result_ellipsed: Result.count <= a_max_len
		end

feature -- Formatting

	tabbify (a_str: !READABLE_STRING_GENERAL; a_tab_chars: INTEGER): !STRING
			-- Tabbifies a string by replacing spaces with tabs.
			--
			-- `a_str': A string to tabbify.
			-- `a_tab_chars': Number of space characters in a tab.
			-- `Result': A tabbified string.
		require
			not_a_str_is_empty: not a_str.is_empty
			a_tab_chars_positive: a_tab_chars > 0
		do
			create Result.make_from_string (tabbify_unicode (a_str, a_tab_chars))
		ensure
			not_result_is_empty: not Result.is_empty
		end

	tabbify_unicode (a_str: !READABLE_STRING_GENERAL; a_tab_chars: INTEGER): !STRING_32
			-- Tabbifies a string by replacing spaces with tabs.
			--
			-- `a_str': A string to tabbify.
			-- `a_tab_chars': Number of space characters in a tab.
			-- `Result': A tabbified string.
		require
			not_a_str_is_empty: not a_str.is_empty
			a_tab_chars_positive: a_tab_chars > 0
		local
			l_str: STRING_32
			l_spaces: INTEGER
			l_reset: BOOLEAN
			i, l_count: INTEGER
			c: CHARACTER_32
		do
			if {l_str32: READABLE_STRING_32} a_str then
				l_str := l_str32
			else
				create l_str.make (a_str.count)
				l_str.append_string_general (a_str)
			end
			l_count := l_str.count
			create Result.make (l_count)
			from i := 1 until i > l_count loop
				c := l_str.item (i)
				if c = ' ' then
					l_reset := l_spaces = 3
					if not l_reset then
						l_spaces := l_spaces + 1
					end
				elseif c = '%T' then
					l_reset := True
				else
					if l_spaces > 0 then
						Result.append (create {STRING_32}.make_filled (' ', l_spaces))
						l_spaces := 0
					end
					Result.append_character (c)
					l_reset := False
				end
				if l_reset then
					Result.append_character ('%T')
					l_spaces := 0
				end
				i := i + 1
			end
			if l_spaces > 0 then
				Result.append (create {STRING_32}.make_filled (' ', l_spaces))
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Symbols

	open_char: CHARACTER = '{'
			-- Index open character

	close_char: CHARACTER = '}';
			-- Index close character

note
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end -- class {STRING_FORMATTER}
