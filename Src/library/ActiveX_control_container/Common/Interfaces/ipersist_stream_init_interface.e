indexing
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IPERSIST_STREAM_INIT_INTERFACE

inherit
	IPERSIST_INTERFACE

feature -- Status Report

	is_dirty_user_precondition: BOOLEAN is
			-- User-defined preconditions for `is_dirty'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	load_user_precondition (pstm: ECOM_STREAM): BOOLEAN is
			-- User-defined preconditions for `load'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	save_user_precondition (pstm: ECOM_STREAM; f_clear_dirty: INTEGER): BOOLEAN is
			-- User-defined preconditions for `save'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_size_max_user_precondition (pcb_size: ECOM_ULARGE_INTEGER): BOOLEAN is
			-- User-defined preconditions for `get_size_max'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	init_new_user_precondition: BOOLEAN is
			-- User-defined preconditions for `init_new'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	is_dirty is
			-- No description available.
		require
			is_dirty_user_precondition: is_dirty_user_precondition
		deferred

		end

	load (pstm: ECOM_STREAM) is
			-- No description available.
			-- `pstm' [in].  
		require
			load_user_precondition: load_user_precondition (pstm)
		deferred

		end

	save (pstm: ECOM_STREAM; f_clear_dirty: INTEGER) is
			-- No description available.
			-- `pstm' [in].  
			-- `f_clear_dirty' [in].  
		require
			save_user_precondition: save_user_precondition (pstm, f_clear_dirty)
		deferred

		end

	get_size_max (pcb_size: ECOM_ULARGE_INTEGER) is
			-- No description available.
			-- `pcb_size' [out].  
		require
			non_void_pcb_size: pcb_size /= Void
			valid_pcb_size: pcb_size.item /= default_pointer
			get_size_max_user_precondition: get_size_max_user_precondition (pcb_size)
		deferred

		end

	init_new is
			-- No description available.
		require
			init_new_user_precondition: init_new_user_precondition
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




end -- IPERSIST_STREAM_INIT_INTERFACE

