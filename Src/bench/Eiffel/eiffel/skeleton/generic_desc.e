-- Attribute description of generic type

class GENERIC_DESC

inherit

	ATTR_DESC
		rename
			same_as as basic_same_as
		redefine
			has_formal, instantiation_in
		end;
	ATTR_DESC
		redefine
			has_formal, instantiation_in, same_as
		select
			same_as
		end;

feature

	type: TYPE_I;
		-- Type having some generic parameters	

	set_type (t: TYPE_I) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	has_formal: BOOLEAN is True;
			-- Has the current description a formal generic one ?

	same_as (other: ATTR_DESC): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			other_generic: GENERIC_DESC;
		do
			if basic_same_as (other) then
				other_generic ?= other;
				Result := type.same_as (other_generic.type);
			end;
		end;

	instantiation_in (class_type: CLASS_TYPE): ATTR_DESC is
			-- Instantiation of the current description in		
			-- `class_type'.
		local
			gen_type: GEN_TYPE_I;
		do
			gen_type ?= class_type.type;
			Result := type.instantiation_in (gen_type).description;
			Result.set_feature_id (feature_id);
			Result.set_attribute_name (attribute_name);
			Result.set_rout_id (rout_id);
		end;

	level: INTEGER is 
			-- Sort level
		do
			Result := Formal_level;
		end;

	generate_code (file: UNIX_FILE) is
			-- Useless
		do
		end;

	sk_value: INTEGER is
			-- Sk value
		do
		end;

	trace is
			-- Debug purpose
		do
			io.error.putstring (attribute_name);
			io.error.putstring ("Generic desc: ");
			type.trace;
		end;

end
