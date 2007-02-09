indexing
	description: "Ballet environment and helpful routines"
	author: "Bernd Schoeller and others"
	date: "$Date$"
	revision: "$Revision$"

class

	SHARED_BPL_ENVIRONMENT

feature -- Access

	environment: BPL_ENVIRONMENT is
			-- Ballet environement to store global variables
		once
			create Result.make
		end

feature -- Output

	bpl_out (a_string: STRING) is
			-- Adding buffering support for easy output.
		do
			environment.out_stream.put_string (a_string)
		end

	add_error (an_error: BPL_ERROR) is
			-- Record error `an_error'.
		require
			not_void: an_error /= Void
		do
			environment.error_log.extend (an_error)
		ensure
			error_recorded: environment.error_log.has_error
		end

	bpl_type_for (type: TYPE_AS): STRING is
			-- Compute the suitable type in BPL for `type'.
		require
			type_not_void: type /= Void
		local
			cls_t: CLASS_TYPE_AS
		do
			cls_t ?= type
			if cls_t /= Void then
				-- mapping_table.has does not work here, because has
				-- seems to compare references even when compare_objects
				-- was called
				if mapping_table.item(cls_t.class_name) /= Void then
					Result := mapping_table.item (cls_t.class_name)
				elseif cls_t.is_expanded then
					add_error(create {BPL_AST_ERROR}.make_ast("Cannot handle type '" + type.dump
												  + "' since it's expanded.", type))
					Result := ""
				elseif cls_t.class_name.substring_index("MML_", 1) = 1 then
					add_error(create {BPL_AST_ERROR}.make_ast("Cannot handle type '" + type.dump
												  + "' since it's an mml type.", type))
					Result := "mmltype"
				else
					Result := once "ref"
				end

			else
				-- we cannot handle all these at the moment
				-- TODO: handle anchored types and friends
				Result := "wrong_type"
				add_error(create {BPL_AST_ERROR}.make_ast("Cannot handle type '" + type.dump
											+ "' so far because it is a " + type.generating_type + ".", type))
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	Mapping_table: TABLE[STRING, STRING] is
			-- Table of mappings between Eiffel and BPL types
		once
			create {HASH_TABLE[STRING, STRING]}Result.make(9)
			Result.compare_objects
			Result.put("int", "INTEGER")
			Result.put("int", "INTEGER_8")
			Result.put("int", "INTEGER_16")
			Result.put("int", "INTEGER_32")
			Result.put("bool", "BOOLEAN")
		end

end
