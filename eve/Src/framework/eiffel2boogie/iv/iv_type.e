note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IV_TYPE

feature -- Status report

	is_boolean: BOOLEAN
			-- Is this the boolean type?

	is_integer: BOOLEAN
			-- Is this the integer type?

	is_real: BOOLEAN
			-- Is this the real type?

	is_reference: BOOLEAN
			-- Is this the reference type?

	is_type: BOOLEAN
			-- Is this the type type?

	is_heap: BOOLEAN
			-- Is this the heap type?

	is_map: BOOLEAN
			-- Is this a map type?

	is_set: BOOLEAN
			-- Is this a set type?

	is_seq: BOOLEAN
			-- Is this a set type?	

	is_frame: BOOLEAN
			-- Is this a frame type?

feature -- Visitor

	process (a_visitor: IV_TYPE_VISITOR)
			-- Process type.
		deferred
		end

feature -- Equality

	is_same_type (a_other: IV_TYPE): BOOLEAN
			-- Is `a_other' same type as this?
		deferred
		end

end
