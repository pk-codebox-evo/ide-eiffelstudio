indexing
	description: "[
		Generator for generating an Eiffel class.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	FULL_CLASS_GENERATOR

inherit
	ICLASS_GENERATOR

feature -- Basic operations

	generate (a_params: APPLICATION_OPTIONS; a_stub: BOOLEAN): STRING is
			-- Generates an Eiffel source file using the application parameters `a_params'
		local
			l_blob_gen: FEATURE_BLOB_GENERATOR
			l_features: STRING
			l_name: STRING
		do
			if a_stub then
				l_name := a_params.stub_class_name
			else
				l_name := a_params.interface_class_name
			end
			create l_blob_gen
			l_features := l_blob_gen.generate (a_params, a_stub)

			create Result.make (1024)
			Result.append (once "indexing%N%Tdescription: %"Generated by the Eiffel Visitor Generator Tool.%"%N%N")
			if not a_stub then
				Result.append (once "deferred ")
			end
			Result.append (once "class%N%T")
			Result.append (l_name)

			if a_params.use_user_data then
					-- Add generic constraint for user data section
				Result.append (once " [G -> ")
				Result.append (a_params.user_data_class_name)
				Result.append_character (']')
			end

				-- Add inheritance clause
			Result.append (once "%N%N")
			if a_stub then
				Result.append (once "inherit%N%T")
				Result.append (a_params.interface_class_name)
				if a_params.use_user_data then
					Result.append (once " [G]")
				end
				if a_stub then
					Result.append ("%N%T%Tredefine%N")
					Result.append (l_blob_gen.generate_redefines_list (a_params, a_stub))
					Result.append ("%T%Tend")
				end
				Result.append (once "%N%N")
			end

				-- Add features
			Result.append (once "feature -- Processing%N%N")
			Result.append (l_features)

			l_features := l_blob_gen.generate_query_features (a_params, a_stub)
			if not l_features.is_empty then
				Result.append (once "feature -- Query%N%N")
				Result.append (l_features)
			end

			Result.append (once "end -- class {")
			Result.append (l_name)
			Result.append (once "}")
		end

;indexing
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

end -- class {FULL_CLASS_GENERATOR}
