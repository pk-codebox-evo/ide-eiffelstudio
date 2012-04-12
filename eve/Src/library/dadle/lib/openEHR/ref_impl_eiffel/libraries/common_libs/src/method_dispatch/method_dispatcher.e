indexing
	component:   "openEHR Library Project"
	description: "Native method dispatcher for Eiffel routine and attribute access. Uses CECIL."
	keywords:    "method dispatch cecil"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2004 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/common_libs/src/method_dispatch/method_dispatcher.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class METHOD_DISPATCHER

inherit
	INTERNAL
		export
			{NONE} all
		end

	SHARED_TYPE_ID_CACHE
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make(ignore_invisible, cache_created_obj_ids: BOOLEAN) is
			-- 'ignore_invisible' = True prevents Eiffel from raising an exception if a feature
			-- call is made on a non-visible object;
			-- 'cache_created_obj_ids' is now ignored; a type id cache is always created.
		do
			if ignore_invisible then
				c_ignore_invisible
			end
		end

feature -- Access

	eif_type_id(a_type_name: STRING): INTEGER is
			-- return the unique internal type id as from eif_type_id()
		obsolete
			"Use INTERNAL.dynamic_type_from_string instead"
		require
			Valid_type_name: a_type_name /= Void and then not a_type_name.is_empty
		do
			Result := dynamic_type_from_string(a_type_name)
		end

feature -- Status

	is_class_visible(a_type_name:STRING):BOOLEAN is
			-- unless a class is described as VISIBLE in the ace file, these
			-- features will not work. Use is_class_visible to test whether
			-- you may use the other features of this class on it.
		require
			Valid_class_name: a_type_name /= Void and then not a_type_name.is_empty
		local
			c_class_name: ANY
		do
			c_class_name := a_type_name.to_c
			Result := c_is_class_visible($c_class_name)
		end

	is_valid_feature(a_type_name:STRING; feature_name:STRING):BOOLEAN is
			-- is the call 'a_type_name'.'feature_name' a valid feature call (of any signature)
		require
			Class_name_exists: a_type_name /= Void and then not a_type_name.is_empty
			Class_visible: is_class_visible(a_type_name)
			Feature_name_exists: feature_name /= Void and then not feature_name.is_empty
		local
			c_class_name, c_feature_name:ANY
		do
			c_class_name := a_type_name.to_c
			c_feature_name := feature_name.to_c
			Result := c_is_valid_feature($c_class_name, $c_feature_name)
		end

feature -- Argument Handling

	marshal_args_reset is
		do
			c_marshal_args_reset
		end

	marshal_int_arg(an_int:INTEGER) is
		do
			c_marshal_int_arg(an_int)
		end

	marshal_ref_arg(a_ref:ANY) is
		do
			c_marshal_ptr_arg($a_ref)
		end

feature -- Creation

	create_object(a_type_name, make_proc_name:STRING):ANY is
			-- create a new object; if make routine is present, any arguments have to be
			-- marshalled in advance
		require
			Class_name_valid: a_type_name /= Void and then not a_type_name.is_empty
			Make_proc_name_valid: make_proc_name /= Void implies not make_proc_name.is_empty
			Class_procedure_validity: is_valid_feature(a_type_name, make_proc_name)
		do
			Result := create_object_by_id(type_id(a_type_name), make_proc_name)
		ensure
			Result_exists: Result /= Void
		end

	create_object_by_id(a_type_id:INTEGER; make_proc_name:STRING):ANY is
			-- create a new object; if make routine is present, any arguments have to be
			-- marshalled in advance
		require
			Make_proc_name_valid: make_proc_name /= Void implies not make_proc_name.is_empty
		local
			c_proc_name:ANY
		do
			if make_proc_name /= Void then
				c_proc_name := make_proc_name.to_c
			end

			Result := c_create_object_by_id(a_type_id, $c_proc_name)
		ensure
			Result_exists: Result /= Void
		end

	create_make_object(a_type_name, make_proc_name:STRING; make_arg:ANY):ANY is
			-- create a new object and call 'make_proc_name' with 'make_arg'
		require
			Type_name_valid: a_type_name /= Void and then not a_type_name.is_empty
			Make_proc_name_valid: make_proc_name /= Void implies not make_proc_name.is_empty
			Class_procedure_validity: is_valid_feature(a_type_name, make_proc_name)
		do
			Result := create_make_object_by_id(type_id(a_type_name), make_proc_name, make_arg)
		ensure
			Result_exists: Result /= Void
		end

	create_make_object_by_id(a_type_id:INTEGER; make_proc_name:STRING; make_arg:ANY):ANY is
			-- create a new object; if make routine is present, any arguments have to be
			-- marshalled in advance
		require
			Make_proc_name_valid: make_proc_name /= Void implies not make_proc_name.is_empty
		local
			c_proc_name:ANY
		do
			if make_proc_name /= Void then
				c_proc_name := make_proc_name.to_c
			end

			Result := c_create_make_object_by_id(a_type_id, $c_proc_name, $make_arg)
		ensure
			Result_exists: Result /= Void
		end

