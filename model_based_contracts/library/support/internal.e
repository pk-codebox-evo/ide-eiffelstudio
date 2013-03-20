indexing
	description: "[
			Access to internal object properties.
			This class may be used as ancestor by classes needing its facilities.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 2005-2008, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	INTERNAL

inherit
	INTERNAL_HELPER

feature -- Conformance

	is_instance_of (object: ANY; type_id: INTEGER): BOOLEAN is
			-- Is `object' an instance of type `type_id'?
		require
			object_not_void: object /= Void
			type_id_nonnegative: type_id >= 0
		do
			Result := c_type_conforms_to ({ISE_RUNTIME}.dynamic_type (object), type_id)
		end

	type_conforms_to (type1, type2: INTEGER): BOOLEAN is
			-- Does `type1' conform to `type2'?
		require
			type1_nonnegative: type1 >= 0
			type2_nonnegative: type2 >= 0
		do
			Result := c_type_conforms_to (type1, type2)
		end

feature -- Creation

	dynamic_type_from_string (class_type: STRING): INTEGER is
			-- Dynamic type corresponding to `class_type'.
			-- If no dynamic type available, returns -1.
		require
			class_type_not_void: class_type /= Void
			class_type_not_empty: not class_type.is_empty
			is_valid_type_string: is_valid_type_string (class_type)
		local
			l_cstr: C_STRING
			l_table: like internal_dynamic_type_string_table
			l_pre_ecma_status: BOOLEAN
		do
			l_table := internal_dynamic_type_string_table
			l_table.search (class_type)
			if l_table.found then
				Result := l_table.found_item
			else
				create l_cstr.make (class_type)
					-- Take into consideration possible pre-ECMA mapping.
				l_pre_ecma_status := {ISE_RUNTIME}.pre_ecma_mapping_status
				{ISE_RUNTIME}.set_pre_ecma_mapping (not is_pre_ecma_mapping_disabled)
				Result := {ISE_RUNTIME}.type_id_from_name (l_cstr.item)
				{ISE_RUNTIME}.set_pre_ecma_mapping (l_pre_ecma_status)
				l_table.put (Result, class_type)
			end
		ensure
			dynamic_type_from_string_valid: Result = -1 or Result = none_type or Result >= 0
		end

	new_instance_of (type_id: INTEGER): ANY is
			-- New instance of dynamic `type_id'.
			-- Note: returned object is not initialized and may
			-- hence violate its invariant.
			-- `type_id' cannot represent a SPECIAL type, use
			-- `new_special_any_instance' instead.
		require
			type_id_nonnegative: type_id >= 0
			not_special_type: not is_special_type (type_id)
		do
			Result := c_new_instance_of (type_id)
		ensure
			not_special_type: not is_special (Result)
			dynamic_type_set: dynamic_type (Result) = type_id
		end

	new_special_any_instance (type_id, count: INTEGER): SPECIAL [ANY] is
			-- New instance of dynamic `type_id' that represents
			-- a SPECIAL with `count' element. To create a SPECIAL of
			-- basic type, use `SPECIAL'.
		require
			count_valid: count >= 0
			type_id_nonnegative: type_id >= 0
			special_type: is_special_any_type (type_id)
		do
			create Result.make (count)
			c_set_dynamic_type (Result, type_id)
		ensure
			special_type: is_special (Result)
			dynamic_type_set: dynamic_type (Result) = type_id
			count_set: Result.count = count
		end

	type_of (object: ?ANY): ?TYPE [ANY]
			-- Type object for `object'.
		do
			if object /= Void then
				Result := type_of_type (dynamic_type (object))
			else
				if {l_result: TYPE [ANY]} new_instance_of (dynamic_type_from_string ("TYPE [NONE]")) then
					Result := l_result
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	type_of_type (type_id: INTEGER): ?TYPE [ANY]
			-- Return type for type id `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			if {l_result: TYPE [ANY]} new_instance_of (dynamic_type_from_string ("TYPE [" + type_name_of_type (type_id) + "]")) then
				Result := l_result
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	is_special_any_type (type_id: INTEGER): BOOLEAN is
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := c_eif_special_any_type (type_id)
		end

	is_special_type (type_id: INTEGER): BOOLEAN is
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type
			-- or a basic type.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := c_eif_is_special_type (type_id)
		end

	is_special (object: ANY): BOOLEAN is
			-- Is `object' a special object?
		require
			object_not_void: object /= Void
		do
			Result := c_is_special (object)
		end

	is_tuple (object: ANY): BOOLEAN is
			-- Is `object' a TUPLE object?
		require
			object_not_void: object /= Void
		do
			Result := c_is_tuple (object)
		end

	is_tuple_type (type_id: INTEGER): BOOLEAN is
			-- Is type represented by `type_id' represent a TUPLE?
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := c_eif_is_tuple_type (type_id)
		end

	is_marked (obj: ANY): BOOLEAN is
			-- Is `obj' marked?
		require
			object_exists: obj /= Void
		do
			Result := c_is_marked (obj)
		end

	is_attached_type (a_type_id: INTEGER): BOOLEAN
			-- Is `a_type_id' an attached type?require -- ToDo: remove this before merge
		require
			a_type_non_negative: a_type_id >= 0
		do
			Result := {ISE_RUNTIME}.is_attached_type (a_type_id)
		end

