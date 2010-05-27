-- This file has been generated by EWG. Do not edit. Changes will be lost!

class CONTROL_TEMPLATE_STRUCT

inherit

	EWG_STRUCT

	CONTROL_TEMPLATE_STRUCT_EXTERNAL
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

	controlrect: POINTER is
			-- Access member `controlRect'
		require
			exists: exists
		do
			Result := get_controlrect_external (item)
		ensure
			result_correct: Result = get_controlrect_external (item)
		end

	set_controlrect (a_value: POINTER) is
			-- Set member `controlRect'
		require
			exists: exists
		do
			set_controlrect_external (item, a_value)
		end

	controlvalue: INTEGER is
			-- Access member `controlValue'
		require
			exists: exists
		do
			Result := get_controlvalue_external (item)
		ensure
			result_correct: Result = get_controlvalue_external (item)
		end

	set_controlvalue (a_value: INTEGER) is
			-- Set member `controlValue'
		require
			exists: exists
		do
			set_controlvalue_external (item, a_value)
		ensure
			a_value_set: a_value = controlvalue
		end

	controlvisible: INTEGER is
			-- Access member `controlVisible'
		require
			exists: exists
		do
			Result := get_controlvisible_external (item)
		ensure
			result_correct: Result = get_controlvisible_external (item)
		end

	set_controlvisible (a_value: INTEGER) is
			-- Set member `controlVisible'
		require
			exists: exists
		do
			set_controlvisible_external (item, a_value)
		ensure
			a_value_set: a_value = controlvisible
		end

	fill: INTEGER is
			-- Access member `fill'
		require
			exists: exists
		do
			Result := get_fill_external (item)
		ensure
			result_correct: Result = get_fill_external (item)
		end

	set_fill (a_value: INTEGER) is
			-- Set member `fill'
		require
			exists: exists
		do
			set_fill_external (item, a_value)
		ensure
			a_value_set: a_value = fill
		end

	controlmaximum: INTEGER is
			-- Access member `controlMaximum'
		require
			exists: exists
		do
			Result := get_controlmaximum_external (item)
		ensure
			result_correct: Result = get_controlmaximum_external (item)
		end

	set_controlmaximum (a_value: INTEGER) is
			-- Set member `controlMaximum'
		require
			exists: exists
		do
			set_controlmaximum_external (item, a_value)
		ensure
			a_value_set: a_value = controlmaximum
		end

	controlminimum: INTEGER is
			-- Access member `controlMinimum'
		require
			exists: exists
		do
			Result := get_controlminimum_external (item)
		ensure
			result_correct: Result = get_controlminimum_external (item)
		end

	set_controlminimum (a_value: INTEGER) is
			-- Set member `controlMinimum'
		require
			exists: exists
		do
			set_controlminimum_external (item, a_value)
		ensure
			a_value_set: a_value = controlminimum
		end

	controldefprocid: INTEGER is
			-- Access member `controlDefProcID'
		require
			exists: exists
		do
			Result := get_controldefprocid_external (item)
		ensure
			result_correct: Result = get_controldefprocid_external (item)
		end

	set_controldefprocid (a_value: INTEGER) is
			-- Set member `controlDefProcID'
		require
			exists: exists
		do
			set_controldefprocid_external (item, a_value)
		ensure
			a_value_set: a_value = controldefprocid
		end

	controlreference: INTEGER is
			-- Access member `controlReference'
		require
			exists: exists
		do
			Result := get_controlreference_external (item)
		ensure
			result_correct: Result = get_controlreference_external (item)
		end

	set_controlreference (a_value: INTEGER) is
			-- Set member `controlReference'
		require
			exists: exists
		do
			set_controlreference_external (item, a_value)
		ensure
			a_value_set: a_value = controlreference
		end

	controltitle: POINTER is
			-- Access member `controlTitle'
		require
			exists: exists
		do
			Result := get_controltitle_external (item)
		ensure
			result_correct: Result = get_controltitle_external (item)
		end

end
