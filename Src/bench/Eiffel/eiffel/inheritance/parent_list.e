-- Eiffel class generated by the 2.3 to 3 translator.

class PARENT_LIST 

inherit
	FIXED_LIST [PARENT_C]

creation
	make, make_filled

feature -- Merging parents

	merge_and_check_renamings (inherit_table: INHERIT_TABLE) is
			-- Go through each parents and merge them into `inherit_table'
			-- Check also the renaming clause of the parents
		local
			p: PARENT_C
			sp_area: SPECIAL [PARENT_C]
			i, nb: INTEGER
		do
			from
				sp_area := area
				i := 0
				nb := count
			until
				i = nb
			loop
				p := sp_area.item (i)
				inherit_table.merge (p)
				p.check_validity1
				i := i + 1
			end
		end

feature -- Validity

	check_validity2 is
			-- Check the redefine and select clause
		local
			sp_area: SPECIAL [PARENT_C]
			i, nb: INTEGER
		do
			from
				sp_area := area
				i := 0
				nb := count
			until
				i = nb
			loop
				sp_area.item(i).check_validity2
				i := i + 1
			end
		end

	check_validity4 is
			-- Check useless selection 
		local
			sp_area: SPECIAL [PARENT_C]
			i, nb: INTEGER
			p: PARENT_C
		do
			from
				sp_area := area
				i := 0
				nb := count
			until
				i = nb
			loop
				p := sp_area.item(i)
				if not (p.selecting = Void) then
					p.check_validity4
				end
				i := i + 1
			end
		end

	is_selecting (feature_name: STRING): BOOLEAN is
			-- Are the parents selecting `feature_name' ?
		require
			good_argument: not (feature_name = Void)
		local
			sp_area: SPECIAL [PARENT_C]
			i, nb: INTEGER
		do
			from
				sp_area := area
				i := 0
				nb := count
			until
				Result or else i = nb
			loop
				Result := sp_area.item(i).is_selecting (feature_name)
				i := i + 1
			end
		end

end -- class PARENT_LIST
