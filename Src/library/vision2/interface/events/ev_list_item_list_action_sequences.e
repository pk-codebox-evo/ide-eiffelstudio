indexing
	description:
		"Action sequences for EV_LIST_ITEM_LIST."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_LIST_ITEM_LIST_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create, copy
		end

feature {NONE} -- Implementation

	implementation: EV_LIST_ITEM_LIST_ACTION_SEQUENCES_I

feature -- Event handling


	select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when an item is selected.
		do
			Result := implementation.select_actions
		ensure
			not_void: Result /= Void
		end


	deselect_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when an item is deselected.
		do
			Result := implementation.deselect_actions
		ensure
			not_void: Result /= Void
		end

end
