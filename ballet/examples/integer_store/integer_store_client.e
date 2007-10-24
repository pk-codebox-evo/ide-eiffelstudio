deferred class INTEGER_STORE_CLIENT

feature -- Problematic Feature

	integer_stores_assign (a,b: INTEGER_STORE) is
		require
			a_not_void: a /= Void
			b_not_void: b /= Void
			a_not_b: a /= b
		do
			a.set_value (4)
			b.set_value (5)
		ensure
			a_set: a.value = 4
			b_set: b.value = 5
		end
						
end
