indexing
	component:   "openEHR Reference Model"

	description: "Reference Model testing application"
	keywords:    "test"

	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2000-2004 The openEHR Foundation <http://www.openEHR.org>"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/openehr/test/src/gui/application.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class
	APPLICATION

inherit
	EV_APPLICATION
	
	SHARED_UI_RESOURCES
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make_and_launch
	
feature {NONE} -- Initialization

	make_and_launch is
			-- Create `Current', build and display `main_window',
			-- then launch the application.
		do
			default_create
		
			if has_resources then
				create main_window
				create splash_window.make
				splash_window.show
				main_window.show
				splash_window.raise
				launch
			else
				io.put_string(fail_reason + "%N")
				io.put_string("Hit any key to exit application%N")
				io.read_character
			end
	
		end
		
feature {NONE} -- Implementation

	main_window: MAIN_WINDOW
		-- Main window of `Current'.

	splash_window: SPLASH_WINDOW
	
	fail_reason: STRING
	
	has_resources: BOOLEAN is
			-- True if all resources are available
		local
			cfa: CONFIG_FILE_ACCESS
			s: STRING
		do
			Result := True
			if not has_icon_directory then
				fail_reason := "Cannot run: 'icons' directory missing"
				Result := False
			else
				s := application_name
				s.replace_substring_all(".exe", ".cfg")
				initialise_resource_config_file_name(s)
				cfa := resource_config_file
				if not cfa.is_valid then
					Result := False
					fail_reason := cfa.fail_reason
				end
			end
		ensure
			not Result implies fail_reason /= Void
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
--| The Original Code is application.e.
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
