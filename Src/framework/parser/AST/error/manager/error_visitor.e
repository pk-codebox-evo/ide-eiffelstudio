note
	description: "Generated by the Eiffel Visitor Generator Tool."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ERROR_VISITOR

feature -- Query

	is_valid: BOOLEAN
			-- Determines if `Current' is in a validate state to permit processing
		do
			Result := True
		end

	is_applicable_visitation_entity (a_value: ANY): BOOLEAN
			-- Determines if object instance `a_value' is applicable for a visitation
		require
			a_value_attached: a_value /= Void
		do
			Result := True
		end

feature -- Processing

	process_bad_character (a_value: BAD_CHARACTER)
			-- Process object `a_value'.
		require
			is_valid: is_valid
			a_value_attached: a_value /= Void
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_basic_gen_type_err (a_value: BASIC_GEN_TYPE_ERR)
			-- Process object `a_value'.
		require
			is_valid: is_valid
			a_value_attached: a_value /= Void
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_error (a_value: ERROR)
			-- Process object `a_value'.
		require
			is_valid: is_valid
			a_value_attached: a_value /= Void
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_string_extension (a_value: STRING_EXTENSION)
			-- Process object `a_value'.
		require
			is_valid: is_valid
			a_value_attached: a_value /= Void
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_string_uncompleted (a_value: STRING_UNCOMPLETED)
			-- Process object `a_value'.
		require
			is_valid: is_valid
			a_value_attached: a_value /= Void
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_syntax_error (a_value: SYNTAX_ERROR)
			-- Process object `a_value'.
		require
			is_valid: is_valid
			a_value_attached: a_value /= Void
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_syntax_warning (a_value: SYNTAX_WARNING)
			-- Process object `a_value'.
		require
			is_valid: is_valid
			a_value_attached: a_value /= Void
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_user_defined_error (a_value: USER_DEFINED_ERROR)
			-- Process object `a_value'.
		require
			is_valid: is_valid
			a_value_attached: a_value /= Void
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_verbatim_string_uncompleted (a_value: VERBATIM_STRING_UNCOMPLETED)
			-- Process object `a_value'.
		require
			is_valid: is_valid
			a_value_attached: a_value /= Void
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_viin (a_value: VIIN)
			-- Process object `a_value'.
		require
			is_valid: is_valid
			a_value_attached: a_value /= Void
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
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

end
