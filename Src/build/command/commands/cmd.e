
deferred class CMD 	

inherit

	DATA;
	SHARED_APPLICATION;
	WINDOWS;
	EDITABLE
	
feature -- Editable

	create_editor is
		local
			ed: CMD_EDITOR;
		do
			if command_editor = Void then
				ed := window_mgr.cmd_editor;
				ed.set_command (Current);
			end;
			window_mgr.display (command_editor);
		end

feature -- Instance

	has_instances: BOOLEAN is
			-- Does Current have instances?
		local
			s: STATE;
			b: BEHAVIOR
		do
			from
				Shared_app_graph.start
			until
				Shared_app_graph.off or Result
			loop
				s ?= Shared_app_graph.key_for_iteration;
				if not (s = Void) then
					from
						s.start
					until
						s.after or Result
					loop
						b := s.output.data;
						from
							b.start
						until
							b.after or
							Result
						loop
							Result := (b.output.associated_command = Current);
							b.forth
						end;
						s.forth
					end;
				end;
				Shared_app_graph.forth
			end
		end;

	instance_counter: INT_GENERATOR;

	instance_count: INTEGER is
		do
			if instance_counter = Void then
				!!instance_counter;
			end;
			Result := instance_counter.value;
			instance_counter.next;
		end;

feature -- Stone

	identifier: INTEGER is
		deferred
		end;

	eiffel_type: STRING is
			-- Name of the class representing
			-- Current command
		deferred
		end;

	arguments: EB_LINKED_LIST [ARG] is
			-- Arguments of Current command
			-- (Currently restricted to contexts)
		deferred
		end;

	labels: EB_LINKED_LIST [CMD_LABEL] is
			-- Exit labels of Current command
		deferred
		end;

	eiffel_text: STRING is
			-- Eiffel class text of Current
			-- command
		deferred
		end;

	data: CMD is
		do
			Result := Current
		end;

	symbol: PIXMAP is
		deferred
		end;

feature -- Editing

	set_eiffel_text (s: STRING) is
		do
		end;

	command_editor: CMD_EDITOR;
			-- Associated command_editor

	set_editor (ed: CMD_EDITOR) is
			-- Set command_editor to `ed'.
		do
			command_editor := ed
		end;

	reset is
			-- `Forget' command_editor.
		do
			command_editor := Void
		end;

	edited: BOOLEAN is
			-- Is Current command being edited?
		do
			Result := not (command_editor = Void)
		end;


feature -- Code Generation

	eiffel_inherit_text (rl: LINKED_LIST [STRING]): STRING is
			-- Code generation for the 
			-- inherit clause of Current.
		local
			old_label, temp: STRING;
			n: LOCAL_NAMER;
		do
			!!n.make ("argument");
			!!Result.make (0);
				temp := clone (eiffel_type);
				temp.to_upper;
			Result.append (temp);
			Result.append ("%N%T%Trename%N%T%T%Texecute as ");
				temp.to_lower;
			Result.append (temp);
			Result.append ("_execute,");
			Result.append ("%N%T%T%Tmake as ");
				temp.to_lower;
			Result.append (temp);
			Result.append ("_make");
			from
				arguments.start
			until
				arguments.after
			loop
				Result.append (",%N%T%T%T");
				n.next;
				Result.append (n.value);
				Result.append (" as ");
				Result.append (temp);
				Result.append ("_");
				Result.append (n.value);
				arguments.forth
			end;
			from
				rl.start
			until
				rl.after
			loop
				Result.append (",%N%T%T%T");
				old_label := rl.item.substring (eiffel_type.count + 2, rl.item.count);
				Result.append (old_label);
				Result.append (" as ");
				Result.append (rl.item);
				rl.forth;
			end;
			Result.append ("%N%T%Tend;%N%T");
				temp.to_upper;
			Result.append (temp);
			Result.append ("%N%T%Trename%N%T%T%Tmake as ");
				temp.to_lower;
			Result.append (temp);
			Result.append ("_make");
			from 
				n.reset;
				arguments.start
			until
				arguments.after
			loop
				Result.append (", %N%T%T%T");
				n.next;
				Result.append (n.value);
				Result.append (" as ");
				Result.append (temp);
				Result.append ("_");
				Result.append (n.value);
				arguments.forth
			end;
			from
				rl.start
			until
				rl.after
			loop
				Result.append (",%N%T%T%T");
				old_label := rl.item.substring (eiffel_type.count + 2, rl.item.count);
				Result.append (old_label);
				Result.append (" as ");
				Result.append (rl.item);
				rl.forth;
			end;
			Result.append ("%N%T%Tredefine%N%T%T%Texecute");
			Result.append ("%N%T%Tselect%N%T%T%Texecute%N%T%Tend");
		end;

	eiffel_body_text: STRING is
			-- Code generation for the 
			-- body of the command. 
		local
			temp: STRING;
		do
			!!Result.make (0);
			Result.append ("%Texecute is%N%T%Tdo%N%T%T%T");
				temp := clone (eiffel_type);
				temp.to_lower;
			Result.append (temp);
			Result.append ("_execute;%N%T%Tend;%N%N");
		end;

	eiffel_creation_text (l: LINKED_LIST [STRING]): STRING is
			-- Code generation for the 
			-- creation clause of Current.
		local
			temp: STRING
		do
			!!Result.make (0);
			Result.append ("%T%T%T");
				temp := clone (eiffel_type);
				temp.to_lower;
			Result.append (temp);
			Result.append ("_make");
			if not l.empty then
				Result.append (" (");
				from
					l.start
				until
					l.after
				loop
					Result.append (l.item);
					l.forth;
					if not l.after then
						Result.append (", ");
					end;
				end;
				Result.append (")");
			end;
			Result.append (";%N");
		end;

	remove_class is
			-- Remove associated class file when command
			-- is deleted.
		deferred
		end;

	recreate_class is
			-- Regenerate associated class file when class
			-- is undeleted
		deferred
		end;

end 
