indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_OBJECT

feature -- Initialization

	make (a_class: like dynamic_class) is
			-- create new runtime node assoziated to a_class
		do
			dynamic_class := a_class
		end


feature -- Access


	dynamic_class: CLASS_C

	type: STRING is
			-- object type
		do
			Result := dynamic_class.name
		end

	identifier: STRING is
			-- identifier used by other nodes
		deferred
		end



feature {NONE} -- Implementation

invariant
	dynamic_class_not_void: dynamic_class /= Void

end
