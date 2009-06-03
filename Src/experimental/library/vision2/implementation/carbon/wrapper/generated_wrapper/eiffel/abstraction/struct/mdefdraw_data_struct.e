-- This file has been generated by EWG. Do not edit. Changes will be lost!

class MDEFDRAW_DATA_STRUCT

inherit

	EWG_STRUCT

	MDEFDRAW_DATA_STRUCT_EXTERNAL
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

	trackingdata: POINTER is
			-- Access member `trackingData'
		require
			exists: exists
		do
			Result := get_trackingdata_external (item)
		ensure
			result_correct: Result = get_trackingdata_external (item)
		end

	set_trackingdata (a_value: POINTER) is
			-- Set member `trackingData'
		require
			exists: exists
		do
			set_trackingdata_external (item, a_value)
		end

	context: POINTER is
			-- Access member `context'
		require
			exists: exists
		do
			Result := get_context_external (item)
		ensure
			result_correct: Result = get_context_external (item)
		end

	set_context (a_value: POINTER) is
			-- Set member `context'
		require
			exists: exists
		do
			set_context_external (item, a_value)
		ensure
			a_value_set: a_value = context
		end

end
