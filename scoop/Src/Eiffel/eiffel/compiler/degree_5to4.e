indexing
	description: "Summary description for {DEGREE_5TO4}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEGREE_5TO4

inherit
	DEGREE
	SHARED_SERVER

create

	make

feature -- Access

	Degree_number: INTEGER is 54
			-- Degree number

feature -- Processing

	execute is
			-- Process all classes.
		local
			i: INTEGER
			is_separate: BOOLEAN
			a_class: CLASS_C
			l_classes: ARRAY [CLASS_C]
			l_degree_output: like degree_output
			l_system: like system
		do
			l_degree_output := Degree_output
			l_degree_output.put_start_degree (Degree_number, count)

			l_system := system
			l_classes := l_system.classes

			is_separate := False

			io.put_string ("degree 5to4: class number: " + count.out + "/" + l_classes.count.out)
			io.put_new_line

			from i := 1 until i > l_classes.count loop
				a_class := l_classes.item (i)
				if a_class /= Void then -- and then a_class.degree_5to4_needed then
					if a_class.is_separate_client then
						is_separate := True
						io.put_string ("test: is_separate: " + a_class.name)
						io.put_new_line
					end
				end
				i := i + 1
			end

			if is_separate then
				-- at least one separate keyword exists
				-- proceed with AST transformation
debug ("SCOOP")
io.error.put_string ("SCOOP: keyword 'separate' found!")
io.error.put_new_line
io.error.put_string ("Starting AST transformation ...")
io.error.put_new_line
end

				-- ... do something!

			end

			l_degree_output.put_end_degree
		end

feature -- Element change

	insert_class (a_class: CLASS_C) is
			-- Add `a_class' to be processed.
		do
			a_class.add_to_degree_5to4
			count := count + 1
		end

feature -- Removal

	remove_class (a_class: CLASS_C) is
			-- Remove `a_class'.
		do
			a_class.remove_from_degree_5to4
			count := count - 1
		end

	wipe_out is
			-- Remove all classes.
		local
			i, nb: INTEGER
			classes: ARRAY [CLASS_C]
			a_class: CLASS_C
		do
			from
				i := 1
				nb := count
				classes := System.classes
			until
				nb = 0
			loop
				a_class := classes.item (i)
				if a_class /= Void then
					a_class.remove_from_degree_5to4
					nb := nb - 1
				end
				i := i + 1
			end
			count := 0
		end

end
