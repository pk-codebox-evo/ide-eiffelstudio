note
	component:   "openEHR Archetype project"
	description: "[
				 Attribute node in ADL parse tree. This class does not model a direct idea of 'is_multiple' because it can be used
				 to represent single attribute constraints which need multiple 'children' to represent the constraint.
				 ]"
	keywords:    "object graph"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2004-2010 openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: https://svn.origo.ethz.ch/abel/trunk/libraries/openehr/src/object_graph/og_attribute_node.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class OG_ATTRIBUTE_NODE

inherit
	OG_NODE
		rename
			make as make_og_node
		redefine
			parent, child_type, put_child, put_child_left, put_child_right, valid_child_for_insertion, node_key
		end

create
	make_single, make_multiple, make_generic

feature -- Definitions

	Generic_attr_name: STRING = "_items"
			-- name given to assumed multiple attribute of container types

feature -- Initialisation

	make_single (a_node_id: attached STRING; a_content_item: VISITABLE)
			-- make an attribute representing a single-valued attribute in some model
		require
			Node_id_valid: not a_node_id.is_empty
		do
			make_og_node(a_node_id, a_content_item)
		ensure
			Is_multiple: not is_multiple
		end

	make_multiple (a_node_id: attached STRING; a_content_item: VISITABLE)
			-- make an attribute representing a multiple-valued (i.e. container) attribute in some model
		require
			Node_id_valid: not a_node_id.is_empty
		do
			make_og_node(a_node_id, a_content_item)
			is_multiple := True
		ensure
			Is_multiple: is_multiple
		end

	make_generic (a_content_item: VISITABLE)
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

	differential_path: OG_PATH
			-- if set, contains the path to this attribute, excluding the name of this attribute, allowing this
			-- OG_ATTRIBUTE_NODE to stand as a 'path-compressed' replacement for a string of OG_OBJECT_NODE/
			-- OG_ATTRIBUTE_NODE objects. Only valid in differential archetypes and templates.

	node_key: STRING
			-- uses differential path if it exists
		do
			if has_differential_path then
				Result := differential_path.as_string
				if not differential_path.is_root then
					Result.append_character({OG_PATH}.segment_separator)
				end
				Result.append(node_id)
			else
				Result := node_id
			end
		end

feature -- Status Report

	is_multiple: BOOLEAN
			-- True if this node logically represents a container attribute. Note that even if is_multiple is False,
			-- there can be multiple children, because for constraint representation, these correspond to alternatives, not
			-- multiple concurrent members.

	is_single: BOOLEAN
			-- True if this node logically represents a single-valued attribute.
		do
			Result := not is_multiple
		end

	is_generic: BOOLEAN
			-- True if this attribute is a created pseudo attribute
			-- representing an unnamed attribute in a generic class like List<T>

	is_addressable: BOOLEAN = True
			-- True if this node has a non-anonymous node_id

	is_object_node: BOOLEAN = False

	has_differential_path: BOOLEAN
			-- True if this node has a differential path
		do
			Result := differential_path /= Void
		end

	valid_child_for_insertion (a_node: like child_type): BOOLEAN
			-- valid OBJ children of a REL node might not all be unique
		do
			Result := not children_ordered.has(a_node)
		end

feature -- Status Setting

	set_multiple
			-- set `is_multiple' True (sometimes discovered after make is done)
		do
			is_multiple := True
		end

	set_generic
			-- set `is_generic' True (sometimes discovered after make is done)
		do
			is_generic := True
		end

feature -- Modification

	put_child(obj_node: attached like child_type)
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

	put_child_left(obj_node, before_obj_node: attached like child_type)
			-- insert a new child node before another object node
			-- if new child is an OBJECT_NODE id is already known in children, generate a unique id for it
		local
			new_id: STRING
		do
			if children.has(obj_node.node_id) then
				duplicate_child_id_count := duplicate_child_id_count + 1
				new_id := obj_node.node_id + "_#" + duplicate_child_id_count.out
				obj_node.set_node_id(new_id)
			end
			precursor(obj_node, before_obj_node)
		end

	put_child_right(obj_node, after_obj_node: attached like child_type)
			-- insert a new child node before another object node
			-- if new child is an OBJECT_NODE id is already known in children, generate a unique id for it
		local
			new_id: STRING
		do
			if children.has(obj_node.node_id) then
				duplicate_child_id_count := duplicate_child_id_count + 1
				new_id := obj_node.node_id + "_#" + duplicate_child_id_count.out
				obj_node.set_node_id(new_id)
			end
			precursor(obj_node, after_obj_node)
		end

	set_differential_path(a_path: attached OG_PATH)
			-- set `differential_path'
		do
			differential_path := a_path
			if parent /= Void then
				parent.replace_node_id (node_id, node_key)
			end
		ensure
			Compessed_path_set: differential_path = a_path
			Parent_has_child: not is_root implies parent.child_with_id (node_key) = Current
			Differential_path_flag_set: has_differential_path
		end

	clear_differential_path
			-- remove `differential_path'
		do
			differential_path := Void
		ensure
			not has_differential_path
		end

	set_differential_path_to_here
			-- compress the path and reparent current node to root node
		do
			differential_path := parent.path
			if not parent.is_root then
				reparent_to_root
			end
		ensure
			Differential_path_set: differential_path /= Void
		end

feature {NONE} -- Implementation

	child_type: OG_OBJECT
			-- relationship target type

	duplicate_child_id_count: INTEGER
			-- cumulative count of children with 'unknown' ids - used to generate unique ids

	reparent_to_root
			-- reparent this node to the root node, removing intervening orphaned nodes on the way
		local
			p: like parent
			csr: OG_NODE
		do
			p := parent
			p.remove_child (Current)
			from
				csr := p
			until
				csr.parent = Void
			loop
				if not csr.has_children then
					csr.parent.remove_child (csr)
				end
				csr := csr.parent
			end
			csr.put_child (Current)
		end

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
