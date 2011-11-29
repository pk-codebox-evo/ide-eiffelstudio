note
	description: "[
					Generated by EiffelRibbon tool
																							]"
	date: "$Date$"
	revision: "$Revision$"

class
	BUTTON_SHOW_MINI_TOOLBAR

inherit
	BUTTON_SHOW_MINI_TOOLBAR_IMP
		redefine
			create_interface_objects
		end

create
	{EV_RIBBON_GROUP, EV_RIBBON_SPLIT_BUTTON, EV_RIBBON_APPLICATION_MENU_GROUP, EV_RIBBON_DROP_DOWN_BUTTON, EV_RIBBON_QUICK_ACCESS_TOOLBAR} make_with_command_list

feature -- Query

	text: STRING_32 = "Button 1"
			-- This is generated by EiffelRibbon tool

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do
			Precursor
			select_actions.extend (agent
										local
											l_point: EV_COORDINATE
											l_res: EV_RIBBON_RESOURCES
											l_screen: EV_SCREEN
										do
											if attached ribbon as l_ribbon then
												create l_res
												if attached {MAIN_WINDOW} l_res.window_for_ribbon (l_ribbon) as l_win then
													create l_screen
													create l_point.make (l_screen.pointer_position.x, l_screen.pointer_position.y)
													l_win.mini_toolbar.show (l_point)
												end
											end
										end)
		end
end

