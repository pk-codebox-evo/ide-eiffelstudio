note
	component:   "openEHR Archetype project"
	description: "Structured error list with some useful facilities"
	keywords:    "Error logging"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2010 openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: https://svn.origo.ethz.ch/abel/trunk/libraries/openehr/src/app_framework/error_reporting/error_accumulator.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class ERROR_ACCUMULATOR

inherit
	ERROR_SEVERITY_TYPES

	SHARED_MESSAGE_DB
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make
		do
			create list.make(0)
		end

feature -- Access

	last_added: attached ERROR_DESCRIPTOR
		do
			Result := list.last
		end

	error_codes: attached ARRAYED_LIST[STRING]
			-- list of all codes from errors currently in list
		do
			create Result.make(0)
			Result.compare_objects
			from list.start until list.off loop
				if list.item.severity = error_type_error then
					Result.extend(list.item.code)
				end
				list.forth
			end
		end

	warning_codes: attached ARRAYED_LIST[STRING]
			-- list of all codes from warnings currently in list
		do
			create Result.make(0)
			Result.compare_objects
			from list.start until list.off loop
				if list.item.severity = error_type_warning then
					Result.extend(list.item.code)
				end
				list.forth
			end
		end

	error_reporting_level: INTEGER
			-- at this level and above, list entries are included in `as_string' and any other output function
		do
			Result := error_reporting_level_cell.item
		end

feature -- Status Report

	is_empty: BOOLEAN
		do
			Result := list.is_empty
		end

	has_errors: BOOLEAN

	has_warnings: BOOLEAN

	has_info: BOOLEAN

feature -- Status Setting

	set_error_reporting_level (a_level: INTEGER)
		require
			valid_error_level: is_valid_error_type (a_level)
		do
			error_reporting_level_cell.put(a_level)
		end

feature -- Modification

	add_error (a_code: attached STRING; args: ARRAY[STRING]; a_loc: STRING)
		do
			extend (create {ERROR_DESCRIPTOR}.make (a_code, error_type_error, create_message_content (a_code, args), a_loc))
		end

	add_warning (a_code: attached STRING; args: ARRAY[STRING]; a_loc: STRING)
		do
			extend (create {ERROR_DESCRIPTOR}.make (a_code, error_type_warning, create_message_content (a_code, args), a_loc))
		end

	add_info (a_code: attached STRING; args: ARRAY[STRING]; a_loc: STRING)
		do
			extend (create {ERROR_DESCRIPTOR}.make (a_code, error_type_info, create_message_content (a_code, args), a_loc))
		end

	add_debug (a_message: attached STRING; a_loc: STRING)
		do
			extend (create {ERROR_DESCRIPTOR}.make ("", error_type_debug, a_message, a_loc))
		end

	extend(err_desc: attached ERROR_DESCRIPTOR)
		do
			list.extend(err_desc)
			has_errors := has_errors or err_desc.severity = Error_type_error
			has_warnings := has_warnings or err_desc.severity = Error_type_warning
			has_info := has_info or err_desc.severity = Error_type_info
		end

	append(other: attached ERROR_ACCUMULATOR)
		do
			list.append(other.list)
			has_errors := has_errors or other.has_errors
			has_warnings := has_warnings or other.has_warnings
			has_info := has_info or other.has_info
		end

	wipe_out
		do
			list.wipe_out
			has_errors := False
			has_warnings := False
			has_info := False
		end

feature -- Output

	as_string: attached STRING
			-- generate stringified version of contents, with newlines inserted after each entry
		do
			create Result.make(0)
			from list.start until list.off loop
				if list.item.severity >= error_reporting_level then
					Result.append(list.item.as_string)
					Result.append_character ('%N')
				end
				list.forth
			end
		end

feature {ERROR_ACCUMULATOR} -- Implementation

	list: attached ARRAYED_LIST[ERROR_DESCRIPTOR]
			-- error output of validator - things that must be corrected

	error_reporting_level_cell: CELL [INTEGER]
		once
			create Result.put (Error_type_warning)
		end

invariant
	Valid_severity_reporting_level: is_valid_error_type (error_reporting_level)
	Has_errors_consistency: has_errors implies list.there_exists (agent (e: ERROR_DESCRIPTOR): BOOLEAN do Result := e.severity = error_type_error end)
	Has_warnings_consistency: has_warnings implies list.there_exists (agent (e: ERROR_DESCRIPTOR): BOOLEAN do Result := e.severity = error_type_warning end)

end


--|
--| ***** BEGIN LICENSE BLOCK *****
--| Version: MPL 1.1/GPL 2.0/LGPL 2.1
--|
--| The contents of this file are subject to the Mozilla Public License Version
--| 1.1 (the 'License'); you may not use this file except in compliance with
--| the License. You may obtain a copy of the License at
--| http://www.mozilla.org/MPL/
--|
--| Software distributed under the License is distributed on an 'AS IS' basis,
--| WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
--| for the specific language governing rights and limitations under the
--| License.
--|
--| The Original Code is error_accumulator.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2007
--| the Initial Developer. All Rights Reserved.
--|
--| Contributor(s):
--|
--| Alternatively, the contents of this file may be used under the terms of
--| either the GNU General Public License Version 2 or later (the 'GPL'), or
--| the GNU Lesser General Public License Version 2.1 or later (the 'LGPL'),
--| in which case the provisions of the GPL or the LGPL are applicable instead
--| of those above. If you wish to allow use of your version of this file only
--| under the terms of either the GPL or the LGPL, and not to allow others to
--| use your version of this file under the terms of the MPL, indicate your
--| decision by deleting the provisions above and replace them with the notice
--| and other provisions required by the GPL or the LGPL. If you do not delete
--| the provisions above, a recipient may use your version of this file under
--| the terms of any one of the MPL, the GPL or the LGPL.
--|
--| ***** END LICENSE BLOCK *****
--|
