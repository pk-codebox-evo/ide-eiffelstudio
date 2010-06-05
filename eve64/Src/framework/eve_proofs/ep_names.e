indexing
	description:
		"[
			Strings used in EVE Proofs.
		]"
	date: "$Date$"
	revision: "$Revision$"

class EP_NAMES

inherit

	SHARED_LOCALE
		export {NONE} all end

feature -- Access: Error strings

	description_no_description: STRING_32
			-- Error description that no description is available
		do
			Result := locale.translation ("No description available.")
		end

	error_file_not_found: STRING_32
			-- Error message for file not found
		do
			Result := locale.translation ("Boogie code file not found")
		end

	description_file_not_found (a_file: STRING_GENERAL): STRING_32
			-- Error description for file not found
		do
			Result := locale.formatted_string (locale.translation ("Boogie code file $1 not found."), [a_file])
		end

	error_file_not_writable: STRING_32
			-- Error message for file not found
		do
			Result := locale.translation ("Output file not writable")
		end

	description_file_not_writable (a_file: STRING_GENERAL): STRING_32
			-- Error description for file not found
		do
			Result := locale.formatted_string (locale.translation ("The output file $1 could not be written to.%NMake sure the file is writable."), [a_file])
		end

	error_launching_boogie_failed: STRING_32
			-- Error message for file not found
		do
			Result := locale.translation ("Launching Boogie failed")
		end

	description_launching_boogie_failed: STRING_32
			-- Error description for file not found
		do
			Result := locale.translation ("Launching of Boogie failed.%NMake sure Spec# is installed.%NYou can download it from http://research.microsoft.com/specsharp/.")
		end

	error_unsupported_constant_type: STRING_32
			-- Error message that constant of this type is not supported
		do
			Result := locale.translation ("Unsupported constant type")
		end

	error_unknown_verification_error: STRING_32
			-- Error message that an unknown error occured
		do
			Result := locale.translation ("An unknown error occured")
		end

	description_unknown_verification_error: STRING_32
			-- Error description that an unknown error occured
		do
			Result := locale.translation ("Boogie produced an unknown error.%NPlease report this to the developers of EVE Proofs.")
		end

	error_precondition_violation: STRING_32
			-- Error message that precondition is violated
		do
			Result := locale.translation ("Precondition of call may be violated")
		end

	description_precondition_violation: STRING_32
			-- Error description that precondition is violated
		do
			Result := locale.translation ("The precondition of this call may be violated.")
		end

	error_postcondition_violation: STRING_32
			-- Error message that postcondition is violated
		do
			Result := locale.translation ("Postcondition may be violated")
		end

	description_postcondition_violation: STRING_32
			-- Error description that postcondition is violated
		do
			Result := locale.translation ("The postcondition of this feature may be violated.")
		end

	error_invariant_violation: STRING_32
			-- Error message that invariant is violated
		do
			Result := locale.translation ("Invariant may be violated")
		end

	description_invariant_violation: STRING_32
			-- Error description that invariant is violated
		do
			Result := locale.translation ("The invariant of this class may be violated at the end of the feature.")
		end

	error_loop_invariant_violation: STRING_32
			-- Error message that loop invariant is violated
		do
			Result := locale.translation ("Loop invariant may be violated")
		end

	description_loop_invariant_violation: STRING_32
			-- Error description that loop invariant is violated
		do
			Result := locale.translation ("This loop invariant may be violated.")
		end

	error_check_violation: STRING_32
			-- Error message that check instruction is violated
		do
			Result := locale.translation ("Check may be violated")
		end

	description_check_violation: STRING_32
			-- Error description that check is violated
		do
			Result := locale.translation ("This check instruction may be violated.")
		end

	error_frame_violation: STRING_32
			-- Error message that frame condition is violated
		do
			Result := locale.translation ("Frame condition may be violated")
		end

	description_frame_violation: STRING_32
			-- Error description that frame condition is violated
		do
			Result := locale.translation ("The frame condition of this feature may be violated.")
		end

	error_syntax_error: STRING_32
			-- Error message that a syntax error occured
		do
			Result := locale.translation ("Syntax error in Boogie code")
		end

	description_syntax_error: STRING_32
			-- Error description that a syntax error occured
		do
			Result := locale.translation ("The generated Boogie code contains a syntax error.%NPlease report this to the developers of EVE Proofs.")
		end

	error_old_expression_not_allowed: STRING_32
			-- Error message that a syntax error occured
		do
			Result := locale.translation ("Old expression not allowed")
		end

	description_old_expression_not_allowed: STRING_32
			-- Error description that a syntax error occured
		do
			Result := locale.translation ("An old expression in this context is not allowed for the verification.")
		end

	error_constant_type_not_supported: STRING_32
			-- Error message that a syntax error occured
		do
			Result := locale.translation ("Constant type not supported")
		end

	description_constant_type_not_supported: STRING_32
			-- Error description that a syntax error occured
		do
			Result := locale.translation ("The type of the constant is not supported.")
		end

feature -- Access: Message strings

	message_no_classes_to_proof: STRING_32
			-- Message that no classes were added to prove
		do
			Result := locale.translation ("No classes to prove")
		end

	message_eve_proofs_started: STRING_32
			-- Message that EVE Proofs started
		do
			Result := locale.translation ("EVE Proofs started")
		end

	message_generating_boogie_code: STRING_32
			-- Message that Boogie code generating started
		do
			Result := locale.translation ("Generating Boogie code")
		end

	message_generating_boogie_code_for_class (a_class: STRING_GENERAL): STRING_32
			-- Message that Boogie code is generated for `a_class'
		do
			Result := locale.formatted_string (locale.translation ("Generating Boogie code: $1"), [a_class])
		end

	message_generating_referenced_features: STRING_32
			-- Message that Boogie code is generated for referenced features
		do
			Result := locale.translation ("Generating Boogie code: Referenced features")
		end

	message_boogie_running: STRING_32
			-- Message that verifier is running
		do
			Result := locale.translation ("Boogie running")
		end

	message_eve_proofs_finished: STRING_32
			-- Message that EVE Proofs finished
		do
			Result := locale.translation ("EVE Proofs finished")
		end

	message_code_generation_failed: STRING_32
			-- Message that code generation failed
		do
			Result := locale.translation ("Code generation failed")
		end

	message_boogie_version (a_version: STRING_GENERAL): STRING_32
			-- Message which Boogie version is used
		do
			Result := locale.formatted_string (locale.translation ("Boogie version $1"), [a_version])
		end

	message_boogie_finished (a_verified, a_errors: STRING_GENERAL): STRING_32
			-- Message that Boogie has finished
		do
			Result := locale.formatted_string (locale.translation ("Boogie finished ($1 verified, $2 errors)"), [a_verified, a_errors])
		end

feature -- Access: Command strings

	verify_class_menu_name: STRING_32
			-- Menu name to verify class
		do
			Result := locale.translation ("Prove class")
		end

	verify_class_menu_description: STRING_32
			-- Menu name to verify class
		do
			Result := locale.translation ("Statically prove class using EVE Proofs")
		end

	verify_class_context_menu_name (a_class: STRING_GENERAL): STRING_32
			-- Menu name to verify class
		do
			Result := locale.formatted_string (locale.translation ("Prove class $1"), [a_class])
		end

	verify_cluster_menu_name: STRING_32
			-- Menu name to verify class
		do
			Result := locale.translation ("Prove cluster")
		end

	verify_cluster_menu_description: STRING_32
			-- Menu name to verify class
		do
			Result := locale.translation ("Statically prove cluster using EVE Proofs")
		end

	verify_cluster_context_menu_name (a_cluster: STRING_GENERAL): STRING_32
			-- Menu name to verify class
		do
			Result := locale.formatted_string (locale.translation ("Prove cluster $1"), [a_cluster])
		end

	verify_library_context_menu_name (a_cluster: STRING_GENERAL): STRING_32
			-- Menu name to verify class
		do
			Result := locale.formatted_string (locale.translation ("Prove library $1"), [a_cluster])
		end

	proof_current_item: STRING_32
			-- Menu item name to proof current item.
		do
			Result := locale.translation ("Prove current item")
		end

	proof_parent_item: STRING_32
			-- Menu item name to proof parent of current item
		do
			Result := locale.translation ("Prove parent cluster of current item")
		end

	proof_system: STRING_32
			-- Menu item name to proof system
		do
			Result := locale.translation ("Prove system")
		end

	command_menu_name: STRING_32
			-- Menu name of command
		do
			Result := locale.translation ("Prove Current Item")
		end

	command_tooltip: STRING_32
			-- Tooltip of command
		do
			Result := locale.translation ("Prove class or cluster")
		end

	command_tooltext: STRING_32
			-- Text of command button
		do
			Result := locale.translation ("Prove")
		end

	command_description: STRING_32
			-- Description of command button
		do
			Result := locale.translation ("Prove class or cluster")
		end

feature -- Access: Proof tool strings

	tool_header_class: STRING_32
			-- Header for class column
		do
			Result := locale.translation ("Class")
		end

	tool_header_feature: STRING_32
			-- Header for feature column
		do
			Result := locale.translation ("Feature")
		end

	tool_header_information: STRING_32
			-- Header for information column
		do
			Result := locale.translation ("Information")
		end

	tool_header_position: STRING_32
			-- Header for position column
		do
			Result := locale.translation ("Position")
		end

	tool_header_time: STRING_32
			-- Header for time column
		do
			Result := locale.translation ("Time [ms]")
		end

	tool_button_successful: STRING_32
			-- Button text for successful button
		do
			Result := locale.translation ("Successful")
		end

	tool_button_failed: STRING_32
			-- Button text for failed button
		do
			Result := locale.translation ("Failed")
		end

	tool_button_skipped: STRING_32
			-- Button text for skipped button
		do
			Result := locale.translation ("Skipped")
		end

	tool_text_filter: STRING_32
			-- Text for filter label
		do
			Result := locale.translation ("Filter")
		end

end
