indexing
	description: "Eiffel language compiler library. Help file: "
	Note: "Automatically generated by the EiffelCOM Wizard."

deferred class
	CEIFFEL_COMPILER_COCLASS

inherit
	IEIFFEL_COMPILER_INTERFACE

	ECOM_STUB

feature -- Access

	ieiffel_compiler_events_cookie_generator: ECOM_COOKIE_GENERATOR
			-- IEiffelCompilerEvents cookie generator.

	ieiffel_compiler_events_call_back_interface_table: HASH_TABLE [IEIFFEL_COMPILER_EVENTS_IMPL_PROXY, INTEGER]
			-- IEiffelCompilerEvents table.

feature -- Status Report

	has_ieiffel_compiler_events_call_back (a_cookie: INTEGER): BOOLEAN is
			-- Has call-back?
		do
			if ieiffel_compiler_events_call_back_interface_table /= Void then
				Result := ieiffel_compiler_events_call_back_interface_table.has (a_cookie)
			end
		end

feature -- Basic Operations

	add_ieiffel_compiler_events_call_back (a_call_back: IEIFFEL_COMPILER_EVENTS_IMPL_PROXY): INTEGER is
			-- Add IEiffelCompilerEvents call back.
		require
			non_void_call_back: a_call_back /= Void
		do
			if ieiffel_compiler_events_cookie_generator = Void then
				create ieiffel_compiler_events_cookie_generator
			end
			if ieiffel_compiler_events_call_back_interface_table = Void then
				create ieiffel_compiler_events_call_back_interface_table.make (10)
			end
			Result := ieiffel_compiler_events_cookie_generator.next_key
			check
				no_key: not ieiffel_compiler_events_call_back_interface_table.has (Result)
			end
			ieiffel_compiler_events_call_back_interface_table.force (a_call_back, Result)
		ensure
			non_void_table: ieiffel_compiler_events_call_back_interface_table /= Void
			added: ieiffel_compiler_events_call_back_interface_table.has (Result)
		end

	remove_ieiffel_compiler_events_call_back (a_cookie: INTEGER) is
			-- Remove IEiffelCompilerEvents call back.
		require
			non_void_cookie_generator: ieiffel_compiler_events_cookie_generator /= Void
			non_void_table: ieiffel_compiler_events_call_back_interface_table /= Void
			has: has_ieiffel_compiler_events_call_back (a_cookie)
		do
			ieiffel_compiler_events_cookie_generator.add_key_to_pool  (a_cookie)
			ieiffel_compiler_events_call_back_interface_table.remove (a_cookie)
		ensure
			not_has:  not has_ieiffel_compiler_events_call_back (a_cookie)
			added_to_pool: ieiffel_compiler_events_cookie_generator.available_key_pool.has (a_cookie)
		end

	event_begin_compile is
			-- Beginning compilation.
		local
			retried: BOOLEAN
		do
			if not retried then
				if ieiffel_compiler_events_call_back_interface_table /= Void then
					from
						ieiffel_compiler_events_call_back_interface_table.start
					until
						ieiffel_compiler_events_call_back_interface_table.after
					loop
						ieiffel_compiler_events_call_back_interface_table.item_for_iteration.begin_compile
						ieiffel_compiler_events_call_back_interface_table.forth
					end
				end
			end
		rescue
			stop_compilation := True
			retried := True
			retry
		end

	event_begin_degree (ul_degree: INTEGER) is
			-- Start of new degree phase in compilation.
			-- `ul_degree' [in].  
		local
			retried: BOOLEAN
		do
			if not retried then
				if ieiffel_compiler_events_call_back_interface_table /= Void then
					from
						ieiffel_compiler_events_call_back_interface_table.start
					until
						ieiffel_compiler_events_call_back_interface_table.after
					loop
						ieiffel_compiler_events_call_back_interface_table.item_for_iteration.begin_degree (ul_degree)
						ieiffel_compiler_events_call_back_interface_table.forth
					end
				end
			end
		rescue
			stop_compilation := True
			retried := True
			retry
		end

	event_end_compile (vb_sucessful: BOOLEAN) is
			-- Finished compilation.
			-- `vb_sucessful' [in].  
		local
			retried: BOOLEAN
		do
			if not retried then
				if ieiffel_compiler_events_call_back_interface_table /= Void then
					from
						ieiffel_compiler_events_call_back_interface_table.start
					until
						ieiffel_compiler_events_call_back_interface_table.after
					loop
						ieiffel_compiler_events_call_back_interface_table.item_for_iteration.end_compile (vb_sucessful)
						ieiffel_compiler_events_call_back_interface_table.forth
					end
				end
			end
		rescue
			stop_compilation := True
			retried := True
			retry
		end

	event_should_continue (pvb_continue: BOOLEAN_REF) is
			-- Should compilation continue.
			-- `pvb_continue' [in, out].  
		local
			retried: BOOLEAN
		do
			if not retried then
				if ieiffel_compiler_events_call_back_interface_table /= Void then
					from
						ieiffel_compiler_events_call_back_interface_table.start
					until
						ieiffel_compiler_events_call_back_interface_table.after or stop_compilation
					loop
						ieiffel_compiler_events_call_back_interface_table.item_for_iteration.should_continue (pvb_continue)
						if not stop_compilation then
							stop_compilation := not pvb_continue.item	
						end
						ieiffel_compiler_events_call_back_interface_table.forth
					end
				end
			end
			pvb_continue.set_item (not stop_compilation)
		rescue
			stop_compilation := True
			retried := True
			retry
		end

	event_output_string (bstr_output: STRING) is
			-- Output string.
			-- `bstr_output' [in].  
		local
			retried: BOOLEAN
		do
			if not retried then
				if ieiffel_compiler_events_call_back_interface_table /= Void then
					from
						ieiffel_compiler_events_call_back_interface_table.start
					until
						ieiffel_compiler_events_call_back_interface_table.after
					loop
						ieiffel_compiler_events_call_back_interface_table.item_for_iteration.output_string (bstr_output)
						ieiffel_compiler_events_call_back_interface_table.forth
					end
				end
			end
		rescue
			stop_compilation := True
			retried := True
			retry
		end

	event_output_error (bstr_full_error: STRING; bstr_short_error: STRING; bstr_code: STRING; bstr_file_name: STRING; ul_line: INTEGER; ul_col: INTEGER) is
			-- Last error.
			-- `bstr_full_error' [in].  
			-- `bstr_short_error' [in].  
			-- `bstr_code' [in].  
			-- `bstr_file_name' [in].  
			-- `ul_line' [in].  
			-- `ul_col' [in].  
		local
			retried: BOOLEAN
		do
			if not retried then
				if ieiffel_compiler_events_call_back_interface_table /= Void then
					from
						ieiffel_compiler_events_call_back_interface_table.start
					until
						ieiffel_compiler_events_call_back_interface_table.after
					loop
						ieiffel_compiler_events_call_back_interface_table.item_for_iteration.output_error (bstr_full_error, bstr_short_error, bstr_code, bstr_file_name, ul_line, ul_col)
						ieiffel_compiler_events_call_back_interface_table.forth
					end
				end
			end
		rescue
			stop_compilation := True
			retried := True
			retry
		end

	event_output_warning (bstr_full_warning: STRING; bstr_short_warning: STRING; bstr_code: STRING; bstr_file_name: STRING; ul_line: INTEGER; ul_col: INTEGER) is
			-- Last warning.
			-- `bstr_full_warning' [in].  
			-- `bstr_short_warning' [in].  
			-- `bstr_code' [in].  
			-- `bstr_file_name' [in].  
			-- `ul_line' [in].  
			-- `ul_col' [in].  
		local
			retried: BOOLEAN
		do
			if not retried then
				if ieiffel_compiler_events_call_back_interface_table /= Void then
					from
						ieiffel_compiler_events_call_back_interface_table.start
					until
						ieiffel_compiler_events_call_back_interface_table.after
					loop
						ieiffel_compiler_events_call_back_interface_table.item_for_iteration.output_warning (bstr_full_warning, bstr_short_warning, bstr_code, bstr_file_name, ul_line, ul_col)
						ieiffel_compiler_events_call_back_interface_table.forth
					end
				end
			end
		rescue
			stop_compilation := True
			retried := True
			retry
		end

	stop_compilation: BOOLEAN
			-- should compilation be stopped?

end -- CEIFFEL_COMPILER_COCLASS

