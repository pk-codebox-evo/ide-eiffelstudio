note
	component:   "openEHR Archetype Project"
	description: "node in ADL parse tree"
	keywords:    "test, ADL"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.com>"
	copyright:   "Copyright (c) 2003-2008 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/BRANCHES/specialisation/libraries/openehr/src/am/archetype/constraint_model/c_attribute.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class C_ATTRIBUTE

inherit
	ARCHETYPE_CONSTRAINT
		redefine
			default_create, parent, representation, path
		end

	ARCHETYPE_TERM_CODE_TOOLS
		export {NONE}
			all
		undefine
			default_create
		end

	C_COMMON
		export {NONE}
			all
		undefine
			default_create
		end

create
	make_single, make_multiple

feature -- Initialisation

	default_create
			--
		do
			create children.make (0)
		end

	make_single(a_name: STRING; an_existence: MULTIPLICITY_INTERVAL)
			-- make representing a single-valued attribute with attr name and optional existence
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			default_create
			create representation.make_single (a_name, Current)
			existence := an_existence
		ensure
			Is_single: not is_multiple
			Existence_set: existence = an_existence
		end

	make_multiple(a_name: STRING; an_existence: MULTIPLICITY_INTERVAL; a_cardinality: CARDINALITY)
			-- make representing a container attribute with attr name & optional existence and cardinality
		require
			a_name_valid: a_name /= Void and then not a_name.is_empty
		do
			default_create
			create representation.make_multiple (a_name, Current)
			existence := an_existence
			cardinality := a_cardinality
		ensure
			Is_multiple: is_multiple
			Existence_set: existence = an_existence
			Cardinality_set: cardinality = a_cardinality
		end

