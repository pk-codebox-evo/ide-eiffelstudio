indexing
	description: "Implemented `ISequentialStream' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	ISEQUENTIAL_STREAM_IMPL_STUB

inherit
	ISEQUENTIAL_STREAM_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	remote_read (pv: CHARACTER_REF; cb: INTEGER; pcb_read: INTEGER_REF) is
			-- No description available.
			-- `pv' [out].  
			-- `cb' [in].  
			-- `pcb_read' [out].  
		do
			-- Put Implementation here.
		end

	remote_write (pv: CHARACTER_REF; cb: INTEGER; pcb_written: INTEGER_REF) is
			-- No description available.
			-- `pv' [in].  
			-- `cb' [in].  
			-- `pcb_written' [out].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: ISEQUENTIAL_STREAM_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::ISequentialStream_impl_stub %"ecom_control_library_ISequentialStream_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- ISEQUENTIAL_STREAM_IMPL_STUB

