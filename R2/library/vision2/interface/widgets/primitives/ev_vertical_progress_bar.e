note
	description:
		"[
			Vertical bar graph gauge for displaying progress of a process.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			+--+
			|  |
			|  |
			|  |
			|25|
			|  |
			|##|
			|##|
			+--+
		]"
	status: "See notice at end of class."
 	keywords: "status, progress, bar, vertical"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_PROGRESS_BAR

inherit
	EV_PROGRESS_BAR
		redefine
			implementation
		end

create
	default_create,
	make_with_value_range

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_VERTICAL_PROGRESS_BAR_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_VERTICAL_PROGRESS_BAR_IMP}
				implementation.make
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_VERTICAL_PROGRESS_BAR