feature -- Access

	rm_attribute_name: STRING
			-- name of this attribute in reference model
		do
			Result := representation.node_id
		end

	rm_attribute_path: STRING
			-- path of this attribute with respect to owning C_OBJECT,
			-- including differential path where applicable
		do
			Result := representation.node_key
		end

	children: ARRAYED_LIST [C_OBJECT]

	existence: MULTIPLICITY_INTERVAL

	cardinality: CARDINALITY

	path: STRING
			-- take account of differential path if it exists
		do
			if has_differential_path then
				Result := rm_attribute_path
			else
				Result := precursor
			end
		end

	differential_path: STRING
			-- if set, contains the path to this attribute, excluding the name of this attribute, allowing this
			-- C_ATTRIBUTE to stand as a 'path-compressed' replacement for a string of C_COMPLEX_OBJECT/
			-- C_ATTRIBUTE constraint objects
		do
			if representation.has_differential_path then
				Result := representation.differential_path.as_string
			end
		end

	occurrences_total_range: MULTIPLICITY_INTERVAL
			-- calculate total possible cardinality range based on occurrences of all children
			-- only valid on flat archetypes
		require
			all_children_have_occurrences: all_children_have_occurrences
		local
			a_lower, an_upper: INTEGER
			an_upper_unbounded: BOOLEAN
		do
			from children.start until children.off loop
				a_lower := a_lower + children.item.occurrences.lower
				an_upper_unbounded := children.item.occurrences.upper_unbounded
				if not an_upper_unbounded then
					an_upper := an_upper + children.item.occurrences.upper
				end
				children.forth
			end

			if an_upper_unbounded then
				create Result.make_upper_unbounded (a_lower)
			else
				create Result.make_bounded (a_lower, an_upper)
			end
		ensure
			Result_attached: Result /= Void
		end

	parent: C_COMPLEX_OBJECT

	child_count: INTEGER
			-- number of children; 0 if any_allowed is True
		do
			Result := children.count
		end

	child_before(an_obj: C_OBJECT): C_OBJECT
			-- return child node before `an_obj' if there is one, else Void
		require
			Object_valid: an_obj /= Void and then has_child (an_obj)
		local
			pos: INTEGER
		do
			pos := children.index_of (an_obj, 1)
			if pos > 1 then
				Result := children.i_th (pos-1)
			end
		ensure
			has_result: Result /= Void implies has_child (Result)
		end

	child_after(an_obj: C_OBJECT): C_OBJECT
			-- return child node after `an_obj' if there is one, else Void
		require
			Object_valid: an_obj /= Void and then has_child (an_obj)
		local
			pos: INTEGER
		do
			pos := children.index_of (an_obj, 1)
			if pos < children.count then
				Result := children.i_th (pos+1)
			end
		ensure
			has_result: Result /= Void implies has_child (Result)
		end

	child_with_id (a_node_id: STRING): C_OBJECT
			-- find the child node with `a_node_id'
		require
			has_child_with_id (a_node_id)
		do
			from
				children.start
			until
				children.off or children.item.node_id.is_equal (a_node_id)
			loop
				children.forth
			end
			Result := children.item
		ensure
			Result_exists: Result /= Void
		end

	children_matching_id (a_node_id: STRING): ARRAYED_LIST[C_OBJECT]
			-- find child nodes with node_ids that contain `a_node_id', e.g. 'at0013' would match
			-- nodes with ids 'at0013.1', 'at0013.2', 'at0013.1.5' and so on
		do
			create Result.make(0)
			from children.start until children.off loop
 				if children.item.node_id.has_substring (a_node_id) then
 					Result.extend (children.item)
 				end
				children.forth
			end
		ensure
			Result_exists: Result /= Void
		end

	child_with_rm_type_name (an_rm_type: STRING): C_OBJECT
			-- return a child node with rm_type_name = `an_rm_type'
		require
			Rm_type_valid: an_rm_type /= void and then has_child_with_rm_type_name(an_rm_type)
		do
			from
				children.start
			until
				children.off or children.item.rm_type_name.is_equal (an_rm_type)
			loop
				children.forth
			end
			Result := children.item
		end

feature -- Source Control

	specialisation_status (specialisation_level: INTEGER): SPECIALISATION_STATUS
			-- status of this node in the source text of this archetype with respect to the
			-- specialisation hierarchy. Values are: defined_here; redefined, added, unknown
		do
			create Result.make(ss_propagated)
		end

feature -- Status Report

	any_allowed: BOOLEAN
			-- Is any value allowed ('*' received in parsed input) - i.e. no children?
		do
			Result := children.is_empty
		end

	has_children: BOOLEAN
			-- True if any object nodes below this node
		do
			Result := children.count > 0
		end

	is_relationship: BOOLEAN
			-- (in the UML sense) - True if attribute target type is not a primitive data type
		require
			has_children: not any_allowed
		local
			a_prim: C_PRIMITIVE_OBJECT
		do
			a_prim ?= children.first
			Result := a_prim = Void
		end

	is_multiple: BOOLEAN
			-- True if this attribute has multiple cardinality
		do
			Result := representation.is_multiple
		end

	is_single: BOOLEAN
			-- True if this attribute is a single-valued attribute, i.e. not a container
		do
			Result := not representation.is_multiple
		end

	is_ordered: BOOLEAN
			-- True if this attribute is multiple and ordered;
			-- if no cardinality, assume it is ordered; should really be checked in the RM schema
		do
			Result := is_multiple and then cardinality.is_ordered
		end

	is_prohibited: BOOLEAN
			-- True if occurrences set to {0} i.e. prohibited
		do
			Result := attached existence and existence.is_prohibited
		end

	has_differential_path: BOOLEAN
			-- True if this node has a contracted path
		do
			Result := differential_path /= Void
		end

	has_child_with_id (a_node_id: STRING): BOOLEAN
			-- has a child node with id a_node_id
		require
			Node_id_valid: a_node_id /= void and then not a_node_id.is_empty
		do
			Result := representation.has_child_with_id (a_node_id)
		end

	has_child_with_rm_type_name (a_type_name: STRING): BOOLEAN
			-- has a child node with rm_type_name = `a_type_name'
		require
			Type_name_valid: a_type_name /= void and then not a_type_name.is_empty
		do
			from
				children.start
			until
				children.off or children.item.rm_type_name.is_equal (a_type_name)
			loop
				children.forth
			end
			Result := not children.off
		end

	has_child (a_node: C_OBJECT): BOOLEAN
			-- True if a_node is actually one of the children
		require
			Node_valid: a_node /= Void
		do
			Result := children.has (a_node)
		end

	all_children_have_occurrences: BOOLEAN
			-- True if all immediate child nodes have occurrences set
		do
			from children.start until children.off or children.item.occurrences = Void loop
				children.forth
			end
			Result := children.off
		end

