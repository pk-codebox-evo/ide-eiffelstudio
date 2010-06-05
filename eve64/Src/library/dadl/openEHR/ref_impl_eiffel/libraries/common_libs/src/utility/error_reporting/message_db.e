indexing
	component:   "openEHR Reusable Libraries"
	description: "[
			     Error database abstraction. Subtypes can be easily turned into a file that is read in as
			     a dADL text.
				 ]"
	keywords:    "error status reporting"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2005 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/common_libs/src/utility/error_reporting/message_db.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

deferred class MESSAGE_DB

feature -- Initialisation

	make is
		deferred
		end

feature -- Access

	templates: HASH_TABLE [STRING, STRING]
			-- error templates in the form of a table of templates
			-- keyed by id

	has_message(an_id: STRING): BOOLEAN is
		require
			an_id /= Void
		do
			Result := templates.has(an_id)
		end

	stringify(an_id: STRING; args: ARRAY[STRING]): STRING is
		require
			an_id /= Void
		local
			i: INTEGER
			idx_str: STRING
		do
			Result := templates.item(an_id).twin
			Result.replace_substring_all("%%N", "%N")
			if args /= Void then
				from
					i := args.lower
				until 
					i > args.upper
				loop
					idx_str := i.out
					idx_str.left_adjust
					Result.replace_substring_all("$" + idx_str, args.item(i))
					i := i + 1
				end
			end
		end

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
--| The Original Code is error_status.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2003-2004
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

 
