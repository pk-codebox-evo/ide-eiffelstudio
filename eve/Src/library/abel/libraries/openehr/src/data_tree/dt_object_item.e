note
	component:   "openEHR Archetype project"
	description: "Any object node in an Data Tree"
	keywords:    "Data Tree"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2003-2010 openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: https://svn.origo.ethz.ch/abel/trunk/libraries/openehr/src/data_tree/dt_object_item.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

deferred class DT_OBJECT_ITEM

inherit
	DT_ITEM
		undefine
			is_equal
		redefine
			parent, representation
		end

	COMPARABLE

feature -- Definitions

	Anonymous_node_id: STRING = "unknown"

	Unknown_type_name: STRING = "UNKNOWN"

feature -- Access

	node_id: attached STRING
			-- locally unique node id
		do
			Result := representation.node_id
		end

	parent: DT_ATTRIBUTE_NODE
			-- parent of all object types must be an attribute node

	rm_type_name: attached STRING
			-- reference model type name of object to instantiate - can be inferred
			-- from object model, or set from parsing dADL text

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- compare based on node_id
		do
			Result := node_id < other.node_id
		end

feature -- Status Report

	is_typed: BOOLEAN
			-- True if this node has a known type
		do
			Result := not rm_type_name.is_equal(Unknown_type_name)
		end

feature -- Modification

	set_node_id (a_node_id: attached STRING)
			-- set node id
		require
			Node_id_valid: not a_node_id.is_empty
		do
			representation.set_node_id(a_node_id)
		end

	set_type_name (a_type_name: attached STRING)
			-- set type name
		require
			Type_name_valid: not a_type_name.is_empty
		do
			rm_type_name := a_type_name
		end

feature -- Conversion

	as_object (a_type_id: INTEGER; make_args: ARRAY[ANY]): attached ANY
			-- make an object of type `a_type_id' whose classes and attributes correspond to the structure
			-- of this DT_OBJECT
		require
			a_type_id >= 0
		deferred
		ensure
			as_object_ref = Result
		end

	as_object_ref: ANY
			-- cached reference to object created from last call to as_object or as_object_from_string

feature -- Representation

	representation: OG_OBJECT

invariant
	Type_name_valid: not rm_type_name.is_empty
	Node_id_valid: not node_id.is_empty

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
--| The Original Code is dadl_object_item.e.
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
