class MAIN

create

	make

feature -- Main

	stack: BA_ARRAYED_STACK [INTEGER]
	stack_mml: BA_ARRAYED_STACK_MML [INTEGER]

	make is
			-- Main routine, called when the program is executed.
		do
			create stack.make (10)
			stack.push (4)
			stack.push (7)
			stack.push (1)
			check stack.top = 1 end
			stack.pop
			check stack.top = 7 end
			check stack.count = 2 end

			create stack_mml.make (10)
			stack_mml.push (4)
			stack_mml.push (7)
			stack_mml.push (1)
			check stack_mml.top = 1 end
			stack_mml.pop
			check stack_mml.top = 7 end
			check stack_mml.count = 2 end
		end
end
