indexing
	description: "Summary description for {SCOOP_TYPE_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCOOP_TYPE_VISITOR

inherit
	AST_ROUNDTRIP_ITERATOR
		redefine
			process_bits_as,
			process_bits_symbol_as,
			process_class_type_as,
			process_generic_class_type_as,
			process_formal_as,
			process_like_cur_as,
			process_like_id_as,
			process_named_tuple_type_as,
			process_none_type_as,
			process_type_dec_as
		end
	SCOOP_BASIC_TYPE
	SHARED_SCOOP_WORKBENCH

feature -- Access

	evaluate_class_from_type (a_type: TYPE_AS; a_base_class: CLASS_C): CLASS_C is
			-- Given a TYPE_AS node, try to find its equivalent CLASS_C node.
		require
			a_type_not_void: a_type /= Void
			a_base_class_not_void: a_base_class /= Void
		local
			i: INTEGER
		do
			last_class_name := Void
			last_class_c := Void
			is_formal := false
			is_tuple_type := false
			is_separate := false
			is_a_like_type := false
			is_class_type := false
			is_generic_parameter := false

			base_class := a_base_class

			a_type.process (Current)

				-- get associated class
			if last_class_name /= Void then
				from
					i := 1
				until
					i > system.classes.count
				loop
					if system.classes.item (i) /= Void and then
					   system.classes.item (i).name_in_upper.is_equal (last_class_name) then

						last_class_c := system.classes.item (i)
					end
					i := i + 1
				end
			end

				-- test if the current type is a generic parameter
			if base_class.generics /= Void then
				from i := 1	until i > base_class.generics.count loop
					if base_class.generics.i_th (i).name.name.as_upper.is_equal (last_class_name) then
						is_generic_parameter := true
					end
					i := i + 1
				end
			end

				-- check: it cannot be separate be if it is of basic type
			if last_class_c /= Void and then is_basic_type (last_class_c.name_in_upper) then
				is_separate := false
			end

			Result := last_class_c
		ensure
			Result_not_void_when_or_formal: Result /= Void or is_generic_parameter
		end

	is_formal: BOOLEAN
			-- Is last resolved type formal?

	is_tuple_type: BOOLEAN
			-- Is last resolved type of type tuple?

	is_separate: BOOLEAN
			-- Is last resolved type separate?

	is_a_like_type: BOOLEAN
			-- Is last resolved type a like type?

	is_class_type: BOOLEAN
			-- Is last resolved type of class type?

	is_generic_parameter: BOOLEAN
			-- Is current type a generic parameter type?

feature {NONE} -- Visitor implementation

	process_like_id_as (l_as: LIKE_ID_AS) is
		do
			if base_class.feature_table.has (l_as.anchor.name.as_lower) then
				last_class_name := base_class.feature_table.item (l_as.anchor.name.as_lower).type.associated_class.name_in_upper
				is_separate := base_class.feature_table.item (l_as.anchor.name.as_lower).type.is_separate
			end
			is_a_like_type := true
		end

	process_like_cur_as (l_as: LIKE_CUR_AS) is
		do
			last_class_name := base_class.name_in_upper
			is_a_like_type := true
		end

	process_formal_as (l_as: FORMAL_AS) is
		do
			is_formal := true
			last_class_name := l_as.name.name.as_upper
		end

	process_class_type_as (l_as: CLASS_TYPE_AS) is
		do
			last_class_name := l_as.class_name.name.as_upper
			is_separate := l_as.is_separate
			is_class_type := true
		end

	process_generic_class_type_as (l_as: GENERIC_CLASS_TYPE_AS) is
		do
			last_class_name := l_as.class_name.name
			is_separate := l_as.is_separate
			is_class_type := true
		end

	process_named_tuple_type_as (l_as: NAMED_TUPLE_TYPE_AS) is
		do
			is_tuple_type := True
			last_class_name := l_as.class_name.name.as_upper
			is_separate := l_as.is_separate
		end

	process_type_dec_as (l_as: TYPE_DEC_AS) is
		do
			l_as.type.process (Current)
		end

	process_none_type_as (l_as: NONE_TYPE_AS) is
		do
			last_class_name := l_as.class_name_literal.name.as_upper
		end

	process_bits_as (l_as: BITS_AS) is
		do
			last_class_name := Void
		end

	process_bits_symbol_as (l_as: BITS_SYMBOL_AS) is
		do
			last_class_name := Void
		end

feature {NONE} -- Implementation

	last_class_name: STRING
			-- Last resolved class name

	last_class_c: CLASS_C
			-- Last resolved class c

	base_class: CLASS_C
			-- Starting point for type analysis

end
