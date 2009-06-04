indexing
	description: "The type model of a processor tag, including some ordering on the instances."


class PROCESSOR_TAG_TYPE

inherit ANY
redefine
	is_equal
	end

create
	make

feature
	make (is_separate : BOOLEAN; proc_name : STRING ; a_handled : BOOLEAN) is
		require
			handled implies not proc_name.is_empty
		do
			make_empty

			set_tag_name (proc_name)
			is_sep  := is_separate
			handled := a_handled

			if is_separate then

				if (handled and proc_name.is_equal ("Current")) then
					make_current
				elseif proc_name.is_equal ("") then
					make_top
				end

			else
				make_current
			end

--			dump_info
		end

	duplicate : PROCESSOR_TAG_TYPE is
			-- Duplicate the current processor tag.
		do
			create Result.make (is_sep, tag_name, handled)
		end


	infix "<" (other : like Current) : BOOLEAN is
		do
			Result := (other.top and not top) or else
			          (bottom and not other.bottom)
		end

	is_current : BOOLEAN is
			-- Determines whether this tag represents the same
			-- processor where the type was declared.
		do
			Result := current_proc
		end


	is_equal (other : like Current) : BOOLEAN is
		do
			Result := (other.top and top)   or else
			          (other.bottom and bottom) or else
			          (other.is_current and is_current and other.tag_name.is_equal (tag_name))
			io.put_string ("Equal says...")
			io.put_boolean (Result)
			io.put_new_line
			dump_info
			other.dump_info
		end

	dump_info is
		do
			io.put_string ("Separate tag with: is_sep: ")
			io.put_boolean(is_sep)
			io.put_string (" process name: ")
			io.put_string (tag_name)
			io.put_string (" handled: ")
			io.put_boolean(handled)
			io.put_string (" current: ")
			io.put_boolean (current_proc)
			io.new_line
		end


	tag_name : STRING

	set_tag_name (name : STRING) is
			-- Sets the name of the tag to `name'
		do
			tag_name := name
		end


	make_top is
		do
			make_empty
			top := True
		end

	make_current is
		do
			make_empty
			current_proc := true
		end

	make_bottom is
		do
			make_empty
			bottom := True
		end

	make_empty is
		do
			current_proc := False
			top := False
			bottom := False
		end

	bottom       : BOOLEAN
	top          : BOOLEAN
	current_proc : BOOLEAN

	is_sep       : BOOLEAN
	handled      : BOOLEAN

invariant
	top_bottom_sep: (bottom implies not top) and (top implies not bottom)

end
