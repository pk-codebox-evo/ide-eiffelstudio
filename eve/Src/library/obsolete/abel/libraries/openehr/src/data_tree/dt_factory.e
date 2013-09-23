note
	component:   "openEHR Archetype project"
	description: "Factory class for Data Tree nodes"
	keywords:    "Data Tree"
	author:      "thomas.beale@oceaninformatics.com"
	support:     "http://www.openehr.org/issues/browse/AWB"
	copyright:   "Copyright (c) 2010 openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: https://svn.origo.ethz.ch/abel/trunk/libraries/openehr/src/data_tree/dt_factory.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class DT_FACTORY

inherit
	DT_TYPES

feature -- Access

	create_complex_object_node (a_parent: attached DT_ATTRIBUTE_NODE; a_node_id: detachable STRING): attached DT_COMPLEX_OBJECT_NODE
		require
			a_node_id_valid: attached a_node_id implies not a_node_id.is_empty
		do
			if attached a_node_id then
				create Result.make_identified(a_node_id)
			else
				create Result.make_anonymous
			end
			a_parent.put_child(Result)
		end

	create_attribute_node (a_parent: attached DT_COMPLEX_OBJECT_NODE; a_rel_name: attached STRING; is_multiple: BOOLEAN): attached DT_ATTRIBUTE_NODE
			-- create a rel_node with a simple name like "text" or "description"
			-- is_multiple flag indicates if multiple cardinality
		do
			if is_multiple then
				create Result.make_multiple(a_rel_name)
			else
				create Result.make_single(a_rel_name)
			end
			a_parent.put_attribute(Result)
		end

	create_dt_primitive_object (a_parent: attached DT_ATTRIBUTE_NODE; an_item: attached ANY; a_node_id: detachable STRING): attached DT_PRIMITIVE_OBJECT
			-- an_item must be STRING, INTEGER, REAL, DOUBLE, BOOLEAN, CHARACTER,
			-- DATE, TIME, DATE_TIME, DATE_TIME_DURATION
		require
			an_item_valid: has_dt_primitive_atomic_type(an_item)
			a_node_id_valid: attached a_node_id implies not a_node_id.is_empty
		do
			if attached a_node_id then
				create Result.make_identified(an_item, a_node_id)
			else
				create Result.make_anonymous(an_item)
			end
			a_parent.put_child(Result)
		end

	create_primitive_object_list (a_parent: attached DT_ATTRIBUTE_NODE; an_item: attached LIST [ANY]; a_node_id: detachable STRING): attached DT_PRIMITIVE_OBJECT_LIST
			-- an_item must conform to LIST of STRING, INTEGER, REAL, DOUBLE, BOOLEAN, CHARACTER,
			-- DATE, TIME, DATE_TIME, DATE_TIME_DURATION
		require
			an_item_valid: has_dt_primitive_sequence_type(an_item)
			a_node_id_valid: attached a_node_id implies not a_node_id.is_empty
		do
			if attached a_node_id then
				create Result.make_identified(an_item, a_node_id)
			else
				create Result.make_anonymous(an_item)
			end
			a_parent.put_child(Result)
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
--| The Original Code is dadl_factory.e.
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
