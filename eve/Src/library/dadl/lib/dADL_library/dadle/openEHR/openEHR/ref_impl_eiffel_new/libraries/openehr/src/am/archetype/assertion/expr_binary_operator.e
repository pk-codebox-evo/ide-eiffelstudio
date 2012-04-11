indexing
	component:   "openEHR Archetype Project"
	description: "node in ADL parse tree"
	keywords:    "test, ADL"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2003 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/openehr/src/am/archetype/assertion/expr_binary_operator.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class EXPR_BINARY_OPERATOR

inherit
	EXPR_OPERATOR

create
	make

feature -- Access

	left_operand: EXPR_ITEM

	right_operand: EXPR_ITEM

feature -- Modification

	set_left_operand(an_item: EXPR_ITEM) is
		require
			an_item_exists: an_item /= Void
		do
			left_operand := an_item
		end

	set_right_operand(an_item: EXPR_ITEM) is
		require
			an_item_exists: an_item /= Void
		do
			right_operand := an_item
		end

feature -- Conversion

	as_string: STRING is
		do
			create Result.make(0)
			Result.append(left_operand.as_string)
			Result.append(" " + operator.out + " ")
			Result.append(right_operand.as_string)
		end

feature -- Visitor

	enter_subtree(visitor: EXPR_VISITOR; depth: INTEGER) is
			-- perform action at start of block for this node
		do
			visitor.start_expr_binary_operator (Current, depth)
		end

	exit_subtree(visitor: EXPR_VISITOR; depth: INTEGER) is
			-- perform action at end of block for this node
		do
			visitor.end_expr_binary_operator (Current, depth)
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
--| The Original Code is adl_expr_binary_operator.e.
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
