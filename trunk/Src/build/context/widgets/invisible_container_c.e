indexing
	description: "Context that represents an invisible container (EV_INVISIBLE_CONTAINER)"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INVISIBLE_CONTAINER_C

inherit
	CONTAINER_C
		redefine
			gui_object,
			is_invisible_container
		end

feature -- Status report

	is_invisible_container: BOOLEAN is
		do
			Result := True
		end

	border_width: INTEGER is
			-- Border width of the container
		deferred
		end

	border_width_modified: BOOLEAN

	spacing: INTEGER is
			-- Spacing of the container
		deferred
		end

	spacing_modified: BOOLEAN

	is_homogeneous: BOOLEAN is
			-- Is the container homogeneous
		deferred
		end

	homogeneous_modified: BOOLEAN

feature -- Status setting

	set_border_width (w: INTEGER) is
			-- Set the border width of the container.
		deferred
		end

	set_spacing (value: INTEGER) is
			-- Set the spacing of the container
		deferred
		end

	set_homogeneous (flag: BOOLEAN) is
			-- Set `is_homogeneous' to `flag'.
		deferred
		end

feature -- Implementation

	gui_object: EV_INVISIBLE_CONTAINER

end -- class INVISIBLE_CONTAINER_C

