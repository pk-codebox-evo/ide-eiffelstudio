
deferred class PULLDOWN_C 

inherit

	MENU_C
		rename
			cut as old_cut,
			undo_cut as old_undo_cut,
			copy_attributes as menu_copy_attributes,
			reset_modified_flags as menu_reset_modified_flags,
			context_initialization as old_context_initialization
		redefine
			set_visual_name, option_list, widget	
		end;

	MENU_C
		redefine
			set_visual_name, context_initialization, copy_attributes, 
			undo_cut, cut, option_list, widget, reset_modified_flags
		select
			cut, undo_cut, copy_attributes, context_initialization,
			reset_modified_flags
		end



	
feature 

	set_visual_name (s: STRING) is
		do
			if (s = Void) then
				visual_name := Void;
				text_modified := False;
				update_tree_element
			else
				set_text (s)
			end;
		end;

	widget: PULLDOWN;

	option_list: ARRAY [INTEGER] is
		do
			!!Result.make (1, 1);
			Result.put (pulldown_form_number, 1);
		end;

	set_text (a_string: STRING) is
        do
            text_modified := True;
            widget.set_text (a_string);
            visual_name := a_string.duplicate;
            update_tree_element
        end;

	text: STRING is
		do
			Result := widget.text
		end;

	text_modified: BOOLEAN;


	reset_modified_flags is
		do
			menu_reset_modified_flags;
			text_modified := False;
		end;

	
feature {NONE}

	copy_attributes (other_context: like Current) is
		do
			if text_modified then
				other_context.set_text (text);
			end;
			menu_copy_attributes (other_context);
		end;

	
feature {CONTEXT}

	context_initialization (context_name: STRING): STRING is
		do
			!!Result.make (0);
			if text_modified then
				function_string_to_string (Result, context_name, "set_text", text)
			end;
			Result.append (old_context_initialization (context_name));
		end;

	
feature 

	cut is
		do
			old_cut;
			widget.button.set_managed (False);
		end;

	undo_cut is
		do
			old_undo_cut;
			widget.button.set_managed (True);
		end;

end
