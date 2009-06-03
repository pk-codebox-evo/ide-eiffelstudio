-- This file has been generated by EWG. Do not edit. Changes will be lost!

class CONTROL_CLICK_ACTIVATION_REC_STRUCT

inherit

	EWG_STRUCT

	CONTROL_CLICK_ACTIVATION_REC_STRUCT_EXTERNAL
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

	localpoint: POINTER is
			-- Access member `localPoint'
		require
			exists: exists
		do
			Result := get_localpoint_external (item)
		ensure
			result_correct: Result = get_localpoint_external (item)
		end

	set_localpoint (a_value: POINTER) is
			-- Set member `localPoint'
		require
			exists: exists
		do
			set_localpoint_external (item, a_value)
		end

	modifiers: INTEGER is
			-- Access member `modifiers'
		require
			exists: exists
		do
			Result := get_modifiers_external (item)
		ensure
			result_correct: Result = get_modifiers_external (item)
		end

	set_modifiers (a_value: INTEGER) is
			-- Set member `modifiers'
		require
			exists: exists
		do
			set_modifiers_external (item, a_value)
		ensure
			a_value_set: a_value = modifiers
		end

	a_result: INTEGER is
			-- Access member `result'
		require
			exists: exists
		do
			Result := get_a_result_external (item)
		ensure
			result_correct: Result = get_a_result_external (item)
		end

	set_a_result (a_value: INTEGER) is
			-- Set member `result'
		require
			exists: exists
		do
			set_a_result_external (item, a_value)
		ensure
			a_value_set: a_value = a_result
		end

end
