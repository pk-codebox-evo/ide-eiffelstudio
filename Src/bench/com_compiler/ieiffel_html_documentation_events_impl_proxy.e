indexing
	description: "Implemented `IEiffelHtmlDocumentationEvents' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_HTML_DOCUMENTATION_EVENTS_IMPL_PROXY

inherit
	IEIFFEL_HTML_DOCUMENTATION_EVENTS_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_ieiffel_html_documentation_events_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Status Report

	last_error_code: INTEGER is
			-- Last error code.
		do
			Result := ccom_last_error_code (initializer)
		end

	last_error_description: STRING is
			-- Last error description.
		do
			Result := ccom_last_error_description (initializer)
		end

	last_error_help_file: STRING is
			-- Last error help file.
		do
			Result := ccom_last_error_help_file (initializer)
		end

	last_source_of_exception: STRING is
			-- Last source of exception.
		do
			Result := ccom_last_source_of_exception (initializer)
		end

feature -- Basic Operations

	notify_initalizing_documentation is
			-- Notify that documentation generating is initializing
		do
			ccom_notify_initalizing_documentation (initializer)
		end

	notify_percentage_complete (ul_percent: INTEGER) is
			-- Notify that the percentage completed has changed
			-- `ul_percent' [in].  
		do
			ccom_notify_percentage_complete (initializer, ul_percent)
		end

	output_header (bstr_msg: STRING) is
			-- Put a header message to the output
			-- `bstr_msg' [in].  
		do
			ccom_output_header (initializer, bstr_msg)
		end

	output_string (bstr_msg: STRING) is
			-- Put a string to the output
			-- `bstr_msg' [in].  
		do
			ccom_output_string (initializer, bstr_msg)
		end

	output_class_document_message (bstr_msg: STRING) is
			-- Put a class name to the output
			-- `bstr_msg' [in].  
		do
			ccom_output_class_document_message (initializer, bstr_msg)
		end

	should_continue (pvb_continue: BOOLEAN_REF) is
			-- Should compilation continue.
			-- `pvb_continue' [in, out].  
		do
			ccom_should_continue (initializer, pvb_continue)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_ieiffel_html_documentation_events_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_notify_initalizing_documentation (cpp_obj: POINTER) is
			-- Notify that documentation generating is initializing
		external
			"C++ [ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy %"ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_impl_proxy_s.h%"]()"
		end

	ccom_notify_percentage_complete (cpp_obj: POINTER; ul_percent: INTEGER) is
			-- Notify that the percentage completed has changed
		external
			"C++ [ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy %"ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_impl_proxy_s.h%"](EIF_INTEGER)"
		end

	ccom_output_header (cpp_obj: POINTER; bstr_msg: STRING) is
			-- Put a header message to the output
		external
			"C++ [ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy %"ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_output_string (cpp_obj: POINTER; bstr_msg: STRING) is
			-- Put a string to the output
		external
			"C++ [ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy %"ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_output_class_document_message (cpp_obj: POINTER; bstr_msg: STRING) is
			-- Put a class name to the output
		external
			"C++ [ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy %"ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_should_continue (cpp_obj: POINTER; pvb_continue: BOOLEAN_REF) is
			-- Should compilation continue.
		external
			"C++ [ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy %"ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_impl_proxy_s.h%"](EIF_OBJECT)"
		end

	ccom_delete_ieiffel_html_documentation_events_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy %"ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_impl_proxy_s.h%"]()"
		end

	ccom_create_ieiffel_html_documentation_events_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy %"ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy %"ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_impl_proxy_s.h%"]():EIF_POINTER"
		end

	ccom_last_error_code (cpp_obj: POINTER): INTEGER is
			-- Last error code
		external
			"C++ [ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy %"ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_impl_proxy_s.h%"]():EIF_INTEGER"
		end

	ccom_last_error_description (cpp_obj: POINTER): STRING is
			-- Last error description
		external
			"C++ [ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy %"ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_impl_proxy_s.h%"]():EIF_REFERENCE"
		end

	ccom_last_error_help_file (cpp_obj: POINTER): STRING is
			-- Last error help file
		external
			"C++ [ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy %"ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_impl_proxy_s.h%"]():EIF_REFERENCE"
		end

	ccom_last_source_of_exception (cpp_obj: POINTER): STRING is
			-- Last source of exception
		external
			"C++ [ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy %"ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_impl_proxy_s.h%"]():EIF_REFERENCE"
		end

end -- IEIFFEL_HTML_DOCUMENTATION_EVENTS_IMPL_PROXY

