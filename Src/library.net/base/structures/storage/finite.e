indexing
	description: "Structures with a finite item count"
	class_type: Interface
	external_name: "ISE.Base.Finite"

deferred class
	FINITE [G]

inherit

	BOX [G]

feature -- Measurement

	count: INTEGER is
		indexing	
			description: "Number of items"
		deferred
		end

--invariant

--	empty_definition: is_empty = (count = 0)
--	non_negative_count: count >= 0

end -- class FINITE