feature -- Comparison

	node_congruent_to (other: like Current; an_rm_schema: SCHEMA_ACCESS): BOOLEAN
			-- True if this node on its own (ignoring any subparts) expresses the same constraints as `other'.
		do
			Result := existence = Void and ((is_single and other.is_single) or (is_multiple and other.is_multiple and cardinality = Void))
		end

	node_conforms_to (other: like Current; an_rm_schema: SCHEMA_ACCESS): BOOLEAN
			-- True if this node on its own (ignoring any subparts) expresses the same or narrower constraints as `other'.
			-- Returns False if any of the following is incompatible:
			--	cardinality
			--	existence
		do
			Result := existence_conforms_to (other) and ((is_single and other.is_single) or (is_multiple and cardinality_conforms_to (other)))
		end

	existence_conforms_to (other: like Current): BOOLEAN
			-- True if the existence of this node conforms to other.existence
		require
			other_exists: other /= Void
			other_is_flat: other.existence /= Void
		do
			Result := existence = Void or
					existence.equal_interval (other.existence) or
					other.existence.contains (existence)
		end

	cardinality_conforms_to (other: like Current): BOOLEAN
			-- True if the cardinality of this node conforms to other.cardinality
		require
			other_exists: other /= Void
			other_is_flat: other.cardinality /= Void
		do
			Result := cardinality = Void or
				cardinality.interval.equal_interval (other.cardinality.interval) or
				other.cardinality.contains (cardinality)
		end

