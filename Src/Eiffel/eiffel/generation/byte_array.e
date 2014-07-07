note
	description: "Byte array for generating melted code"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class BYTE_ARRAY

inherit
	CHARACTER_ARRAY
		rename
			make as basic_make
		end
	PLATFORM
		export
			{NONE} all
		end
	SHARED_C_LEVEL
		export
			{NONE} all
		end

	REFACTORING_HELPER
		export
			{NONE} fixme
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			basic_make (Chunk)
			position := 0
			create forward_marks.make (Jump_stack_size)
			create forward_marks2.make (Jump_stack_size)
			create forward_marks3.make (Jump_stack_size)
			create forward_marks4.make (Jump_stack_size)
			create backward_marks.make (Jump_stack_size)
		end

feature -- Access

	last_string: STRING
			-- Last string read by `last_string'.

	last_long_integer: INTEGER
			-- Last long integer read by `read_long_integer'.

	last_short_integer: INTEGER
			-- Last short integer read by `read_short_integer'.

	Chunk: INTEGER = 5000
			-- Chunk array

	Jump_stack_size: INTEGER = 50
			-- Initial size of stack recording jump in generated byte code.

	max_string_count: INTEGER
			-- Maximum length of a string with explicitly specified count
			-- (see `append_string')
		do
			Result := {INTEGER_16}.max_value
		end

feature -- Removal

	clear
			-- Clear the structure
		do
			position := 0
			last_string := Void
			last_long_integer := 0
			last_short_integer := 0
			retry_position := 0
		end

feature --

	character_array: CHARACTER_ARRAY
			-- Simple character array
		local
			other_area: like area
		do
			create Result.make (position)
			other_area := Result.area
			internal_copy (area, other_area, position, 0)
		end

	feature_table: MELTED_FEATURE_TABLE
			-- Melted feature table
		local
			other_area: like area
		do
			create Result.make (position)
			other_area := Result.area
			internal_copy (area, other_area, position, 0)
		end

	melted_feature: MELT_FEATURE
			-- Melted feature
		local
			other_area: like area
		do
			create Result.make (position)
			other_area := Result.area
			internal_copy (area, other_area, position, 0)
		end

	melted_descriptor: MELTED_DESC
			-- Melted descriptor
		local
			other_area: like area
		do
			create Result.make (position)
			other_area := Result.area
			internal_copy (area, other_area, position, 0)
		end

	melted_routine_table: MELTED_ROUT_TABLE
			-- Melted routine table
		local
			other_area: like area
		do
			create Result.make (position)
			other_area := Result.area
			internal_copy (area, other_area, position, 0)
		end

	melted_routid_array: MELTED_ROUTID_ARRAY
			-- Melted routine id array
		local
			other_area: like area
		do
			create Result.make (position)
			other_area := Result.area
			internal_copy (area, other_area, position, 0)
		end

