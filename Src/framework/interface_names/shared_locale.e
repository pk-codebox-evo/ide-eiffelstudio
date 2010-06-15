note
	description:
		"Locale used by interface name translation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_LOCALE

inherit
	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	SYSTEM_ENCODINGS

feature -- Access

	locale: I18N_LOCALE
			-- Current locale
        do
			Result := locale_internal.item
		ensure
			locale_not_void: Result /= Void
		end

	locale_manager: I18N_LOCALE_MANAGER
			-- Locale manager
		once
			if is_eiffel_layout_defined and then eiffel_layout.is_valid_environment then
				create Result.make (eiffel_layout.language_path)
			else
				create Result.make (".")
			end
		end

feature -- Status change

	set_locale_with_id (a_id: STRING)
			-- Set `locale' with `a_id'.
			-- `a_id' is a Locale Id.
			-- If locale of `a_id' not found, an empty locale is set.
		require
			a_id_not_void: a_id /= Void
		local
			l_id: I18N_LOCALE_ID
        do
			create l_id.make_from_string (a_id)
			if locale_manager.has_locale (l_id) then
				locale_internal.put (locale_manager.locale (l_id))
			else
				locale_internal.put (empty_locale)
			end
		end

	set_locale (a_locale: like locale)
			-- Set `locale' with `a_locale'.
		require
			a_locale_not_void: a_locale /= Void
		do
			locale_internal.put (a_locale)
		end

	set_system_locale
			-- Set `locale' `system_locale'
		do
			locale_internal.put (system_locale)
		end

	set_empty_locale
			-- Set locale to be an empty locale.
		do
			locale_internal.put (empty_locale)
		end

feature -- Output

	localized_print (a_str: STRING_GENERAL)
			-- Print `a_str' as localized encoding.
			-- `a_str' is taken as a UTF-32 string.
		local
			l_string: STRING_GENERAL
		do
			if a_str /= Void then
				l_string := utf32_to_console_encoding (console_encoding, a_str)
				if l_string /= Void then
					check
						l_string_is_valid_as_string_8: l_string.is_valid_as_string_8
					end
					io.put_string (l_string.as_string_8)
				else
					io.put_string (a_str.as_string_8)
				end
			end
		end

	localized_print_error (a_str: STRING_GENERAL)
			-- Print an error, `a_str', as localized encoding.
			-- `a_str' is taken as a UTF-32 string.
		local
			l_string: STRING_GENERAL
		do
			l_string := utf32_to_console_encoding (console_encoding, a_str)
			if l_string /= Void then
				check
					l_string_is_valid_as_string_8: l_string.is_valid_as_string_8
				end
				io.error.put_string (l_string.as_string_8)
			else
				io.error.put_string (a_str.as_string_8)
			end
		end

