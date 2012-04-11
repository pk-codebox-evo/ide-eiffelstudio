indexing
	component:   "openEHR Archetype Project"
	description: "[
				 object birectional converter. Errors due to mismatching data and object 
				 model reported in last_op_fail and fail_reason.
				 ]"
	keywords:    "dADL"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2005 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/common_libs/src/structures/data_tree/dt_object_converter.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class DT_OBJECT_CONVERTER

inherit
	DT_FACTORY

	MESSAGE_BILLBOARD
		export
			{NONE} all
		end

feature -- Conversion

	object_to_dt(an_obj: ANY): DT_COMPLEX_OBJECT_NODE is
			-- generate a DT_OBJECT from an Eiffel object
		do
			create Result.make_anonymous
			populate_dt_from_object(an_obj, Result)
		end

	populate_dt_from_object(an_obj:ANY; a_dt_obj:DT_COMPLEX_OBJECT_NODE) is
			-- make a data tree from an object
		local
			a_dt_attr: DT_ATTRIBUTE_NODE
			fld_dynamic_type: INTEGER
			fld_val: ANY
			equiv_prim_type_id, i: INTEGER
			fld_name: STRING
			a_sequence: SEQUENCE[ANY]
			a_hash_table: HASH_TABLE [ANY, HASHABLE]
			dt_conv: DT_CONVERTIBLE
			fld_lst: ARRAYED_LIST[STRING]
		do
			a_dt_obj.set_type_name(an_obj.generating_type)
			debug ("DT")
				io.put_string("DT_OBJECT_CONVERTER.populate_dt_from_object: populating from a " +
					an_obj.generating_type + "%N")
			end

			-- it is a generic object itself, have to deal with specially
			a_hash_table ?= an_obj
			a_sequence ?= an_obj
			if a_hash_table /= Void or a_sequence /= Void then
				create a_dt_attr.make_multiple_generic
				create_dt_from_generic_obj(a_dt_attr, an_obj)
				a_dt_obj.put_attribute(a_dt_attr)
			else -- its not a container object
				dt_conv ?= an_obj
				if dt_conv /= Void then
					fld_lst := dt_conv.persistent_attributes
				end
				from
					i := 1
				until
					i > field_count(an_obj)
				loop
					fld_val := field(i, an_obj)
					if fld_val /= Void then
						fld_name := field_name(i, an_obj)
						if fld_lst = Void or else fld_lst.has(fld_name) then
							debug ("DT")
								io.put_string("DT_OBJECT_CONVERTER.populate_dt_from_object: field_name = " + fld_name + "%N")
							end
							fld_dynamic_type := dynamic_type(fld_val)
							equiv_prim_type_id := any_primitive_conforming_type(fld_dynamic_type)
							if equiv_prim_type_id /= 0 then
								create a_dt_attr.make_single(fld_name)
								populate_prim_type_attribute(an_obj, a_dt_attr, fld_val, equiv_prim_type_id)
								a_dt_obj.put_attribute(a_dt_attr)
							else -- its a complex object, or else a SEQUENCE or HASH_TABLE of a complex object
								debug ("DT")
									io.put_string("DT_OBJECT_CONVERTER.populate_dt_from_object: (complex or container type)%N")
								end
								a_hash_table ?= fld_val
								a_sequence ?= fld_val
								if a_hash_table /= Void or a_sequence /= Void then
									debug ("DT")
										io.put_string("DT_OBJECT_CONVERTER.populate_dt_from_object: (container type)%N")
									end
									create a_dt_attr.make_multiple(fld_name)
									create_dt_from_generic_obj(a_dt_attr, fld_val)
									if not a_dt_attr.is_empty then
										a_dt_obj.put_attribute(a_dt_attr)
									end
								else
									debug ("DT")
										io.put_string("DT_OBJECT_CONVERTER.populate_dt_from_object: (normal complex type)%N")
									end
									-- it's a normal complex object
									create a_dt_attr.make_single(fld_name)
									populate_dt_from_object(fld_val, create_complex_object_node(a_dt_attr, Void))
									a_dt_obj.put_attribute(a_dt_attr)
								end
							end
						end
					end
					i := i + 1
				end
			end
		end

	populate_prim_type_attribute(an_obj:ANY; a_dt_attr: DT_ATTRIBUTE_NODE; fld_val:ANY; equiv_prim_type_id: INTEGER) is
			-- FIXME: this routine exists because of the Eiffel expanded
			-- non-conformance problem. It has been made a separate
			-- routine to allow exception handling to function properly
		local
			-- FIXME: all this code just to handle expanded nonconformance of INTERVAL[INTEGER] -> INTERVAL[PART_COMPARABLE]
			-- REMOVE when this problem fixed
			oe_int_real: INTERVAL[REAL]
			oe_int_integer: INTERVAL[INTEGER]
			exception_caught: BOOLEAN
		do
			if not exception_caught then
				debug ("DT")
					io.put_string("DT_OBJECT_CONVERTER.populate_dt_from_object: (primitive type)%N")
					io.put_string("%T from_obj_proc.call([DT_ATTRIBUTE_NODE(" +
						a_dt_attr.rm_attr_name + "), " + fld_val.generating_type + ", Void)%N")
				end
				cvt_tbl.item(equiv_prim_type_id).from_obj_proc.call([a_dt_attr, fld_val, Void])
				debug ("DT")
					io.put_string("%T(return)%N")
				end
			else
				-- FIXME: all this code just to handle expanded nonconformance of INTERVAL[INTEGER] -> INTERVAL[PART_COMPARABLE]
				-- REMOVE when this problem fixed
				oe_int_integer ?= fld_val
				if oe_int_integer /= Void then
					debug ("DT")
						io.put_string("Using INTERVAL[INTEGER_REF] conversion%N")
					end
					cvt_tbl.item(equiv_prim_type_id).from_obj_proc.call([a_dt_attr,
						interval_integer_to_interval_integer_ref(oe_int_integer), Void])
				else
					oe_int_real ?= fld_val
					if oe_int_real /= Void then
						debug ("DT")
							io.put_string("Using INTERVAL[REAL_REF] conversion%N")
						end
						cvt_tbl.item(equiv_prim_type_id).from_obj_proc.call([a_dt_attr,
							interval_real_to_interval_real_ref(oe_int_real), Void])
					else
						debug ("DT")
							io.put_string("No conversion available%N")
						end
					end
				end
			end
		rescue
			if not exception_caught then
				if equiv_prim_type_id /= 0 then -- this must have been an argument type mismatch which killed the from_obj_proc.call[]
					post_error(Current, "populate_prim_type_attribute", "populate_dt_proc_arg_type_mismatch",
						<<type_name(an_obj), a_dt_attr.rm_attr_name, fld_val.generating_type, type_name_of_type(equiv_prim_type_id)>>)
				end
				exception_caught := True
				retry
			else
				post_error(Current, "populate_prim_type_attribute", "unhandled_exception", <<"Failed to convert type">>)
			end
		end

	dt_to_object(a_dt_obj: DT_COMPLEX_OBJECT_NODE; a_type_id: INTEGER): ANY is
			-- make an object whose classes and attributes correspond to the structure
			-- of this DT_OBJECT
		local
			a_dt_attr: DT_ATTRIBUTE_NODE
			a_dt_obj_leaf: DT_OBJECT_LEAF
			fld_name: STRING
			fld_type_id, equiv_prim_type_id, i: INTEGER
			a_gen_field: ANY
			a_dt_conv: DT_CONVERTIBLE
			exception_caught: BOOLEAN
		do
			if is_special_any_type(a_type_id) then
				-- FIXME: how to determine the length of the SPECIAL?
				debug ("DT")
					io.put_string("DT_OBJECT_CONVERTER.dt_to_object: about to call new_special_any_instance(" +
						type_name_of_type(a_type_id) + ")%N")
				end
				Result := new_special_any_instance(a_type_id, 1)
				debug ("DT")
					io.put_string("%T(return)%N")
				end
			else
				debug ("DT")
					io.put_string("DT_OBJECT_CONVERTER.dt_to_object: about to call new_instance_of(" +
						type_name_of_type(a_type_id) + ")%N")
				end
				Result := new_instance_of(a_type_id)
				debug ("DT")
					io.put_string("%T(return)%N")
				end

				-- FIXME: the following is a hacker's attempt to
				-- reliably call a reasonable make function? Should call at least 'default_create'
				-- Eiffel does not allow this at the moment.
				a_dt_conv ?= Result
				if a_dt_conv /= Void then
					a_dt_conv.make_dt
				end
			end

			if not exception_caught then
				if generic_count_of_type(a_type_id) > 0 then
					-- we are on a generic object, and the correspoding DT object must
					-- have a single attribute which is_generic and is_multiple
					-- we don't go through its fields, instead we just go to the next
					-- object level down in the DT tree
					if not a_dt_obj.is_empty then
						a_dt_obj.start -- get first attribute
						a_dt_attr := a_dt_obj.item
						if a_dt_attr.is_generic then
							set_generic_object_data_from_dt (Result, a_dt_attr)
						else
							-- should never get here: it means that the DT data parsed as a
							-- nested generic, but that the corresponding object types are not
						end
					end
				else
					-- for each field in the object
					from
						i := 1
					until
						i > field_count(Result)
					loop
						fld_name := field_name(i, Result)

						if a_dt_obj.has_attribute(fld_name) then
							a_dt_attr := a_dt_obj.attribute(fld_name)

							fld_type_id := field_static_type_of_type(i, a_type_id)
							if a_dt_attr.is_multiple and not a_dt_attr.is_empty then
								if is_container_type(fld_type_id) then
									-- create container object
									debug ("DT")
										io.put_string("DT_OBJECT_CONVERTER.dt_to_object: about to call (2) new_instance_of(" +
											type_name_of_type(fld_type_id) + ")%N")
									end
									a_gen_field := new_instance_of(fld_type_id)
									debug ("DT")
										io.put_string("%T(return)%N")
									end
									set_reference_field(i, Result, a_gen_field)

									-- FIXME: can only deal with one generic parameter for the moment
									set_generic_object_data_from_dt (a_gen_field, a_dt_attr)
								else -- type in parsed data is container, but is not in Eiffel class		
									post_error(Current, "dt_to_object", "container_type_mismatch",
										<<type_name_of_type(fld_type_id), type_name_of_type(a_type_id)>>
									)
								end
							else
								a_dt_attr.start
								a_dt_obj_leaf ?= a_dt_attr.item
								if a_dt_obj_leaf /= Void then
									equiv_prim_type_id := any_primitive_conforming_type(fld_type_id)
									if equiv_prim_type_id /= 0 then
										debug ("DT")
											io.put_string("DT_OBJECT_CONVERTER.dt_to_object: from_dt_proc.call([" +
												i.out + ", " + Result.generating_type + ", " +
												a_dt_obj_leaf.value.generating_type + ")%N")
										end
										cvt_tbl.item(equiv_prim_type_id).from_dt_proc.call([i, Result, a_dt_obj_leaf.value])
										debug ("DT")
											io.put_string("%T(return)%N")
										end
									else -- type implied in data is primitive, but it is not a primitive type in Eiffel class
										post_error(Current, "dt_to_object", "primitive_type_mismatch",
											<<type_name_of_type(fld_type_id), type_name_of_type(a_type_id)>>
										)
									end
								else -- must be a reference type field
									set_reference_field(i, Result, a_dt_attr.item.as_object(fld_type_id))
								end
							end
						end
						i := i + 1
					end
				end
			end
		rescue
			if equiv_prim_type_id /= 0 then -- this must have been an argument type mismatch which killed the from_dt_proc.call[]
				post_error(Current, "dt_to_object", "dt_proc_arg_type_mismatch",
					<<type_name_of_type(a_type_id), fld_name, type_name_of_type(fld_type_id), type_name(a_dt_obj_leaf.value)>>)
			end
			exception_caught := True
			retry
		end

	prim_object_to_dt(a_parent: DT_ATTRIBUTE_NODE; an_obj: ANY; a_node_id: STRING) is
		require
			Type_valid: has_primitive_type(an_obj)
			Obj_exists: an_obj /= Void
			Node_id_valid: a_node_id /= Void implies not a_node_id.is_empty
		do
			debug ("DT")
				io.put_string("DT_OBJECT_CONVERTER.prim_object_to_dt: from_obj_proc.call([DT_ATTRIBUTE_NODE(" +
					a_parent.rm_attr_name + "), " + an_obj.generating_type + ", [a_node_id])%N")
			end
			cvt_tbl.item(any_primitive_conforming_type(dynamic_type(an_obj))).from_obj_proc.call([a_parent, an_obj, a_node_id])
			debug ("DT")
				io.put_string("%T(return)%N")
			end
		end

