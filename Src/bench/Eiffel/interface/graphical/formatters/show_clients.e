-- Command to display class clients.

class SHOW_CLIENTS 

inherit

	FORMATTER

creation

	make

feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window);
			indent := 4
		end;

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Showclients) 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showclients end;

	title_part: STRING is do Result := l_Clients_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display clients of `c' in tree form.
		local
			clients: LINKED_LIST [CLASS_C];
			class_c: CLASSC_STONE
		do
			text_window.put_string ("Clients of class ");
			text_window.put_clickable_string (c, c.signature);
			text_window.put_string (":%N%N");
			from
				clients := c.class_c.clients;
				clients.start
			until
				clients.after
			loop
				if (c.class_c /= clients.item) then
					!!class_c.make (clients.item);
					text_window.put_string (tabs (1));
					text_window.put_clickable_string (class_c, class_c.signature);
					text_window.new_line;
				end;
				clients.forth
			end
		end

end
