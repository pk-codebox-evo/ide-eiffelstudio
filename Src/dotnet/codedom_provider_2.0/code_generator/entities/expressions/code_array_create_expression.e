note
	description: "Source code generator for array creation expression"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"
	
class
	CODE_ARRAY_CREATE_EXPRESSION

inherit
	CODE_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make (a_type: CODE_TYPE_REFERENCE; a_size: INTEGER; a_size_expression: CODE_EXPRESSION; a_initializers: LIST [CODE_EXPRESSION])
			-- Initialize `initializers'.
		require
			non_void_type: a_type /= Void
			valid_arguments: (a_size_expression /= Void xor a_size > 0) or a_initializers /= Void
		do
			array_type := a_type
			size := a_size
			size_expression := a_size_expression
			initializers := a_initializers
		ensure
			type_set: array_type = a_type
			size_set: size = a_size
			size_expression_set: size_expression = a_size_expression
			initializers_set: initializers = a_initializers
		end
		
feature -- Access

	array_type: CODE_TYPE_REFERENCE
			-- Array type
	
	size: INTEGER
			-- Array size

	size_expression: CODE_EXPRESSION
			-- Array size expression
	
	initializers: LIST [CODE_EXPRESSION]
			-- Array initializers
	
	target: STRING
			-- Creation target

feature -- Code Generation

	code: STRING
			-- Eiffel code for array creation expression
			-- | 	Result := "create `target'.make (`size_expression')" if size_expression /= Void and target /= Void
			-- | OR
			-- | 	Result := "create `target'.make (`size')" if size > 0 and target /= Void
			-- | OR
			-- | 	Result := "create {`array_type'}.make (`size_expression')" if size_expression /= Void and target = Void
			-- | OR
			-- | 	Result := "create {`array_type'}.make (`size')" if size > 0 and target = Void
			-- | OR 
			-- |	Result := "({NATIVE_ARRAY [`array_type']}) [({ARRAY [`array_type']}) [<<`initializers', `initializers',...>>]]
		do
			create Result.make (160)
			if size_expression /= Void or size > 0 then
				Result.append ("create ")
				if target /= Void then
					Result.append (target)					
				else
					Result.append_character ('{')
					Result.append (array_type.eiffel_name)
					Result.append_character ('}')
				end
				Result.append (".make (")
				if size_expression /= Void then
					Result.append (size_expression.code)
				else
					Result.append (size.out)
				end
				Result.append_character (')')
			elseif initializers /= Void then
				Result.append ("({NATIVE_ARRAY [")
				Result.append (array_type.eiffel_name)
				Result.append ("]}) [({ARRAY [")
				Result.append (array_type.eiffel_name)
				Result.append ("]}) [<<")
				from
					initializers.start
					if not initializers.after then
						Result.append (initializers.item.code)
						initializers.forth
					end
				until
					initializers.after
				loop
					Result.append (", ")
					Result.append (initializers.item.code)
					initializers.forth
				end
				Result.append (">>]]")
			end
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE
			-- Type
		do
			Result := array_type
		end
	
feature {CODE_ASSIGN_STATEMENT} -- Element Settings

	set_target (a_target: like target)
			-- Set `target' with `a_target'.
		require
			non_void_target: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end
		
invariant
	non_void_element_type: array_type /= Void
	one_and_only_one_info: size_expression /= Void xor size > 0 xor initializers /= Void
	size_if_target: target /= Void implies (size > 0 or size_expression /= Void)
	
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
end -- class CODE_ARRAY_CREATE_EXPRESSION

