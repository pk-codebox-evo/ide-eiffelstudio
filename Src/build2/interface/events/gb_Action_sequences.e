indexing
	description: "Objects that represent a Vision2 action sequences class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_ACTION_SEQUENCES
	
inherit
	internal

feature -- Access

	count: INTEGER is
			-- Number of action sequence in Current.
		do
			Result := names.count		
		end
		
	names: ARRAYED_LIST [STRING] is
			-- All names of action sequences contained in `Current'.
		deferred
		end
		
	
	types: ARRAYED_LIST [STRING] is
			-- All types of action sequences contained in `Current'.
		deferred
		end
	
	comments: ARRAYED_LIST [STRING] is
			-- All comments of action sequences contained in `Current'.
		deferred
		end
		
	connect_event_output_agent (object: EV_ANY; action_sequence: STRING; adding: BOOLEAN; string_handler: ORDERED_STRING_HANDLER) is
			-- If `adding', then connect an agent to `action_sequence' actions of `object' which will display name of 
			-- action sequence and all arguments in `textable'. If not `adding' then `wipe_out' `action_sequence'.
		require
			object_not_void: object /= Void
			action_sequence_not_void_or_empty: action_sequence /= Void and not action_sequence.is_empty
			string_handler_not_void: string_handler /= Void
		deferred
		end
		
invariant
	-- Cannot be executed as the invariant will not execute the once.
	-- Could reference each atribute in the 
	--lists_equal_in_length: (names.count = types.count) and (names.count = comments.count)

end -- class GB_ACTION_SEQUENCES
