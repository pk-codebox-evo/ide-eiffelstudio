indexing
	component:   "openEHR Archetype Project"
	description: "[
			 Object node type representing a reference to a constraint
			 defined in the ontology section of the archetype.
			 ]"
	keywords:    "test, ADL"

	author:      "Thomas Beale"
	support:     "Ocean Informatics<support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2004 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/openehr/src/am/archetype/constraint_model/constraint_ref.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class CONSTRAINT_REF

inherit
	C_REFERENCE_OBJECT
		redefine
			default_create, representation, is_valid, enter_subtree, exit_subtree
		end

create
	make

feature -- Initialisation

	default_create is
			--
		do
			precursor
			rm_type_name := (create {CODE_PHRASE}.default_create).generator
		end

	make(a_code: STRING) is
			-- make from pattern of form "[acNNNN[.NN[etc]]]"
		require
			Code_exists: a_code /= Void and then not a_code.is_empty
		do
			default_create
			create representation.make_anonymous(Current)
			target := a_code
		ensure
			Target_set: target = a_code
		end

feature -- Access

	target: STRING
			-- reference to another constraint object containing the logical
			-- constraints for this object, defined outside the archetype,
			-- usually in the ontology section of an ADL archetype
			-- [called 'reference' in AOM, but that is a keyword in Eiffel]

feature -- Status Report

	is_valid: BOOLEAN is
			-- report on validity
		do
			Result := precursor
		end

feature -- Conversion

	as_string: STRING is
			--
		do
			create Result.make (0)
			Result.append("[" + target + "]")
		end

feature -- Representation

	representation: !OG_OBJECT_LEAF

feature -- Visitor

	enter_subtree(visitor: C_VISITOR; depth: INTEGER) is
			-- perform action at start of block for this node
		do
			precursor(visitor, depth)
			visitor.start_constraint_ref(Current, depth)
		end

	exit_subtree(visitor: C_VISITOR; depth: INTEGER) is
			-- perform action at end of block for this node
		do
			precursor(visitor, depth)
			visitor.end_constraint_ref(Current, depth)
		end

invariant
	Target_valid: target /= Void

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
--| The Original Code is cadl_object_term.e.
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
