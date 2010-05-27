-- This file has been generated by EWG. Do not edit. Changes will be lost!

class HIVIEW_KIND_STRUCT

inherit

	EWG_STRUCT

	HIVIEW_KIND_STRUCT_EXTERNAL
		export
			{NONE} all
		end

create

	make_new_unshared,
	make_new_shared,
	make_unshared,
	make_shared

feature {ANY} -- Access

	sizeof: INTEGER is
		do
			Result := sizeof_external
		end

feature {ANY} -- Member Access

	signature: INTEGER is
			-- Access member `signature'
		require
			exists: exists
		do
			Result := get_signature_external (item)
		ensure
			result_correct: Result = get_signature_external (item)
		end

	set_signature (a_value: INTEGER) is
			-- Set member `signature'
		require
			exists: exists
		do
			set_signature_external (item, a_value)
		ensure
			a_value_set: a_value = signature
		end

	kind: INTEGER is
			-- Access member `kind'
		require
			exists: exists
		do
			Result := get_kind_external (item)
		ensure
			result_correct: Result = get_kind_external (item)
		end

	set_kind (a_value: INTEGER) is
			-- Set member `kind'
		require
			exists: exists
		do
			set_kind_external (item, a_value)
		ensure
			a_value_set: a_value = kind
		end

end
