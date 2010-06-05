indexing

	component:   "openEHR Common Archetype Model"
	
	description: "Constrainer type for instances of STRING"
	keywords:    "archetype, string, data"
	
	design:      "openEHR Common Archetype Model 0.2"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2000-2004 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/openehr/src/am/archetype/constraint_model/primitive/c_string.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class C_STRING_2

inherit
	C_PRIMITIVE

create
	make_any, make_from_string, make_from_regexp, make_from_string_list

feature -- Definitions

	default_delimiter: CHARACTER is '/'
	
	alternative_delimiter: CHARACTER is '^'
	
	Regexp_compile_error: STRING is "regexp COMPILE ERROR"
	
feature -- Initialization

	make_any is
			-- make completely open
		do
			is_open := True
		end
		
	make_from_string(str: STRING) is
			-- make from a single string
		require
			str /= Void
		do
			create strings.make(0)
			strings.extend(str)
			strings.compare_objects
		ensure
			not is_open
		end

	make_from_regexp(str: STRING; using_default_delimiter: BOOLEAN) is
			-- make from a regular expression contained in 'str' (not including delimiters);
			-- if `using_default_delimiter' is True, the '/' delimiter is being used, 
			-- else the '^' delimiter is being used
		require
			str /= Void
		do
			regexp := str.twin
			regexp_default_delimiter := using_default_delimiter
			create regexp_parser.compile_case_sensitive(regexp)
			if not regexp_parser.is_compiled then
				regexp := Regexp_compile_error.twin
			end
		ensure
			strings = Void
			regexp.is_equal(str) xor regexp.is_equal(Regexp_compile_error)
		end

	make_from_string_list(lst: LIST[STRING]) is
		require
			lst /= Void
		do
			create strings.make(0)
			strings.fill(lst)
			strings.compare_objects
		ensure
			strings /= Void
			not is_open
		end

feature -- Modification

	set_open is
		do
			is_open := True
		end

	add_string(str: STRING) is
		require
			str /= Void
		do
			strings.extend(str)
		end

feature -- Access

	strings: ARRAYED_LIST[STRING]
			-- representation of constraint as allowed values for the constrained string
			
	regexp: STRING
			-- representation of constraint as PERL-compliant regexp pattern

	default_value: STRING is
			-- 	generate a default value from this constraint object
		do
			if strings /= Void then
				if is_open then
					Result := "*"
				elseif strings.count > 0 then
					Result := strings.first
				else
					Result := ""
				end
			elseif regexp /= Void then
				Result := "" -- FIXME - what is default from regexp?
			end
		ensure then
			Result /= Void
		end
		
	regexp_delimiter: CHARACTER is 
			-- return correct delimiter according to `regexp_default_delimiter'
		do
			if regexp_default_delimiter then
				Result := default_delimiter
			else
				Result := alternative_delimiter
			end
		end
	
feature -- Status Report

	is_open: BOOLEAN
			-- values other than those in 'items' are allowed

feature -- Status Report

	valid_value (a_value: STRING): BOOLEAN is 
		do
			if is_open then
				Result := True
			elseif strings /= Void then 
				Result := strings.has (a_value)
			else
				Result := regexp_parser.matches(a_value)
			end
		end
		
	regexp_default_delimiter: BOOLEAN
			-- if True, the '/' delimiter is being used, 
			-- else the '^' delimiter is being used		

feature -- Output

	as_string:STRING is
		do
			create Result.make(0)
			
			if strings /= Void then
				from
					strings.start
				until
					strings.off
				loop
					if not strings.isfirst then 
						Result.append(", ")
					end
					Result.append_character('%"')
					Result.append(strings.item)
					Result.append_character('%"')
					strings.forth
				end
				if is_open then
					Result.append(", ...")
				end			
			else -- its a regexp
				Result.append_character(regexp_delimiter)
				Result.append(regexp)
				Result.append_character(regexp_delimiter)
			end
			if assumed_value /= Void then
				Result.append("; %"" + assumed_value.out + "%"")
			end

		end

	as_canonical_string:STRING is
		do
		end

feature {NONE} -- Implementation

	regexp_parser: LX_DFA_REGULAR_EXPRESSION

invariant
	strings_regexp_mutex: strings /= Void xor regexp /= Void

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
--| The Original Code is c_string.e.
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
