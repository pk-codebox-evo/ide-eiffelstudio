indexing

	description:
		"Resource encapsulating an array of strings."
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAY_RESOURCE

inherit
	STRING_RESOURCE
		rename
			make as sr_make,
			default_value as value
		redefine
			set_value, value, xml_trace
		end;

creation
	make, make_from_string

feature {NONE} -- Initialization

	make (a_name: STRING; a_value: ARRAY [STRING]) is
			-- Initialize Current
		do
			name := a_name
			actual_value := a_value
			update_value
		end

	make_from_string (a_name: STRING; a_value: STRING) is
			-- Initialize Current
		do
			name := a_name
			value := a_value
			update_actual_value
		end

feature -- Access

	value: STRING
			-- Value of the resource 

--	default_value, 
		actual_value: ARRAY [STRING]
			-- The array, as reprensented by `value'.

feature -- Setting

	set_actual_value (an_array: ARRAY [STRING]) is
			-- Set `actual_value' to `an_array' and
			-- update `value'.
		do
			actual_value := an_array
			update_value
		end

	set_value (a_string: STRING) is
			-- Set `value' to `a_string' and update
			-- `actual_value',
		require else
			a_string_is_valid: is_valid (a_string)
		do
			value := a_string
			update_actual_value
		end

--	has_changed: BOOLEAN is
--			-- Has the resource changed from the default value?
--		local
--			i: INTEGER
--		do
--			Result := True
--			if actual_value /= Void and then
--				default_value /= Void 
--			then
--				if actual_value.count = default_value.count then
--					from	
--						i := 1
--					until
--						i > actual_value.count or else not Result
--					loop
--						Result := not default_value.item (i).is_equal
--									(actual_value.item (i))
--						i := i + 1
--					end
--				end
--			elseif actual_value = Void and then
--				default_value = Void 
--			then
--				Result := False
--			end
--		end

feature {NONE} -- Implementation

	update_value is
			-- Updates `value' using current `actual_value'.
		local
			index: INTEGER
			not_first_time: BOOLEAN
			c: INTEGER
		do
			!! value.make (0)
			c := actual_value.count
			if c > 0 then
				from
					index := 1
				until
					index > c
				loop
					if not not_first_time then
						not_first_time := True
					else
						value.append (";%N")
					end;
					value.append (actual_value.item (index))
					index := index + 1
				end
			end
		end

	update_actual_value is
			-- Update `actual_value' using current `value'.
		local
			start_pos, end_pos: INTEGER
		do
			!! actual_value.make (1, 0)
			if not value.empty then
				from
					start_pos := 1
					end_pos := value.index_of (';', start_pos)
				until
					end_pos = 0
				loop
					actual_value.force (value.substring (start_pos, end_pos - 1), actual_value.count + 1)
					start_pos := end_pos + 1
					end_pos := value.index_of (';', start_pos)
				end
				if start_pos <= value.count then
					actual_value.force (value.substring (start_pos, value.count), actual_value.count + 1)
				end
			end
		end

feature -- Output

	xml_trace: STRING is
			-- XML representation of current
		do
			Result := "<TEXT>"
			Result.append (name)
			Result.append ("<LIST_STRING>")
			Result.append (value)
			Result.append ("</LIST_STRING></TEXT>")
		end

end -- class ARRAY_RESOURCE
