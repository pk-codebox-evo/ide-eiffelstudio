indexing

	description: 
		"Feature data denoting that it has been removed. Kept %
		%for compatibility. Will be removed at the same time %
		%as S_FEATURE_DATA_R331";
	date: "$Date$";
	revision: "$Revision $"

class S_DELETED_FEATURE_DATA

inherit

	S_FEATURE_DATA_R331
		redefine
			is_deleted_since_last_re,
			is_reversed_engineered, set_reversed_engineered
		end

creation

	make

feature -- Properties

	is_deleted_since_last_re: BOOLEAN is True;
			-- Current feature is deleted since last re

	is_reversed_engineered: BOOLEAN
			-- Is Current class reversed engineered?

feature -- Setting

	set_reversed_engineered is
			-- Set `is_reversed_engineered' to True.
		do
			is_reversed_engineered := True
		ensure then
			is_reversed_engineered: is_reversed_engineered
		end

end -- class S_DELETED_FEATURE_DATA
