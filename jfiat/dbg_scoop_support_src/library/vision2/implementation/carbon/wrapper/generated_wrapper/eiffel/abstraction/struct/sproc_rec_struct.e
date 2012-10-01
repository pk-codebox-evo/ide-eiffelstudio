-- This file has been generated by EWG. Do not edit. Changes will be lost!

class SPROC_REC_STRUCT

inherit

	EWG_STRUCT

	SPROC_REC_STRUCT_EXTERNAL
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

	nxtsrch: POINTER is
			-- Access member `nxtSrch'
		require
			exists: exists
		do
			Result := get_nxtsrch_external (item)
		ensure
			result_correct: Result = get_nxtsrch_external (item)
		end

	set_nxtsrch (a_value: POINTER) is
			-- Set member `nxtSrch'
		require
			exists: exists
		do
			set_nxtsrch_external (item, a_value)
		ensure
			a_value_set: a_value = nxtsrch
		end

	srchproc: POINTER is
			-- Access member `srchProc'
		require
			exists: exists
		do
			Result := get_srchproc_external (item)
		ensure
			result_correct: Result = get_srchproc_external (item)
		end

	set_srchproc (a_value: POINTER) is
			-- Set member `srchProc'
		require
			exists: exists
		do
			set_srchproc_external (item, a_value)
		ensure
			a_value_set: a_value = srchproc
		end

-- TODO: function pointers not yet callable from
--		struct, use corresponding callback class instead
end
