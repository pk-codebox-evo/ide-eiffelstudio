indexing
	description	: "Command to open goto dialog for editor line access."
	date		: "$Date$"
	revision	: "$Revision $"

class
	EB_GOTO_COMMAND

inherit
	EB_EDITOR_COMMAND
		redefine
			executable
		end

create
	make

feature -- Status report

	executable: BOOLEAN is
			-- Is the operation possible?
		do
			Result := editor.is_editable
		end

feature -- Execution

	execute is
			-- Execute the operation
		do
			editor.redo
		end

feature {NONE} -- Implementation

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Goto
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_redo
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Redo
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.e_Redo
		end

	name: STRING is "Redo"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_REDO_COMMAND
