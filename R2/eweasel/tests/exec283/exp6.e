expanded class
	EXP6 [G]

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature

	default_create
		do
			i := 5
		end

	i: INTEGER

end

