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
			a_target_class_type: STRING;
			a_context: DS_LIST [TUPLE [id: STRING; type: STRING; inv: BOOLEAN; attributes: DS_LIST [STRING]]];
			a_call_stack_id: INTEGER_32;
			a_call_stack_index: INTEGER_32
			) is
			-- Initialize `Current'.
		require
			a_feature_not_void: a_feature /= Void
			a_target_class_type_valid: a_target_class_type /= Void and then not a_target_class_type.is_empty
			a_context_valid: a_context /= Void and then not a_context.is_empty
			a_call_stack_id_valid: a_call_stack_id > 0
			a_call_stack_index_valid: a_call_stack_index > 0
		do
			represented_feature := a_feature
			target_class_type := a_target_class_type
			context := a_context
			call_stack_id := a_call_stack_id
			call_stack_index := a_call_stack_index
		end


feature {ANY} -- Access

	represented_feature: E_FEATURE
			-- The feature whose invocation is represented by `Current'

	target_class_type: STRING
			-- The dynamic type of the target object for the feature call represented by `Current'

	context: DS_LIST [TUPLE [id: STRING; type: STRING; inv: BOOLEAN; attributes: DS_LIST [STRING]]]
			-- The context for the invocation of `represented_feature'

	call_stack_id: INTEGER_32
			-- ID of the call stack originally containing `Current'

	call_stack_index: INTEGER_32
			-- Index denoting the postition of `Current' in the original call stack denoted by `call_stack_id'


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
	target_class_type_valid: target_class_type /= Void and then not target_class_type.is_empty
	context_valid: context /= Void and then not context.is_empty
	call_stack_id_valid: call_stack_id > 0
	call_stack_index_valid: call_stack_index > 0

end
