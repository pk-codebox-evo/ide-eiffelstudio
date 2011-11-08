note

	description:

		"Objects representing a feature belonging to a certain type"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class AUT_FEATURE_OF_TYPE

inherit

	HASHABLE

	DEBUG_OUTPUT

	AUT_SHARED_PREDICATE_CONTEXT

create

	make,
	make_as_creator

feature {NONE} -- Initialization

	make (a_feature: like feature_; a_type: like type)
			-- Create new object representing feature
			-- `a_feature' of type `a_type'.
		require
			a_feature_not_void: a_feature /= Void
			a_type_not_void: a_type /= Void
		do
			feature_ := a_feature
			type := a_type
		ensure
			feature_set: feature_ = a_feature
			type_set: type = a_type
		end

	make_as_creator (a_feature: like feature_; a_type: like type)
			-- Create new object representing feature
			-- `a_feature' of type `a_type' as a creator.
		require
			a_feature_not_void: a_feature /= Void
			a_type_not_void: a_type /= Void
		do
			feature_ := a_feature
			type := a_type
			is_creator := True
		ensure
			feature_set: feature_ = a_feature
			type_set: type = a_type
			is_creator_set: is_creator
		end


feature -- Access

	feature_: FEATURE_I
			-- Feature associated with `type'

	type: TYPE_A
			-- Type associated with `feature_'
			-- The type of target when `feature_' is called.

	hash_code: INTEGER
		do
			Result := feature_.feature_name_id
		end

	associated_class: CLASS_C
			-- Class from which current feature is viewed
		do
			Result := type.associated_class
		ensure
			good_result: Result = type.associated_class
		end

	feature_name: STRING
			-- Name of current feature
		do
			Result := feature_.feature_name
		ensure
			result_attached: Result /= Void
			good_result: Result.is_equal (feature_.feature_name)
		end

	argument_count: INTEGER
			-- Number of arguments in `feature_'
		do
			Result := feature_.argument_count
		ensure
			good_result: Result = feature_.argument_count
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := type.associated_class.name + "." + feature_.feature_name
		end

feature -- Status report

	is_creator: BOOLEAN
			-- Is `feature_' a creator?

feature -- Setting

	set_is_creator (b: BOOLEAN)
			-- Set `is_creator' with `b'.
		do
			is_creator := b
		ensure
			is_creator_set: is_creator = b
		end

feature -- Precondition satisfaction

	id: INTEGER
			-- Identifier for precondition satisfaction
		do
			feature_id_table.search (full_name)
			if feature_id_table.found then
				Result := feature_id_table.found_item
			end
		end

	full_name: STRING
			-- Full name of Current in form of "CLASS_NAME.feature_name'
		do
			if full_name_cache = Void then
				create full_name_cache.make (64)
				full_name_cache.append (type.associated_class.name_in_upper)
				full_name_cache.append_character ('.')
				full_name_cache.append (feature_name)
			end
			Result := full_name_cache
		end

	full_name_cache: detachable like full_name
			-- Cache for `full_name'

invariant

	feature_not_void: feature_ /= Void
	type_not_void: type /= Void

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
