indexing
	description	: "superclass for the ast visitors in ballet"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date:$"
	revision	: "$Revision:$"

deferred class
   BPL_VISITOR

inherit

	AST_ROUNDTRIP_ITERATOR
		redefine
			process_feature_as
		end

	SHARED_BPL_ENVIRONMENT

feature {NONE}

	current_class: CLASS_AS is
			-- Alias for 'parsed_class'.
		do
			Result := parsed_class
		end

	current_feature: FEATURE_AS

feature

	process_feature_as (l_as: FEATURE_AS) is
		do
			current_feature := l_as
			Precursor (l_as)
			current_feature := Void
		end

indexing
	copyright:	"Copyright (c) 2006, Raphael Mack"
	license:	"GPL version 2 or later"
	copying: "[

             This program is free software; you can redistribute it and/or
             modify it under the terms of the GNU General Public License as
             published by the Free Software Foundation; either version 2 of
             the License, or (at your option) any later version.
             
             This program is distributed in the hope that it will be useful,
             but WITHOUT ANY WARRANTY; without even the implied warranty of
             MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
             GNU General Public License for more details.
             
             You should have received a copy of the GNU General Public
             License along with this program; if not, write to the Free Software
             Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
             MA 02110-1301  USA

		]"

end -- class BPL_VISITOR
