note
	description: "Eiffel Vision Progress bar. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR_IMP

inherit
	EV_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		redefine
			interface,
			make,
			set_value,
			set_range
		end

feature {NONE} -- Implementation

	old_make (an_interface: like interface)
			-- Create the progress bar.
		do
			assign_interface (an_interface)
		end

	make
		do
			create progress_indicator.make
			--progress_indicator.start_animation
			progress_indicator.set_indeterminate (False)
			cocoa_item := progress_indicator
		end

	set_value (a_value: INTEGER)
			-- Set `value' to `a_value'.
		do
			Precursor {EV_GAUGE_IMP} (a_value)
			progress_indicator.set_double_value (a_value)
		end

	set_range
		do
			Precursor {EV_GAUGE_IMP}
			progress_indicator.set_min_value (value_range.lower)
			progress_indicator.set_max_value (value_range.upper)
		end

feature -- Status report

	is_segmented: BOOLEAN
			-- Is display animated ?

feature -- Status setting

	enable_segmentation
			-- Display bar is animated
		do
			progress_indicator.start_animation
			is_segmented := True
		end

	disable_segmentation
			-- Display bar is not animated
		do
			progress_indicator.stop_animation
			is_segmented := False
		end

feature {EV_ANY_I} -- Implementation

	progress_indicator: NS_PROGRESS_INDICATOR

	interface: detachable EV_PROGRESS_BAR note option: stable attribute end;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_PROGRESS_BAR_IMP

