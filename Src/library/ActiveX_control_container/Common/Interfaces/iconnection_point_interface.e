indexing
	description: "Control interfaces. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	ICONNECTION_POINT_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	get_connection_interface_user_precondition (p_iid: ECOM_GUID): BOOLEAN is
			-- User-defined preconditions for `get_connection_interface'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_connection_point_container_user_precondition (pp_cpc: CELL [ICONNECTION_POINT_CONTAINER_INTERFACE]): BOOLEAN is
			-- User-defined preconditions for `get_connection_point_container'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	advise_user_precondition (p_unk_sink: ECOM_INTERFACE; pdw_cookie: INTEGER_REF): BOOLEAN is
			-- User-defined preconditions for `advise'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	unadvise_user_precondition (dw_cookie: INTEGER): BOOLEAN is
			-- User-defined preconditions for `unadvise'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	enum_connections_user_precondition (ppenum: CELL [IENUM_CONNECTIONS_INTERFACE]): BOOLEAN is
			-- User-defined preconditions for `enum_connections'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	get_connection_interface (p_iid: ECOM_GUID) is
			-- No description available.
			-- `p_iid' [out].  
		require
			non_void_p_iid: p_iid /= Void
			valid_p_iid: p_iid.item /= default_pointer
			get_connection_interface_user_precondition: get_connection_interface_user_precondition (p_iid)
		deferred

		end

	get_connection_point_container (pp_cpc: CELL [ICONNECTION_POINT_CONTAINER_INTERFACE]) is
			-- No description available.
			-- `pp_cpc' [out].  
		require
			non_void_pp_cpc: pp_cpc /= Void
			get_connection_point_container_user_precondition: get_connection_point_container_user_precondition (pp_cpc)
		deferred

		ensure
			valid_pp_cpc: pp_cpc.item /= Void
		end

	advise (p_unk_sink: ECOM_INTERFACE; pdw_cookie: INTEGER_REF) is
			-- No description available.
			-- `p_unk_sink' [in].  
			-- `pdw_cookie' [out].  
		require
			non_void_pdw_cookie: pdw_cookie /= Void
			advise_user_precondition: advise_user_precondition (p_unk_sink, pdw_cookie)
		deferred

		end

	unadvise (dw_cookie: INTEGER) is
			-- No description available.
			-- `dw_cookie' [in].  
		require
			unadvise_user_precondition: unadvise_user_precondition (dw_cookie)
		deferred

		end

	enum_connections (ppenum: CELL [IENUM_CONNECTIONS_INTERFACE]) is
			-- No description available.
			-- `ppenum' [out].  
		require
			non_void_ppenum: ppenum /= Void
			enum_connections_user_precondition: enum_connections_user_precondition (ppenum)
		deferred

		ensure
			valid_ppenum: ppenum.item /= Void
		end

end -- ICONNECTION_POINT_INTERFACE

