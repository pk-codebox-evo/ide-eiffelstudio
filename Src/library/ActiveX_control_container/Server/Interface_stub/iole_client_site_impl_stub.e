indexing
	description: "Implemented `IOleClientSite' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IOLE_CLIENT_SITE_IMPL_STUB

inherit
	IOLE_CLIENT_SITE_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	save_object is
			-- No description available.
		do
			-- Put Implementation here.
		end

	get_moniker (dw_assign: INTEGER; dw_which_moniker: INTEGER; ppmk: CELL [IMONIKER_INTERFACE]) is
			-- No description available.
			-- `dw_assign' [in].  
			-- `dw_which_moniker' [in].  
			-- `ppmk' [out].  
		do
			-- Put Implementation here.
		end

	get_container (pp_container: CELL [IOLE_CONTAINER_INTERFACE]) is
			-- No description available.
			-- `pp_container' [out].  
		do
			-- Put Implementation here.
		end

	show_object is
			-- No description available.
		do
			-- Put Implementation here.
		end

	on_show_window (f_show: INTEGER) is
			-- No description available.
			-- `f_show' [in].  
		do
			-- Put Implementation here.
		end

	request_new_object_layout is
			-- No description available.
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IOLE_CLIENT_SITE_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IOleClientSite_impl_stub %"ecom_control_library_IOleClientSite_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IOLE_CLIENT_SITE_IMPL_STUB

