indexing

	description:
		"Client root-class for the advanced example.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class JOIN

inherit

	NETWORK_CLIENT
		redefine
			received
		end

creation

	make_join

feature

	make_join (argv: ARRAY [STRING]) is
		do
			if argv.count /= 2 then
				io.error.putstring ("Usage: ")
				io.error.putstring (argv.item (0))
				io.error.putstring (" hostname%N")
			else
				check_name
	
				make (2000, argv.item (1))
				max_to_poll := in_out.descriptor + 1

				!!connection.make (in_out)
				!!poll.make_read_only
				poll.put_read_command (connection)
	
				!!std_input.make (io.input)
				!!input_poll.make_read_only
				input_poll.put_read_command (std_input)
	
				send_name_to_server
				processing
			end
		rescue
			io.error.putstring ("IN RESCUE%N");
			!!message_out.make_message
			message_out.set_client_name (client_name)
			message_out.set_new (False)
			message_out.set_over (True)
			send (message_out)
			cleanup
		end

feature {NONE} -- Implementation

	send_name_to_server is
		do
			!!message_out.make_message
			message_out.set_client_name (client_name)
			message_out.set_new (True)
			message_out.set_over (False)
			send (message_out)
		end

	processing is
		do
			from
				over := False
			until
				over
			loop
				scan_from_server
				if not over then
					scan_from_std_input
				end
			end
			cleanup
		end

	scan_from_std_input is
		local
			temp: STRING
		do
			std_input.initialize
			input_poll.execute (1, 15000)
			if std_input.is_waiting then
				io.readline
				temp := clone (io.laststring)
				if temp.is_equal ("bye") then
					over := True
				end
				!!message_out.make_message
				message_out.extend (temp)
				message_out.extend ("%N")
				message_out.set_over (over)
				message_out.set_client_name (client_name)
				message_out.set_new (False)
				send (message_out)
			end
		end

	check_name is
		do
			io.putstring ("Enter your name : ")
			io.readline
			client_name := clone (io.laststring)
		end

	scan_from_server is
		do
			connection.initialize
			poll.execute (max_to_poll, 15000)
			if connection.is_waiting then
				receive
				received.print_message
				if received.over then
					over := True
				end
			end
		end

	connection, std_input: CONNECTION

	message_in, message_out, received: MESSAGE

	client_name: STRING

	over: BOOLEAN

	poll, input_poll: MEDIUM_POLLER

	max_to_poll: INTEGER

end -- class JOIN

--|----------------------------------------------------------------
--| EiffelNet: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

