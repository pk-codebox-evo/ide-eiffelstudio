indexing
	description: "Objects that represent the dates in a Birthday Book"
	author: "Jackie Wang and others"
	date: "$Date$"
	revision: "$Revision$"

class
	BB_DATE

inherit
	
	ANY
		redefine
			is_equal
		end

create

	make

feature

	make(new_day, new_month : INTEGER) is
			-- initializes a new date
		require
			valid_day: 1 <= new_day and new_day <= 31
			valid_month: 1 <= new_month and new_month <= 12
		do
			day := new_day
			month := new_month
		ensure
			day_set: day = new_day
			month_set: month = new_month
		end

feature -- members

	day : INTEGER
	month : INTEGER
	
feature -- queries
	
	valid_day(a_day: INTEGER): BOOLEAN is
			-- is 'a_day' a valid day?
		do
			Result := (a_day /= 0 implies 1 <= a_day and a_day <= 31)
		ensure
			Result = (a_day /= 0 implies 1 <= a_day and a_day <= 31)
		end
	
	valid_month(a_month: INTEGER): BOOLEAN is
			-- is 'a_day' a valid day?
		do
			Result := (a_month /= 0 implies 1 <= a_month and a_month <= 12)
		ensure
			Result = (a_month /= 0 implies 1 <= a_month and a_month <= 12)
		end

feature -- equality

	is_equal (other: BB_DATE): BOOLEAN is
			-- is the current date equal to 'other'?
		do
			Result := (month = other.month and then day = other.day)
		ensure then
			Result = (month = other.month and then day = other.day)
		end
	
invariant
	valid_day: 1 <= day and day <= 31
	valid_month: 1 <= month and month <= 12
end
