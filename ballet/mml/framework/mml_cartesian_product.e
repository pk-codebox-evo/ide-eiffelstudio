indexing
	description: "Cartesian product of two sets to form a relation"
	author: "Bernd Schoeller"
	date: "$Date$"
	revision: "$Revision$"

class
	MML_CARTESIAN_PRODUCT [X,Y]

inherit
	MML_USER

feature -- Cartesian product

	cartesian_product (a: MML_SET[X]; b: MML_SET[Y]): MML_RELATION[X,Y] is
			-- Compose relations `a' and `b'
		local
			new_array: ARRAY [MML_PAIR[X,Y]]
			new_pair: MML_DEFAULT_PAIR [X,Y]
			i: INTEGER
			j: INTEGER
			a_count: INTEGER
			b_count: INTEGER
			a_array: ARRAY [X]
			b_array: ARRAY [Y]
		do
			if not a.is_empty and not b.is_empty then
				a_count := a.count
				a_array := a.as_array
				b_count := b.count
				b_array := b.as_array
				create new_array.make (1,a_count*b_count)
				from
					i := 1
				until
					i > a_count
				loop
					from
						j := 1
					until
						j > b_count
					loop
						create new_pair.make_from (a_array.item (i),b_array.item (j))
						new_array.put (new_pair,(i-1)*b_count+j)
						j := j + 1
					end
					i := i + 1
				end
			end
			create {MML_DEFAULT_RELATION[X,Y]}Result.make_from_array (new_array)
		end

end
