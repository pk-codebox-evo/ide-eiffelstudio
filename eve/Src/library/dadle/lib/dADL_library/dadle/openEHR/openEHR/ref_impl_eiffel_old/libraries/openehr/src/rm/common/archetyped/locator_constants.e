indexing
	component:   "openEHR Reference Object Model"
	description: "Locator constants."
	keywords:    "content, path, locator"
	requirements:"clin:data-ref-std"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2000-2004 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/openehr/src/rm/common/archetyped/locator_constants.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class LOCATOR_CONSTANTS

feature {NONE} -- Definitions

	Current_transaction_id:STRING is "current"

	Fragment_separator:STRING is "#"
			-- separator between identifiers for whole document, and for fragments. In the EHR, this is
			-- between the transaction id, and id of organiser and/or content

	Content_path_separator:STRING is "|"
			-- separator between path items in content paths

	Organiser_path_separator:STRING is "/"
			-- separator between path items in organiser paths

	Multipart_id_delimiter:STRING is "::"
			-- separator between sections in multi-part ids, such as the transaction id

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
--| The Original Code is locator_constants.e.
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
