indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_CASE_PRINTER

feature -- Access

	print_test_case (reflection: CDD_REFLECTED_OBJECT; test_class_name: STRING; feature_name: STRING; a_file: FILE) is
		require
			a_file_writeable: a_file /= Void and then a_file.is_writable
		local
			rlist: DS_LIST [CDD_COMPOSITE_OBJECT]
			root_object: CDD_COMPOSITE_OBJECT
		do
			output_file := a_file
			root_object := reflection.root_object
			append_text (class_header (test_class_name, feature_name))
			rlist := reflection.composite_objects
			from
				rlist.start
			until
				rlist.after
			loop
				append_object_declaration (rlist.item_for_iteration)
				rlist.forth
			end
			append_text ("		do%N")
			append_text ("			-- Create objects%N")
			from
				rlist.start
			until
				rlist.after
			loop
				rlist.item_for_iteration.append_creation (Current)
				rlist.forth
			end
			append_text ("			-- Assign attributes%N")
			from
				rlist.start
			until
				rlist.after
			loop
				rlist.item_for_iteration.append_assignment (Current)
				rlist.forth
			end
			append_text ("%N%N" + indent)
			append_text (root_object.identifier + "." + feature_name)
			if reflection.arguments.count > 0 then
				append_text (" (")
				from
					reflection.arguments.start
				until
					reflection.arguments.after
				loop
					append_text (reflection.arguments.item_for_iteration.identifier)
					reflection.arguments.forth
					if not reflection.arguments.after then
						append_text (", ")
					end
				end
				append_text (")")
			end
			append_text ("%N%N		end%N%N%N")
			append_text (implementation_features)
			output_file.flush
			output_file.close
		end


feature {CDD_OBJECT} -- Testcase generation

	append_object_declaration (an_object:CDD_COMPOSITE_OBJECT) is
			--
		do
			append_instruction (an_object.identifier + ": " + an_object.full_type)
		end

	append_regular_creation (an_object: CDD_REGULAR_OBJECT) is
			--
		do
			append_instruction (an_object.identifier + " ?= build (%"" +an_object.type + "%")")
		end


	append_regular_assignment (an_object: CDD_REGULAR_OBJECT) is
			--
		local
			instr: STRING
			a_key: STRING
			a_value: CDD_OBJECT
		do
			from
				an_object.attributes.start
			until
				an_object.attributes.after
			loop
				a_key := an_object.attributes.key_for_iteration
				a_value := an_object.attributes.item_for_iteration
				instr := "set_attr (" + an_object.identifier + ", %""
				instr.append (a_key + "%", " + a_value.identifier + ")")
				append_instruction (instr)
				an_object.attributes.forth
			end
		end

	append_string_creation (a_string: CDD_STRING_OBJECT) is
			--
		do
			append_instruction (a_string.identifier + " := " + a_string.representation)
		end

	append_string_assignment (a_string: CDD_STRING_OBJECT) is
			--
		do
			-- do nothing since strings get fully assigned at creation
		end


	append_special_creation (a_special: CDD_SPECIAL_OBJECT) is
			--
		do
			append_instruction ("create " + a_special.identifier + ".make(" + a_special.attributes.count.out + ")")
		end


	append_special_assignment (a_special: CDD_SPECIAL_OBJECT) is
			--
		local
			i: INTEGER
			instr: STRING
		do
			from
				i := 0
			until
				i = a_special.attributes.count
			loop
				instr := a_special.identifier + ".put ("
				instr.append (i.out + ", " + a_special.attributes.item (i.out).identifier)
				instr.append (")")
				append_instruction (instr)
				i := i + 1
			end
		end

	append_tuple_creation (a_tuple: CDD_TUPLE_OBJECT) is
			--
		local
			i: INTEGER
			instr: STRING
		do
			from
				i := 1
				instr := a_tuple.identifier + " := ["
			until
				i > a_tuple.attributes.count
			loop
				instr.append (a_tuple.attributes.item (i.out).identifier)
				if i < a_tuple.attributes.count then
					instr.append (", ")
				end
				i := i + 1
			end
			instr.append ("]")
			append_instruction (instr)
		end

	append_tuple_assignment (a_tuple: CDD_TUPLE_OBJECT) is
			--
		do
			-- nothing to do since tuple gets fully assigned at creation
		end



