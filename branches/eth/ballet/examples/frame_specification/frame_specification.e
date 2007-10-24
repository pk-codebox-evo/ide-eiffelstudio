class FRAME_SPECIFICATION

create

	make

feature -- Settor

	set_values (a,b: INT_STORE) is
			-- A problematic routine.
		require
			a_not_void: a /= Void
			b_not_void: b /= Void
			a_not_b: a /= b
			frame_requirement: a.value_frame.is_disjoint_from (b.set_value_frame)
		do
			a.set_value(4)
			b.set_value(5)
		ensure
			a_set: a.value = 4
			b_set: b.value = 5
		end

feature -- Main

	make is
			-- Main routine, called when the program is executed.
		local
			a: REL_INT_STORE
			b: ABS_INT_STORE
		do
			create b
			create a.make(b)
			Current.set_values(b,a)
			print (a.value)
			print ("%N")
			print (b.value)
			print ("%N")
		end

end
