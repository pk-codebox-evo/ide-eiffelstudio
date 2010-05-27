note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	COMPILER_COUNTER

inherit
	SHARED_WORKBENCH

	COMPILER_EXPORTER

create
	make

feature -- Initialization

	make
			-- Create a new counter.
		do
		end

	append (other: like Current)
			-- Append ids generated by `other' to `Current' and
			-- renumber the resulting set of ids.
		require
			other_not_void: other /= Void
		do
			precompiled_offset := (precompiled_offset).max (other.count)
			count := precompiled_offset
		end

feature -- Access

	next_id: INTEGER
			-- Next id
		do
			count := count + 1
			Result := count
		ensure
			id_not_void: Result > 0
		end

	precompiled_offset: INTEGER
			-- Last Ids retrieved from precompiled library.

	count: INTEGER
			-- Number of ids in system.

	current_count: INTEGER
			-- Number of ids generated during current compilation.
		do
			Result := count - precompiled_offset
		end

	is_precompiled (an_id: INTEGER): BOOLEAN
			-- Is `an_id' a precompiled id?
		do
			Result := an_id <= precompiled_offset
		end

feature -- Setting

	set_value (value: INTEGER)
			-- Reset the counter so that next geneareted id
			-- will be `value' + 1
		do
			count := value
		end

	set_precompiled_offset (v: INTEGER)
			-- Assign `v' to `precompiled_offset'.
		require
			valid_value: v > 0
		do
			precompiled_offset := v
		ensure
			precompiled_offset_set: precompiled_offset = v
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class COMPILER_COUNTER
