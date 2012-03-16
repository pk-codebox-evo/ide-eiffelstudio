note
	component:   "openEHR Archetype project"
	description: "Leaf object node in an Data Tree"
	keywords:    "Data Tree"
	author:      "Thomas Beale <thomas.beale@oceaninformatics.com>"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2003-2010 openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: https://svn.origo.ethz.ch/abel/trunk/libraries/openehr/src/data_tree/dt_object_leaf.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

deferred class DT_OBJECT_LEAF

inherit
	DT_OBJECT_ITEM
		redefine
			representation, default_create
		end

	DADL_DEFINITIONS
		export
			{NONE} all
		undefine
			is_equal, default_create
		end

feature -- Initialisation

	make_identified (a_value: attached like value; a_node_id: attached STRING)
		require
			Node_id_valid: not a_node_id.is_empty
		do
			default_create
			create representation.make(a_node_id, Current)
			set_value(a_value)
		ensure
			is_addressable
		end

	make_anonymous (a_value: attached like value)
		do
			default_create
			create representation.make_anonymous(Current)
			set_value(a_value)
		ensure
			not is_addressable
		end

	default_create
			-- create with unknown type
		do
			rm_type_name := Unknown_type_name.twin
		end

feature -- Access

	value: ANY
			-- data item of this node
		deferred
		end

feature -- Status Report

	is_valid: BOOLEAN
			-- report on validity
		do
			create invalid_reason.make(0)
			invalid_reason.append(rm_type_name + ": ")
			if value = Void then
				invalid_reason.append("leaf value Void")
			else
				Result := True
			end
		end

feature -- Representation

	representation: OG_OBJECT_LEAF

feature -- Conversion

	as_object (a_type_id: INTEGER; make_args: ARRAY[ANY]): ANY
			-- make an object whose classes and attributes correspond to the structure
			-- of this DT_OBJECT
		do
			Result := value
			as_object_ref := Result
		end

feature -- Modification

	set_value (a_value: attached like value)
		deferred
		ensure
			Value_set: value = a_value
		end

feature -- Output

	as_string: attached STRING
		deferred
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
--| The Original Code is dadl_object_leaf.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2003-2009
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
