class MAIN

create

	make

feature -- Main

	b1: BANK_ACCOUNT
	b2: BANK_ACCOUNT
	
	make is
			-- Main routine, called when the program is executed.
		do
			create b1.make
			create b2.make

			b1.deposit (100)
			b1.withdraw (20)
			b1.transfer (b2,30)
			check
				b1.balance = 50
				b2.balance = 30
			end

			-- this one will break
			b1.transfer (b1,15)
			
		end
end
