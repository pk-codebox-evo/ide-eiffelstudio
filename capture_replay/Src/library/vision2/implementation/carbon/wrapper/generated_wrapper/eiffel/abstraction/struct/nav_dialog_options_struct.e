-- This file has been generated by EWG. Do not edit. Changes will be lost!

class NAV_DIALOG_OPTIONS_STRUCT

inherit

	EWG_STRUCT

	NAV_DIALOG_OPTIONS_STRUCT_EXTERNAL
		export
			{NONE} all
		end

creation

	make_new_unshared,
	make_new_shared,
	make_unshared,
	make_shared

feature {NONE} -- Implementation

	sizeof: INTEGER is
		do
			Result := sizeof_external
		end

feature {ANY} -- Member Access

	get_version: INTEGER is
		obsolete "Use `version' instead."
			-- Access member `version'
		require
			exists: exists
		do
			Result := get_version_external (item)
		ensure
			result_correct: Result = get_version_external (item)
		end

	version: INTEGER is
			-- Access member `version'
		require
			exists: exists
		do
			Result := get_version_external (item)
		ensure
			result_correct: Result = get_version_external (item)
		end

	set_version (a_value: INTEGER) is
			-- Set member `version'
		require
			exists: exists
		do
			set_version_external (item, a_value)
		ensure
			a_value_set: a_value = version
		end

	get_dialogoptionflags: INTEGER is
		obsolete "Use `dialogoptionflags' instead."
			-- Access member `dialogOptionFlags'
		require
			exists: exists
		do
			Result := get_dialogoptionflags_external (item)
		ensure
			result_correct: Result = get_dialogoptionflags_external (item)
		end

	dialogoptionflags: INTEGER is
			-- Access member `dialogOptionFlags'
		require
			exists: exists
		do
			Result := get_dialogoptionflags_external (item)
		ensure
			result_correct: Result = get_dialogoptionflags_external (item)
		end

	set_dialogoptionflags (a_value: INTEGER) is
			-- Set member `dialogOptionFlags'
		require
			exists: exists
		do
			set_dialogoptionflags_external (item, a_value)
		ensure
			a_value_set: a_value = dialogoptionflags
		end

	get_location: POINTER is
		obsolete "Use `location' instead."
			-- Access member `location'
		require
			exists: exists
		do
			Result := get_location_external (item)
		ensure
			result_correct: Result = get_location_external (item)
		end

	location: POINTER is
			-- Access member `location'
		require
			exists: exists
		do
			Result := get_location_external (item)
		ensure
			result_correct: Result = get_location_external (item)
		end

	set_location (a_value: POINTER) is
			-- Set member `location'
		require
			exists: exists
		do
			set_location_external (item, a_value)
		end

	get_clientname: POINTER is
		obsolete "Use `clientname' instead."
			-- Access member `clientName'
		require
			exists: exists
		do
			Result := get_clientname_external (item)
		ensure
			result_correct: Result = get_clientname_external (item)
		end

	clientname: POINTER is
			-- Access member `clientName'
		require
			exists: exists
		do
			Result := get_clientname_external (item)
		ensure
			result_correct: Result = get_clientname_external (item)
		end

	get_windowtitle: POINTER is
		obsolete "Use `windowtitle' instead."
			-- Access member `windowTitle'
		require
			exists: exists
		do
			Result := get_windowtitle_external (item)
		ensure
			result_correct: Result = get_windowtitle_external (item)
		end

	windowtitle: POINTER is
			-- Access member `windowTitle'
		require
			exists: exists
		do
			Result := get_windowtitle_external (item)
		ensure
			result_correct: Result = get_windowtitle_external (item)
		end

	get_actionbuttonlabel: POINTER is
		obsolete "Use `actionbuttonlabel' instead."
			-- Access member `actionButtonLabel'
		require
			exists: exists
		do
			Result := get_actionbuttonlabel_external (item)
		ensure
			result_correct: Result = get_actionbuttonlabel_external (item)
		end

	actionbuttonlabel: POINTER is
			-- Access member `actionButtonLabel'
		require
			exists: exists
		do
			Result := get_actionbuttonlabel_external (item)
		ensure
			result_correct: Result = get_actionbuttonlabel_external (item)
		end

	get_cancelbuttonlabel: POINTER is
		obsolete "Use `cancelbuttonlabel' instead."
			-- Access member `cancelButtonLabel'
		require
			exists: exists
		do
			Result := get_cancelbuttonlabel_external (item)
		ensure
			result_correct: Result = get_cancelbuttonlabel_external (item)
		end

	cancelbuttonlabel: POINTER is
			-- Access member `cancelButtonLabel'
		require
			exists: exists
		do
			Result := get_cancelbuttonlabel_external (item)
		ensure
			result_correct: Result = get_cancelbuttonlabel_external (item)
		end

	get_savedfilename: POINTER is
		obsolete "Use `savedfilename' instead."
			-- Access member `savedFileName'
		require
			exists: exists
		do
			Result := get_savedfilename_external (item)
		ensure
			result_correct: Result = get_savedfilename_external (item)
		end

	savedfilename: POINTER is
			-- Access member `savedFileName'
		require
			exists: exists
		do
			Result := get_savedfilename_external (item)
		ensure
			result_correct: Result = get_savedfilename_external (item)
		end

	get_message: POINTER is
		obsolete "Use `message' instead."
			-- Access member `message'
		require
			exists: exists
		do
			Result := get_message_external (item)
		ensure
			result_correct: Result = get_message_external (item)
		end

	message: POINTER is
			-- Access member `message'
		require
			exists: exists
		do
			Result := get_message_external (item)
		ensure
			result_correct: Result = get_message_external (item)
		end

	get_preferencekey: INTEGER is
		obsolete "Use `preferencekey' instead."
			-- Access member `preferenceKey'
		require
			exists: exists
		do
			Result := get_preferencekey_external (item)
		ensure
			result_correct: Result = get_preferencekey_external (item)
		end

	preferencekey: INTEGER is
			-- Access member `preferenceKey'
		require
			exists: exists
		do
			Result := get_preferencekey_external (item)
		ensure
			result_correct: Result = get_preferencekey_external (item)
		end

	set_preferencekey (a_value: INTEGER) is
			-- Set member `preferenceKey'
		require
			exists: exists
		do
			set_preferencekey_external (item, a_value)
		ensure
			a_value_set: a_value = preferencekey
		end

	get_popupextension: POINTER is
		obsolete "Use `popupextension' instead."
			-- Access member `popupExtension'
		require
			exists: exists
		do
			Result := get_popupextension_external (item)
		ensure
			result_correct: Result = get_popupextension_external (item)
		end

	popupextension: POINTER is
			-- Access member `popupExtension'
		require
			exists: exists
		do
			Result := get_popupextension_external (item)
		ensure
			result_correct: Result = get_popupextension_external (item)
		end

	set_popupextension (a_value: POINTER) is
			-- Set member `popupExtension'
		require
			exists: exists
		do
			set_popupextension_external (item, a_value)
		ensure
			a_value_set: a_value = popupextension
		end

	get_reserved: POINTER is
		obsolete "Use `reserved' instead."
			-- Access member `reserved'
		require
			exists: exists
		do
			Result := get_reserved_external (item)
		ensure
			result_correct: Result = get_reserved_external (item)
		end

	reserved: POINTER is
			-- Access member `reserved'
		require
			exists: exists
		do
			Result := get_reserved_external (item)
		ensure
			result_correct: Result = get_reserved_external (item)
		end

end
