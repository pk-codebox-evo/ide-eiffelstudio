indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_PROJECT_BOX

inherit
	WIZARD_EIFFEL_PROJECT_BOX_IMP
		redefine
			show
		end

	WIZARD_VALIDITY_CHECKER
		undefine
			default_create,
			is_equal,
			copy
		end

	WIZARD_SHARED_DATA
		undefine
			default_create,
			is_equal,
			copy
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
		do
			initialize_checker
			epr_box.setup ("Path to Eiffel project file (*.epr):", "epr_key", agent eiffel_project_validity (?), create {ARRAYED_LIST [TUPLE [STRING, STRING]]}.make_from_array (<<["*.epr", "Eiffel Project File (*.epr)"]>>), "Browse for Eiffel Project File")
			ace_file_box.setup ("Path to system's ace file (*.ace):", "ace_key", agent ace_file_validity (?), create {ARRAYED_LIST [TUPLE [STRING, STRING]]}.make_from_array (<<["*.ace", "LACE File (*.ace)"], ["*.*", "All Files (*.*)"]>>), "Browse for system's ace file")
			facade_box.setup ("Name of Eiffel facade class:", "facade_key", agent eiffel_class_validity (?), Void, Void)
			facade_cluster_box.setup ("Name of Eiffel facade class cluster:", "cluster_key", agent cluster_validity (?), Void, Void)
		end

feature -- Basic Operations

	save_values is
			-- Persist combo box entries for next session.
		do
			facade_box.save_combo_text
			facade_cluster_box.save_combo_text
		end

	update_environment is
			-- Update `environment' according to text fields contents.
		local
			l_text: STRING
		do
			l_text := epr_box.value
			if is_valid_file (l_text) then
				environment.set_eiffel_project (l_text)
				environment.set_project_name (l_text.substring (l_text.last_index_of ('\', l_text.count) + 1, l_text.count))
			end
			l_text := ace_file_box.value
			if is_valid_file (l_text) then
				environment.set_ace_file_name (l_text)
			end
			l_text := facade_box.value
			if is_valid_eiffel_identifier (l_text) then
				environment.set_eiffel_class_name (l_text)
			end
			l_text := facade_cluster_box.value
			if is_valid_eiffel_identifier (l_text) then
				environment.set_class_cluster_name (l_text)
			end
		end

	show is
			-- Update environment and show.
		do
			Precursor {WIZARD_EIFFEL_PROJECT_BOX_IMP}
			update_environment
		end
		
feature {NONE} -- Implementation

	eiffel_project_validity (a_project_file: STRING): WIZARD_VALIDITY_STATUS is
			-- Is `a_project_file' a valid eiffel project file?
			-- Setup environment accordingly.
		do
			if is_valid_file (a_project_file) then
				create Result.make_success (feature {WIZARD_VALIDITY_STATUS_IDS}.Eiffel_project)
				environment.set_eiffel_project (a_project_file)
				environment.set_project_name (a_project_file.substring (a_project_file.last_index_of ('\', a_project_file.count) + 1, a_project_file.count))
			else
				create Result.make_error (feature {WIZARD_VALIDITY_STATUS_IDS}.Eiffel_project)
			end
			set_status (Result)
		end
		
	ace_file_validity (a_ace_file: STRING): WIZARD_VALIDITY_STATUS is
			-- Is `a_ace_file' a valid eiffel ace file?
			-- Setup environment accordingly.
		do
			if is_valid_file (a_ace_file) then
				create Result.make_success (feature {WIZARD_VALIDITY_STATUS_IDS}.Ace_file)
				environment.set_ace_file_name (a_ace_file)
			else
				create Result.make_error (feature {WIZARD_VALIDITY_STATUS_IDS}.Ace_file)
			end
			set_status (Result)
		end
		
	eiffel_class_validity (a_eiffel_class: STRING): WIZARD_VALIDITY_STATUS is
			-- Is `a_eiffel_class' a valid eiffel class?
			-- Setup environment accordingly.
		do
			if is_valid_eiffel_identifier (a_eiffel_class) then
				create Result.make_success (feature {WIZARD_VALIDITY_STATUS_IDS}.Eiffel_class)
				environment.set_eiffel_class_name (a_eiffel_class)
			else
				create Result.make_error (feature {WIZARD_VALIDITY_STATUS_IDS}.Eiffel_class)
			end
			set_status (Result)
		end
		
	cluster_validity (a_cluster: STRING): WIZARD_VALIDITY_STATUS is
			-- Is `a_cluster' a valid eiffel cluster?
			-- Setup environment accordingly.
		do
			if is_valid_eiffel_identifier (a_cluster) then
				create Result.make_success (feature {WIZARD_VALIDITY_STATUS_IDS}.Eiffel_cluster)
				environment.set_class_cluster_name (a_cluster)
			else
				create Result.make_error (feature {WIZARD_VALIDITY_STATUS_IDS}.Eiffel_cluster)
			end
			set_status (Result)
		end
		
	is_valid_eiffel_identifier (a_string: STRING): BOOLEAN is
			-- Is `a_string' a valid eiffel identifier?
		local
			i, l_count: INTEGER;
			l_char: CHARACTER
		do
			l_count := a_string.count
			if l_count /= 0 and then a_string.item(1).is_alpha then
				from
					Result := True
					i := 2
				until
					i > l_count or else not Result
				loop
					l_char := a_string.item (i)
					Result := l_char.is_alpha or else l_char = '_' or else l_char.is_digit
					i := i + 1
				end
			end
		end

end -- class WIZARD_EIFFEL_PROJECT_BOX

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

