indexing

	description:	
		"Command for Case Storage";
	date: "$Date$";
	revision: "$Revision$"

class CASE_STORAGE 

inherit

	ICONED_COMMAND
		redefine
			text_window
		end;

creation

	make
	
feature -- Initialization

	make (c: COMPOSITE; a_text_window: SYSTEM_TEXT) is
			-- Initialize the format button  with its bitmap.
			-- Set up the mouse click and control-click actions
			-- (click requires a confirmation, control-click doesn't).
		do
			init (c, a_text_window);
			set_action ("!c<Btn1Down>", Current, control_click)
		end;

feature -- Properties

	text_window: SYSTEM_TEXT;
			-- Text window associated with Current.

feature {NONE} -- Attributes

	control_click: ANY is
			-- No confirmation required, used in work
		once
			!!Result
		end;

	symbol: PIXMAP is 
			-- Symbol on the button.
		once 
			Result := bm_Case_storage 
		end;
 
	command_name: STRING is
			-- Internal command name.
		do
			Result := l_Case_storage
		end;

feature {NONE} -- Implementation

	work (argument: ANY) is
			-- Execute the command.
		local
			format_storage: E_STORE_CASE_INFO
		do
			if 
				argument = control_click or
				(last_confirmer /= Void and argument = last_confirmer)
			then
				set_global_cursor (watch_cursor);
				!! format_storage.make (Error_window);
				format_storage.execute;
				restore_cursors
			else
				confirmer (text_window).call (Current,
					"This command requires exploring the entire%N%
					%system and may take a long time...",
					"Continue")
			end
		end;
	
end -- class CASE_STORAGE