feature -- Access

	none_type: INTEGER is -2
			-- Type ID representation for NONE.

	Pointer_type: INTEGER is 0

	Reference_type: INTEGER is 1

	character_8_type, Character_type: INTEGER is 2

	Boolean_type: INTEGER is 3

	Integer_type, integer_32_type: INTEGER is 4

	Real_type, real_32_type: INTEGER is 5

	Double_type, real_64_type: INTEGER is 6

	Expanded_type: INTEGER is 7

	Bit_type: INTEGER is 8

	Integer_8_type: INTEGER is 9

	Integer_16_type: INTEGER is 10

	Integer_64_type: INTEGER is 11

	character_32_type, Wide_character_type: INTEGER is 12

	natural_8_type: INTEGER is 13

	natural_16_type: INTEGER is 14

	natural_32_type: INTEGER is 15

	natural_64_type: INTEGER is 16

	max_predefined_type: INTEGER is 16

	class_name (object: ANY): STRING is
			-- Name of the class associated with `object'
		require
			object_not_void: object /= Void
		do
			Result := object.generator
		end

	class_name_of_type (type_id: INTEGER): STRING is
			-- Name of class associated with dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := {ISE_RUNTIME}.c_generator_of_type (type_id)
		end

	type_name (object: ANY): STRING is
			-- Name of `object''s generating type (type of which `object'
			-- is a direct instance).
		require
			object_not_void: object /= Void
		do
			Result := object.generating_type
		end

	type_name_of_type (type_id: INTEGER): STRING is
			-- Name of `type_id''s generating type (type of which `type_id'
			-- is a direct instance).
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := {ISE_RUNTIME}.c_generating_type_of_type (type_id)
		end

	dynamic_type (object: ANY): INTEGER is
			-- Dynamic type of `object'
		require
			object_not_void: object /= Void
		do
			Result := {ISE_RUNTIME}.dynamic_type (object)
		ensure
			dynamic_type_nonnegative: Result >= 0
		end

	generic_count (obj: ANY): INTEGER is
			-- Number of generic parameter in `obj'.
		require
			obj_not_void: obj /= Void
		do
			Result := eif_gen_count_with_dftype ({ISE_RUNTIME}.dynamic_type (obj))
		end

	generic_count_of_type (type_id: INTEGER): INTEGER is
			-- Number of generic parameter in `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		do
			Result := eif_gen_count_with_dftype (type_id)
		end

	generic_dynamic_type (object: ANY; i: INTEGER): INTEGER is
			-- Dynamic type of generic parameter of `object' at
			-- position `i'.
		require
			object_not_void: object /= Void
			object_generic: generic_count (object) > 0
			i_valid: i > 0 and i <= generic_count (object)
		do
			Result := eif_gen_param_id ({ISE_RUNTIME}.dynamic_type (object), i)
		ensure
			dynamic_type_nonnegative: Result >= 0
		end

	generic_dynamic_type_of_type (type_id: INTEGER; i: INTEGER): INTEGER is
			-- Dynamic type of generic parameter of `type_id' at position `i'.
		require
			type_id_nonnegative: type_id >= 0
			type_id_generic: generic_count_of_type (type_id) > 0
			i_valid: i > 0 and i <= generic_count_of_type (type_id)
		do
			Result := eif_gen_param_id (type_id, i)
		ensure
			dynamic_type_nonnegative: Result >= 0
		end

	field (i: INTEGER; object: ANY): ?ANY is
			-- Object attached to the `i'-th field of `object'
			-- (directly or through a reference)
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		do
			Result := c_field (i - 1, object)
		end

	field_name (i: INTEGER; object: ANY): STRING is
			-- Name of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		do
			create Result.make_from_c_pointer (c_field_name_of_type (i - 1, {ISE_RUNTIME}.dynamic_type (object)))
		ensure
			Result_exists: Result /= Void
		end

	field_name_of_type (i: INTEGER; type_id: INTEGER): STRING is
			-- Name of `i'-th field of dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enought: i <= field_count_of_type (type_id)
		do
			create Result.make_from_c_pointer (c_field_name_of_type (i - 1, type_id))
		end

	field_offset (i: INTEGER; object: ANY): INTEGER is
			-- Offset of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			not_special: not is_special (object)
		do
			Result := c_field_offset (i - 1, object)
		end

	field_type (i: INTEGER; object: ANY): INTEGER is
			-- Abstract type of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
		do
			Result := c_field_type_of_type (i - 1, {ISE_RUNTIME}.dynamic_type (object))
		ensure
			field_type_nonnegative: Result >= 0
		end

	field_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER is
			-- Abstract type of `i'-th field of dynamic type `type_id'
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		do
			Result := c_field_type_of_type (i - 1, type_id)
		ensure
			field_type_nonnegative: Result >= 0
		end

	field_static_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER is
			-- Static type of declared `i'-th field of dynamic type `type_id'
		require
			type_id_nonnegative: type_id >= 0
			index_large_enough: i >= 1
			index_small_enough: i <= field_count_of_type (type_id)
		do
			Result := c_field_static_type_of_type (i - 1, type_id)
		ensure
			field_type_nonnegative: Result >= 0
		end

	expanded_field_type (i: INTEGER; object: ANY): STRING is
			-- Class name associated with the `i'-th
			-- expanded field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			is_expanded: field_type (i, object) = Expanded_type
		do
			Result := c_expanded_type (i - 1, object)
		ensure
			Result_exists: Result /= Void
		end

	character_8_field, character_field (i: INTEGER; object: ANY): CHARACTER_8 is
			-- CHARACTER_8 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_8_field: field_type (i, object) = Character_8_type
		do
			Result := c_character_8_field (i - 1, object)
		end

	character_32_field (i: INTEGER; object: ANY): CHARACTER_32 is
			-- CHARACTER_32 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_32_field: field_type (i, object) = Character_32_type
		do
			Result := c_character_32_field (i - 1, object)
		end

	boolean_field (i: INTEGER; object: ANY): BOOLEAN is
			-- Boolean value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			boolean_field: field_type (i, object) = Boolean_type
		do
			Result := c_boolean_field (i - 1, object)
		end

	natural_8_field (i: INTEGER; object: ANY): NATURAL_8 is
			-- NATURAL_8 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_8_field: field_type (i, object) = natural_8_type
		do
			Result := c_natural_8_field (i - 1, object)
		end

	natural_16_field (i: INTEGER; object: ANY): NATURAL_16 is
			-- NATURAL_16 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_16_field: field_type (i, object) = natural_16_type
		do
			Result := c_natural_16_field (i - 1, object)
		end

	natural_32_field (i: INTEGER; object: ANY): NATURAL_32 is
			-- NATURAL_32 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_32_field: field_type (i, object) = natural_32_type
		do
			Result := c_natural_32_field (i - 1, object)
		end

	natural_64_field (i: INTEGER; object: ANY): NATURAL_64 is
			-- NATURAL_64 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_64_field: field_type (i, object) = natural_64_type
		do
			Result := c_natural_64_field (i - 1, object)
		end

	integer_8_field (i: INTEGER; object: ANY): INTEGER_8 is
			-- INTEGER_8 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_8_field: field_type (i, object) = Integer_8_type
		do
			Result := c_integer_8_field (i - 1, object)
		end

	integer_16_field (i: INTEGER; object: ANY): INTEGER_16 is
			-- INTEGER_16 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_16_field: field_type (i, object) = Integer_16_type
		do
			Result := c_integer_16_field (i - 1, object)
		end

	integer_field, integer_32_field (i: INTEGER; object: ANY): INTEGER is
			-- INTEGER_32 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_32_field: field_type (i, object) = Integer_32_type
		do
			Result := c_integer_32_field (i - 1, object)
		end

	integer_64_field (i: INTEGER; object: ANY): INTEGER_64 is
			-- INTEGER_64 value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_64_field: field_type (i, object) = Integer_64_type
		do
			Result := c_integer_64_field (i - 1, object)
		end

	real_32_field, real_field (i: INTEGER; object: ANY): REAL is
			-- Real value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_32_field: field_type (i, object) = real_32_type
		do
			Result := c_real_32_field (i - 1, object)
		end

	pointer_field (i: INTEGER; object: ANY): POINTER is
			-- Pointer value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			pointer_field: field_type (i, object) = Pointer_type
		do
			Result := c_pointer_field (i - 1, object)
		end

	real_64_field, double_field (i: INTEGER; object: ANY): DOUBLE is
			-- Double precision value of `i'-th field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_64_field: field_type (i, object) = real_64_type
		do
			Result := c_real_64_field (i - 1, object)
		end

feature -- Version

	compiler_version: INTEGER is
		external
			"C [macro %"eif_project.h%"]"
		alias
			"egc_compiler_tag"
		end

feature -- Element change

	set_reference_field (i: INTEGER; object: ANY; value: ANY) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			reference_field: field_type (i, object) = Reference_type
			value_conforms_to_field_static_type:
				value /= Void implies
					type_conforms_to (dynamic_type (value),
						field_static_type_of_type (i, dynamic_type (object)))
		do
			c_set_reference_field (i - 1, object, value)
		end

	set_real_64_field, set_double_field (i: INTEGER; object: ANY; value: DOUBLE) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_64_field: field_type (i, object) = real_64_type
		do
			c_set_real_64_field (i - 1, object, value)
		end

	set_character_8_field, set_character_field (i: INTEGER; object: ANY; value: CHARACTER_8) is
			-- Set character value of `i'-th field of `object' to `value'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_field: field_type (i, object) = Character_8_type
		do
			c_set_character_8_field (i - 1, object, value)
		end

	set_character_32_field (i: INTEGER; object: ANY; value: CHARACTER_32) is
			-- Set character 32 value of `i'-th field of `object' to `value'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			character_field: field_type (i, object) = Character_32_type
		do
			c_set_character_32_field (i - 1, object, value)
		end

	set_boolean_field (i: INTEGER; object: ANY; value: BOOLEAN) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			boolean_field: field_type (i, object) = Boolean_type
		do
			c_set_boolean_field (i - 1, object, value)
		end

	set_natural_8_field (i: INTEGER; object: ANY; value: NATURAL_8) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_8_field: field_type (i, object) = natural_8_type
		do
			c_set_natural_8_field (i - 1, object, value)
		end

	set_natural_16_field (i: INTEGER; object: ANY; value: NATURAL_16) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_16_field: field_type (i, object) = natural_16_type
		do
			c_set_natural_16_field (i - 1, object, value)
		end

	set_natural_32_field (i: INTEGER; object: ANY; value: NATURAL_32) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_32_field: field_type (i, object) = natural_32_type
		do
			c_set_natural_32_field (i - 1, object, value)
		end

	set_natural_64_field (i: INTEGER; object: ANY; value: NATURAL_64) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			natural_64_field: field_type (i, object) = natural_64_type
		do
			c_set_natural_64_field (i - 1, object, value)
		end

	set_integer_8_field (i: INTEGER; object: ANY; value: INTEGER_8) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_8_field: field_type (i, object) = Integer_8_type
		do
			c_set_integer_8_field (i - 1, object, value)
		end

	set_integer_16_field (i: INTEGER; object: ANY; value: INTEGER_16) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_16_field: field_type (i, object) = Integer_16_type
		do
			c_set_integer_16_field (i - 1, object, value)
		end

	set_integer_field, set_integer_32_field (i: INTEGER; object: ANY; value: INTEGER) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_32_field: field_type (i, object) = Integer_32_type
		do
			c_set_integer_32_field (i - 1, object, value)
		end

	set_integer_64_field (i: INTEGER; object: ANY; value: INTEGER_64) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			integer_64_field: field_type (i, object) = Integer_64_type
		do
			c_set_integer_64_field (i - 1, object, value)
		end

	set_real_32_field, set_real_field (i: INTEGER; object: ANY; value: REAL) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			real_32_field: field_type (i, object) = real_32_type
		do
			c_set_real_32_field (i - 1, object, value)
		end

	set_pointer_field (i: INTEGER; object: ANY; value: POINTER) is
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			pointer_field: field_type (i, object) = Pointer_type
		do
			c_set_pointer_field (i - 1, object, value)
		end

feature -- Measurement

	field_count (object: ANY): INTEGER is
			-- Number of logical fields in `object'
		require
			object_not_void: object /= Void
		do
			Result := field_count_of_type ({ISE_RUNTIME}.dynamic_type (object))
		end

	field_count_of_type (type_id: INTEGER): INTEGER is
			-- Number of logical fields in dynamic type `type_id'.
		require
			type_id_nonnegative: type_id >= 0
		external
			"C macro signature (EIF_INTEGER): EIF_INTEGER use %"eif_internal.h%""
		alias
			"ei_count_field_of_type"
		end

	bit_size (i: INTEGER; object: ANY): INTEGER is
			-- Size (in bit) of the `i'-th bit field of `object'
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
			index_small_enough: i <= field_count (object)
			is_bit: field_type (i, object) = Bit_type
		do
			Result := c_bit_size (i - 1, object)
		ensure
			positive_result: Result > 0
		end

	physical_size (object: ANY): INTEGER is
			-- Space occupied by `object' in bytes
		require
			object_not_void: object /= Void
		do
			Result := c_size (object)
		end

	deep_physical_size (object: ANY): INTEGER is
			-- Space occupied by `object' and its children in bytes
		require
			object_not_void: object /= Void
		local
			l_traverse: OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE
			l_objects: ?ARRAYED_LIST [ANY]
		do
			create l_traverse
			l_traverse.set_root_object (object)
			l_traverse.traverse
			l_objects := l_traverse.visited_objects
			if l_objects /= Void then
				from
					l_objects.start
				until
					l_objects.after
				loop
					Result := Result + physical_size (l_objects.item)
					l_objects.forth
				end
			end
		end

feature -- Marking

	mark (obj: ANY) is
			-- Mark object `obj'.
			-- To be thread safe, make sure to call this feature when you
			-- have the marking lock that you acquire using `lock_marking'.
		require
			object_not_void: obj /= Void
			object_not_marked: not is_marked (obj)
		do
			c_mark (obj)
		ensure
			is_marked: is_marked (obj)
		end

	unmark (obj: ANY) is
			-- Unmark object `obj'.
			-- To be thread safe, make sure to call this feature when you
			-- have the marking lock that you acquire using `lock_marking'.
		require
			object_not_void: obj /= Void
			object_marked: is_marked (obj)
		do
			c_unmark (obj)
		ensure
			is_not_marked: not is_marked (obj)
		end

	lock_marking is
			-- Get a lock on `mark' and `unmark' routine so that 2 threads cannot `mark' and
			-- `unmark' at the same time.
		external
			"C blocking use %"eif_traverse.h%""
		alias
			"eif_lock_marking"
		end

	unlock_marking is
			-- Release a lock on `mark' and `unmark', so that another thread can
			-- use `mark' and `unmark'.
		external
			"C use %"eif_traverse.h%""
		alias
			"eif_unlock_marking"
		end

feature {NONE} -- Cached data

	internal_dynamic_type_string_table: HASH_TABLE [INTEGER, STRING] is
			-- Table of dynamic type indexed by type name
		once
			create Result.make (100)
		ensure
			internal_dynamic_type_string_table_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	c_is_instance_of (type1: INTEGER; obj: ANY): BOOLEAN is
			-- Is `obj' an instance of `type1'?
		external
			"built_in static"
		end

	c_field (i: INTEGER; object: ANY): ?ANY is
			-- Object referenced by the `i'-th field of `object'
		external
			"built_in static"
		end

	c_field_name_of_type (i: INTEGER; type_id: INTEGER): POINTER is
			-- C pointer to name of `i'-th field of `object'
		external
			"C macro signature (EIF_INTEGER, EIF_INTEGER): EIF_POINTER use %"eif_internal.h%""
		alias
			"ei_field_name_of_type"
		end

	c_field_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER is
			-- Abstract type of `i'-th field of dynamic type `type_id'
		external
			"C signature (long, EIF_INTEGER): EIF_INTEGER use %"eif_internal.h%""
		alias
			"ei_field_type_of_type"
		end

	c_field_static_type_of_type (i: INTEGER; type_id: INTEGER): INTEGER is
			-- Static type of `i'-th field of dynamic type `type_id'
		external
			"C signature (long, EIF_INTEGER): EIF_INTEGER use %"eif_internal.h%""
		alias
			"ei_field_static_type_of_type"
		end

	c_expanded_type (i: INTEGER; object: ANY): STRING is
			-- Class name of the `i'-th expanded field of `object'
		external
			"built_in static"
		end

	c_character_8_field (i: INTEGER; object: ANY): CHARACTER_8 is
			-- Character value of `i'-th field of `object'
		external
			"built_in static"
		end

	c_character_32_field (i: INTEGER; object: ANY): CHARACTER_32 is
			-- Character value of `i'-th field of `object'
		external
			"built_in static"
		end

	c_boolean_field (i: INTEGER; object: ANY): BOOLEAN is
			-- Boolean value of `i'-th field of `object'
		external
			"built_in static"
		end

	c_natural_8_field (i: INTEGER; object: ANY): NATURAL_8 is
			-- NATURAL_8 value of `i'-th field of `object'
		external
			"built_in static"
		end

	c_natural_16_field (i: INTEGER; object: ANY): NATURAL_16 is
			-- NATURAL_16 value of `i'-th field of `object'
		external
			"built_in static"
		end

	c_natural_32_field (i: INTEGER; object: ANY): NATURAL_32 is
			-- NATURAL_32 value of `i'-th field of `object'
		external
			"built_in static"
		end

	c_natural_64_field (i: INTEGER; object: ANY): NATURAL_64 is
			-- NATURAL_64 value of `i'-th field of `object'
		external
			"built_in static"
		end

	c_integer_8_field (i: INTEGER; object: ANY): INTEGER_8 is
			-- Integer value of `i'-th field of `object'
		external
			"built_in static"
		end

	c_integer_16_field (i: INTEGER; object: ANY): INTEGER_16 is
			-- Integer value of `i'-th field of `object'
		external
			"built_in static"
		end

	c_integer_32_field (i: INTEGER; object: ANY): INTEGER is
			-- Integer value of `i'-th field of `object'
		external
			"built_in static"
		end

	c_integer_64_field (i: INTEGER; object: ANY): INTEGER_64 is
			-- Integer value of `i'-th field of `object'
		external
			"built_in static"
		end

	c_real_32_field (i: INTEGER; object: ANY): REAL is
			-- Real value of `i'-th field of `object'
		external
			"built_in static"
		end

	c_pointer_field (i: INTEGER; object: ANY): POINTER is
			-- Pointer value of `i'-th field of `object'
		external
			"built_in static"
		end

	c_real_64_field (i: INTEGER; object: ANY): DOUBLE is
			-- Double precision value of `i'-th field of `object'
		external
			"built_in static"
		end

	c_is_special (object: ANY): BOOLEAN is
			-- Is `object' a special object?
		external
			"built_in static"
		end

	c_is_tuple (object: ANY): BOOLEAN is
			-- Is `object' a TUPLE object?
		external
			"built_in static"
		end

	c_field_offset (i: INTEGER; object: ANY): INTEGER is
			-- Offset of `i'-th field of `object'
		external
			"built_in static"
		end

	c_bit_size (i: INTEGER; object: ANY): INTEGER is
			-- Size (in bit) of the `i'-th bit field of `object'
		external
			"built_in static"
		end

	c_size (object: ANY): INTEGER is
			-- Physical size of `object'
		external
			"built_in static"
		end

	c_set_reference_field (i: INTEGER; object: ANY; value: ANY) is
		external
			"built_in static"
		end

	c_set_real_64_field (i: INTEGER; object: ANY; value: DOUBLE) is
		external
			"built_in static"
		end

	c_set_character_8_field (i: INTEGER; object: ANY; value: CHARACTER_8) is
		external
			"built_in static"
		end

	c_set_character_32_field (i: INTEGER; object: ANY; value: CHARACTER_32) is
		external
			"built_in static"
		end

	c_set_boolean_field (i: INTEGER; object: ANY; value: BOOLEAN) is
		external
			"built_in static"
		end

	c_set_natural_8_field (i: INTEGER; object: ANY; value: NATURAL_8) is
		external
			"built_in static"
		end

	c_set_natural_16_field (i: INTEGER; object: ANY; value: NATURAL_16) is
		external
			"built_in static"
		end

	c_set_natural_32_field (i: INTEGER; object: ANY; value: NATURAL_32) is
		external
			"built_in static"
		end

	c_set_natural_64_field (i: INTEGER; object: ANY; value: NATURAL_64) is
		external
			"built_in static"
		end

	c_set_integer_8_field (i: INTEGER; object: ANY; value: INTEGER_8) is
		external
			"built_in static"
		end

	c_set_integer_16_field (i: INTEGER; object: ANY; value: INTEGER_16) is
		external
			"built_in static"
		end

	c_set_integer_32_field (i: INTEGER; object: ANY; value: INTEGER) is
		external
			"built_in static"
		end

	c_set_integer_64_field (i: INTEGER; object: ANY; value: INTEGER_64) is
		external
			"built_in static"
		end

	c_set_real_32_field (i: INTEGER; object: ANY; value: REAL) is
		external
			"built_in static"
		end

	c_set_pointer_field (i: INTEGER; object: ANY; value: POINTER) is
		external
			"built_in static"
		end

	eif_gen_count_with_dftype (type_id: INTEGER): INTEGER is
			-- Number of generic parameters of `obj'.
		external
			"C signature (int16): int use %"eif_gen_conf.h%""
		end

	eif_gen_param_id (dftype: INTEGER; pos: INTEGER): INTEGER is
			-- Type of generic parameter in `obj' at position `pos'.
		external
			"C (EIF_TYPE_INDEX, int): EIF_INTEGER | %"eif_gen_conf.h%""
		end

	c_new_instance_of (type_id: INTEGER): ANY is
			-- New instance of dynamic `type_id'.
			-- Note: returned object is not initialized and may
			-- hence violate its invariant.
			-- `type_id' cannot represent a SPECIAL type, use
			-- `new_special_any_instance' instead.	
		external
			"C macro use %"eif_macros.h%""
		alias
			"RTLNSMART"
		end

	c_set_dynamic_type (obj: SPECIAL [ANY]; dtype: INTEGER) is
			-- Set `obj' dynamic type to `dtype'.
		external
			"built_in static"
		end

	c_eif_special_any_type (type_id: INTEGER): BOOLEAN is
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type.
		external
			"C signature (EIF_INTEGER): EIF_BOOLEAN use %"eif_internal.h%""
		alias
			"eif_special_any_type"
		end

	c_eif_is_special_type (type_id: INTEGER): BOOLEAN is
			-- Is type represented by `type_id' represent
			-- a SPECIAL [XX] where XX is a reference type or
			-- a basic type.
		external
			"C signature (EIF_INTEGER): BOOLEAN use %"eif_internal.h%""
		alias
			"eif_is_special_type"
		end

	c_eif_is_tuple_type (type_id: INTEGER): BOOLEAN is
			-- Is type represented by `type_id' represent a TUPLE?
		external
			"C signature (EIF_INTEGER): BOOLEAN use %"eif_internal.h%""
		alias
			"eif_is_tuple_type"
		end

	c_type_conforms_to (type1, type2: INTEGER): BOOLEAN is
			-- Does `type1' conform to `type2'?
		external
			"C signature (int16, int16): EIF_BOOLEAN use %"eif_gen_conf.h%""
		alias
			"eif_gen_conf"
		end

	c_is_marked (obj: ANY): BOOLEAN is
		external
			"built_in static"
		end

	c_unmark (obj: ANY) is
		external
			"built_in static"
		end

	c_mark (obj: ANY) is
		external
			"built_in static"
		end

end
