indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_GENERIC_OBJECT

inherit

	CDD_REGULAR_OBJECT
		redefine
			full_type
		end

create
	make_generic

feature {NONE} -- Initialization

	make_generic (dtype: like dynamic_class; attribute_count: INTEGER; gtype: STRING) is
			-- Initialize with generic type gtype
		do
			make_with_count (dtype, attribute_count)
			generic_type := gtype
		end


feature -- Access

	generic_type: STRING

	full_type: STRING is
			-- with generics
		do
			Result := type + " [" + generic_type + "]"
		end



feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
