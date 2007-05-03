class REL_INT_STORE

inherit

	INT_STORE

create

	make

feature{NONE} -- Initialization

	make (an_other: ABS_INT_STORE) is
			-- Create the interger store relative to `an_other'.
		require
			other_not_void: an_other /= Void
		do
			other := an_other
		ensure
			other_set: other = an_other
		end

feature -- Access

	value: INTEGER is
			-- Value stored
		do
			Result := internal + other.value
		end

feature -- Settor

	set_value (a_value: INTEGER) is
			-- Store a value in `value'.
		do
			internal := a_value - other.value
		end

feature -- Frame Queries

	value_frame: MML_SET[ANY] is
			-- Frame of the value query
		do
			create {MML_DEFAULT_SET[ANY]}Result.make_empty
			Result := Result.extended(Current)
			Result := Result.extended(other)
		end

	set_value_frame: MML_SET[ANY] is
			-- Frame for the set_value command
		do
			create {MML_DEFAULT_SET[ANY]}Result.make_empty
			Result := Result.extended(Current)
		end

feature{NONE} -- Implementation

	other: ABS_INT_STORE
	internal: INTEGER

invariant
	other_not_void: other /= Void
end
