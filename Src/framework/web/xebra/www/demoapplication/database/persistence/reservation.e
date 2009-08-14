note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	RESERVATION

create
	make, make_with_arguments

feature {NONE} -- Initialization

	make_with_arguments (a_id: INTEGER; a_name: STRING; a_date: DATE; a_persons: INTEGER; a_description: STRING)
			-- Initialization for `Current'.
		require
			not_a_name_is_detached_or_not_empty: a_name /= Void implies not a_name.is_empty
			not_a_date_is_detached_or_empty: a_date /= Void
			not_a_description_is_detached_or_empty: a_description /= Void and then not a_description.is_empty
		do
			id := a_id
			name := a_name
			date:= a_date
			persons:= a_persons
			description:= a_description
		ensure
			id_set: equal (id, a_id)
			name_set: equal (name, a_name)
			date_set: date = a_date
			persons_set: equal (persons, a_persons)
			description_set: equal (description, a_description)
		end

	make
		do
			id := 0
			name := "default_name"
			create date.make_now
			persons := 1
			description := ""
		end

feature -- Access

	id: INTEGER
	name: STRING assign set_name
	set_name (a_name: STRING)
		do
			name := a_name
		end
	date:  DATE assign set_date
	set_date (a_date: DATE)
		do
			date := a_date
		end
	persons: INTEGER
	s_persons: STRING assign set_s_persons
		do
			Result := persons.out
		end
	set_s_persons (a_s_persons: STRING)
		do
			persons := a_s_persons.to_integer
		end
	description: STRING assign set_description
	set_description (a_desc: STRING)
		do
			description := a_desc
		end


invariant
	not_name_is_detached_or_empty: name /= Void and then not name.is_empty
	not_date_is_detached_or_empty: date /= Void
	not_description_is_detached_or_empty: description /= Void
end
