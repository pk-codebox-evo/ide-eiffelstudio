note
	description	: "[
						cURL debug example Eiffel version. 
						For original C version, please see:
						http://curl.haxx.se/lxr/source/docs/examples/debug.c
						
						This demo will showing how to use the debug callback.
					]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature -- Initialization

	make
			-- Run application.
		local
			l_result: INTEGER
		do
			print ("Eiffel cURL debug example.%N")

			curl_handle := curl_easy.init

			if curl_handle /= default_pointer then
				curl_easy.set_debug_function (curl_handle)
				-- The DEBUGFUNCTION has no effect until we enable VERBOSE
				curl_easy.setopt_integer (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_verbose, 1)

				curl_easy.setopt_string (curl_handle, {CURL_OPT_CONSTANTS}.curlopt_url, "www.google.com")
				l_result := curl_easy.perform (curl_handle)

				-- Always cleanup
				curl_easy.cleanup (curl_handle)
			end

		end

feature {NONE} -- Implementation

	curl_easy: CURL_EASY_EXTERNALS
			-- cURL easy externals
		once
			create Result
		end

	curl_handle: POINTER;
			-- cURL handle

note
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class APPLICATION
