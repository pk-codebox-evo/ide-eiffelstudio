indexing
	description: "Objects that represent names in the birthday book"
	author: "Jackie Wang and others"
	date: "$Date$"
	revision: "$Revision$"

class
	BB_NAME
	
inherit
	ANY
		redefine
			is_equal
		end

create
	make
	
feature
	make(new_name: STRING) is
			-- initializes a name
		do
			string_name := new_name
		ensure
			string_name.is_equal (new_name)
		end

feature -- equality

	is_equal (other: BB_NAME): BOOLEAN is
			-- is the current name equal to 'other'?
		do
			Result := string_name.is_equal (other.string_name)
		ensure then
			Result = string_name.is_equal (other.string_name)
		end

feature -- member
	string_name : STRING

end
