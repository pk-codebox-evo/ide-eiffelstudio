indexing
	component:   "openEHR EHR Reference Model"
	description: "[
	             A particular version of content extracted from a  VERSIONED_COMPOSITION. 
	             Corresponds to the event of a HCP committing new information to the health 
	             record. A new COMPOSITION is created by a VERSIONED_COMPOSITION for 
	             creation or modification. 
	             
	             COMPOSITION objects are simple items combining an audit and a content object.
			 ]"
	keywords:    "composition, versioning"

	requirements:"ISO 18308 TS V1.0 ???"
	design:      "openEHR EHR Reference Model 5.0"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2000-2005 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/openehr/src/rm/composition/composition.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class COMPOSITION

inherit
	LOCATABLE

	EXTERNAL_ENVIRONMENT_ACCESS
		export
			{NONE} all
		end

feature -- Definitions

	Id_delimiter: STRING is "!"
			-- delimiter for sections of id.

feature -- Access
	
	composer: PARTY_PROXY
			-- Person or agent primarily responsible for the content of the Composition

	content: LIST [CONTENT_ITEM]
			-- the clinical session content of this transaction

	context: EVENT_CONTEXT
			-- The clinical session context of this transaction, 
			-- i.e. the contextual attributes of the clinical session
			
	language: CODE_PHRASE	
			-- Mandatory indicator of the localised language in which this 
			-- Composition is written. Coded from openEHR Code Set �languages�.
			-- individual Entries may override this value
			
	territory: CODE_PHRASE	
			-- Name of territory in which this Composition was written. 
			-- Coded from openEHR �countries� code set, which is an expression of the ISO 3166 standard.

	category: DV_CODED_TEXT	
			-- Indicates what broad category this Composition is belogs to, 
			-- e.g. "persistent� - of longitudinal validity, �event�, �process� etc.

	path_of_item (a_loc: LOCATABLE): STRING is
			-- The path to an item relative to the root of this archetyped structure.
		do
				-- TO_BE_IMPLEM
		end

	item_at_path (a_path: STRING): LOCATABLE is
			-- The item at a path (relative to this item).
		do
				-- TO_BE_IMPLEM
		end

	parent: LOCATABLE is
			-- parent node of this node in compositional structure
		once			
		end

feature -- Status Report

	is_persistent: BOOLEAN is
			-- Indicates whether this transaction is considered persistent, i.e. of longitudinal validity or not.
		do
			
		end
		
	path_exists (a_path: STRING): BOOLEAN is
			-- True if the path is valid with respect to the current item.
		do
				-- TO_BE_IMPLEM
		end
		
feature {NONE} -- Implementation

	term_set_descriptors: LIST [TERMINOLOGY_ID]
			-- terminology ids for all terms used in this transaction, keyed by 
			-- the idea recorded in the term

invariant
	Archetype_root_point: is_archetype_root
	Composer_exists: composer /= Void
	Content_valid: content /= Void implies not content.is_empty
	Category_validity: category /= Void and then 
		terminology(Terminology_id_openehr).has_code_for_group_id (Group_id_composition_category, category.defining_code)
	Is_persistent_validity: is_persistent implies context = Void
	Territory_valid: territory /= Void and then code_set(Code_set_id_countries).has(territory)
	Language_valid: language /= Void and then code_set(Code_set_id_languages).has(language)
	No_parent: parent = Void

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
--| The Original Code is composition.e.
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
