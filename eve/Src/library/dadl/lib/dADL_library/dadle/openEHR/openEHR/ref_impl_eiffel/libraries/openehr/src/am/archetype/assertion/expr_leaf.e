note
	component:   "openEHR Archetype Project"
	description: "[
					Expression tree leaf item. This can represent one of:
						* a manifest constant of any primitive type (Integer, Real, Boolean, 
						  String, Character, Date, Time, Date_time, Duration), or (in future) 
						  of any complex reference model type, e.g. a DV_CODED_TEXT;
						* a path referring to a value in the archetype (paths with a leading '/' 
						  are in the definition section; paths with no leading '/'are in the outer 
						  part of the archetype, e.g. 'archetype_id/value' refers to the String 
						  value of the archetype_id attribute of the enclosing archetype;
						* a constraint, expressed in the form of concrete subtype of C_OBJECT; 
						  most often this will be a C_PRIMITIVE_OBJECT.
				 ]"
	keywords:    "assertion, ADL"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2003, 2004 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/BRANCHES/specialisation/libraries/openehr/src/am/archetype/assertion/expr_leaf.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class EXPR_LEAF

inherit
	EXPR_ITEM
		redefine
			out
		end

create
	make_boolean, make_integer, make_real, make_string, make_character,
	make_archetype_definition_ref, make_archetype_ref,
	make_ordinal, make_coded_term,
	make_constraint

feature -- Definitions

	Ref_type_attribute: STRING = "attibute"
	Ref_type_constant: STRING = "constant"
	Ref_type_constraint: STRING = "constraint"

feature -- Initialisation

	make_archetype_ref(a_ref: STRING)
			-- node refers to a feature in the main part of an archetype
			-- (not the definition section)
		require
			ref_exists: a_ref /= Void and then not a_ref.is_empty
		do
			item := a_ref
			type := "String" -- FIXME: need access to ref model to know what type it really is
			reference_type := Ref_type_attribute.twin
		ensure
			is_archetype_ref
		end

	make_archetype_definition_ref(a_ref: STRING)
			-- node refers to a feature in the archetype definition
		require
			ref_exists: a_ref /= Void and then not a_ref.is_empty
		do
			item := a_ref
			type := "Any" -- FIXME: need access to ref model to know what type it really is
			reference_type := Ref_type_attribute.twin
		ensure
			is_archetype_definition_ref
		end

	make_boolean(an_item: BOOLEAN)
			-- node is a boolean value
   		do
			item := an_item
			type := "Boolean"
			reference_type := Ref_type_constant.twin
		end

	make_real(an_item: REAL)
			-- node is a real value
   		do
			item := an_item
			type := "Real"
			reference_type := Ref_type_constant.twin
		end

	make_integer(an_item: INTEGER)
			-- node is an integer value
   		do
			item := an_item
			type := "Integer"
			reference_type := Ref_type_constant.twin
		end

	make_string(an_item: STRING)
			-- node is a string value
		require
			Item_exists: an_item /= Void
   		do
			item := an_item
			type := "String"
			reference_type := Ref_type_constant
		end

	make_character(an_item: CHARACTER)
			-- node is a character value
   		do
			item := an_item
			type := "Character"
			reference_type := Ref_type_constant
		end

	make_ordinal(an_item: ORDINAL)
			-- node is a ordinal value
		require
			Item_exists: an_item /= Void
   		do
			item := an_item
			type := "ORDINAL"
			reference_type := Ref_type_constant
		end

	make_coded_term(an_item: CODE_PHRASE)
			-- node is a term value
		require
			Item_exists: an_item /= Void
   		do
			item := an_item
			type := "CODE_PHRASE"
			reference_type := Ref_type_constraint
		end

	make_constraint(an_item: C_PRIMITIVE)
			-- node is a constraint on a primitive type; can only be used with "matches" function
		require
			Item_exists: an_item /= Void
   		do
			item := an_item
			type := an_item.generator
			reference_type := Ref_type_constraint
		end

feature -- Access

	reference_type: STRING
			-- Type of reference: "constant", "attribute", "function", "constraint". The first three are
			-- used to indicate the referencing mechanism for an operand. The last is used to indicate
			-- a constraint operand, as happens in the case of the right-hand operand of the �matches� operator.

	item: ANY

feature -- Status Report

	is_archetype_ref: BOOLEAN
			-- True if this leaf node is a reference to a node in an archetype outer structure (i.e., not the definition part)
		local
			a_path: STRING
		do
			if reference_type.is_equal (Ref_type_attribute) then
				a_path ?= item
				Result := a_path.item(1) /= '/'
			end
		end

	is_archetype_definition_ref: BOOLEAN
			-- True if this leaf node is a reference to a node in an archetype definition
		local
			a_path: STRING
		do
			if reference_type.is_equal (Ref_type_attribute) then
				a_path ?= item
				Result := a_path.item(1) = '/'
			end
		end

feature -- Conversion

	out: STRING
		do
			create Result.make(0)
			Result.append (item.out)
		end

	as_string: STRING
		do
			create Result.make(0)
			if reference_type.is_equal("constraint") then
				Result.append ("{")
			end
			Result.append (item.out)
			if reference_type.is_equal("constraint") then
				Result.append ("}")
			end
		end

feature -- Visitor

	enter_subtree(visitor: EXPR_VISITOR; depth: INTEGER)
			-- perform action at start of block for this node
		do
			visitor.start_expr_leaf (Current, depth)
		end

	exit_subtree(visitor: EXPR_VISITOR; depth: INTEGER)
			-- perform action at end of block for this node
		do
			visitor.end_expr_leaf (Current, depth)
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
--| The Original Code is adl_expr_leaf.e.
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
