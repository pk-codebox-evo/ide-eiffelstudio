indexing
	description	: "Example on how to use the class WEL_DISK_SPACE"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	DISKSPACE_DEMO

creation
	make

feature -- Initialization

	make is
			-- Main Initialization routine.
		local
			drive: CHARACTER -- Current drive checked.
		do
			from
				drive := 'C'
				disk_space.query_local_drive(drive)
			until
				disk_space.last_query_success = False
			loop
				io.putstring ("Drive ")
				io.putchar (drive)
				io.putstring (" :%T");
				io.putstring (disk_space.last_free_space_in_string+" Free / ")
				io.putstring (disk_space.last_total_space_in_string+ " Total")
				io.new_line

				drive := drive + 1
				disk_space.query_local_drive(drive)
			end
		end

	disk_space: WEL_DISK_SPACE is
			-- Object use to query disk space.
		once
			create Result
		end

end -- class DISKSPACE_DEMO

