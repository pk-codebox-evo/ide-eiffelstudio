indexing
	description:
		"Mswindows implementation of pick and dropable for items."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_ITEM_IMP

inherit
	EV_PICK_AND_DROPABLE_IMP
		undefine
			set_pointer_style
		redefine
			pnd_press,
			check_drag_and_drop_release
		end

feature -- Access

	pnd_original_parent: EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
		-- Actual widget parent of `Current' when PND starts.
		--| This is required as the item's parent may change during
		--| exection of the actions, while we still need to access it
		--| after the actions have been called.

	set_pnd_original_parent is
			-- Assign `parent_imp' to `pnd_original_parent'.
			--| This is done as a feature rather than just an assignment
			--| within pnd_press as EV_TREE_ITEM_IMP needs to store
			--| top_parent_imp. This allows a simply redefinition of
			--| this feature rather than pnd_press which would lead
			--| to unecessary code duplication. 
		do
			pnd_original_parent ?= parent_imp
			check
				pnd_original_parent_not_void: pnd_original_parent /= Void
			end
		end
		
	parent_imp: EV_ITEM_LIST_IMP [EV_ITEM] is
			-- Parent implementation of `Current'.
		deferred
		end

	top_level_window_imp: EV_WINDOW_IMP is
			-- Window containing `Current' in parenting heirarchy.
		local
			pickable_parent: EV_PICK_AND_DROPABLE_IMP
		do
			if parent_imp /= Void then
				pickable_parent ?= parent_imp
				check
					parent_is_item_list: pickable_parent /= Void
				end
				Result := pickable_parent.top_level_window_imp
			end
		end

	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
			-- Process a pointer press that may alter the current state
			-- of pick/drag and drop.
		do
			if press_action = Ev_pnd_start_transport then
				-- We must now check that we are not currently in a pick and drop.
					-- If we are, then we should do nothing, as the event was generated
					-- as a result of clicking on a widget while dropping.
				if application_imp.pick_and_drop_source = Void then				
						-- Now check the correct pointer_button was pressed to start 
						-- The transport, otherwise, do nothing.
					if (a_button = 1 and not mode_is_pick_and_drop) or
						(a_button = 3 and mode_is_pick_and_drop) then
						set_pnd_original_parent
						start_transport (a_x, a_y, a_button, 0, 0, 0.5, a_screen_x,
							a_screen_y)
						if pebble /= Void then
							pnd_original_parent.set_parent_source_true
							pnd_original_parent.set_item_source (Current)
							pnd_original_parent.set_item_source_true
						end
					end
				end
			elseif press_action = Ev_pnd_end_transport then
				end_transport (a_x, a_y, a_button, 0, 0, 0.5, a_screen_x, a_screen_y)
				pnd_original_parent.set_parent_source_false
				pnd_original_parent.set_item_source (Void)
				pnd_original_parent.set_item_source_false
					-- If the user cancelled a pick and drop with the left
					-- button then we need to make sure that the
					-- pointer_button_press_actions are not called on
					-- `pnd_original_parent' or an item at the current
					-- pointer position within `pnd_original_parent'.
				if a_button = 1 then
					pnd_original_parent.discard_press_event
				end
			else
				pnd_original_parent.set_parent_source_false
				pnd_original_parent.set_item_source (Void)
				pnd_original_parent.set_item_source_false
				check
					disabled: press_action = Ev_pnd_disabled
				end
			end
		end

	check_drag_and_drop_release (a_x, a_y: INTEGER) is
			-- End transport if in drag and drop.
			--| Releasing the left button ends drag and drop.
		do
			original_x := -1
			original_y := -1
			application_imp.end_awaiting_movement
			awaiting_movement := False	
			if mode_is_drag_and_drop and press_action =
				Ev_pnd_end_transport then
				end_transport (a_x, a_y, 1, 0, 0, 0, 0, 0)
				pnd_original_parent.set_parent_source_false
				pnd_original_parent.set_item_source (Void)
				pnd_original_parent.set_item_source_false
			else
				original_top_level_window_imp.move_to_foreground
			end
		end

	set_pointer_style (c: EV_CURSOR) is
			-- Assign `c' to `parent_imp' pointer style.
		local
			pickable_parent: EV_PICK_AND_DROPABLE_IMP
		do
			if parent_imp /= Void then
				pickable_parent ?= parent_imp
				check
					parent_is_item_list: pickable_parent /= Void
				end
				pickable_parent.set_pointer_style (c)
			end
		end

	set_capture is
			-- Grab user input.
			-- Works only on current windows thread.
		do
			pnd_original_parent.set_capture
		end

	release_capture is
			-- Release user input.
			-- Works only on current windows thread.
		do
			pnd_original_parent.release_capture
		end

	set_heavy_capture is
			-- Grab user input.
			-- Works on all windows threads.
		do
			pnd_original_parent.set_heavy_capture
		end

	release_heavy_capture is
			-- Release user input.
			-- Works on all windows threads.
		do
			pnd_original_parent.release_heavy_capture
		end

end -- class EV_PICK_AND_DROPABLE_ITEM_IMP

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