feature -- Modification

	set_existence(an_interval: MULTIPLICITY_INTERVAL)
			-- set existence constraint on this relation - applies whether single or multiple
		require
			Interval_exists: an_interval /= Void
		do
			existence := an_interval
		end

	set_cardinality(a_cardinality: CARDINALITY)
			--
		require
			cardinality_exists: a_cardinality /= Void
		do
			cardinality := a_cardinality
		end

	remove_cardinality
		do
			cardinality := Void
		ensure
			cardinality = Void
		end

	remove_existence
		do
			existence := Void
		ensure
			existence = Void
		end

	set_differential_path(a_path: STRING)
			-- set `differential_path'
		require
			Path_valid: a_path /= Void and then not a_path.is_empty
		do
			representation.set_differential_path(create {OG_PATH}.make_from_string (a_path))
		end

	clear_differential_path
			-- remove `differential_path'
		do
			representation.clear_differential_path
		end

	set_differential_path_to_here
			-- set `differential_path'
		require
			not has_differential_path
		do
			representation.set_differential_path(representation.parent.path)
			if not parent.is_root then
				reparent_to_root
			end
		ensure
			Differential_path_set: differential_path /= Void
		end

	put_child (an_obj: C_OBJECT)
			-- put a new child node
		require
			Object_valid: an_obj /= Void and then valid_new_child (an_obj)
		do
			representation.put_child (an_obj.representation)
			children.extend (an_obj)
			an_obj.set_parent(Current)
		end

	put_child_left(an_obj, before_obj: C_OBJECT)
			-- insert a new child node before another node
		require
			Object_valid: an_obj /= Void and then valid_new_child (an_obj)
			Before_obj_valid: before_obj /= Void and then has_child (before_obj)
		do
			representation.put_child_left(an_obj.representation, before_obj.representation)
			children.go_i_th (children.index_of (before_obj, 1))
			children.put_left (an_obj)
			an_obj.set_parent(Current)
		end

	put_child_right(an_obj, after_obj: C_OBJECT)
			-- insert a new child node after another node
		require
			Object_valid: an_obj /= Void and then valid_new_child (an_obj)
			After_obj_valid: after_obj /= Void and then has_child (after_obj)
		do
			representation.put_child_right(an_obj.representation, after_obj.representation)
			children.go_i_th (children.index_of (after_obj, 1))
			children.put_right(an_obj)
			an_obj.set_parent(Current)
		end

	put_sibling_child (an_obj: C_OBJECT)
			-- put a new child node after any sibling that is already there
			-- 'sibling' is defined as an object with a node_id with the same parent as the node_id of `an_obj';
			-- usually it is a specialised node id with a common parent, but may be a top level id
			-- put `an_obj' at end if no sibling found
		require
			Object_valid: an_obj /= Void and then valid_new_child (an_obj)
		local
			parent_id: STRING
			siblings: ARRAYED_LIST [C_OBJECT]
		do
			parent_id := specialisation_parent_from_code (an_obj.node_id)
			siblings := children_matching_id (parent_id)
			if not siblings.is_empty then
				put_child_right(an_obj, siblings.last)
			else
				put_child (an_obj)
			end
		end

	replace_child_by_id (an_obj: C_OBJECT; an_id: STRING)
			-- replace node with id `an_id' by `an_obj'
		require
			Object_valid: an_obj /= Void and then valid_replacement_child (an_obj)
			Id_valid: an_id /= Void and then has_child_with_id (an_id)
		do
			children.go_i_th (children.index_of (child_with_id (an_id), 1))
			children.replace (an_obj)
			representation.replace_child_by_id (an_obj.representation, an_id)
			an_obj.set_parent(Current)
		end

	replace_child_by_rm_type_name(an_obj: C_OBJECT)
			-- replace node with rm_type_name `a_type_name' by `an_obj'
		require
			Attribute_validity: is_single
			Object_valid: an_obj /= Void and then valid_replacement_child (an_obj)
		do
			representation.replace_child_by_id (an_obj.representation, child_with_rm_type_name(an_obj.rm_type_name).representation.node_key)
			children.go_i_th (children.index_of (child_with_rm_type_name(an_obj.rm_type_name), 1))
			children.replace (an_obj)
			an_obj.set_parent(Current)
		end

	remove_child (an_obj: C_OBJECT)
			-- remove an existing child node
		require
			Object_valid: an_obj /= Void and then has_child (an_obj)
		do
			representation.remove_child_by_id (an_obj.node_id)
			children.prune_all(an_obj)
		end

	remove_child_by_id (an_id: STRING)
			-- remove an existing child node
		require
			Id_valid: an_id /= Void and then has_child_with_id (an_id)
		local
			an_obj: C_OBJECT
		do
			an_obj := child_with_id (an_id)
			representation.remove_child_by_id (an_id)
			children.prune_all(an_obj)
		end

	replace_node_id (old_id, new_id: STRING)
			-- replace old_id with new_id in relevant child node, and also in attribute parent list
		require
			Old_id_valid: old_id /= Void and then has_child_with_id (old_id)
			New_id_valid: new_id /= Void and then not new_id.is_empty
		do
			representation.replace_node_id (old_id, new_id)
			representation.child_with_id (new_id).set_node_id (new_id)
		ensure
			has_child_with_id (new_id)
		end

	overlay_differential(a_flat_obj, diff_obj: C_OBJECT; an_rm_schema: SCHEMA_ACCESS)
			-- apply any differences from `diff_obj' to `an_obj' node including node_id
		require
			Flat_obj_valid: has_child (a_flat_obj)
			Diff_obj_valid: diff_obj /= Void and then diff_obj.node_conforms_to (a_flat_obj, an_rm_schema)
		do
			if not a_flat_obj.node_id.is_equal(diff_obj.node_id) then
				representation.replace_node_id (a_flat_obj.node_id, diff_obj.node_id)
			end
			a_flat_obj.overlay_differential (diff_obj, an_rm_schema)
		end

