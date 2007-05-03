indexing
	description: "Birthday book that consists of unlimited number of name-to-birthdate mappings"
	author: "Jackie Wang and others"
	date: "$Date$"
	revision: "$Revision$"

class

	BIRTHDAY_BOOK

inherit
	MML_USER

create

	make

feature -- constructor

	make is
			-- initializes an empty birthday book
		do
			create names.make
			create dates.make
			count := 0
		ensure
			empty_book: count = 0
			model_is_empty: model.is_empty
		end

feature -- member

	count: INTEGER

feature -- command routine

	add_birthday (new_name: BB_NAME; new_date: BB_DATE) is
			-- add a non-existing name-date pair into the current birthday
			-- book
		require
			not_existing: not model.domain.contains(new_name)
		do
			names.extend(new_name)
			dates.extend(new_date)
			count := count + 1
		ensure
			name_registered: model.contains_pair(new_name,new_date)
		end

feature -- function routine: query on name

	find_birthday (query_name: BB_NAME): BB_DATE is
			-- find the corresponding birthday of 'query_name'
		require
			name_exists: model.domain.contains(query_name)
		local
			index : INTEGER
		do
			from
				index := 1
			until
				Result /= Void
			loop
				if names.i_th(index).is_equal (query_name) then
					Result := dates.i_th(index)
				end
				index := index + 1
			end
		ensure
			model_lookup: equal_value(Result,model.item(query_name))
			query_property: model |=| old(model)
		end

feature -- function routine: query on date

	remind (today: BB_DATE): FLAT_LINKED_LIST[BB_NAME] is
			-- collect the people currently in the book whose birthday is 'today' 
		local
			index: INTEGER
		do
			create Result.make
			from
				index := 1
			until
				index > count
			loop
				if dates.i_th (index).is_equal (today) then
					Result.extend (names.i_th(index))
				end
				index := index + 1
			end
		ensure
			query_property: model |=| old(model)
			model_result: Result.model_sequence.range |=| model.anti_image_of (today)
		end

feature -- Model

	model: MML_RELATION[BB_NAME,BB_DATE] is
			-- Abstraction function
		local
			i: INTEGER
		do
			create {MML_DEFAULT_RELATION[BB_NAME,BB_DATE]}Result.make_empty
			from
				i := 1
			until
				i > count
			loop
				Result := Result.extended_by_pair(names.i_th(i),dates.i_th(i))
				i := i + 1
			end
		end

feature {NONE} -- implementation

	names : FLAT_LINKED_LIST[BB_NAME]
	dates : FLAT_LINKED_LIST[BB_DATE]

invariant
	non_negative_book_size: count >= 0

	-- model invariant
	model.is_function

	-- class invariants referring to internal variables
	same_number_of_names_and_dates: names.count = dates.count
	consistency_between_implementation_and_attribute: count = names.count
end
