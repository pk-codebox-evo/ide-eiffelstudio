note
	component:   "openEHR EHR Reference Model"

	description: "[
	              Details of part of Instruction which caused an action which
				  to be executed.
				  ]"
	keywords:    "content, clinical, instruction, action, workflow"

	requirements:"ISO 18308 TS V1.0 ???"
	design:      "openEHR EHR Reference Model 5.0"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2005 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/BRANCHES/specialisation/libraries/openehr/src/rm/composition/content/entry/action.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class ACTION

inherit
	CARE_ENTRY

feature -- Access

	time: DV_DATE_TIME
			-- time at which activity occurred

	description: ITEM_STRUCTURE
			-- description of activity that occured

	ism_transition: ISM_TRANSITION
			-- transition that occurred due to this action

	instruction_details: INSTRUCTION_DETAILS
			-- details of Instruction corresponding to this Action, if
			-- relevant

	path_of_item (a_loc: LOCATABLE): STRING
			-- The path to an item relative to the root of this archetyped structure.
		do
		end

	item_at_path (a_path: STRING): LOCATABLE
			-- The item at a path (relative to this item).
		do
		end
			
feature -- Status Report

	path_exists (a_path: STRING): BOOLEAN
			-- True if the path is valid with respect to the current item.
		do
		end

invariant
	Time_exists: time /= Void
	Description_exists: description /= Void
	Ism_transition_exists: ism_transition /= Void

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
--| The Original Code is action.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2005
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
