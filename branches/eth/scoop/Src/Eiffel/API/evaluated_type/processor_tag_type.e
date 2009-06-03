indexing
	description: "The type model of a processor tag, including some ordering on the instances."


class PROCESSOR_TAG_TYPE

inherit
	COMPARABLE
	redefine infix "<", is_equal end

create
	make

feature

		--FIXME: this constructor sucks, require clause is used in the body, ugh.
	make (is_separate : BOOLEAN; proc_name : STRING ; a_handled : BOOLEAN) is
		require
			handled implies not proc_name.is_empty
		do
			make_empty

			set_tag_name (proc_name)
			is_sep  := is_separate
			handled := a_handled

			if is_separate then

				if proc_name.is_empty or else
				   (handled and proc_name.is_equal ("Current")) then

					make_current


				else
					make_top
				end

			else
				make_current
			end
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
			Result := other.top = top       or else
			          other.bottom = bottom or else
			          other.tag_name.is_equal (tag_name)
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
