indexing

	description:	
		"Manager for all edit windows.";
	date: "$Date$";
	revision: "$Revision$"

class EDITOR_MGR 

inherit

	GRAPHICS;
	WINDOWS

feature -- Initialization

	make (a_screen: SCREEN; i: INTEGER) is
			-- Create a window manager. All editors will be create 
			-- with `a_screen' as the parent.
		do
			free_list_max := i;
			screen := a_screen;
			!!active_editors.make;
			!!free_list.make
		end;

feature -- Properties

	active_editors: LINKED_LIST [like editor_type];
			-- Editors currently active 

feature -- Fonts

	set_font_to_default is
			-- Set the font of all active editors to the default font.
		do
			from 
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.text_window.set_font_to_default;
				active_editors.forth
			end
		end;

feature -- Tabulations

	set_tab_length_to_default is
			-- Set the tab length of all active editors 
			-- to the default tab length.
		local
			text_window: TEXT_WINDOW;
			was_changed: BOOLEAN
		do
			from 
				active_editors.start
			until
				active_editors.after
			loop
				text_window := active_editors.item.text_window;
				was_changed := text_window.changed;
				text_window.set_tab_length_to_default;
				text_window.set_changed (was_changed);
				text_window.tool.update_save_symbol;
				active_editors.forth
			end
		end;

feature -- Synchronization

	synchronize is
			-- Synchronize active editors.
			-- Set them back to their default format.
		do
			from 
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.set_default_format;
				active_editors.item.synchronize;
				active_editors.forth
			end
		end;

feature -- Modifications

	changed: BOOLEAN is
			-- Has the text of one of the active editor been edited
			-- since last display?
		do
			from
				active_editors.start
			until
				Result or active_editors.after
			loop
				Result := active_editors.item.text_window.changed
				active_editors.forth
			end;
		end;

feature {NONE} -- Properties

	editor_type: BAR_AND_TEXT;
			-- Abstract window type. Redefined in descendants
			-- for specific window creation

	free_list: LINKED_LIST [like editor_type];
			-- Editors that has been requested to be destroyed 

	free_list_max: INTEGER;

	screen: SCREEN;
			-- Screen used for window creation

feature {WINDOW_MGR} -- Properties

	count: INTEGER is
		do
			Result := active_editors.count
		end;

	empty_editor: like editor_type is
			-- Retrieve an empty editor. If not found
			-- then create one.
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.forth
			end;
			if not active_editors.after then
				Result := active_editors.item
			else
				Result := top_shell_editor
			end
		end;

	form_d_editor: like editor_type is
		local
			mp: MOUSE_PTR;
			ed: BAR_AND_TEXT;
			fd: EB_FORM_DIALOG
		do
			!! mp.set_watch_cursor;
			!! fd.make ("", Project_tool);
			ed := shell_editor (fd);
			fd.set_title (ed.tool_name);
			Result ?= ed;
			mp.restore;
		end;

	top_shell_editor: like editor_type is
		local
			mp: MOUSE_PTR;
			ed: BAR_AND_TEXT;
			ts: EB_TOP_SHELL
		do
			!! mp.set_watch_cursor;
			!! ts.make ("", Project_tool.screen);
			ed := shell_editor (ts);
			ts.set_title (ed.tool_name);
			Result ?= ed
			mp.restore;
		end;

	shell_editor (a_parent: EB_SHELL): like editor_type is
			-- Creates new editor. (Either creates one or
			-- retrieves one from the free_list).
		local
			mp: MOUSE_PTR
		do
			if
				not free_list.empty
			then
				free_list.start;
				Result := free_list.item;
				Result.set_default_position;
				Result.text_window.set_tab_length_to_default;
				Result.text_window.set_font_to_default;
				free_list.remove;
			else
				!! Result.make_shell (a_parent);
			end;
			active_editors.extend (Result);
		end;

	has (ed: like editor_type): BOOLEAN is
			-- Is editor `ed' displayed?
		do
			Result := active_editors.has (ed)
		end;

feature {WINDOW_MGR} -- Implementation

	hide_editors is
			-- Hide all active editors.
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.hide;
				active_editors.item.close_windows;
				active_editors.forth
			end;
		end;

	show_editors is
			-- Show all active editors.
		local
			ed: like editor_type
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				ed := active_editors.item;
				ed.show;
				ed.set_x_y (ed.eb_shell.x, ed.eb_shell.y);
				active_editors.forth
			end
		end;

	remove (ed: like editor_type) is
			-- Remove an editor `ed'.
		do
			active_editors.start;
			active_editors.compare_references
			active_editors.search (ed);
			if
				not active_editors.after
			then
				ed.close;
				active_editors.remove;
				if free_list.count >= free_list_max then
print("First destroy:%N")
					ed.destroy
				else
					free_list.extend (ed)
				end;
			else
					--| Should never happen but this is ultra
					--| safe programming.
				ed.close;
				ed.unregister_holes;
				if ed.is_a_shell then
					ed.destroy
				end
			end;
		end;

	raise_editors is
			-- Raise all active editors.
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.raise;
				active_editors.forth
			end
		end;

end -- class EDITOR_MGR