feature {NONE} -- Conversion to object

	set_primitive_integer_field (i: INTEGER; object: ANY; value: INTEGER_REF) is
		do
			set_integer_field (i, object, value)
		end

	set_primitive_real_field (i: INTEGER; object: ANY; value: REAL_REF) is
		do
			set_real_field (i, object, value)
		end

	set_primitive_double_field (i: INTEGER; object: ANY; value: DOUBLE_REF) is
		do
			set_double_field (i, object, value)
		end

	set_primitive_boolean_field (i: INTEGER; object: ANY; value: BOOLEAN_REF) is
		do
			set_boolean_field (i, object, value)
		end

	set_primitive_character_field (i: INTEGER; object: ANY; value: CHARACTER_REF) is
		do
			set_character_field (i, object, value)
		end

	set_primitive_sequence_field (i: INTEGER; object: ANY; value: ANY) is
			-- set i-th field of object which is some kind of sequence of a primitive type,
			-- from a value which is either an ARRAYED_LIST or a single object like a INTEGER_REF
		require
			object_not_void: object /= Void
			index_large_enough: i >= 1
		local
			al_val, al_field: ARRAYED_LIST[ANY]
			seq: SEQUENCE[ANY]
			val_type, fld_type: INTEGER
		do
			val_type := dynamic_type(value)
			fld_type := field_static_type_of_type(i, dynamic_type(object))
			if val_type = fld_type then
				set_reference_field (i, object, value)
			else
				debug ("DT")
					io.put_string("DT_OBJECT_CONVERTER.set_primitive_sequence_field: about to call new_instance_of(" +
						type_name_of_type(fld_type) + ")%N")
				end
				set_reference_field (i, object, new_instance_of(fld_type))
				debug ("DT")
					io.put_string("%T(return)%N")
				end
				al_field ?= field(i, object)
				if al_field /= Void then
					al_field.make(0)
				end
				seq ?= field(i, object)
				al_val ?= value
				if al_val /= Void then
					from
						al_val.start
					until
						al_val.off
					loop
						seq.extend(al_val.item)
						al_val.forth
					end
				else
					-- this means we have an object whose field type is a container, but
					-- where the dADL scanned as a single object - this happens with
					-- any list of one item. The dADL syntax is to use "<xx, ...>" to
					-- show it is a list, but this is often forgotten
					-- So...we do a conversion
					seq.extend(value)
				end
			end
		end

	set_interval_integer_field (i: INTEGER; object: ANY; value: INTERVAL[INTEGER_REF]) is
			-- set INTERVAL[INTEGER] field in an object from a value of type INTERVAL[INTEGER_REF]
			-- FIXME: This routine only exists because of the difference between expanded and reference
		local
			fld_type: INTEGER
		do
			fld_type := field_static_type_of_type(i, dynamic_type(object))
			if dynamic_type(value) = fld_type then
				set_reference_field (i, object, value)
			else
				set_reference_field (i, object, interval_integer_ref_to_interval_integer(value))
			end
		end

	set_interval_real_field (i: INTEGER; object: ANY; value: INTERVAL[REAL_REF]) is
			-- set INTERVAL[REAL] field in an object from a value of type INTERVAL[REAL_REF]
			-- FIXME: This routine only exists because of the difference between expanded and reference
		local
			fld_type: INTEGER
		do
			fld_type := field_static_type_of_type(i, dynamic_type(object))
			if dynamic_type(value) = fld_type then
				set_reference_field (i, object, value)
			else
				set_reference_field (i, object, interval_real_ref_to_interval_real(value))
			end
		end

	set_interval_double_field (i: INTEGER; object: ANY; value: INTERVAL[DOUBLE_REF]) is
			-- set INTERVAL[DOUBLE] field in an object from a value of type INTERVAL[DOUBLE_REF]
			-- FIXME: This routine only exists because of the difference between expanded and reference
		local
			fld_type: INTEGER
		do
			fld_type := field_static_type_of_type(i, dynamic_type(object))
			if dynamic_type(value) = fld_type then
				set_reference_field (i, object, value)
			else
				set_reference_field (i, object, interval_double_ref_to_interval_double(value))
			end
		end

