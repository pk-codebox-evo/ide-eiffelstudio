indexing
	description: "[
		Entry point for MSI based installation. It retrieves and checks if GDI+ is installed.

		It is highly dependent on the MSI script for property names. Make sure to
		keep this file and the installer in sync.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	GDI_PLUS_CUSTOM_ACTIONS

inherit
	MESSAGE_BOX_HELPER

	EXCEPTIONS

feature -- Status report

	is_gdi_plus_installed (a_handle: POINTER): INTEGER is
			-- Check if CD key is valid.
		require
			a_handle_not_null: a_handle /= default_pointer
		local
			l_api: MSI_API
			retried: BOOLEAN
		do
			if not retried then
				create l_api
				if c_is_gdi_plus_installed then
					l_api.set_property (a_handle, "GDIPLUSNEEDED", "0")
				else
					l_api.set_property (a_handle, "GDIPLUSNEEDED", "1")
				end
			end
			Result := {MSI_API}.error_success
		rescue
			retried := True
			message_box ("Dll Failure occurred in `is_gdi_plus_installed'.%NException message is:%N%N" + exception_trace)
			retry
		end

feature {NONE} -- Implementation

	c_is_gdi_plus_installed: BOOLEAN is
			-- Check if we can load `gdiplus.dll'.
		external
			"C inline use <windows.h>, %"eif_eiffel.h%""
		alias
			"[
				{
					HMODULE l_module = LoadLibrary(L"gdiplus.dll");
					EIF_BOOLEAN l_result = EIF_FALSE;
					if (l_module) {
						l_result = EIF_TRUE;
						FreeLibrary(l_module);
					}
					return l_result;
				}
			]"
		end

end
