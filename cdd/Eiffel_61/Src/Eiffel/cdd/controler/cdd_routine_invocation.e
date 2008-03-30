indexing
	description: "Objects representing extracted and reproduceable routine invocations"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_ROUTINE_INVOCATION

inherit
	CDD_ROUTINES
		rename
			is_creation_feature as internal_is_creation_feature
		export
			{NONE} all
		end

create
	make

feature {ANY} -- Initialisation

	make (	a_feature: E_FEATURE;
			an_operand_type_list: DS_LIST [STRING_8];
			a_context: DS_LIST [TUPLE [id: STRING; type: STRING; inv: BOOLEAN; attributes: DS_LIST [STRING]]];
			a_call_stack_id: INTEGER_32;
			a_call_stack_index: INTEGER_32
			) is
			-- Initialize `Current'.
		require
			a_feature_not_void: a_feature /= Void
			an_operand_type_list: an_operand_type_list /= Void and (an_operand_type_list.count = (a_feature.argument_count + 1))
			a_context_valid: a_context /= Void and then not a_context.is_empty
			a_call_stack_id_valid: a_call_stack_id > 0
			a_call_stack_index_valid: a_call_stack_index > 0
		do
			represented_feature := a_feature
			operand_type_list := an_operand_type_list
			context := a_context
			call_stack_id := a_call_stack_id
			call_stack_index := a_call_stack_index
		end


feature {ANY} -- Access

	represented_feature: E_FEATURE
			-- The feature whose invocation is represented by `Current'

	operand_type_list: DS_LIST [STRING_8]
			-- List of generating types of arguments for feature call represented by `Current'

	context: DS_LIST [TUPLE [id: STRING; type: STRING; inv: BOOLEAN; attributes: DS_LIST [STRING]]]
			-- The context for the invocation of `represented_feature'

	call_stack_id: INTEGER_32
			-- ID of the call stack originally containing `Current'

	call_stack_index: INTEGER_32
			-- Index denoting the postition of `Current' in the original call stack denoted by `call_stack_id'

feature -- Basic Operations

	set_call_stack_id (an_id: INTEGER_32) is
			-- Set `call_stack_id' to `an_id'.
		require
			an_id_is_valid: an_id > 0
		do
			call_stack_id := an_id
		ensure
			call_stack_id_set: call_stack_id = an_id
		end

	set_call_stack_index (an_index: INTEGER_32) is
			-- Set `call_stack_index' to `an_index'.
		require
			an_index_is_valid: an_index > 0
		do
			call_stack_index := an_index
		ensure
			call_stack_index_set: call_stack_index = an_index
		end

feature -- Measurement

feature {ANY} -- Status report

	is_creation_feature: BOOLEAN is
			-- Does `Current' represent the invocation of a creation feature?
		do
			Result := internal_is_creation_feature (represented_feature)
		end

feature -- Status setting

feature {NONE} -- Implementation

invariant
	feature_not_void: represented_feature /= Void
	operand_type_list_valid: operand_type_list /= Void and (operand_type_list.count = (represented_feature.argument_count + 1))
	context_valid: context /= Void and then not context.is_empty
	call_stack_id_valid: call_stack_id > 0
	call_stack_index_valid: call_stack_index > 0

end
