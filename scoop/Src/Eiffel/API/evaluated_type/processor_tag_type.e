indexing
	description: "The type model of a processor tag, including some ordering on the instances."


class PROCESSOR_TAG_TYPE

inherit
	COMPARABLE
	redefine infix "<", is_equal end

creation
	make

feature


	make (is_separate : BOOLEAN; proc_as : EXPLICIT_PROCESSOR_SPECIFICATION_AS) is
		require
			proc_as_not_void: proc_as /= Void
		do
			make_empty
	
			if is_separate then
				if proc_as /= Void then
					tag_name := proc_as.entity.name
				else
					make_top
				end
			else
				make_current
			end


		end

	infix "<" (other : like Current) : BOOLEAN is
		do
			Result := other.top                      or else 
			          bottom                         or else
			          top          implies other.top or else
			          other.bottom implies bottom    
		end

	is_equal (other : like Current) : BOOLEAN is
		do
			Result := other.tag_name.is_equal (tag_name)
		end

	tag_name : STRING

feature {PROCESSOR_TAG_TYPE}
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


	
invariant
	top_bottom_sep: (bottom implies not top) and (top implies not bottom)

end
