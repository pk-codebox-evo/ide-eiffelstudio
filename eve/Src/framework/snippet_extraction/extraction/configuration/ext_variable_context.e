note
	description: "Maintaining variable information necessary in the context of snippet extraction."
	date: "$Date$"
	revision: "$Revision$"

class
	EXT_VARIABLE_CONTEXT

create
	make

feature -- Initialization

	make
			-- Default initialization.
		do
		end

feature -- Access

	target_variables: HASH_TABLE [TYPE_A, STRING]
		assign set_target_variables
			-- Set of target variables at which we are looking at.

	interface_variables: HASH_TABLE [TYPE_A, STRING]
		assign set_interface_variables
			-- Set of interface variables.

	candidate_interface_variables: HASH_TABLE [TYPE_A, STRING]
		assign set_candidate_interface_variables
			-- Set of candidate interface variables.

feature -- Configuration

	set_target_variable (a_target_variable_type: like target_variables.item_for_iteration; a_target_variable_name: like target_variables.key_for_iteration)
			-- Configures this class with a single target variable.
		require
			attached a_target_variable_type
			attached a_target_variable_name
		local
			l_target_variables: like target_variables
		do
			create l_target_variables.make (1)
			l_target_variables.compare_objects
			l_target_variables.force (a_target_variable_type, a_target_variable_name)

			target_variables := l_target_variables
		ensure
			target_variables_not_void: target_variables /= Void
		end

	set_target_variables (a_target_variables: like target_variables)
			-- Configures this class with a set of target variables.
		require
			a_target_variables_not_void: a_target_variables /= Void
		do
			target_variables := a_target_variables
		ensure
			target_variables_not_void: target_variables /= Void
		end

	set_interface_variables (a_interface_variables: like interface_variables)
			-- Configures this class with a set of interface variables.
		require
			a_interface_variables_not_void: a_interface_variables /= Void
		do
			interface_variables := a_interface_variables
		ensure
			interface_variables_not_void: interface_variables /= Void
		end

	set_candidate_interface_variables (a_candidate_interface_variables: like candidate_interface_variables)
			-- Configures this class with a set of interface variables.
		require
			a_candidate_interface_variables_not_void: a_candidate_interface_variables /= Void
		do
			candidate_interface_variables := a_candidate_interface_variables
		ensure
			candidate_interface_variables_not_void: candidate_interface_variables /= Void
		end

	is_target_variable (a_variable_name: like {EXT_VARIABLE_CONTEXT}.target_variables.key_for_iteration): boolean
			-- query if `variable_name' is equal to the target variable.
		require
			a_variable_name_attached: a_variable_name /= void
		do
			result := target_variables.has (a_variable_name)
		end

	is_interface_variable (a_variable_name: like {EXT_VARIABLE_CONTEXT}.interface_variables.key_for_iteration): boolean
			-- query if `variable_name' is one of the interface variables.
		require
			a_variable_name_attached: a_variable_name /= void
		do
			result := interface_variables.has (a_variable_name)
		end

	is_variable_of_interest (a_variable_name: string): boolean
			-- query if `variable_name' is either the target or one of the interface variables.
		require
			a_variable_name_attached: a_variable_name /= void
		do
			result := is_target_variable (a_variable_name) or is_interface_variable (a_variable_name)
		end
		
end
