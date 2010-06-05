indexing
	component:   "openEHR Archetype Project"
	description: "leaf OBJECT item in an dADL parse tree"
	keywords:    "test, ADL"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2003, 2004 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/common_libs/src/structures/data_tree/dt_object_leaf.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

deferred class DT_OBJECT_LEAF

inherit
	DT_OBJECT_ITEM
		redefine
			representation, default_create
		end

feature -- Initialisation

	default_create is
			-- create with unknown type
		do
			create rm_type_name.make(0)
			rm_type_name.append(Unknown_type_name)
		end

feature -- Access

	value: ANY is
			-- data item of this node
		deferred
		end
	
feature -- Status Report

	is_leaf: BOOLEAN is True
		
feature -- Representation

	representation: OG_OBJECT_LEAF
	
feature -- Conversion

	as_object(a_type_id: INTEGER): ANY is
			-- make an object whose classes and attributes correspond to the structure 
			-- of this DT_OBJECT
		do	
			Result := value
		end

feature -- Output

	as_string: STRING is
		deferred
		ensure
			Result_exists: Result /= Void
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