feature -- Conversion from object

	from_obj_primitive_type(a_parent: DT_ATTRIBUTE_NODE; an_obj: ANY; a_node_id: STRING) is
		local
			a_dt_obj: DT_PRIMITIVE_OBJECT
		do
			debug("DT")
				io.put_string("--->ENTER from_obj_primitive_type(DT_ATTIBUTE_NODE, " +
							an_obj.generating_type + ", [a_node_id])%N")
			end
			a_dt_obj := create_primitive_object(a_parent, an_obj, a_node_id)
			debug("DT")
				io.put_string("<---EXIT from_obj_primitive_type%N")
			end
		end

	from_obj_sequence_primitive_type(a_parent: DT_ATTRIBUTE_NODE; an_obj: SEQUENCE[ANY]; a_node_id: STRING) is
		local
			a_dt_obj: DT_PRIMITIVE_OBJECT_LIST
		do
			debug("DT")
				io.put_string("--->ENTER from_obj_sequence_primitive_type(DT_ATTIBUTE_NODE, " +
							an_obj.generating_type + ", [node_id])%N")
			end
			if a_node_id /= Void then
				create a_dt_obj.make_identified(an_obj, a_node_id)
			else
				create a_dt_obj.make_anonymous(an_obj)
			end
			a_parent.put_child(a_dt_obj)
			debug("DT")
				io.put_string("<---EXIT from_obj_sequence_primitive_type%N")
			end
		end

	from_obj_interval_primitive_type(a_parent: DT_ATTRIBUTE_NODE; an_obj: INTERVAL[PART_COMPARABLE]; a_node_id: STRING) is
		local
			a_dt_obj: DT_PRIMITIVE_OBJECT_INTERVAL
		do
			debug("DT")
				io.put_string("--->ENTER from_obj_interval_primitive_type(DT_ATTIBUTE_NODE, " +
							an_obj.generating_type + ", [a_node_id])%N")
			end
			if a_node_id /= Void then
				create a_dt_obj.make_identified(an_obj, a_node_id)
			else
				create a_dt_obj.make_anonymous(an_obj)
			end
			a_parent.put_child(a_dt_obj)
			debug("DT")
				io.put_string("<---EXIT from_obj_interval_primitive_type%N")
			end
		end

