indexing

	description:

		"Exception handling"

	usage:      "This class should not be used directly through %
				%inheritance and client/supplier relationship. %
				%Inherit from KL_SHARED_EXCEPTIONS instead."
	pattern:    "Singleton"
	library:    "Gobo Eiffel Kernel Library"
	author:     "Eric Bezault <ericb@gobo.demon.co.uk>"
	copyright:  "Copyright (c) 1997, Eric Bezault"
	date:       "$Date$"
	revision:   "$Revision$"

class KL_EXCEPTIONS

inherit

	EXCEPTIONS
		rename
			die as obsolete_die,
			new_die as die
		end

end -- class KL_EXCEPTIONS
