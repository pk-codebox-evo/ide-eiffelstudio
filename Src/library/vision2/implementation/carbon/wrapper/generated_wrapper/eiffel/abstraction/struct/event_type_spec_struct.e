-- This file has been generated by EWG. Do not edit. Changes will be lost!

class EVENT_TYPE_SPEC_STRUCT

inherit

	EWG_STRUCT

	EVENT_TYPE_SPEC_STRUCT_EXTERNAL
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

	eventclass: INTEGER is
			-- Access member `eventClass'
		require
			exists: exists
		do
			Result := get_eventclass_external (item)
		ensure
			result_correct: Result = get_eventclass_external (item)
		end

	set_eventclass (a_value: INTEGER) is
			-- Set member `eventClass'
		require
			exists: exists
		do
			set_eventclass_external (item, a_value)
		ensure
			a_value_set: a_value = eventclass
		end

	eventkind: INTEGER is
			-- Access member `eventKind'
		require
			exists: exists
		do
			Result := get_eventkind_external (item)
		ensure
			result_correct: Result = get_eventkind_external (item)
		end

	set_eventkind (a_value: INTEGER) is
			-- Set member `eventKind'
		require
			exists: exists
		do
			set_eventkind_external (item, a_value)
		ensure
			a_value_set: a_value = eventkind
		end

end
