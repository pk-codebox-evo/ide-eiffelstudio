indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_BOTTOM_BOX

inherit
	WIZARD_BOTTOM_BOX_IMP

feature -- Initialization

	setup (a_next_routine: like next_routine; a_label: STRING) is
			-- Set `next_routine' with `a_next_routine'.
		do
			next_routine := a_next_routine
			if a_label /= Void then
				next_button.set_text (a_label)
			end
		ensure
			next_routine_set: next_routine = a_next_routine
		end

feature -- Access

	next_routine: ROUTINE [ANY, TUPLE[]]
			-- Routine called when `next' button is clicked

feature -- Basic Operation

	enable_button (a_bool: BOOLEAN) is
			-- Enable button if `a_bool', disable ite otherwise.
		do
			if a_bool then
				next_button.enable_sensitive
			else
				next_button.disable_sensitive
			end
		end
		
feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
		end

feature {NONE} -- Implementation

	
	on_next is
			-- Called by `select_actions' of `next_button'.
		do
			if next_routine /= Void then
				next_routine.call (Void)
			end
		end

end -- class WIZARD_BOTTOM_BOX

