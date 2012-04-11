note
	component:   "openEHR Archetype Project"
	description: "Tests for ADL differential ontology class"
	keywords:    "archetype, ontology, terminology"

	author:      "Peter Gummer"
	support:     "Ocean Informatics <support@OceanInformatics.com>"
	copyright:   "Copyright (c) 2009 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/BRANCHES/specialisation/libraries/openehr/tests/test_differential_archetype_ontology.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"
	testing:     "type/manual"

class
	TEST_DIFFERENTIAL_ARCHETYPE_ONTOLOGY

inherit
	OPENEHR_TEST_SET
		undefine
			default_create
		end

	DIFFERENTIAL_ARCHETYPE
		redefine
			default_create
		end

feature {NONE} -- Initialisation

	default_create
			-- Satisfy the invariant of `DIFFERENTIAL_ARCHETYPE'.
		do
			make_minimal (create {ARTEFACT_TYPE}, create {ARCHETYPE_ID}, "en", 0)
		end

	create_parented_target
			-- Create `target' with `parent'.
		do
			create target.make_empty ("en", 1)
			create parent.make_empty ("en", 0)
			target.set_parent_ontology (parent)
		end

feature {NONE} -- Targets

	target, parent: DIFFERENTIAL_ARCHETYPE_ONTOLOGY

feature -- Test routines

	test_make_from_tree_anonymous
			-- The ontology can be made from an anonymous tree node.
		note
			testing: "covers/{DIFFERENTIAL_ARCHETYPE_ONTOLOGY}.make_from_tree"
		do
			create target.make_from_tree ("en", create {DT_COMPLEX_OBJECT_NODE}.make_anonymous, default_concept_code)
			assert_equal (default_concept_code, target.concept_code)
		end

	test_make_from_tree_identified
			-- The ontology can be made from an identified tree node.
		note
			testing: "covers/{DIFFERENTIAL_ARCHETYPE_ONTOLOGY}.make_from_tree"
		local
			tree: DT_COMPLEX_OBJECT_NODE
		do
			create tree.make_identified (default_concept_code)
			create target.make_from_tree ("en", tree, default_concept_code)
			assert_equal (default_concept_code, target.concept_code)
		end

	test_new_non_specialised_term_code
			-- Each new non-specialised term code tail keeps increasing by 1, including double-digit tails.
		note
			testing: "covers/{DIFFERENTIAL_ARCHETYPE_ONTOLOGY}.new_non_specialised_term_code"
		local
			code: STRING
			i: INTEGER
		do
			create_parented_target

			from i := 1 until i = 12 loop
				code := target.new_non_specialised_term_code
				assert_equal ("at0." + i.out, code)
				target.add_term_definition ("en", create {ARCHETYPE_TERM}.make (code))
				i := i + 1
			end
		end

	test_new_specialised_term_code
			-- Each new specialised term code tail keeps increasing by 1, including double-digit tails.
		note
			testing: "covers/{DIFFERENTIAL_ARCHETYPE_ONTOLOGY}.new_specialised_term_code"
		local
			code: STRING
			i: INTEGER
		do
			create_parented_target
			parent.add_term_definition ("en", create {ARCHETYPE_TERM}.make ("at0001"))

			from i := 1 until i = 12 loop
				code := target.new_specialised_term_code ("at0001")
				assert_equal ("at0001." + i.out, code)
				target.add_term_definition ("en", create {ARCHETYPE_TERM}.make (code))
				i := i + 1
			end
		end

	test_new_non_specialised_constraint_code
			-- Each new non-specialised constraint code tail keeps increasing by 1, including double-digit tails.
		note
			testing: "covers/{DIFFERENTIAL_ARCHETYPE_ONTOLOGY}.new_non_specialised_constraint_code"
		local
			code: STRING
			i: INTEGER
		do
			create_parented_target

			from i := 1 until i = 12 loop
				code := target.new_non_specialised_constraint_code
				assert_equal ("ac0." + i.out, code)
				target.add_constraint_definition ("en", create {ARCHETYPE_TERM}.make (code))
				i := i + 1
			end
		end

	test_new_specialised_constraint_code
			-- Each new specialised constraint code tail keeps increasing by 1, including double-digit tails.
		note
			testing: "covers/{DIFFERENTIAL_ARCHETYPE_ONTOLOGY}.new_specialised_constraint_code"
		local
			code: STRING
			i: INTEGER
		do
			create_parented_target
			parent.add_constraint_definition ("en", create {ARCHETYPE_TERM}.make ("ac0001"))

			from i := 1 until i = 12 loop
				code := target.new_specialised_constraint_code ("ac0001")
				assert_equal ("ac0001." + i.out, code)
				target.add_constraint_definition ("en", create {ARCHETYPE_TERM}.make (code))
				i := i + 1
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
--| The Original Code is test_differential_archetype_ontology.e.
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
