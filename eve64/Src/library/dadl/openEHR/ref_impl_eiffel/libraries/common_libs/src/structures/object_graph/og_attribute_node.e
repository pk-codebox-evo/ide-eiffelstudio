indexing
	component:   "openEHR Archetype Project"
	description: "[
				 Attribute node in ADL parse tree. This class does not model a direct idea of 'is_multiple' because it can be used
				 to represent single attribute constraints which need multiple 'children' to represent the constraint.
				 ]"
	keywords:    "ADL"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.com>"
	copyright:   "Copyright (c) 2004 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/common_libs/src/structures/object_graph/og_attribute_node.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class OG_ATTRIBUTE_NODE

inherit
	OG_NODE
		rename
			make as make_og_node
		redefine
			parent, child_type, put_child, valid_child_for_insertion
		end

create
	make_single, make_multiple, make_generic

feature -- Definitions

	Generic_attr_name: STRING is "_items"
			-- name given to assumed multiple attribute of container types

feature -- Initialisation

	make_single (a_node_id: STRING; a_content_item: VISITABLE) is
			-- make an attribute representing a single-valued attribute in some model
		require
			Node_id_valid: a_node_id /= Void and then not a_node_id.is_empty
		do
			make_og_node(a_node_id, a_content_item)
		ensure
			Is_multiple: not is_multiple
		end

	make_multiple (a_node_id: STRING; a_content_item: VISITABLE) is
			-- make an attribute representing a multiple-valued (i.e. container) attribute in some model
		require
			Node_id_valid: a_node_id /= Void and then not a_node_id.is_empty
		do
			make_og_node(a_node_id, a_content_item)
			is_multiple := True
		ensure
			Is_multiple: is_multiple
		end

	make_generic (a_content_item: VISITABLE) is
			-- create with pseudo-node id indicating that it is an unnamed
			-- container attribute of a generic type
		do
			default_create
			node_id := Generic_attr_name.twin
			content_item := a_content_item
			is_generic := True
			is_multiple := True
		ensure
			Node_id_set: node_id.is_equal(Generic_attr_name)
			Is_generic: is_generic
			Is_multiple: is_multiple
		end

feature -- Access

	parent: OG_OBJECT_NODE

feature -- Status Report

	is_multiple: BOOLEAN
			-- True if this node logically represents a container attribute. Note that even if is_multiple is False,
			-- there can be multiple children, because for constraint representation, these correspond to alternatives, not
			-- multiple concurrent members.

	is_generic: BOOLEAN
			-- True if this attribute is a created pseudo attribute
			-- representing an unnamed attribute in a generic class like List<T>

	is_addressable: BOOLEAN is True
			-- True if this node has a non-anonymous node_id

	is_object_node: BOOLEAN is False

	valid_child_for_insertion(a_node: like child_type):BOOLEAN is
			-- valid OBJ children of a REL node might not all be unique
		do
			Result := not children_ordered.has(a_node)
		end

feature -- Status Setting

	set_multiple is
			-- set `is_multiple' True (sometimes discovered after make is done)
		do
			is_multiple := True
		end

feature -- Modification

	put_child(obj_node: like child_type) is
			-- put a new child node
			-- if new child is an OBJECT_NODE id is already known in children, generate a unique id for it
		local
			new_id: STRING
		do
			if children.has(obj_node.node_id) then
				duplicate_child_id_count := duplicate_child_id_count + 1
				new_id := obj_node.node_id + "_#" + duplicate_child_id_count.out
				obj_node.set_node_id(new_id)
			end
			precursor(obj_node)
		end

feature {NONE} -- Implementation

	child_type: OG_OBJECT
			-- relationship target type

	duplicate_child_id_count: INTEGER
			-- cumulative count of children with 'unknown' ids - used to generate unique ids

invariant
	Generic_validity: not (is_generic xor node_id.is_equal(Generic_attr_name))

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
--| The Original Code is cadl_rel_node.e.
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
