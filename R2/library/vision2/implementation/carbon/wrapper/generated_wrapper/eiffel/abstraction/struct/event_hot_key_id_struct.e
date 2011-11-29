-- This file has been generated by EWG. Do not edit. Changes will be lost!

class EVENT_HOT_KEY_ID_STRUCT

inherit

	EWG_STRUCT

	EVENT_HOT_KEY_ID_STRUCT_EXTERNAL
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

	id: INTEGER is
			-- Access member `id'
		require
			exists: exists
		do
			Result := get_id_external (item)
		ensure
			result_correct: Result = get_id_external (item)
		end

	set_id (a_value: INTEGER) is
			-- Set member `id'
		require
			exists: exists
		do
			set_id_external (item, a_value)
		ensure
			a_value_set: a_value = id
		end

end
