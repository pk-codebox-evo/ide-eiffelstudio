indexing
	description: "This class represents a MS_WINDOWS timer";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	TIMER_WINDOWS

inherit
	TIMER_I

	G_ANY_WINDOWS

	WEL_FRAME_WINDOW
		rename
			destroy as wel_destroy
		redefine
			on_timer
		end

creation
	make

feature -- Initialization

	make (a_timer: TIMER) is
		do
			make_top ("")
		end
 
feature -- Status report

 	is_call_back_set: BOOLEAN is
			-- Is a call back already set ?
		do
			Result := call_back_set
		end

	is_regular_call_back: BOOLEAN is
			-- Is the call back set a regular one ?
		do
			Result := call_back_regular
		end 

feature -- Status setting

	set_next_call_back (a_delay: INTEGER; a_command: COMMAND; an_argument: ANY) is
			-- Set `a_command' with `argument' to execute when `a_delay'
			-- in milliseconds has expired.
		local
			bw: BASE_WINDOWS
		do
			timer_actions.add (bw, a_command, an_argument)
			current_callback := a_command
			current_arg := an_argument
			call_back_set := True
			call_back_regular := False
			set_timer (timer_id, a_delay)
		end 

	set_no_call_back is
			-- Remove any call-back already set.
		local
			bw: BASE_WINDOWS
		do
			timer_actions.remove (bw, current_callback, current_arg)
			call_back_set := False
			call_back_regular := False
			kill_timer (timer_id)
		end 

	set_regular_call_back (a_time: INTEGER; a_command: COMMAND; an_argument: ANY) is
			-- Set `a_command' with `argument' to execute all the `a_time'
			-- milliseconds.
		local
			bw: BASE_WINDOWS
		do
			timer_actions.add (bw, a_command, an_argument)
			current_callback := a_command
			current_arg := an_argument
			call_back_set := True
			call_back_regular := True
			set_timer (timer_id, a_time)
		end

	destroy is
		do
		end

feature {NONE} -- Implementation

	on_timer (a_timer_id: INTEGER) is
		do
			check
				valid_id: a_timer_id = timer_id
			end
			print ("tick")
			current_callback.execute (current_arg)
			if not call_back_regular then
				kill_timer (timer_id)
			end
		end

	current_callback: COMMAND

	current_arg: ANY

	call_back_set: BOOLEAN

	call_back_regular: BOOLEAN

	timer_id: INTEGER is 1
			-- Timer identifier


end -- TIMER_W 
 
--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
