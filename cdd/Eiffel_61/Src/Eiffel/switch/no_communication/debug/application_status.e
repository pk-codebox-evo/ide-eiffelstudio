indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION_STATUS

feature -- Access

	is_stopped: BOOLEAN is do end
	exception_occurred: BOOLEAN is do end
	exception_code: INTEGER is do end

end