feature -- Validation

	valid_new_child (an_obj: C_OBJECT): BOOLEAN
			-- test an_obj for addition as a new child node (including for replacement)
		require
			Object_exists: an_obj /= Void
		do
			Result := valid_child (an_obj)
			if Result then
				if is_single then
					Result := (an_obj.is_addressable and not has_child_with_id (an_obj.node_id))
						or not has_child_with_rm_type_name(an_obj.rm_type_name)
				else
					Result := not has_child_with_id (an_obj.node_id)
				end
			end
		end

	valid_replacement_child (an_obj: C_OBJECT): BOOLEAN
			-- test an_obj for addition as a new child node (including for replacement)
		require
			Object_exists: an_obj /= Void
		do
			Result := valid_child (an_obj)
			if Result then
				if is_single then
					Result := not an_obj.is_addressable or has_child_with_id (an_obj.node_id)
				else
					Result := has_child_with_id (an_obj.node_id)
				end
			end
		end

	valid_child (an_obj: C_OBJECT): BOOLEAN
			-- test an_obj for validity as a child node
		do
			Result := not has_child (an_obj)
			if Result then
				if is_single then
					Result := an_obj.occurrences = Void or else (not an_obj.occurrences.upper_unbounded and an_obj.occurrences.upper <= 1)
				else
					Result := an_obj.occurrences = Void or cardinality = Void or else
						(cardinality.interval.upper_unbounded or (not an_obj.occurrences.upper_unbounded and
						cardinality.interval.upper >= an_obj.occurrences.upper)) and
						an_obj.is_addressable
				end
			end
		end

feature -- Representation

	representation: attached OG_ATTRIBUTE_NODE

feature -- Serialisation

	enter_subtree(visitor: C_VISITOR; depth: INTEGER)
			-- perform serialisation at start of block for this node
		do
			visitor.start_c_attribute(Current, depth)
		end

	exit_subtree(visitor: C_VISITOR; depth: INTEGER)
			-- perform serialisation at end of block for this node
		do
			visitor.end_c_attribute(Current, depth)
		end

feature {NONE} -- Implementation

	reparent_to_root
			-- reparent this node to the root node, removing intervening orphaned nodes on the way
		local
			p: like parent
			csr: ARCHETYPE_CONSTRAINT
		do
			p := parent
			debug("compress")
				io.put_string("%T%Tabout to REPARENT attribute Current (" + rm_attribute_path + ") from parent object " + p.rm_type_name + "[" + p.node_id + "]%N")
			end
			p.remove_attribute (Current)
			from csr := p until csr.parent = Void loop
				if attached {C_COMPLEX_OBJECT} csr.parent as cco and attached {C_ATTRIBUTE} csr as ca then
					if not ca.has_children then
						debug("compress")
							io.put_string("%T%Tabout to remove ORPHAN attribute " + ca.rm_attribute_name + " from object " + cco.rm_type_name + "[" + cco.node_id + "]%N")
						end
						cco.remove_attribute (ca)
					end
				elseif attached {C_ATTRIBUTE} csr.parent as ca2 and attached {C_COMPLEX_OBJECT} csr as cco2 then
					if not cco2.has_attributes then
						debug("compress")
							io.put_string("%T%Tabout to remove ORPHAN object " + cco2.rm_type_name + "[" + cco2.node_id + "] from attribute " + ca2.rm_attribute_name + "%N")
						end
						ca2.remove_child (cco2)
					end
				end
				csr := csr.parent
			end
			if attached {C_COMPLEX_OBJECT} csr as cco3 then
				debug("compress")
					io.put_string("%T%Tabout to put REPARENTED attribute Current (" + rm_attribute_path + ") on ROOT object " + cco3.rm_type_name + "[" + cco3.node_id + "]%N")
				end
				cco3.put_attribute (Current)
			end
		end

invariant
	Rm_attribute_name_valid: rm_attribute_name /= Void and then not rm_attribute_name.is_empty
	Children_validity: children /= Void
	Any_allowed_validity: any_allowed xor not children.is_empty
--	Children_occurrences_validity: cardinality /= Void implies cardinality.interval.contains (occurrences_total_range)
	Differential_path_valid: differential_path /= Void implies not differential_path.is_empty
	Has_differential_path_valid: differential_path = Void xor has_differential_path

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
