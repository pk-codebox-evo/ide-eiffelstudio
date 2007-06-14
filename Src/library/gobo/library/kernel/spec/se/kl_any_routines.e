indexing

	description:

		"Routines that ought to be in class ANY"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2005-2006, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class KL_ANY_ROUTINES

feature -- Status report

	same_types (obj1, obj2: ANY): BOOLEAN is
			-- Is type of `obj1' identical to type of `obj2'?
		require
			obj1_not_void: obj1 /= Void
			obj2_not_void: obj2 /= Void
		do

			Result := obj1.same_dynamic_type (obj2)



		end

	same_objects (obj1, obj2: ANY): BOOLEAN is
			-- Are `obj1' and `obj2' the same object?
			-- Useful as a way to workaround VWEQ validity rule
			-- (when running flat Degree 3 for example):
			--    my_hashable := my_string
			--    my_comparable := my_string
			--    ANY_.same_objects (my_hashable, my_comparable)
		do
			Result := obj1 = obj2
		ensure
			definition: Result = (obj1 = obj2)
		end

	equal_objects (obj1, obj2: ANY): BOOLEAN is
			-- Are `obj1' and `obj2' considered equal?
		do
			if obj1 = obj2 then
				Result := True
			elseif obj1 = Void then
				Result := False
			elseif obj2 = Void then
				Result := False
			elseif same_types (obj1, obj2) then
				Result := obj1.is_equal (obj2)
			end
		ensure
			same_types: Result and (obj1 /= Void and obj2 /= Void) implies same_types (obj1, obj2)
		end

feature -- Conversion

	to_any (an_any: ANY): ANY is
			-- Return `an_any';
			-- This can be used to workaround VWEQ validy rule:
			--    my_hashable := my_string
			--    my_comparable := my_string
			--    ANY_.to_any (my_hashable) = ANY_.to_any (my_comparable)
			-- This is also useful to workaround the validity rule
			-- introduced by SE for assignment attempts whereby the type
			-- of the target has to conform to the type of the source:
			--    my_string ?= ANY_.to_any (my_storable)
		do
			Result := an_any
		ensure
			definition: Result = an_any
		end

end
