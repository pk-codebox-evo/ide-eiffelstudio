note
	component:   "openEHR Archetype Project"
	description: "Serialise DADL archetype to any syntax format"
	keywords:    "test, DADL"
	author:      "Thomas Beale"
	support:     "ETHZ Abel project <http://abel.origo.ethz.ch/issues>"
	copyright:   "Copyright (c) 2003-2011 Ocean Informatics Pty Ltd <http://www.oceaninformatics.com>"
	license:     "See notice at bottom of class"

	file:        "$URL: https://svn.origo.ethz.ch/abel/trunk/libraries/openehr/src/dadl_syntax/serialiser/dadl_syntax_serialiser.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class DADL_SYNTAX_SERIALISER

inherit
	DT_SERIALISER

	DADL_TOKENS
		export
			{NONE} all
		end

	DT_TYPES
		export
			{NONE} all
		end

create
	make

feature -- Visitor

	start_complex_object_node(a_node: DT_COMPLEX_OBJECT_NODE; depth: INTEGER)
			-- start serialising a DT_COMPLEX_OBJECT_NODE
		do
			if not a_node.is_root and then a_node.parent.is_multiple then
				last_result.append(create_indent(depth//2 + multiple_attr_count))
			end
			if a_node.is_addressable then
				last_result.append(apply_style("[%"" + clean (a_node.node_id) + "%"]", STYLE_IDENTIFIER))
				last_result.append(format_item(FMT_SPACE))
				last_result.append(apply_style(symbol(SYM_EQ), STYLE_OPERATOR) + format_item(FMT_SPACE))
			end

			-- output type information
			if a_node.is_typed or full_type_marking_on then
				last_result.append("(" + a_node.rm_type_name + ")" + format_item(FMT_SPACE) + symbol(SYM_START_DBLOCK) +
					format_item(FMT_NEWLINE))
			elseif not a_node.is_root then
				last_result.append(symbol(SYM_START_DBLOCK) + format_item(FMT_NEWLINE))
			end
		end

	end_complex_object_node(a_node: DT_COMPLEX_OBJECT_NODE; depth: INTEGER)
			-- end serialising a DT_COMPLEX_OBJECT_NODE
		do
			last_result.append(create_indent(depth//2 + multiple_attr_count))
			if not a_node.is_root or else a_node.is_typed or full_type_marking_on then
				last_result.append(symbol(SYM_END_DBLOCK) + format_item(FMT_NEWLINE))
			end
		end

	start_attribute_node(a_node: DT_ATTRIBUTE_NODE; depth: INTEGER)
			-- start serialising a DT_ATTRIBUTE_NODE
		do
			if not a_node.is_generic then
				last_result.append(create_indent(depth//2 + multiple_attr_count) +
						apply_style(a_node.rm_attr_name, STYLE_IDENTIFIER) +  format_item(FMT_SPACE))
				last_result.append(apply_style(symbol(SYM_EQ), STYLE_OPERATOR) + format_item(FMT_SPACE))
				if a_node.is_multiple then
					multiple_attr_count := multiple_attr_count + 1
					last_result.append(symbol(SYM_START_DBLOCK) + format_item(FMT_NEWLINE))
				end
			end
		end

	end_attribute_node(a_node: DT_ATTRIBUTE_NODE; depth: INTEGER)
			-- end serialising an DT_ATTRIBUTE_NODE
		do
			last_object_simple := False
			if not a_node.is_generic and a_node.is_multiple then
				multiple_attr_count := multiple_attr_count - 1
				last_result.append(create_indent(depth//2 + multiple_attr_count) + symbol(SYM_END_DBLOCK) + format_item(FMT_NEWLINE))
			end
		end

	start_primitive_object(a_node: DT_PRIMITIVE_OBJECT; depth: INTEGER)
			-- start serialising a DT_PRIMITIVE_OBJECT
		do
			start_object_leaf(a_node, depth)
			last_object_simple := True
		end

	end_primitive_object(a_node: DT_PRIMITIVE_OBJECT; depth: INTEGER)
			-- end serialising a DT_PRIMITIVE_OBJECT
		do
			last_result.append(symbol(SYM_END_DBLOCK) + format_item(FMT_NEWLINE))
		end

	start_primitive_object_list(a_node: DT_PRIMITIVE_OBJECT_LIST; depth: INTEGER)
			-- start serialising an DT_PRIMITIVE_OBJECT_LIST
		do
			start_object_leaf(a_node, depth)
			last_object_simple := True
		end

	end_primitive_object_list(a_node: DT_PRIMITIVE_OBJECT_LIST; depth: INTEGER)
			-- end serialising an DT_PRIMITIVE_OBJECT_LIST
		do
			last_result.append(symbol(SYM_END_DBLOCK) + format_item(FMT_NEWLINE))
		end

	start_primitive_object_interval(a_node: DT_PRIMITIVE_OBJECT_INTERVAL; depth: INTEGER)
			-- start serialising a DT_PRIMITIVE_OBJECT_INTERVAL
		do
			start_object_leaf(a_node, depth)
			last_object_simple := True
		end

	end_primitive_object_interval(a_node: DT_PRIMITIVE_OBJECT_INTERVAL; depth: INTEGER)
			-- end serialising a DT_PRIMITIVE_OBJECT_INTERVAL
		do
			last_result.append(symbol(SYM_END_DBLOCK) + format_item(FMT_NEWLINE))
		end

	start_object_reference(a_node: DT_OBJECT_REFERENCE; depth: INTEGER)
			-- start serialising a DT_OBJECT_REFERENCE
		do
			start_object_leaf(a_node, depth)
			last_object_simple := True
		end

	end_object_reference(a_node: DT_OBJECT_REFERENCE; depth: INTEGER)
			-- end serialising a DT_OBJECT_REFERENCE
		do
			last_result.append(symbol(SYM_END_DBLOCK) + format_item(FMT_NEWLINE))
		end

	start_object_reference_list(a_node: DT_OBJECT_REFERENCE_LIST; depth: INTEGER)
			-- start serialising a DT_OBJECT_REFERENCE_LIST
		do
			start_object_leaf(a_node, depth)
			last_object_simple := True
		end

	end_object_reference_list(a_node: DT_OBJECT_REFERENCE_LIST; depth: INTEGER)
			-- end serialising a DT_OBJECT_REFERENCE_LIST
		do
			last_result.append(symbol(SYM_END_DBLOCK) + format_item(FMT_NEWLINE))
		end

feature {NONE} -- Implementation

	multiple_attr_count: INTEGER
			-- counter for how many multiple attributes at the current point

	last_object_simple: BOOLEAN
			-- True if last object traversed was an OBJECT_SIMPLE

	start_object_leaf(a_node: DT_OBJECT_LEAF; depth: INTEGER)
			-- start serialising a DT_OBJECT_LEAF
		local
			s: STRING
		do
			if a_node.parent.is_multiple then
				last_result.append(create_indent(depth//2 + multiple_attr_count) + apply_style("[%"" + clean (a_node.node_id) + "%"]", STYLE_IDENTIFIER))
				last_result.append(format_item(FMT_SPACE))
				last_result.append(apply_style(symbol(SYM_EQ), STYLE_OPERATOR) + format_item(FMT_SPACE))
			end

			if attached {DT_PRIMITIVE_OBJECT} a_node as a_dt_p_o then
				-- output type specifier
				if full_type_marking_on or else not dadl_inferred_primitive_atomic_types.has (dynamic_type (a_node.value)) then
					last_result.append("(" + a_node.rm_type_name + ")" + format_item(FMT_SPACE))
				end
				last_result.append(symbol(SYM_START_DBLOCK))
				s := a_dt_p_o.clean_as_string(agent clean)

			elseif attached {DT_PRIMITIVE_OBJECT_LIST} a_node as a_dt_p_o_l then
				-- output type specifier
				if full_type_marking_on or else not is_dadl_inferred_primitive_sequence_type(dynamic_type (a_node.value)) then
					last_result.append("(" + a_node.rm_type_name + ")" + format_item(FMT_SPACE))
				end
				last_result.append(symbol(SYM_START_DBLOCK))
				s := a_dt_p_o_l.clean_as_string(agent clean)

			elseif attached {DT_PRIMITIVE_OBJECT_INTERVAL} a_node as a_dt_p_o_i then
				-- output type specifier
				if full_type_marking_on or else not dadl_inferred_primitive_interval_types.has(dynamic_type (a_node.value)) then
					last_result.append("(" + a_node.rm_type_name + ")" + format_item(FMT_SPACE))
				end
				last_result.append(symbol(SYM_START_DBLOCK))
				s := a_dt_p_o_i.as_string

			else -- can only be DT_OBJECT_REFERENCE or DT_OBJECT_REFERENCE_LIST; no typing info required
				s := a_node.as_string
			end

			last_result.append(apply_style(s, STYLE_VALUE))
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
--| The Original Code is dadl_serialiser.e.
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
