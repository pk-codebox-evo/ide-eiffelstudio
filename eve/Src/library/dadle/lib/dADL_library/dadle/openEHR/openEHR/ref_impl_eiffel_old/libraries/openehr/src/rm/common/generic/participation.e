indexing
	component:   "openEHR Common Reference Model"

	description: "[
				 Used to represent any participation of a Party in some activity, 
				 which is not explicitly in the model, e.g. assisting nurse. 
				 Can be used to record past or future participations.
				 ]"
	keywords:    "participation"

	design:      "openEHR Common Reference Model 2.0"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2000-2005 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/openehr/src/rm/common/generic/participation.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class PARTICIPATION

inherit
	EXTERNAL_ENVIRONMENT_ACCESS
		export
			{NONE} all
		end

feature -- Initialization

feature -- Access

	performer: PARTY_PROXY
			-- The party participating in the activity.

	function: DV_TEXT
			-- The function of the Party in this participation (a given party might
			-- participate in more than one way in a given activity).

	mode: DV_CODED_TEXT
			-- The modality of the performer / activity interaction, e.g. present,
			-- by telephone, by email etc.

	time: DV_INTERVAL [DV_DATE_TIME]
			-- The time interval during which the participation took place,
			-- if it is used in an observational context (i.e. recording facts about
			-- the past); or the intended time interval of the participation when used
			-- in future contexts, such as EHR Instructions.

invariant
	Performer_exists: performer /= Void
	Mode_valid: terminology(Terminology_id_openehr).has_code_for_group_id(Group_id_participation_mode, mode.defining_code)
	Function_valid: function /= Void and then function.generating_type.name.is_equal("DV_CODED_TEXT")
-- FIXME: re-instate when a simple way is found to do an 'inline cast'
--		implies terminology("openehr").codes_for_group_name("participation function", "en")
--		.has(function.defining_code)

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
--| The Original Code is participation.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2003-2005
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
