indexing

	description:	
		"Window to search for a string in a text.";
	date: "$Date$";
	revision: "$Revision: "

class SEARCH_W 

inherit

	COMMAND_W;
	NAMER;
	PROMPT_D
		rename
			make as prompt_dialog_create
		end;
	SET_WINDOW_ATTRIBUTES

creation

	make
	
feature -- Initialization

	make (a_composite: COMPOSITE; t_w: TEXT_WINDOW) is
			-- Create a file selection dialog
		local
			void_argument: ANY
		do
			text_window := t_w;
			prompt_dialog_create (l_Search, a_composite);
			set_title (l_Search);
			set_selection_label ("search for...");
			hide_apply_button;
			hide_help_button;
			!!ok_it;
			!!cancel_it;
			set_width (200);
			set_ok_label ("Next");
			add_ok_action (Current, ok_it);
			text_window.set_action ("Ctrl<Key>d", Current, ok_it);
			add_cancel_action (Current, cancel_it);
			set_composite_attributes (Current)
		end;

feature -- Closing

	close is
		do
			if is_popped_up then
				popdown
			end
		end;

feature -- Access

	call is
			-- Record calling text_window `a_text_window' and popup current.
		do
			popup;
			raise
		end;

feature {NONE} -- Properties

	ok_it, cancel_it: ANY;
			-- Arguments for the command

	text_window: TEXT_WINDOW
			-- Text_window which popped up current

feature {NONE} -- Implementation

	work (argument: ANY) is
        do
			if last_warner /= Void then
				last_warner.popdown
			end;
			if argument = ok_it then
				text_window.search (selection_text);
				if text_window.found then
					--popdown
				end
			elseif argument = cancel_it then
				popdown
			end
		end;

end -- class SEARCH_W
