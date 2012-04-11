note
	component:   "openEHR Data Types"

	description: "[
			 Code phrase, possibly coordinated by terminology service; consisting of
			 a key, which is parsable into a terminology id and a code string,
			 representing the key within the terminology service for the intended
			 concept, from the given terminology.
			 The format of the key is:
			 	terminology_id SEP code_string
			 ]"
	keywords:    "text, data"

	requirements:"ISO 18308 TS V1.0 STR 4.2"
	design:      "openEHR Data Types Reference Model 1.7"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2000-2004 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/BRANCHES/specialisation/libraries/openehr/src/rm/data_types/text/code_phrase.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class CODE_PHRASE

inherit
	CANONICAL_FRAGMENT
		undefine
			is_equal, default_create
		redefine
			out
		end

	COMPARABLE
		undefine
			out
		redefine
			default_create
		end

create
	default_create,
	make, make_from_string, make_from_canonical_string

feature -- Definitions

	default_code_string: STRING = "000001"

	separator: STRING = "::"

feature -- Initialization

	default_create
		do
			create terminology_id.default_create
			code_string := default_code_string.twin
		ensure then
			Terminology_id_set: terminology_id /= Void
			Code_string_set: code_string.is_equal(default_code_string)
		end

	make_from_string(a_key: STRING)
			-- make from a string of the form terminology_id::code_string, e.g. ICD10(1998)::M10
			-- the form terminology_id:: is also allowable, in which case the default_code_string will
			-- be used
		require
			Key_valid: a_key /= Void and then not a_key.is_empty
		local
			sep_pos: INTEGER
		do
			sep_pos := a_key.substring_index(separator, 1)
			create terminology_id.make(a_key.substring(1, sep_pos-1))
			if a_key.count > sep_pos + 1 then
				code_string := a_key.substring(sep_pos+separator.count, a_key.count)
			else
				code_string := default_code_string.twin
			end
		ensure
			Terminology_id_set: terminology_id /= Void
			Code_string_set: code_string /= Void
		end

	make(a_terminology_id, a_code_string: STRING)
			-- make from two strings
		require
			Terminology_id_valid: a_terminology_id /= Void and then not a_terminology_id.is_empty
			Code_string_valid: a_code_string /= Void and then not a_code_string.is_empty
		do
			create terminology_id.make (a_terminology_id)
			code_string := a_code_string
		ensure
			Terminology_id_set: terminology_id.value.is_equal(a_terminology_id)
			Code_string_set: code_string = a_code_string
		end

	make_from_canonical_string (str: STRING)
			-- make from string of form:
			-- <terminology_id>
			--		<name>string</name>
			-- 		[<version_id>string</version_id>]
			-- </terminology_id>
			-- <code_string>string</code_string>
		do
			create terminology_id.make_from_canonical_string(xml_extract_from_tags(str, "terminology_id", 1))
			code_string := xml_extract_from_tags(str, "code_string", 1)
		end

feature -- Status Report

	is_local: BOOLEAN
			-- True if this terminology id = "local"
		do
			Result := terminology_id.is_local
		end

	valid_canonical_string(str: STRING): BOOLEAN
			-- True if str contains required tags
		do
			Result := xml_has_tag(str, "terminology_id", 1) and xml_has_tag(str, "code_string", 1)
		end

feature -- Access

	terminology_id: TERMINOLOGY_ID
			-- Identifier of the distinct terminology from which the code_string
			-- (or its elements) was extracted

	code_string: STRING
			-- The key used by the terminology service to identify a concept or
			-- coordination of concepts. This string is most likely parsable inside
			-- the terminology service, but nothing can be assumed about its syntax
			-- outside that context.

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Compare two terms
		local
			s, s_other: STRING
		do
			create s.make(0)
			s.append (terminology_id.value)
			s.append (code_string)

			create s_other.make(0)
			s_other.append (other.terminology_id.value)
			s_other.append (other.code_string)

			Result := s < s_other
		end

feature -- Output

	as_string: STRING
			-- string form displayable for humans - e.g. ICD9(1989)::M17
		do
			create Result.make(0)
			Result.append (terminology_id.value)
			Result.append (separator)
			Result.append (code_string)
		end

	out: STRING
			-- '['  + `as_string' + ']'
		do
			Result := "[" + as_string + "]"
		end


	as_canonical_string: STRING
			-- standardised form of string guaranteed to contain all information
			-- in data item
		do
			Result := "<terminology_id>" + terminology_id.as_canonical_string + "</terminology_id>" +
				"<code_string>" + code_string + "</code_string>"
		end

invariant
	terminology_id_exists: terminology_id /= Void
	code_string_valid: code_string /= Void and then not code_string.is_empty

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
--| The Original Code is coordinated_term.e.
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
