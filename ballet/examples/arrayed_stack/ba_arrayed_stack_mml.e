class BA_ARRAYED_STACK_MML [G]

create

	make

feature -- Model

	model_sequence: MML_SEQUENCE [G] is
			-- Sequence of the elements model
		local
			i: INTEGER
		do
			create {MML_DEFAULT_SEQUENCE[G]}Result.make_empty
			from i := 1 until i > count loop
				Result := Result.extended (container.item(i))
				i := i + 1
			end
		end

	model_capacity: INTEGER is
			-- Capacity model
		do
			Result := capacity
		end
	
	model: MML_PAIR [MML_SEQUENCE [G], INTEGER] is
			-- Combined model
		do
			create {MML_DEFAULT_PAIR[MML_SEQUENCE[G],INTEGER]}Result.make_from
			(model_sequence,model_capacity)
		end
	
feature -- Initialization

	make (a_capacity: INTEGER) is
			-- Create a stack with the maximum capacity of `a_capacity'.
		require
			capacity_positive: capacity > 0
		do
			capacity := a_capacity
			count := 0
			create container.make (1,capacity)
		ensure
			count_set: count = 0
			capacity_set: capacity = a_capacity
							  
			model_sequence_empty: model_sequence.is_empty
			model_capacity_set: model_capacity = a_capacity
		end
	
feature -- Operations

	capacity: INTEGER
			-- Capacity of the stack.

	count: INTEGER
			-- Number of elements stored on the stack.

	push (a_value: G) is
			-- Push `a_value' onto the stack.
		require
			not_full: count < capacity
			model_not_full: model_sequence.count < model_capacity
		do
			count := count + 1
			container.put (a_value,count)
		ensure
			count_increased: count = old count + 1
			value_on_top: top = a_value

			model_sequence_increased: model_sequence =
											  old model_sequence.extended (a_value)
			model_capacity_unchanged: model_capacity = old model_capacity
		end

	top: G is
			-- Top element
		require
			not_empty: count > 0
			model_not_empty: not model_sequence.is_empty
		do
			Result := container.item (count)
		ensure
			model_unchanged: model = old model			
		end

	pop is
			-- Remove top element.
		require
			not_empty: count > 0
			model_not_empty: not model_sequence.is_empty
		do
			count := count - 1
		ensure
			count_decreased: count = old count - 1
								  
			model_sequence_decreased: model_sequence =
											  old model_sequence.front
			model_capacity_unchanged: model_capacity = old model_capacity
		end
	
feature {NONE} -- Implementation

	container: ARRAY[G]

invariant
	container_not_void: container /= Void
	capacity_positive: capacity > 0
	count_not_negative: count >= 0
	not_overfull: count <= capacity

	model_sequence_not_overfull: model_sequence.count <= model_capacity
end
	