feature {NONE} -- Implementation

	set_generic_object_data_from_dt (a_gen_obj:ANY; a_dt_attr: DT_ATTRIBUTE_NODE) is
			-- set generic values in a generic object, from a_dt_attr
			-- only deals with first generic parameter; generally safe for HASH_TABLE and LIST types
		require
			Obj_exists: a_gen_obj /= Void
			Dt_attr_node_valid: a_dt_attr /= Void and then a_dt_attr.is_multiple
		local
			a_sequence: SEQUENCE[ANY]
			an_arrayed_list: ARRAYED_LIST[ANY]
			a_hash_table: HASH_TABLE [ANY, HASHABLE]
			gen_param_1_type_id: INTEGER
		do
			gen_param_1_type_id := generic_dynamic_type(a_gen_obj, 1)

			-- determine dynamic type of generic type
			a_hash_table ?= a_gen_obj
			if a_hash_table /= Void then
				a_hash_table.make(0)
				from
					a_dt_attr.start
				until
					a_dt_attr.off
				loop
					-- FIXME: should check to see whether node_id should be converted to another type
					a_hash_table.extend(a_dt_attr.item.as_object(gen_param_1_type_id), a_dt_attr.item.node_id)
					a_dt_attr.forth
				end
			else
				a_sequence ?= a_gen_obj
				if a_sequence /= Void then
					an_arrayed_list ?= a_sequence
					if an_arrayed_list /= Void then
						an_arrayed_list.make(0)
					end
					from
						a_dt_attr.start
					until
						a_dt_attr.off
					loop
						a_sequence.extend(a_dt_attr.item.as_object(gen_param_1_type_id))
						a_dt_attr.forth
					end
				end
			end
		end

	create_dt_from_generic_obj(a_dt_attr: DT_ATTRIBUTE_NODE; an_obj: ANY) is
			--
		local
			generic_param_type: INTEGER
			a_sequence: SEQUENCE[ANY]
			a_hash_table: HASH_TABLE [ANY, HASHABLE]
		do
			a_hash_table ?= an_obj
			a_sequence ?= an_obj

			generic_param_type := generic_dynamic_type(an_obj, 1)
			-- FIXME: only deal with the 1st generic param at the moment
			if a_hash_table /= Void then
				from
					a_hash_table.start
				until
					a_hash_table.off
				loop
					if is_any_primitive_conforming_type(generic_param_type) then
						debug ("DT")
							io.put_string("DT_OBJECT_CONVERTER.create_dt_from_generic_obj: from_obj_proc.call([DT_ATTRIBUTE_NODE(" +
								a_dt_attr.rm_attr_name + "), " + a_hash_table.item_for_iteration.generating_type +
								", " + a_hash_table.key_for_iteration.out + ")%N")
						end
						cvt_tbl.item(any_primitive_conforming_type(generic_param_type)).from_obj_proc.call([a_dt_attr,
								a_hash_table.item_for_iteration, a_hash_table.key_for_iteration.out])
						debug ("DT")
							io.put_string("%T(return)%N")
						end
					else
						populate_dt_from_object(a_hash_table.item_for_iteration,
							create_complex_object_node(a_dt_attr, a_hash_table.key_for_iteration.out))
					end
					a_hash_table.forth
				end
			elseif a_sequence /= Void then
				from
					a_sequence.start
				until
					a_sequence.off
				loop
					if is_any_primitive_conforming_type(generic_param_type) then
						debug ("DT")
							io.put_string("DT_OBJECT_CONVERTER.create_dt_from_generic_obj(2): from_obj_proc.call([DT_ATTRIBUTE_NODE(" +
								a_dt_attr.rm_attr_name + "), " + a_sequence.item.generating_type +
								", " + a_sequence.index.out + ")%N")
						end
						cvt_tbl.item(any_primitive_conforming_type(generic_param_type)).from_obj_proc.call([a_dt_attr,
								a_sequence.item, a_sequence.index.out])
						debug ("DT")
							io.put_string("%T(return)%N")
						end
					else
						populate_dt_from_object(a_sequence.item,
							create_complex_object_node(a_dt_attr, a_sequence.index.out))
					end
					a_sequence.forth
				end
			end
		end

	cvt_tbl: HASH_TABLE [DT_CONV_DESC, INTEGER] is
		local
			a_dt_conv: DT_CONV_DESC
		once
			create Result.make (0)

			-- primitive types
			create a_dt_conv.make (agent from_obj_primitive_type (?, ?, ?), agent set_primitive_integer_field (?, ?, ?))
			Result.put (a_dt_conv, dynamic_type (create {INTEGER}))
			Result.put (a_dt_conv, dynamic_type (create {INTEGER_REF}))
			Result.put (a_dt_conv, dynamic_type_from_string ("INTEGER_32"))

			create a_dt_conv.make (agent from_obj_primitive_type (?, ?, ?), agent set_primitive_boolean_field (?, ?, ?))
			Result.put (a_dt_conv, dynamic_type (create {BOOLEAN}))
			Result.put (a_dt_conv, dynamic_type (create {BOOLEAN_REF}))
			Result.put (a_dt_conv, dynamic_type_from_string ("BOOLEAN"))

			create a_dt_conv.make (agent from_obj_primitive_type (?, ?, ?), agent set_primitive_real_field (?, ?, ?))
			Result.put (a_dt_conv, dynamic_type (create {REAL}))
			Result.put (a_dt_conv, dynamic_type (create {REAL_REF}))
			Result.put (a_dt_conv, dynamic_type_from_string ("REAL_32"))

			create a_dt_conv.make (agent from_obj_primitive_type (?, ?, ?), agent set_primitive_double_field (?, ?, ?))
			Result.put (a_dt_conv, dynamic_type (create {DOUBLE}))
			Result.put (a_dt_conv, dynamic_type (create {DOUBLE_REF}))
			Result.put (a_dt_conv, dynamic_type_from_string ("REAL_64"))

			create a_dt_conv.make (agent from_obj_primitive_type (?, ?, ?), agent set_primitive_character_field (?, ?, ?))
			Result.put (a_dt_conv, dynamic_type (create {CHARACTER}))
			Result.put (a_dt_conv, dynamic_type (create {CHARACTER_REF}))
			Result.put (a_dt_conv, dynamic_type_from_string ("CHARACTER_8"))

			create a_dt_conv.make (agent from_obj_primitive_type (?, ?, ?), agent set_reference_field (?, ?, ?))
			Result.put (a_dt_conv, dynamic_type (create {STRING}.make_empty))
			Result.put (a_dt_conv, dynamic_type (create {DATE}.make_now))
			Result.put (a_dt_conv, dynamic_type (create {DATE_TIME}.make_now))
			Result.put (a_dt_conv, dynamic_type (create {TIME}.make_now))
			Result.put (a_dt_conv, dynamic_type (create {DATE_TIME_DURATION}.make_definite (1, 0, 0, 0)))
			Result.put (a_dt_conv, dynamic_type (create {URI}.make_from_string ("http://no.way.home")))
			Result.put (a_dt_conv, dynamic_type (create {CODE_PHRASE}))

			-- primitive sequence types
			from
				primitive_sequence_types.start
			until
				primitive_sequence_types.off
			loop
				create a_dt_conv.make (agent from_obj_sequence_primitive_type (?, ?, ?), agent set_primitive_sequence_field (?, ?, ?))
				Result.put (a_dt_conv, primitive_sequence_types.item)
				primitive_sequence_types.forth
			end

			-- primitive interval types
			create a_dt_conv.make (agent from_obj_interval_primitive_type (?, ?, ?), agent set_interval_integer_field (?, ?, ?))
			Result.put (a_dt_conv, dynamic_type (create {INTERVAL [INTEGER]}))

			create a_dt_conv.make (agent from_obj_interval_primitive_type (?, ?, ?), agent set_interval_real_field (?, ?, ?))
			Result.put (a_dt_conv, dynamic_type (create {INTERVAL [REAL]}))

			create a_dt_conv.make (agent from_obj_interval_primitive_type (?, ?, ?), agent set_interval_double_field (?, ?, ?))
			Result.put (a_dt_conv, dynamic_type (create {INTERVAL [DOUBLE]}))

			create a_dt_conv.make (agent from_obj_interval_primitive_type (?, ?, ?), agent set_reference_field (?, ?, ?))
			Result.put (a_dt_conv, dynamic_type (create {INTERVAL [DOUBLE_REF]}))
			Result.put (a_dt_conv, dynamic_type (create {INTERVAL [REAL_REF]}))
			Result.put (a_dt_conv, dynamic_type (create {INTERVAL [INTEGER_REF]}))
			Result.put (a_dt_conv, dynamic_type (create {INTERVAL [DATE]}))
			Result.put (a_dt_conv, dynamic_type (create {INTERVAL [DATE_TIME]}))
			Result.put (a_dt_conv, dynamic_type (create {INTERVAL [TIME]}))
			Result.put (a_dt_conv, dynamic_type (create {INTERVAL [DATE_TIME_DURATION]}))

--			from
--				primitive_interval_types.start
--			until
--				primitive_interval_types.off
--			loop
--				create a_dt_conv.make (agent from_obj_interval_primitive_type (?, ?, ?), agent set_primitive_interval_field (?, ?, ?))
--				Result.put (a_dt_conv, primitive_interval_types.item)
--				primitive_interval_types.forth
--			end
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
--| The Original Code is dt_object_converter.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2005
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