feature {NONE} -- Implementation

	append_text (s: STRING) is
		require
			file_writable: output_file /= Void and then output_file.is_writable
		do
			output_file.put_string (s)
		end

	append_instruction (l: STRING) is
		require
			file_writable: output_file /= Void and then output_file.is_writable
		do
			append_text (indent + l + "%N")
		end

	append_comment (c: STRING) is
		require
			file_writable: output_file /= Void and then output_file.is_writable
		do
			append_text (indent + "%T" + c + "%N")
		end

	output_file: FILE

	indent: STRING is "%T%T%T"

	class_header (class_name: STRING; feature_name: STRING): STRING is
		do
			Result :=
			"indexing%N%N%
			%class%N%
			%	" + class_name + "%N%N%
			%feature -- Testing%N%N%
			%	test_" + feature_name + " is%N%
			%		local%N"
		end


	implementation_features: STRING is
		once
			Result :=
				"feature {NONE} -- Implementation%N%N" +
				internal_attributes +
				build_object_feature +
				assign_values_feature
		end

	internal_attributes: STRING is
		"	internal: INTERNAL is%N%
		%		once%N%
		%			create Result%N%
		%		end%N%N%
		%	attributes: HASH_TABLE [ANY, STRING]%N%N"

	build_object_feature: STRING is
		"	build_object (class_name: STRING): ANY is%N%
		%		require%N%
		%			valid_class: class_exists_in_system (class_name)%N%
		%		local%N%
		%			type: INTEGER%N%
		%		do%N%
		%			type := internal.dynamic_type_from_string (class_name)%N%
		%			Result := internal.new_instance_of (type)%N%
		%		end%N%N"


	assign_values_feature: STRING is
		"	assign_values (obj: ANY) is%N%
		%			-- Give object a state%N%
		%		local%N%
		%			i: INTEGER%N%
		%			name: STRING%N%N%
		%			b: BOOLEAN%N%
		%			c: CHARACTER%N%
		%			i8: INTEGER_8%N%
		%			i16: INTEGER_16%N%
		%			i32: INTEGER_32%N%
		%			i64: INTEGER_64%N%
		%			n8: NATURAL_8%N%
		%			n16: NATURAL_16%N%
		%			n32: NATURAL_32%N%
		%			n64: NATURAL_64%N%
		%			r32: REAL_32%N%
		%			r64: REAL_64%N%
		%		do%N%
		%			from%N%
		%				i := 1%N%
		%			until%N%
		%				i > internal.field_count (obj)%N%
		%			loop%N%
		%				name := internal.field_name (i, obj)%N%
		%				if values.has (name) then%N%
		%					inspect internal.field_type (i, obj)%N%
		%					when {INTERNAL}.reference_type then%N%
		%						internal.set_reference_field (i, obj, attributes.item (name))%N%
		%					when {INTERNAL}.boolean_type then%N%
		%						b ?= attributes.item (name)%N%
		%						internal.set_boolean_field (i, obj, b)%N%
		%					when {INTERNAL}.character_type then%N%
		%						c ?= attributes.item (name)%N%
		%						internal.set_character_field (i, obj, c)%N%
		%					when {INTERNAL}.integer_8_type then%N%
		%						i8 ?= attributes.item (name)%N%
		%						internal.set_integer_8_field (i, obj, i8)%N%
		%					when {INTERNAL}.integer_16_type then%N%
		%						i16 ?= attributes.item (name)%N%
		%						internal.set_integer_16_field (i, obj, i16)%N%
		%					when {INTERNAL}.integer_32_type then%N%
		%						i32 ?= attributes.item (name)%N%
		%						internal.set_integer_32_field (i, obj, i32)%N%
		%					when {INTERNAL}.integer_64_type then%N%
		%						i64 ?= attributes.item (name)%N%
		%						internal.set_integer_64_field (i, obj, i64)%N%
		%					when {INTERNAL}.natural_8_type then%N%
		%						n8 ?= attributes.item (name)%N%
		%						internal.set_natural_8_field (i, obj, n8)%N%
		%					when {INTERNAL}.natural_16_type then%N%
		%						n16 ?= attributes.item (name)%N%
		%						internal.set_natural_16_field (i, obj, n16)%N%
		%					when {INTERNAL}.natural_32_type then%N%
		%						n32 ?= attributes.item (name)%N%
		%						internal.set_natural_32_field (i, obj, n32)%N%
		%					when {INTERNAL}.natural_64_type then%N%
		%						n64 ?= attributes.item (name)%N%
		%						internal.set_natural_64_field (i, obj, n64)%N%
		%					when {INTERNAL}.real_32_type then%N%
		%						r32 ?= attributes.item (name)%N%
		%						internal.set_real_32_field (i, obj, r32)%N%
		%					when {INTERNAL}.real_64_type then%N%
		%						r64 ?= attributes.item (name)%N%
		%						internal.set_real_64_field (i, obj, r64)%N%
		%					else%N%
		%						debug (%"wrong type%") end%N%
		%						check false end%N%
		%					end%N%
		%				else%N%
		%					debug (%"attribute not defined%") end%N%
		%					check false end%N%
		%				end%N%
		%				i := i + 1%N%
		%			end%N%
		%		end"

invariant
	invariant_clause: True -- Your invariant here

end
