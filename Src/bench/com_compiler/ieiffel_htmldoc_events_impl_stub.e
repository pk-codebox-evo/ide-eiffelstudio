indexing
	description: "Implemented `IEiffelHTMLDocEvents' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_HTMLDOC_EVENTS_IMPL_STUB

inherit
	IEIFFEL_HTMLDOC_EVENTS_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	put_header (new_value: STRING) is
			-- Put a header message to the output
			-- `new_value' [in].  
		do
			-- Put Implementation here.
		end

	put_string (new_value: STRING) is
			-- Put a string to the output
			-- `new_value' [in].  
		do
			-- Put Implementation here.
		end

	put_class_document_message (new_value: STRING) is
			-- Put a class name to the output
			-- `new_value' [in].  
		do
			-- Put Implementation here.
		end

	put_initializing_documentation is
			-- Notify that documentation generating is initializing
		do
			-- Put Implementation here.
		end

	put_percentage_completed (new_value: INTEGER) is
			-- Notify that the percentage completed has changed
			-- `new_value' [in].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IEIFFEL_HTMLDOC_EVENTS_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_EiffelComCompiler::IEiffelHTMLDocEvents_impl_stub %"ecom_EiffelComCompiler_IEiffelHTMLDocEvents_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IEIFFEL_HTMLDOC_EVENTS_IMPL_STUB