feature -- Routine Dispatch

	dispatch_procedure (obj:ANY; feature_name:STRING; arg:ANY) is
			-- dispatch a procedure call. Signature: PROC (ARG)
		require
			Object_exists: obj /= Void
			Valid_feature_name: feature_name /= Void and then not feature_name.is_empty
		local
			c_feature_name: ANY
		do
			c_feature_name := feature_name.to_c
			c_dispatch_procedure($obj, $c_feature_name, $arg)
		end

	dispatch_reference_function (obj:ANY; feature_name:STRING; arg:ANY):ANY is
			-- dispatch a call to a feature with signature: FEATURE (ARG) : REFERENCE
		do
			dispatch_function (obj, feature_name, arg, Reference_type)
			Result := c_result_obj
		end

	dispatch_boolean_function (obj:ANY; feature_name:STRING; arg:ANY):BOOLEAN is
			-- dispatch a call to a feature with signature: FEATURE (ARG) : BOOLEAN
		do
			dispatch_function (obj, feature_name, arg, Boolean_type)
			Result := c_result_bool
		end

	dispatch_character_function (obj:ANY; feature_name:STRING; arg:ANY):CHARACTER is
			-- dispatch a call to a feature with signature: FEATURE (ARG) : CHARACTER
		do
			dispatch_function (obj, feature_name, arg, Character_type)
			Result := c_result_char
		end

	dispatch_integer_function (obj:ANY; feature_name:STRING; arg:ANY):INTEGER is
			-- dispatch a call to a feature with signature: FEATURE (ARG) : INTEGER
		do
			dispatch_function (obj, feature_name, arg, Integer_type)
			Result := c_result_int
		end

	dispatch_real_function (obj:ANY; feature_name:STRING; arg:ANY):REAL is
			-- dispatch a call to a feature with signature: FEATURE (ARG) : REAL
		do
			dispatch_function (obj, feature_name, arg, Real_type)
			Result := c_result_real
		end

	dispatch_double_function (obj:ANY; feature_name:STRING; arg:ANY):DOUBLE is
			-- dispatch a call to a feature with signature: FEATURE (ARG) : DOUBLE
		do
			dispatch_function (obj, feature_name, arg, Double_type)
			Result := c_result_double
		end

	dispatch_pointer_function (obj:ANY; feature_name:STRING; arg:ANY):POINTER is
			-- dispatch a call to a feature with signature: FEATURE (ARG) : POINTER
		do
			dispatch_function (obj, feature_name, arg, Pointer_type)
			Result := c_result_pointer
		end

	dispatch_bit_function (obj:ANY; feature_name:STRING; arg:ANY):BIT_REF is
			-- dispatch a call to a feature with signature: FEATURE (ARG) : BIT_REF
		do
			dispatch_function (obj, feature_name, arg, Bit_type)
			Result := c_result_bit
		end

feature -- Field Dispatch

	dispatch_reference_field (obj:ANY; feature_name:STRING):ANY is
			-- obtain a field (signature: ATTRIBUTE : ANY)
		require
			Object_exists: obj /= Void
			Valid_feature_name: feature_name /= Void and then not feature_name.is_empty
		local
			c_feature_name: ANY
		do
			c_feature_name := feature_name.to_c
			c_dispatch_reference_field($obj, $c_feature_name)
			Result := c_result_obj
		end

	dispatch_integer_field (obj:ANY; feature_name:STRING):INTEGER is
			-- obtain a field (signature: ATTRIBUTE : INTEGER)
		require
			Object_exists: obj /= Void
			Valid_feature_name: feature_name /= Void and then not feature_name.is_empty
		local
			c_feature_name: ANY
		do
			c_feature_name := feature_name.to_c
			c_dispatch_integer_field($obj, $c_feature_name)
			Result := c_result_int
		end

	dispatch_boolean_field (obj:ANY; feature_name:STRING):BOOLEAN is
			-- obtain a field (signature: ATTRIBUTE : BOOLEAN)
		require
			Object_exists: obj /= Void
			Valid_feature_name: feature_name /= Void and then not feature_name.is_empty
		local
			c_feature_name: ANY
		do
			c_feature_name := feature_name.to_c
			c_dispatch_boolean_field($obj, $c_feature_name)
			Result := c_result_bool
		end

	dispatch_real_field (obj:ANY; feature_name:STRING):REAL is
			-- obtain a field (signature: ATTRIBUTE : REAL)
		require
			Object_exists: obj /= Void
			Valid_feature_name: feature_name /= Void and then not feature_name.is_empty
		local
			c_feature_name: ANY
		do
			c_feature_name := feature_name.to_c
			c_dispatch_real_field($obj, $c_feature_name)
			Result := c_result_real
		end

	dispatch_double_field (obj:ANY; feature_name:STRING):DOUBLE is
			-- obtain a field (signature: ATTRIBUTE : DOUBLE)
		require
			Object_exists: obj /= Void
			Valid_feature_name: feature_name /= Void and then not feature_name.is_empty
		local
			c_feature_name: ANY
		do
			c_feature_name := feature_name.to_c
			c_dispatch_double_field($obj, $c_feature_name)
			Result := c_result_double
		end

	dispatch_character_field (obj:ANY; feature_name:STRING):CHARACTER is
			-- obtain a field (signature: ATTRIBUTE : CHARACTER)
		require
			Object_exists: obj /= Void
			Valid_feature_name: feature_name /= Void and then not feature_name.is_empty
		local
			c_feature_name: ANY
		do
			c_feature_name := feature_name.to_c
			c_dispatch_character_field($obj, $c_feature_name)
			Result := c_result_char
		end

