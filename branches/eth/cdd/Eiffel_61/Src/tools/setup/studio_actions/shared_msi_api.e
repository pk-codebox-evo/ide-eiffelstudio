indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_MSI_API

feature -- Access

	msi_api: MSI_API is
			-- Access to global MSI api
		indexing
			once_status: global
		once
			create Result
		end

feature -- Query

	is_valid_handle (a_handle: POINTER): BOOLEAN is
			-- Determines if `a_handle' is a valid  MSI handle
		do
			Result := a_handle /= default_pointer
		end

end
