-- Argument which is not instantiated

class ARG 

inherit

	TYPE_DATA

creation

	session_init, storage_init, set
	
feature 

	set (t: CONTEXT_TYPE; p: CMD) is
			-- Set type to `t' and 
			-- parent `p'
		do
			set_type (t);
			set_parent (p)
		end;

	session_init (other: TYPE_STONE) is
		do
			type := other.data.type
		ensure
			Type_set: type /= Void
		end;

	storage_init (other: CONTEXT_TYPE) is
		do
			set_type (other)
		ensure
			Type_set: type /= Void 
		end;

feature -- Data

	type: CONTEXT_TYPE;

	set_type (other: CONTEXT_TYPE) is
		do
			type := other
		end;

	identifier: INTEGER is
		do
			Result := - type.identifier
		end;

	data: ARG is
		do
			Result := Current
		end;

	label: STRING is
		do
			Result := type.label
		end;

	symbol: PIXMAP is
		do
			Result := type.symbol
		end;

	eiffel_type: STRING is
		do
			Result := type.eiffel_type
		end;

-- **************
-- Reuse features
-- **************

	parent_type: CMD;
		-- Command which defines
		-- Current argument if
		-- introduced by inheritance

	set_parent (c: CMD) is
		do
			parent_type := c
		end;

	inherited: BOOLEAN is
		do
			Result := not (parent_type = Void)
		end

end
