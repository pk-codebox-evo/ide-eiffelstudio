indexing
 
	description:
		"Class identifiers.";
	date: "$Date$";
	revision: "$Revision $"

class CLASS_ID

inherit

	COMPILER_ID
		export
			{COMPILER_EXPORTER} all;
			{ANY} is_equal;
			{CLASS_C_SERVER} internal_id, compilation_id
		end

creation

	make

feature {COMPILER_EXPORTER} -- Access

	packet_number: INTEGER is
			-- Packet in which the file for the corresponding 
			-- class will be generated
		do
			if System.in_final_mode then
				Result := id // System.makefile_generator.Packet_number + 1
			else
				Result :=
					internal_id // System.makefile_generator.Packet_number + 1
			end
		end

	generated_id: STRING is
			-- Textual representation of class id
			-- used in generated C code
		do
			!! Result.make (5);
			Result.append_integer (id);
		ensure
			generated_id_not_void: Result /= Void
		end

	associated_class: CLASS_C is
			-- Class associated with current id
		do
			Result := class_array.item (internal_id)
		end

feature {COMPILER_EXPORTER} -- Status report

	protected: BOOLEAN is
			-- Is the class associated with id protected?
			-- Protected classes are GENERAL, ANY, DOUBLE, REAL,
			-- INTEGER, BOOLEAN, CHARACTER, ARRAY, BIT, POINTER, STRING
		do
		end

feature {NONE} -- Implementation

	counter: CLASS_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Class_counter.item (Normal_compilation)
		end

	class_array: ARRAY [CLASS_C] is
			-- Classes compiled during compilation `compilation_id'
		once
			Result := System.project_classes
		end

end -- class CLASS_ID
