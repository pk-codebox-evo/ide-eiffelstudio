indexing
	description:
		"Facility for applying boolean comparators to indexable components"

	status:	"See note at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	COMPARATOR_FACILITY

feature -- Access

	comparator: COMPARATOR_FACILITY_IMPL is
			-- Singleton instance
		once
			create Result
		end

end -- class COMPARATOR_FACILITY

--|----------------------------------------------------------------
--| EiffelTest: Reusable components for developing unit tests.
--| Copyright (C) 2000 Interactive Software Engineering Inc (ISE).
--| EiffelTest may be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
