indexing
	description: "Integer format of the database";
	date: "$Date$"
	revision: "$Revision$"

class 
	DATABASE_INTEGER [G -> DATABASE]

inherit

	DB_TYPE
		redefine
			eiffel_name
		end

	HANDLE_SPEC [G]

feature -- Status report

	sql_name: STRING is
			-- SQL type name for integer
		do
			Result := db_spec.sql_name_integer
		end
	
	eiffel_name: STRING is
			-- Eiffel type name for integer
		once
			Result := "INTEGER"
		ensure then
			Result.is_equal ("INTEGER")
		end

	eiffel_ref: INTEGER_REF is
			-- Shared integer reference
		once
			!! Result
		end

end -- class DATABASE_INTEGER

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
