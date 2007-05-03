indexing
	description	: "Integer counter"
	date: "$Date$"
	revision: "$Revision$"

class
	COUNTER

create
	make_zero

feature -- Initialization

	make_zero is
		do
			value := 0
		ensure
			value_is_zero: value = 0
		end

	increment is
		do
			value := value + 1
		ensure
			value_incremented: value = old value + 1
		end

	decrement is
		do
			value := value - 1
		ensure
			value_decremented: value = old value - 1
		end

	add (other: COUNTER) is
		do
			value := value + other.value
		ensure
			added: value = old (value + other.value)
		end

	value: INTEGER

end -- class COUNTER
