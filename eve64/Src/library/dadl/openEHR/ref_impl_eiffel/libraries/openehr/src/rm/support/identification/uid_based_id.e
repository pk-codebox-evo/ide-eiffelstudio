indexing
	component:   "openEHR Support Reference Model"
	
	description: "[
				 Abstract model of UID-based identifiers consisting of a root part and an optional extension; 
				 lexical form: root '::' extension
			     ]"
	keywords:    "object identifiers"

	design:      "openEHR Common Reference Model 1.4.1"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2007 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://svn.openehr.org/ref_impl_eiffel/TRUNK/libraries/openehr/src/rm/support/identification/hier_object_id.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

deferred class UID_BASED_ID

inherit
	OBJECT_ID
	
feature -- Definitions
	
	Extension_separator: STRING is "::"

feature -- Access

	root: UID is
			-- The identifier of the conceptual namespace in which the object exists, 
			-- within the identification scheme.  Returns the part to the left of the 
			-- first '::' separator, if any, or else the whole string.
		local
			end_pos: INTEGER
		do
			end_pos := value.substring_index(Extension_separator, 1) - 1
			if end_pos <= 0 then
				end_pos := value.count
			end
			Result := string_to_uid(value.substring (1, end_pos))
		end

	extension: STRING is
			-- Optional local identifier of the object within the context of the root identifier.
			-- Returns the part to the right of the first '::' separator if any, or else any empty String.
		require
			has_extension
		do
			Result := value.substring(value.substring_index(Extension_separator, 1) + 
						Extension_separator.count, value.count)
		ensure
			Result /= Void and then not Result.is_empty
		end

feature -- Status Report

	has_extension: BOOLEAN is
			-- True if there is a root part - at least one '.' in id before version part
		do
			Result := value.substring_index(Extension_separator, 1) > 0
		end

feature -- Output

	as_string: STRING is
			-- string form displayable for humans - e.g. ICD9;1989::M17(en-au)
		do
			create Result.make(0)
			Result.append(root.value)
			if has_extension then
				Result.append(Extension_separator)
				Result.append(extension)
			end
		end

	as_canonical_string: STRING is
			-- standardised form of string guaranteed to contain all information
			-- in data item
		do
			create Result.make(0)
			Result.append("<root>" + root.value + "</root>")
			if has_extension then
				Result.append("<extension>" + extension + "</extension>")
			end
		end

feature {NONE} -- Implementation

	string_to_uid(s: STRING): UID is
			-- The identifier of the conceptual namespace in which the object exists, 
			-- within the identification scheme.  Returns the part to the left of the 
			-- first '::' separator, if any, or else the whole string.
		require
			string_valid: s /= Void and then not s.is_empty
		do
			create {UUID_EHR} Result.default_create
			if Result.valid_id (s) then
				create {UUID_EHR} Result.make(s)
			else	
				create {ISO_OID} Result.default_create
				if Result.valid_id (s) then			
					create {ISO_OID} Result.make(s)
				else
					create {INTERNET_ID} Result.default_create
					if Result.valid_id (s) then			
						create {INTERNET_ID} Result.make(s)
					else
						-- error
					end
				end
			end
		end

invariant
	Root_valid: root /= Void
	Extension_validity: extension /= Void
	Has_extension_validity: extension.is_empty xor has_extension	

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
--| The Original Code is uid_based_id.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2007
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
