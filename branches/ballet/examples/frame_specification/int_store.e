deferred class INT_STORE

feature -- Access

	value: INTEGER is
			-- Value stored
		deferred
		--! need value_frame
		end

feature -- Settor

	set_value (a_value: INTEGER) is
			-- Store a value in `value'.
		deferred
		ensure
			value_set: value = a_value
		--! modify set_frame
		end

feature -- Frame Queries

	value_frame: MML_SET[ANY] is
			-- Frame of the value query.
		deferred
		end

	set_value_frame: MML_SET[ANY] is
			-- Frame of the value query.
		deferred
		end

end
