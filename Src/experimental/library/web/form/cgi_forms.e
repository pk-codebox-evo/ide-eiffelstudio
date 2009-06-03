note
	description: "Class which allows retrieving information relative to%
					% a specific type of form."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CGI_FORMS

feature -- Access

	text_field_value (field_name: STRING): STRING
			-- First (unique?) value for a text field.
			-- Applies for a password and a text area too.
		require
			field_not_void: field_name /= Void;
			field_exists: field_defined (field_name)
		local
			l_list: detachable LINKED_LIST [STRING_8]
		do
			l_list := form_data.item (field_name)
				-- Per precondition
			check l_list_attached: l_list /= Void end
			Result := l_list.first
		ensure
			value_exists: Result /= Void
		end

	button_value (field_name: STRING; overriding_value: detachable STRING): BOOLEAN
			-- Is Button relative to 'field_name' selected ?
		require
			field_not_void: field_name /= Void;
			field_exists: field_defined (field_name)
		local
			s: STRING
			l_list: detachable LINKED_LIST [STRING_8]
		do
			l_list := form_data.item (field_name)
				-- Per precondition
			check l_list_attached: l_list /= Void end
			s := l_list.first
			s.to_lower
			if s.is_equal ("on") then
				Result := True
			elseif overriding_value /= Void then
				overriding_value.to_lower
				Result := overriding_value.is_equal (s)
			end
		end

	menu_values (field_name: STRING): LINKED_LIST [STRING]
			-- Selected values for a list, whose name
			-- is 'field_name'.
		require
			field_not_void: field_name /= Void
			field_exists: field_defined (field_name)
		local
			l_list: detachable LINKED_LIST [STRING_8]
		do
			l_list := form_data.item (field_name)
				-- Per precondition
			check l_list_attached: l_list /= Void end
			Result := l_list
		ensure
			value_exists: Result /= Void
		end

feature -- Advanced Access

	fields: ARRAY [STRING]
			-- Names of fields in the form.
		once
			Result := form_data.current_keys
			Result.compare_objects
		end

	value_count (field_name: STRING): INTEGER
			-- Number of values for a field.
		require
			field_not_void: field_name /= Void
			field_exists: field_defined (field_name)
		local
			l_list: detachable LINKED_LIST [STRING_8]
		do
			l_list := form_data.item (field_name)
				-- Per precondition
			check l_list_attached: l_list /= Void end
			Result := l_list.count
		ensure
			valid_count: Result >= 0
		end

	value_list (field_name: STRING): LINKED_LIST [STRING]
			-- List of values for a field.
		require
			field_not_void: field_name /= Void
			field_exists: field_defined (field_name)
		local
			l_list: detachable LINKED_LIST [STRING_8]
		do
			l_list := form_data.item (field_name)
				-- Per precondition
			check l_list_attached: l_list /= Void end
			Result := l_list
		ensure
			valid_count: Result.count = value_count (field_name)
		end

feature -- Report

	field_defined (field_name: STRING): BOOLEAN
			-- Is field `field_name' defined?
		require
			filed_name_not_void: field_name /= Void
		do
			Result := fields.has (field_name)
		end

feature -- Implementation

	form_data: HASH_TABLE [LINKED_LIST [STRING], STRING]
			-- Table in which is contained all the information
			-- relative to the different user inputs.
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class CGI_FORMS

