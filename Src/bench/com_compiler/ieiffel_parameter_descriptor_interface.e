indexing
	description: "Feature parameter info.  Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	name_user_precondition: BOOLEAN is
			-- User-defined preconditions for `name'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	display_user_precondition: BOOLEAN is
			-- User-defined preconditions for `display'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	name: STRING is
			-- Parameter name
		require
			name_user_precondition: name_user_precondition
		deferred

		end

	display: STRING is
			-- Parameter display
		require
			display_user_precondition: display_user_precondition
		deferred

		end

end -- IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE

