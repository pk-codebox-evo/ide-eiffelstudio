indexing
	description: "Eiffel Assembly Cache access errors"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_ERRORS

inherit
	ERROR_MANAGER

feature -- Access

	Error_category: INTEGER_8 is 0x02
	
	Assembly_not_found_error: INTEGER is 0x02000001

	Consume_error: INTEGER is 0x02000002
	
	Remove_error: INTEGER is 0x02000003
	
	Not_in_eac_error: INTEGER is 0x02000004
	
	Update_error: INTEGER is 0x02000005

feature {NONE} -- Implementation

	error_message_table: HASH_TABLE [STRING, INTEGER] is
			-- Error messages
		once
			create Result.make (2)
			Result.put ("Assembly not found", Assembly_not_found_error)
			Result.put ("Could not import assembly", Consume_error)
			Result.put ("Could not remove assembly from EAC", Remove_error)
			Result.put ("Assembly is not in the EAC", Not_in_eac_error)
			Result.put ("Could not update assembly", Update_error)
		end
		
end -- class CACHE_ERRORS
