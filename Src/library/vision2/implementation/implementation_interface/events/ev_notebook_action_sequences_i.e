indexing
	description:
		"Action sequences for EV_NOTEBOOK_I."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_NOTEBOOK_ACTION_SEQUENCES_I


feature -- Event handling

	selection_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `selected_item' changes.
		do
			if selection_actions_internal = Void then
				selection_actions_internal :=
					 create_selection_actions
			end
			Result := selection_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_selection_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a selection action sequence.
		deferred
		end

	selection_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `selection_actions'.

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

