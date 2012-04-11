note
	component:   "openEHR Archetype Project"
	description: "[
				 File-system ad hoc repository of archetypes - where archetypes are not arranged as a tree
				 but may appear anywhere. Items are added to the repository by the user, not by an automatic
				 scan of a directory tree.
				 ]"
	keywords:    "ADL"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2007 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"


class ARCHETYPE_ADHOC_FILE_REPOSITORY

inherit
	ARCHETYPE_FILE_REPOSITORY_IMP

create
	make

feature {NONE} -- Initialisation

	make (a_group_id: INTEGER)
			-- Create as part of `a_group_id', with a sensible default `work_path'.
		require
			group_id_valid: a_group_id > 0
		do
			group_id := a_group_id
			create archetype_id_index.make (0)
		ensure
			group_id_set: group_id = a_group_id
		end

feature -- Access

	item (full_path: STRING): ARCH_REP_ARCHETYPE
			-- The archetype at `full_path'.
		require
			has_full_path: has_path (full_path)
		do
			Result := archetype_id_index.item (full_path)
		end

feature -- Status Report

	has_path (full_path: STRING): BOOLEAN
			-- Has `full_path' been added to this repository?
		do
			Result := archetype_id_index.has (full_path)
		end

feature -- Modification

	add_item (full_path: STRING)
			-- Add the archetype designated by `full_path' to this repository.
		require
			path_valid: is_valid_path (full_path)
			hasnt_path: not has_path (full_path)
		local
			ara: ARCH_REP_ARCHETYPE
			arch_id, parent_arch_id: ARCHETYPE_ID
			amp: ARCHETYPE_MINI_PARSER
		do
			create amp
			amp.parse (full_path)
			if amp.last_parse_valid then
				if not amp.last_archetype_id_old_style then
					create arch_id.make_from_string(amp.last_archetype_id)
					if not archetype_id_index.has (amp.last_archetype_id) then
						if amp.last_archetype_specialised then
							create parent_arch_id.make_from_string(amp.last_parent_archetype_id)
							create ara.make_specialised (full_path, arch_id, parent_arch_id, Current, amp.last_archetype_artefact_type)
						else
							create ara.make (full_path, arch_id, Current, amp.last_archetype_artefact_type)
						end
						archetype_id_index.force (ara, full_path)
					else
						post_info (Current, "build_directory", "pair_filename_i1", <<full_path>>)
					end
				else
					post_warning (Current, "build_directory", "parse_archetype_e7", <<full_path>>)
				end
			else
				post_error (Current, "build_directory", "parse_archetype_e5", <<full_path>>)
			end
		ensure
			added_1_or_none: (0 |..| 1).has (archetype_id_index.count - old archetype_id_index.count)
			has_path: archetype_id_index.count > old archetype_id_index.count implies has_path (full_path)
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
--| The Original Code is adl_node_control.e.
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
