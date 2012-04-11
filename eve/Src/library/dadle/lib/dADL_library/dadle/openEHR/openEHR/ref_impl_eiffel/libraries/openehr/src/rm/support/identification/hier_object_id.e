note
	component:   "openEHR Support Reference Model"

	description: "[
			 Hierarhical object identifiers. The syntax of the value attribute is as follows:
					 [ root '.' ] extension
			 ]"
	keywords:    "object identifiers"

	design:      "openEHR Common Reference Model 1.4.1"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2000-2006 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/BRANCHES/specialisation/libraries/openehr/src/rm/support/identification/hier_object_id.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class HIER_OBJECT_ID

inherit
	UID_BASED_ID

create
	make

feature -- Initialization

	make(a_root: UID; an_extension: STRING)
			-- build an external ID
		require
			Root_valid: a_root /= Void
			Extension_exists: an_extension /= Void and then not an_extension.is_empty
		do
			create value.make(0)
			if a_root /= Void then
				value.append(a_root.value + Extension_separator)
			end
			value.append(an_extension)
		ensure
			Root_set: a_root /= Void implies root.value.is_equal(a_root.value)
			Extension_set: extension.is_equal(an_extension)
		end

	make_from_string(a_string:STRING)
			-- make from a string of the same form as `id', i.e. "root::extension"
		require
			String_exists: a_string /= Void and then valid_id(a_string)
		do

		end

feature -- Status Report

	valid_id(a_str:STRING): BOOLEAN
			--
		do
			-- Result :=
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
--| The Original Code is hier_object_id.e.
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
