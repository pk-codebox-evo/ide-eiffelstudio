indexing
	description: "Sensitive check."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DV_SENSITIVE_CHECK

feature -- Access

	checked: BOOLEAN is
			-- Is property checked?
		deferred
		end

feature -- Basic operations

	enable_checked is
			-- Check property.
		deferred
		end

	disable_checked is
			-- Uncheck property.
		deferred
		end

	request_sensitive is
			-- Request display sensitive.
		deferred
		end

	request_insensitive is
			-- Request display insensitive.
		deferred
		end

indexing

	library: "[
			EiffelStore: library of reusable components for ISE Eiffel.
			]"

	status: "[
			Copyright (C) 1986-2001 Interactive Software Engineering Inc.
			All rights reserved. Duplication and distribution prohibited.
			May be used only with ISE Eiffel, under terms of user license. 
			Contact ISE for any other use.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Contact: http://contact.eiffel.com
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_SENSITIVE_CHECK
