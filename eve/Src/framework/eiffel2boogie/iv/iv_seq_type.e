note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_SEQ_TYPE

inherit

	IV_TYPE

create
	make

feature {NONE} -- Initialization

	make (a_content_type: IV_TYPE)
			-- Initialize field type with content type `a_content_type'.
		require
			a_content_type_attached: attached a_content_type
		do
			content_type := a_content_type
			is_seq := True
		ensure
			content_type_set: content_type = a_content_type
		end

feature -- Access

	content_type: IV_TYPE
			-- Content type for this field type.

feature -- Visitor

	process (a_visitor: IV_TYPE_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_seq_type (Current)
		end

feature -- Equality

	is_same_type (a_other: IV_TYPE): BOOLEAN
			-- Is `a_other' same type as this?
		do
			if attached {IV_SEQ_TYPE} a_other as t then
				Result := content_type.is_same_type (t.content_type)
			end
		end

end
