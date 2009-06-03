note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IADVISE_SINK_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	on_data_change_user_precondition (p_formatetc: TAG_FORMATETC_RECORD; p_stgmed: STGMEDIUM_RECORD): BOOLEAN
			-- User-defined preconditions for `on_data_change'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	on_view_change_user_precondition (dw_aspect: INTEGER; lindex: INTEGER): BOOLEAN
			-- User-defined preconditions for `on_view_change'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	on_rename_user_precondition (pmk: IMONIKER_INTERFACE): BOOLEAN
			-- User-defined preconditions for `on_rename'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	on_save_user_precondition: BOOLEAN
			-- User-defined preconditions for `on_save'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	on_close_user_precondition: BOOLEAN
			-- User-defined preconditions for `on_close'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	on_data_change (p_formatetc: TAG_FORMATETC_RECORD; p_stgmed: STGMEDIUM_RECORD)
			-- No description available.
			-- `p_formatetc' [in].  
			-- `p_stgmed' [in].  
		require
			non_void_p_formatetc: p_formatetc /= Void
			valid_p_formatetc: p_formatetc.item /= default_pointer
			non_void_p_stgmed: p_stgmed /= Void
			valid_p_stgmed: p_stgmed.item /= Void
			on_data_change_user_precondition: on_data_change_user_precondition (p_formatetc, p_stgmed)
		deferred

		end

	on_view_change (dw_aspect: INTEGER; lindex: INTEGER)
			-- No description available.
			-- `dw_aspect' [in].  
			-- `lindex' [in].  
		require
			on_view_change_user_precondition: on_view_change_user_precondition (dw_aspect, lindex)
		deferred

		end

	on_rename (pmk: IMONIKER_INTERFACE)
			-- No description available.
			-- `pmk' [in].  
		require
			on_rename_user_precondition: on_rename_user_precondition (pmk)
		deferred

		end

	on_save
			-- No description available.
		require
			on_save_user_precondition: on_save_user_precondition
		deferred

		end

	on_close
			-- No description available.
		require
			on_close_user_precondition: on_close_user_precondition
		deferred

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




end -- IADVISE_SINK_INTERFACE

