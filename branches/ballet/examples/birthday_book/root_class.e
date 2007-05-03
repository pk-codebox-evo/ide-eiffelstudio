indexing

class
	ROOT_CLASS

create
	make

feature -- Initialization

	make is
			-- Run unit tests
		local
			bbook: BIRTHDAY_BOOK
			date1: BB_DATE
			name1: BB_NAME
			date2: BB_DATE
			name2: BB_NAME
			date3: BB_DATE
			name3: BB_NAME
			x : FLAT_LINKED_LIST[BB_NAME]
		do
			create bbook.make

			create name1.make("Bernd Schoeller")
			create date1.make (5,4)
			bbook.add_birthday (name1,date1)

			create name2.make("Pharrell Williams")
			create date2.make (5,4)
			bbook.add_birthday (name2,date2)

			create name3.make("Jana Steinbrueck")
			create date3.make (13,12)
			bbook.add_birthday (name3,date3)

			print(bbook.find_birthday(name3).month)
			print("%N")
			from
				x := bbook.remind(date1)
				x.start
			until
				x.off
			loop
				print(x.item.string_name)
				print("%N")
				x.forth
			end
			print("%N")
		end

end -- class ROOT_CLASS