feature -- Element change

	append (c: CHARACTER)
			-- Append `c' in the array
		local
			new_position: INTEGER
		do
			new_position := position + 1
			if new_position >= count then
				resize (count + Chunk)
			end
			area.put (c, position)
			position := new_position
		end

	append_boolean (b: BOOLEAN)
			-- Append boolean `b' in array.
		do
			if b then
				append ('%/001/')
			else
				append ('%U')
			end
		end

	append_character_32 (c: CHARACTER_32)
			-- Append character `c' in the array.
		do
			append_natural_32 (c.natural_32_code)
		end

	append_natural_8 (n: NATURAL_8)
			-- Append natural `n' in the array
		local
			new_position: INTEGER
		do
			new_position := position + natural_8_bytes
			if new_position >= count then
				resize (count + Chunk)
			end
			($area + position).memory_copy ($n, natural_8_bytes)
			position := new_position
		end

	append_natural_16 (n: NATURAL_16)
			-- Append natural `n' in the array
		local
			new_position: INTEGER
		do
			new_position := position + natural_16_bytes
			if new_position >= count then
				resize (count + Chunk)
			end
			($area + position).memory_copy ($n, natural_16_bytes)
			position := new_position
		end

	append_natural_32 (n: NATURAL_32)
			-- Append unsigned 32 bits natural in the array
		local
			new_position: INTEGER
		do
			new_position := position + natural_32_bytes
			if new_position >= count then
				resize (count + Chunk)
			end
			($area + position).memory_copy ($n, natural_32_bytes)
			position := new_position
		end

	append_natural_64 (n: NATURAL_64)
			-- Append long natural `n' in the array
		local
			new_position: INTEGER
		do
			new_position := position + natural_64_bytes
			if new_position >= count then
				resize (count + Chunk)
			end
			($area + position).memory_copy ($n, natural_64_bytes)
			position := new_position
		end

	append_integer_8 (i: INTEGER_8)
			-- Append integer `i' in the array
		local
			new_position: INTEGER
		do
			new_position := position + integer_8_bytes
			if new_position >= count then
				resize (count + Chunk)
			end
			($area + position).memory_copy ($i, integer_8_bytes)
			position := new_position
		end

	append_integer_16 (i: INTEGER_16)
			-- Append integer `i' in the array
		local
			new_position: INTEGER
		do
			new_position := position + integer_16_bytes
			if new_position >= count then
				resize (count + Chunk)
			end
			($area + position).memory_copy ($i, integer_16_bytes)
			position := new_position
		end

	append_integer (i: INTEGER)
			-- Append `i' in the array
		do
			fixme ("Should we update callers to use `append_integer_32' ?")
			append_integer_32 (i)
		end

	append_integer_for_type_array (i: INTEGER)
			-- Write `i' a non-negative integer as a sequence of 16-bit value.
			-- For values between 0 and 0x7FFF, write the value itself.
			-- For values between 0x8000 and 0x7FFFFFE, write 1xxxxxxx xxxxxxxx xxxxxxxx xxxxxxxx.
			-- We do not enabled 0x7FFFFFFF because this would generate 0x8FFF 0xFFFF and the 0xFFFF
			-- would be considered a terminator which is not what is intended.
		require
			i_non_negative: i >= 0
			i_not_maximum_integer: i < {INTEGER}.max_value
		do
			if i <= 0x7FFF then
				append_natural_16 (i.to_natural_16)
			else
				append_natural_16 (((i.to_natural_32 |>> 16) | 0x8000).to_natural_16)
				append_natural_16 (i.as_natural_16)
			end
		end

 	append_integer_32 (i: INTEGER)
			-- Append long integer `i' in the array
		local
			new_position: INTEGER
		do
			new_position := position + integer_32_bytes
			if new_position >= count then
				resize (count + Chunk)
			end
			($area + position).memory_copy ($i, integer_32_bytes)
			position := new_position
		end

	append_integer_64 (i: INTEGER_64)
			-- Append long integer `i' in the array
		local
			new_position: INTEGER
		do
			new_position := position + integer_64_bytes
			if new_position >= count then
				resize (count + Chunk)
			end
			($area + position).memory_copy ($i, integer_64_bytes)
			position := new_position
		end

	append_short_integer (i: INTEGER)
			-- Append short integer `i' in the array
		require
			valid_short_integer: i >= {INTEGER_16}.Min_value and
				i <= {INTEGER_16}.Max_value
		do
			fixme ("[
				Callers should verify that they actually don't mean to
				use `append_natural_16' use NATURAL_16.
				]")
			append_integer_16 (i.to_integer_16)
		end

	append_uint32_integer (i: INTEGER)
			-- Append integer `i' in the array
		do
			fixme ("[
				Callers should verify that they actually don't mean to
				use `append_natural_32' use NATURAL_32.
				]")
			append_integer_32 (i)
		end

	append_double (d: DOUBLE)
			-- Append real value `d'.
		local
			new_position: INTEGER
		do
			new_position := position + real_64_bytes
			if new_position >= count then
				resize (count + Chunk)
			end
			($area + position).memory_copy ($d, real_64_bytes)
			position := new_position
		end

	append_offset (a_offset: INTEGER)
			-- Append offset `a_offset'.
		require
			a_offset_non_negative: a_offset >= 0
		do
			append_integer_32 (a_offset)
		end

	append_feature_id (a_id: INTEGER)
			-- Append feature ID `a_id'.
		require
			a_id_non_negative: a_id >= 0
		do
			append_integer_32 (a_id)
		end

	append_routine_id (a_id: INTEGER)
			-- Append routine ID `a_id'.
		require
			a_id_non_negative: a_id >= 0
		do
			append_integer_32 (a_id)
		end

	append_type_id (type_id: INTEGER)
			-- Append type ID `type_id'.
		require
			type_id_non_negative: type_id >= 0
		do
			append_short_integer (type_id - 1)
		end

	append_argument_count (c: INTEGER)
			-- Append argument count `c'.
		require
			c_non_negative: c >= 0
			c_small_enough: c <= {INTEGER_16}.Max_value
		do
			append_short_integer (c)
		end

	append_string (s: STRING)
			-- Append string `s'.
		require
			string_not_void: s /= Void
			string_not_too_long: s.count <= max_string_count
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := s.count
					-- First write the string count
				append_short_integer (nb)
			until
				i > nb
			loop
				append (s.item (i))
				i := i + 1
			end
		end

	append_raw_string (s: STRING)
			-- Append string `s'.
		require
			good_argument: s /= Void
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := s.count
			until
				i > nb
			loop
				append (s.item (i))
				i := i + 1
			end
			append ('%U')
		end

	append_raw_string_32 (s: STRING_32)
			-- Append string `s' as a byte sequence in little endian format.
		require
			good_argument: s /= Void
		local
			i, l_count: INTEGER
			l_code: NATURAL_32
		do
			from
				l_count := s.count
				i := 1
			until
				i > l_count
			loop
				l_code := s.code (i)
				append_natural_8 ((l_code & 0x000000FF).to_natural_8)
				append_natural_8 ((l_code & 0x0000FF00 |>> 8).to_natural_8)
				append_natural_8 ((l_code & 0x00FF0000 |>> 16).to_natural_8)
				append_natural_8 ((l_code & 0xFF000000 |>> 24).to_natural_8)
				i := i + 1
			end
			append ('%U')
		end

feature -- Forward and backward jump managment

	forward_marks: ARRAYED_STACK [INTEGER]
			-- Forward jump stack

	mark_forward
			-- Mark a forward offset
		do
			forward_marks.put (position)
			append_integer_32 (0)
		end

	write_forward
			-- Write Current position at previous mark
		local
			pos: INTEGER
		do
			pos := position
			position := forward_marks.item
			forward_marks.remove
			append_integer_32 (pos - position - integer_32_bytes)
			position := pos
		end

	forward_marks2: ARRAYED_STACK [INTEGER]
			-- Forward jump stack

	mark_forward2
			-- Mark a forward offset
		do
			forward_marks2.put (position)
			append_integer_32 (0)
		end

	write_forward2
			-- Write Current position at previous mark
		local
			pos: INTEGER
		do
			pos := position
			position := forward_marks2.item
			forward_marks2.remove
			append_integer_32 (pos - position - integer_32_bytes)
			position := pos
		end

	forward_marks3: ARRAYED_STACK [INTEGER]
			-- Forward jump stack

	mark_forward3
			-- Mark a forward offset
		do
			forward_marks3.put (position)
			append_integer_32 (0)
		end

	write_forward3
			-- Write Current position at previous mark
		local
			pos: INTEGER
		do
			pos := position
			position := forward_marks3.item
			forward_marks3.remove
			append_integer_32 (pos - position - integer_32_bytes)
			position := pos
		end

	forward_marks4: ARRAYED_STACK [INTEGER]
			-- Forward jump stack

	mark_forward4
			-- Mark a forward offset
		do
			forward_marks4.put (position)
			append_integer_32 (0)
		end

	write_forward4
			-- Write Current position at previous mark
		local
			pos: INTEGER
		do
			pos := position
			position := forward_marks4.item
			forward_marks4.remove
			append_integer_32 (pos - position - integer_32_bytes)
			position := pos
		end

	backward_marks: ARRAYED_STACK [INTEGER]
			-- Backward jump stack

	mark_backward
			-- Mark a backward offset
		do
			backward_marks.put (position)
		end

	write_backward
			-- Write a backward jump
		do
			append_integer_32 (- position - integer_32_bytes + backward_marks.item)
			backward_marks.remove
		end

	retry_position: INTEGER
			-- Retry position

	mark_retry
			-- Record retry position
		do
			retry_position := position
		end

	write_retry
			-- Write a retry offset
		do
			append_integer_32 (- position - integer_32_bytes + retry_position)
		end

	prepend (other: BYTE_ARRAY)
			-- Prepend `other' before in Current
		local
			new_size, old_pos, new_pos, other_position: INTEGER
			other_area, buffer_area: like area
		do
			old_pos := position
			other_position := other.position
			if old_pos >= Buffer.count then
				new_size := Chunk * (1 + (old_pos // Chunk))
				Buffer.resize (new_size)
			end
			buffer_area := Buffer.area
			internal_copy (area, buffer_area, old_pos, 0)
			new_pos := old_pos + other_position
			if new_pos >= count then
				new_size := Chunk * (1 + (new_pos // Chunk))
				resize (new_size)
			end
			other_area := other.area
			internal_copy (other_area, area, other_position, 0)
			internal_copy (buffer_area, area, old_pos, other_position)
			position := new_pos
		end

	Buffer: BYTE_ARRAY
			-- Prepend buffer
		once
			create Result.make
		end

feature -- Debugger

	generate_melted_debugger_hook(lnr: INTEGER)
			-- Write continue mark (where breakpoint may be set).
			-- lnr is the current breakable line number index.
		do
			append ({BYTE_CONST}.bc_hook)
			append_integer_32 (lnr)
		end

	generate_melted_debugger_hook_nested(lnr, nr: INTEGER)
			-- Write continue mark (where breakpoint may be set).
			-- lnr is the current breakable line number index (nested call).
		do
			append ({BYTE_CONST}.bc_nhook)
			append_integer_32 (lnr) -- breakable index
			append_integer_32 (nr) -- breakable nested index
		end

feature {BYTE_ARRAY} -- Access

	position: INTEGER
			-- Position of the cursor in the array

invariant
	position_greater_than_zero: position >= 0
	position_less_than_size: position < count
	integer_32_valid: integer_32_bytes = natural_32_bytes

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