feature -- Conversion

	utf32_to_console_encoding (a_console_encoding: ENCODING; a_str: STRING_GENERAL): STRING_GENERAL
			-- Convert `a_str' to console encoding if possible.
			-- `a_str' is taken as a UTF-32 string.
		require
			a_console_encoding_not_void: a_console_encoding /= Void
			a_str_not_void: a_str /= Void
		local
			l_result: detachable STRING_GENERAL
		do
			utf32.convert_to (a_console_encoding, a_str)
			if utf32.last_conversion_successful then
				l_result := utf32.last_converted_string
			else
					-- This is a hack, since some OSes don't support convertion from/to UTF-32 to `a_console_encoding'.
					-- We convert UTF-32 to UTF-8 first, then convert UTF-8 to `a_console_encoding'.
				if not utf8.is_equal (a_console_encoding) then
					utf32.convert_to (utf8, a_str)
					if utf32.last_conversion_successful then
						l_result := utf32.last_converted_string
						utf8.convert_to (a_console_encoding, l_result)
						if utf8.last_conversion_successful then
							l_result := utf8.last_converted_string
						end
					end
				end
				if l_result = Void then
					l_result := a_str
				end
			end
			Result := l_result
		end

	console_encoding_to_utf32 (a_console_encoding: ENCODING; a_str: STRING_GENERAL): STRING_GENERAL
			-- Convert `a_str' to UTF-32 if possible.
			-- `a_str' is taken as a console encoding string.
		require
			a_console_encoding_not_void: a_console_encoding /= Void
			a_str_not_void: a_str /= Void
		local
			l_result: detachable STRING_GENERAL
		do
			a_console_encoding.convert_to (utf32, a_str)
			if a_console_encoding.last_conversion_successful then
				l_result := a_console_encoding.last_converted_string
			else
					-- This is a hack, since some OSes don't support convertion from/to UTF-32 to `a_console_encoding'.
					-- We convert `a_console_encoding' to UTF-8 first, then convert UTF-8 to UTF-32.
				if not utf8.is_equal (a_console_encoding) then
					a_console_encoding.convert_to (utf8, a_str)
					if a_console_encoding.last_conversion_successful then
						l_result := a_console_encoding.last_converted_string
						utf8.convert_to (utf32, l_result)
						if utf8.last_conversion_successful then
							l_result := utf8.last_converted_string
						end
					end
				end
				if l_result = Void then
					l_result := a_str
				end
			end
			Result := l_result
		end

feature {NONE} -- Implementation

	locale_internal: CELL [I18N_LOCALE]
		once
			create Result.put (empty_locale)
		ensure
			result_not_void: Result /= Void
		end

	system_locale: I18N_LOCALE
		once
			Result := locale_manager.system_locale
		ensure
			result_not_void: Result /= Void
		end

	empty_locale: I18N_LOCALE
		once
			Result := locale_manager.locale (create {I18N_LOCALE_ID}.make_from_string (""))
		ensure
			result_not_void: Result /= Void
		end

feature -- File saving

	save_string_32_in_file (a_file: FILE; a_str: STRING_32)
			-- Save `a_str' in `a_file', according to current locale.
			-- `a_str' should be UTF-32 string.
		require
			a_file_not_void: a_file /= Void
			a_file_open: a_file.is_open_write
			a_file_exist: a_file.exists
			a_str_not_void: a_str /= Void
		do
			utf32.convert_to (system_encoding, a_str)
			if utf32.last_conversion_successful then
				a_file.put_string (utf32.last_converted_stream)
			else
				a_file.put_string (a_str.as_string_8)
			end
		end

feature -- String

	first_character_as_upper (a_s: STRING_GENERAL): STRING_GENERAL
			-- First character to upper case if possible.
			-- Be careful to apply this to a translated word.
			-- Since translation might result in more than one word from one in English.
		require
			a_s_not_void: a_s /= Void
		local
			c: NATURAL_32
		do
			Result := a_s.twin
			if not Result.is_empty then
				c := Result.code (1)
				if c <= {CHARACTER_8}.max_value.to_natural_32 then
					Result.put_code (c.to_character_8.as_upper.natural_32_code, 1)
				end
			end
		ensure
			Result_not_void: Result /= Void
			Identity: Result /= a_s
		end

	string_general_as_lower (a_s: STRING_GENERAL): STRING_GENERAL
			-- Make all possible char in `a_str' to lower.
			-- |FIXME: We need real Unicode as lower.
			-- |For the moment, only ANSII code are concerned.
		require
			a_str_not_void: a_s /= Void
		local
			i, nb: INTEGER_32
			l_result: STRING_32
		do
			if attached {STRING_32} a_s as l_str then
				create l_result.make_from_string (l_str)
				from
					i := 1
					nb := l_str.count
				until
					i > nb
				loop
					if l_str.item (i).code <= {CHARACTER_8}.max_value then
						l_result.put (l_str.item (i).to_character_8.as_lower, i)
					else
						l_result.put (l_str.item (i), i)
					end
					i := i + 1
				end
				Result := l_result
			elseif attached {STRING_8} a_s as l_str then
				Result := l_str.as_lower
			end
		ensure
			Result_not_void: Result /= Void
			Result_is_lower: is_string_general_lower (Result)
			Identity: Result /= a_s
		end

	string_general_as_upper (a_s: STRING_GENERAL): STRING_GENERAL
			-- Make all possible char in `a_str' to upper.
			-- |FIXME: We need real Unicode as upper.
			-- |For the moment, only ANSII code are concerned.
		require
			a_str_not_void: a_s /= Void
		local
			i, nb: INTEGER_32
			l_result: STRING_32
		do
			if attached {STRING_32} a_s as l_str then
				create l_result.make_from_string (l_str)
				from
					i := 1
					nb := l_str.count
				until
					i > nb
				loop
					if l_str.item (i).code <= {CHARACTER_8}.max_value then
						l_result.put (l_str.item (i).to_character_8.as_upper, i)
					else
						l_result.put (l_str.item (i), i)
					end
					i := i + 1
				end
				Result := l_result
			elseif attached {STRING_8} a_s as l_str then
				Result := l_str.as_upper
			end
		ensure
			Result_not_void: Result /= Void
			Result_is_upper: is_string_general_upper (Result)
			Identity: Result /= a_s
		end

	string_general_left_adjust (a_str: STRING_GENERAL)
			-- Make all possible char in `a_str' to upper.
			-- |FIXME: We need real Unicode as upper.
			-- |For the moment, only ANSII code are concerned.
		require
			a_str_not_void: a_str /= Void
		local
			i, nb: INTEGER_32
		do
			if attached {STRING_32} a_str as l_str then
				from
					i := 1
					nb := l_str.count
				until
					i > nb or else (not l_str.item (i).is_character_8 or else not l_str.item (i).is_space)
				loop
					i := i + 1
				end
				if i > 1 then
					l_str.keep_tail (nb - i + 1)
				end
			elseif attached {STRING_8} a_str as l_str_8 then
				l_str_8.left_adjust
			end
		end

	string_general_right_adjust (a_str: STRING_GENERAL)
			-- Remove leading whitespace.
			-- |FIXME: Only take ASCII into consideration.
		require
			a_str_not_void: a_str /= Void
		local
			i, nb: INTEGER_32
		do
			if attached {STRING_32} a_str as l_str then
				from
					nb := l_str.count
					i := nb
				until
					i < 1 or else (not l_str.item (i).is_character_8 or else not l_str.item (i).is_space)
				loop
					i := i - 1
				end
				if i < nb then
					l_str.keep_head (i)
				end
			elseif attached {STRING_8} a_str as l_str_8 then
				l_str_8.right_adjust
			end
		end

	is_string_general_lower (a_str: STRING_GENERAL): BOOLEAN
			-- Is `a_str' in lower case?
			-- |FIXME: For the moment, only ANSII code are concerned.
		require
			a_str_not_void: a_str /= Void
		local
			i, nb: INTEGER_32
		do
			if attached {STRING_32} a_str as l_str then
				Result := True
				from
					i := 1
					nb := l_str.count
				until
					i > nb or not Result
				loop
					if l_str.item (i).code <= {CHARACTER_8}.max_value and then
						l_str.item (i).to_character_8.as_lower /= l_str.item (i).to_character_8
					then
						Result := False
					end
					i := i + 1
				end
			elseif attached {STRING_8} a_str as l_str then
				Result := l_str.as_upper.is_equal (l_str)
			end
		end

	is_string_general_upper (a_str: STRING_GENERAL): BOOLEAN
			-- Is `a_str' in upper case?
			-- |FIXME: For the moment, only ANSII code are concerned.
		require
			a_str_not_void: a_str /= Void
		local
			i, nb: INTEGER_32
		do
			if attached {STRING_32} a_str as l_str then
				Result := True
				from
					i := 1
					nb := l_str.count
				until
					i > nb or not Result
				loop
					if l_str.item (i).code <= {CHARACTER_8}.max_value and then
						l_str.item (i).to_character_8.as_upper /= l_str.item (i).to_character_8
					then
						Result := False
					end
					i := i + 1
				end
			elseif attached {STRING_8} a_str as l_str then
				Result := l_str.as_upper.is_equal (l_str)
			end
		end

	string_32_is_caseless_equal (a_str_32: STRING_32; a_str_other: STRING_32): BOOLEAN
			-- Is `a_str_32' in UTF32 case insensitive equal to `a_str_other'?
			-- |FIXME: For the moment, only ANSII code are concerned.
		require
			a_str_32_not_void: a_str_32 /= Void
			a_str_other_not_void: a_str_other /= Void
		local
			i, nb: INTEGER_32
			l_char, l_char_2: CHARACTER_32
		do
			if a_str_32 = a_str_other then
				Result := True
			else
				nb := a_str_32.count
				if nb = a_str_other.count then
					from
						Result := True
						i := 1
					until
						i > nb or not Result
					loop
						l_char := a_str_32.item (i)
						l_char_2 := a_str_other.item (i)
						if l_char.is_character_8 and then l_char_2.is_character_8 then
							Result := l_char.as_lower = l_char_2.as_lower
						else
							Result := l_char = l_char_2
						end
						i := i + 1
					end
				end
			end
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
