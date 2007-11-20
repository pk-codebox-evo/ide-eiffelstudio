indexing
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IOLE_PARENT_UNDO_UNIT_INTERFACE

inherit
	IOLE_UNDO_UNIT_INTERFACE

feature -- Status Report

	open_user_precondition (p_puu: IOLE_PARENT_UNDO_UNIT_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `open'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	close_user_precondition (p_puu: IOLE_PARENT_UNDO_UNIT_INTERFACE; f_commit: INTEGER): BOOLEAN is
			-- User-defined preconditions for `close'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	add_user_precondition (p_uu: IOLE_UNDO_UNIT_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `add'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	find_unit_user_precondition (p_uu: IOLE_UNDO_UNIT_INTERFACE): BOOLEAN is
			-- User-defined preconditions for `find_unit'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_parent_state_user_precondition (pdw_state: INTEGER_REF): BOOLEAN is
			-- User-defined preconditions for `get_parent_state'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	open (p_puu: IOLE_PARENT_UNDO_UNIT_INTERFACE) is
			-- No description available.
			-- `p_puu' [in].  
		require
			open_user_precondition: open_user_precondition (p_puu)
		deferred

		end

	close (p_puu: IOLE_PARENT_UNDO_UNIT_INTERFACE; f_commit: INTEGER) is
			-- No description available.
			-- `p_puu' [in].  
			-- `f_commit' [in].  
		require
			close_user_precondition: close_user_precondition (p_puu, f_commit)
		deferred

		end

	add (p_uu: IOLE_UNDO_UNIT_INTERFACE) is
			-- No description available.
			-- `p_uu' [in].  
		require
			add_user_precondition: add_user_precondition (p_uu)
		deferred

		end

	find_unit (p_uu: IOLE_UNDO_UNIT_INTERFACE) is
			-- No description available.
			-- `p_uu' [in].  
		require
			find_unit_user_precondition: find_unit_user_precondition (p_uu)
		deferred

		end

	get_parent_state (pdw_state: INTEGER_REF) is
			-- No description available.
			-- `pdw_state' [out].  
		require
			non_void_pdw_state: pdw_state /= Void
			get_parent_state_user_precondition: get_parent_state_user_precondition (pdw_state)
		deferred

		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IOLE_PARENT_UNDO_UNIT_INTERFACE

