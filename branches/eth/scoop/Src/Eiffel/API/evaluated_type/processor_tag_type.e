indexing
	description: "The type model of a processor tag, including some ordering on the instances."

class PROCESSOR_TAG_TYPE

inherit
	ANY
	redefine
		is_equal
	end

create
	make,
	make_top,
	make_bottom

feature --Creation
	make (is_separate : BOOLEAN; proc_name : STRING ; a_handled : BOOLEAN) is
		require
			a_handled implies not proc_name.is_empty
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
		end

	-- A make_handled, make_explicit_proc, creations may be desired at some point

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

feature --Copy
	duplicate : PROCESSOR_TAG_TYPE is
			-- Duplicate the current processor tag.
		do
			create Result.make (is_sep, tag_name, handled)
		end

feature --Compare
	infix "<" (other : like Current) : BOOLEAN is
		do
			Result := (other.top and not top) or else
			          (bottom and not other.bottom)
		end

	is_equal (other : like Current) : BOOLEAN is
		do
			Result := (other.top    and top)    or else
			          (other.bottom and bottom) or else
			          (other.is_current and is_current and other.tag_name.is_equal (tag_name))

			debug
				io.put_string ("Equal says...")
				io.put_boolean (Result)
				io.put_new_line
				dump_info
				other.dump_info
			end
		end

feature --Access
	is_current : BOOLEAN is
			-- Determines whether this tag represents the same
			-- processor where the type was declared.
		do
			Result := current_proc
		end

	tag_name : STRING
	bottom   : BOOLEAN
	top      : BOOLEAN

feature --Debug
	dump_info is
		do
			io.put_string ("Separate tag with: is_sep: " + is_sep.out)
			io.put_string (" process name: " + tag_name)
			io.put_string (" handled: " + handled.out)
			io.put_string (" current: " + current_proc.out)
			io.new_line
		end

feature {NONE} -- Implementation
	set_tag_name (name : STRING) is
			-- Sets the name of the tag to `name'
		do
			tag_name := name
		end

	make_current is
		do
			make_empty
			current_proc := True
		end

	make_empty is
		do
			current_proc := False
			top          := False
			bottom       := False
		end

	current_proc : BOOLEAN
	is_sep       : BOOLEAN
	handled      : BOOLEAN

invariant
	top_bottom_exclusive: (bottom implies not top) and (top implies not bottom)
	tag_exclusive:        not tag_name.is_empty implies (not top and not bottom)

end
