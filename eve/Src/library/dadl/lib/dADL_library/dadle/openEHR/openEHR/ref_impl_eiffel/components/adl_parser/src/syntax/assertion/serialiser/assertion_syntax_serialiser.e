note
	component:   "openEHR Archetype Project"
	description: "[
			 Serialise assertion to any syntax format, i.e. where the
			 output reflects the tree hierarchy of the parse tree inline - nodes
			 are presented in the order of the tree traversal, and the semantics 
			 of the tree are output as language syntax keywords, symbols etc.
	             ]"
	keywords:    "serialiser, assertion"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2005 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/BRANCHES/specialisation/components/adl_parser/src/syntax/assertion/serialiser/assertion_syntax_serialiser.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class ASSERTION_SYNTAX_SERIALISER

inherit
	ASSERTION_SERIALISER

	CADL_TOKENS
		export
			{NONE} all
		end

create
	make

feature -- Modification

	start_assertion(invs: ARRAYED_LIST[ASSERTION]; depth: INTEGER)
			-- start serialising an ASSERTION
		do
			from
				invs.start
			until
				invs.off
			loop
				last_result.append (create_indent(depth+1))
				if invs.item.tag /= Void then
					last_result.append (invs.item.tag + ": ")
				end
				last_result.append (invs.item.expression.as_string + format_item(FMT_NEWLINE))
				invs.forth
			end
		end

	end_assertion(a_node: ARRAYED_LIST[ASSERTION]; depth: INTEGER)
			-- end serialising an ASSERTION
		do
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
--| The Original Code is cadl_serialiser.e.
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
