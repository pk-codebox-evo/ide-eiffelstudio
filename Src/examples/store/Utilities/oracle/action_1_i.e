indexing

	description: "Nested queries example."
	product: "EiffelStore"
	database: "Oracle"
	Status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"
	author: "Patrice Khawam"

class ACTION_1_I inherit

	ACTION_1

creation
        
	make

feature

	process_row is
		local
			my_action: ACTION_2_I
			new_selection: DB_SELECTION
			tuple: DB_TUPLE
			table_name: STRING
		do      
			!! tuple.copy (selection.cursor)
			table_name ?= tuple.item (1)
			if table_name /= Void then
				io.putstring ("-- Column(s) for table ") 
				io.putstring (table_name)
				io.new_line
				!! new_selection.make
				!! my_action.make (new_selection)
				new_selection.set_action (my_action)
				new_selection.set_map_name (table_name, "table_name")
				new_selection.query (select_string)
				new_selection.load_result
				new_selection.unset_map_name ("table_name")
			end
		end

	select_string: STRING is
		once
			Result :=
			"select COLUMN_NAME from ACCESSIBLE_COLUMNS %
			%where TABLE_NAME = :table_name"
		end

end -- class ACTION_1_I


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

