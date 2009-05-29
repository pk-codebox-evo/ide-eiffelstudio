indexing
	description: "The type model of a processor tag, including some ordering on the instances."


class PROCESSOR_TAG_TYPE

inherit
	COMPARABLE
	redefine infix "<" end

creation
	make,
	make_top,
	make_bottom

feature
	make_top is
		do
			make_empty
			top := True
		end

	make_bottom is
		do
			make_empty
			bottom := True
		end

	make (proc_as : EXPLICIT_PROCESSOR_SPECIFICATION_AS) is
		require
			proc_as_not_void: proc_as /= Void
		do
			make_empty
			tag_name := proc_as.entity.name
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

feature {NONE}
	make_empty is
		do
			top := False
			bottom := False
		end

	tag_name : STRING
	
invariant
	top_bottom_sep: (bottom implies not top) and (top implies not bottom)

end
