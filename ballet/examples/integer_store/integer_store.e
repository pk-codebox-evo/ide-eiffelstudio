class INTEGER_STORE

create
	make

feature -- Initialization

	make (an_other: INTEGER_STORE) is
			-- Create a new integer store.
		do
			other := an_other
		end

feature -- Access

	value: INTEGER is
			-- Value stored
		do
			if other = Void then
				Result := v
			else
				Result := v + other.value
			end
		end

	set_value (a_value: INTEGER) is
			-- Set value to `a_value'.
		do
			if other = Void then
				v := a_value
			else
				v := a_value - other.value
			end
		ensure
			value_set: value = a_value
		end

feature {NONE} -- Implementation

	v: INTEGER
			-- Actual value stored

	other: INTEGER_STORE
			-- Reference to another INTEGER_STORE

end


