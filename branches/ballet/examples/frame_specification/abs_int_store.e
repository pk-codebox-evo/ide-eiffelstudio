class ABS_INT_STORE

inherit

	INT_STORE

feature -- Access

	value: INTEGER
			-- Value stored

feature -- Settor

	set_value (a_value: INTEGER) is
			-- Store a value in `value'.
		do
			value := a_value
		end

feature -- Frames

	value_frame: MML_SET[ANY] is
			-- Frame of the value query
		do
			create {MML_DEFAULT_SET[ANY]}Result.make_empty
			Result := Result.extended(Current)
		end

	set_value_frame: MML_SET[ANY] is
			-- Frame of the set_value command
		do
			create {MML_DEFAULT_SET[ANY]}Result.make_empty
			Result := Result.extended(Current)
		end

end
