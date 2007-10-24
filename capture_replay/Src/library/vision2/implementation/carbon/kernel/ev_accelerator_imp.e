indexing
	description: "EiffelVision accelerator. Carbon implementation."

class
	EV_ACCELERATOR_IMP

inherit
	EV_ACCELERATOR_I
		export
			{EV_INTERMEDIARY_ROUTINES} actions_internal
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Connect interface.
		do
			base_make (an_interface)
		end

	initialize is
			-- Setup `Current'
		do
			set_is_initialized (True)
		end

feature {EV_TITLED_WINDOW_IMP} -- Implementation

	modifier_mask: INTEGER is
			-- The mask consisting of alt, shift and control keys.
		do
		end

feature {EV_TITLED_WINDOW_IMP} -- Implementation

	add_accel (a_window_imp: EV_TITLED_WINDOW_IMP) is
			-- Add the current key combination
		require
			a_window_imp_not_void: a_window_imp /= Void
		do
		end

	remove_accel (a_window_imp: EV_TITLED_WINDOW_IMP) is
			-- Remove the current key combination
		require
			a_window_imp_not_void: a_window_imp /= Void
		do
		end

feature -- Access

	key: EV_KEY
			-- Representation of the character that must be entered
			-- by the user. See class EV_KEY_CODE

	shift_required: BOOLEAN
			-- Must the shift key be pressed?

	alt_required: BOOLEAN
			-- Must the alt key be pressed?

	control_required: BOOLEAN
			-- Must the control key be pressed?

feature -- Element change

	set_key (a_key: EV_KEY) is
			-- Set `a_key' as new key that has to be pressed.
		do
			key := a_key.twin
		end

	enable_shift_required is
			-- "Shift" must be pressed for the key combination.
		do
			shift_required := True
		end

	disable_shift_required is
			-- "Shift" is not part of the key combination.
		do
			shift_required := False
		end

	enable_alt_required is
			-- "Alt" must be pressed for the key combination.
		do
			alt_required := True
		end

	disable_alt_required is
			-- "Alt" is not part of the key combination.
		do
			alt_required := False
		end

	enable_control_required is
			-- "Control" must be pressed for the key combination.
		do
			control_required := True
		end

	disable_control_required is
			-- "Control" is not part of the key combination.
		do
			control_required := False
		end

feature {NONE} -- Implementation

	interface: EV_ACCELERATOR
		-- Interface object of `Current'

feature {NONE} -- Implementation

	destroy is
			-- Free resources of `Current'
		do
		end

indexing
	copyright:	"Copyright (c) 1984-2006, The Eiffel.Mac Team"
end -- class EV_ACCELERATOR_IMP

