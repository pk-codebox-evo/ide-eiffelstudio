indexing

	description:
		"Command to popup the menu for a toolbar.";
	date: "$Date$";
	revision: "$Revision$"

class TOOLBAR_CMD

inherit
	COMMAND

creation
	make

feature {NONE} -- Initialization

	make (a_tool: TOOL_W) is
			-- Initialize Current with `a_tool' as `tool'.
		do
			tool := a_tool
		end

feature -- Execution

	execute (argument: ANY) is
			-- Execute Current
		local
			popup: POPUP;
			entry: PUSH_B;
			e_text: STRING;
			a_bar: TOOLBAR;
			arg: ANY;
			bars: ARRAYED_LIST [WIDGET];
			sep: SEPARATOR;
			screen: SCREEN
		do
			screen := tool.toolbar_parent.screen;

			if tool.popup_cell.item /= Void and then tool.popup_cell.item.parent = tool.toolbar_parent then
				popup := tool.popup_cell.item
			else
				!! popup.make ("", tool.toolbar_parent);
				popup.set_title ("Toolbars");
				!! sep.make ("", popup);

				from
					bars := tool.toolbar_parent.children;
					bars.finish
				until
					bars.before
				loop
					a_bar ?= bars.item;
					if a_bar /= Void then
						!! e_text.make (0);
						if a_bar.managed then
							e_text.append ("Hide ");
							arg := a_bar.arg_hide
						else
							e_text.append ("Show ");
							arg := a_bar.arg_show
						end;
						e_text.append (a_bar.identifier);
						!! entry.make (e_text, popup);
						entry.add_activate_action (a_bar, arg)
					end
					bars.back
				end;
				tool.popup_cell.put (popup)
			end;
			popup.set_x_y (screen.x, screen.y);
			popup.popup
		end

feature {NONE} -- Properties

	tool: TOOL_W
			-- Tool window that holds the popup.

end -- class TOOLBAR_CMD