feature {NONE} -- Implementation

	dispatch_function (obj:ANY; feature_name:STRING; arg:ANY; feature_type:INTEGER) is
			-- dispatch any feature call
		require
			Object_exists: obj /= Void
			Valid_feature_name: feature_name /= Void and then not feature_name.is_empty
		local
			c_feature_name: ANY
		do
			c_feature_name := feature_name.to_c
			c_dispatch_function($obj, $c_feature_name, $arg, feature_type)
		end

	object_id_cache:HASH_TABLE[INTEGER, STRING]

feature {NONE} -- External

	c_ignore_invisible is
		external
		   "C"
		end

	c_create_object_by_id(obj_type_id: INTEGER; c_make_proc_name: POINTER): ANY is
		external
		   "C"
		end

	c_create_make_object_by_id(obj_type_id: INTEGER; c_make_proc_name, c_arg: POINTER): ANY is
		external
		   "C"
		end

	c_is_valid_feature(c_str_class_name, c_str_feature_name: POINTER): BOOLEAN is
		external
		   "C"
		end

	c_is_class_visible(c_class_name: POINTER): BOOLEAN is
		external
		   "C"
		end

	c_dispatch_procedure (c_obj, c_feature, c_arg: POINTER) is
		external
		   "C"
		end

	c_dispatch_reference_field (c_obj, c_feature: POINTER) is
		external
		   "C"
		end

	c_dispatch_boolean_field (c_obj: POINTER; c_feature: POINTER) is
		external
		   "C"
		end

	c_dispatch_integer_field (c_obj: POINTER; c_feature: POINTER) is
		external
		   "C"
		end

	c_dispatch_real_field (c_obj: POINTER; c_feature: POINTER) is
		external
		   "C"
		end

	c_dispatch_double_field (c_obj: POINTER; c_feature: POINTER) is
		external
		   "C"
		end

	c_dispatch_character_field (c_obj: POINTER; c_feature: POINTER) is
		external
		   "C"
		end

	c_dispatch_function (c_obj, c_feature, c_arg: POINTER; feature_type: INTEGER) is
		external
		   "C"
		end

	c_result_char: CHARACTER is
		external
		   "C"
		end

	c_result_bool: BOOLEAN is
		external
		   "C"
		end

	c_result_int: INTEGER is
		external
		   "C"
		end

	c_result_real: REAL is
		external
		   "C"
		end

	c_result_double: DOUBLE is
		external
		   "C"
		end

	c_result_pointer: POINTER is
		external
		   "C"
		end

	c_result_bit: BIT_REF is
		external
		   "C"
		end

	c_result_obj: ANY is
		external
		   "C"
		end

	c_marshal_args_reset is
		external
		   "C"
		end

	c_marshal_int_arg(arg: INTEGER) is
		external
		   "C"
		end

	c_marshal_ptr_arg(arg: POINTER) is
		external
		   "C"
		end

end

--|
--| ***** BEGIN LICENSE BLOCK *****
--| Version: MPL 1.1/GPL 2.0/LGPL 2.1
--|
--| The contents of this file are subject to the Mozilla Public License Version
--| 1.1 (the 'License'); you may not use this file except in compliance with
--| the License. You may obtain a copy of the License at
--| http://www.mozilla.org/MPL/
--|
--| Software distributed under the License is distributed on an 'AS IS' basis,
--| WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
--| for the specific language governing rights and limitations under the
--| License.
--|
--| The Original Code is method_dispatcher.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2003-2004
--| the Initial Developer. All Rights Reserved.
--|
--| Contributor(s):
--|
--| Alternatively, the contents of this file may be used under the terms of
--| either the GNU General Public License Version 2 or later (the 'GPL'), or
--| the GNU Lesser General Public License Version 2.1 or later (the 'LGPL'),
--| in which case the provisions of the GPL or the LGPL are applicable instead
--| of those above. If you wish to allow use of your version of this file only
--| under the terms of either the GPL or the LGPL, and not to allow others to
--| use your version of this file under the terms of the MPL, indicate your
--| decision by deleting the provisions above and replace them with the notice
--| and other provisions required by the GPL or the LGPL. If you do not delete
--| the provisions above, a recipient may use your version of this file under
--| the terms of any one of the MPL, the GPL or the LGPL.
--|
--| ***** END LICENSE BLOCK *****
--|
