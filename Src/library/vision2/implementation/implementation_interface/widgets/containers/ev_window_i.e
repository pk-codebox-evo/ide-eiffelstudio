indexing

	description: 
		"EiffelVision window, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class

	EV_WINDOW_I
	
inherit
	
	EV_CONTAINER_I
		
--	EV_WINDOW_MANAGER_EV_WINDOW_I

	
feature {NONE} -- Initialization
	
        make is
                        -- Create a window. Window does not have any
                        -- parents
		deferred
		end
	
		
feature  -- Access


        icon_name: STRING is
                        -- Short form of application name to be
                        -- displayed by the window manager when
                        -- application is iconified
                deferred
                end

feature -- Status report

        is_iconic_state: BOOLEAN is
                        -- Does application start in iconic state?
                deferred
                end

feature -- Status setting

        set_iconic_state is
                        -- Set start state of the application to be iconic.
                deferred
                end

        set_normal_state is
                        -- Set start state of the application to be normal.
                deferred
                end

feature -- Element change

        set_icon_name (a_name: STRING) is
                        -- Set `icon_name' to `a_name'.
                deferred
                end
	
end

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
