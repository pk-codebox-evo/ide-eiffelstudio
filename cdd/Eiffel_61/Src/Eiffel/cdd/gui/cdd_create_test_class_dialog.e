indexing
	description:
		"[
			Objects that help the use create a test class
			by providing an input field for defining
			a name for the new test class
		]"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_CREATE_TEST_CLASS_DIALOG

inherit

	EV_DIALOG
		redefine
			initialize
		end

	EB_SHARED_PIXMAPS
		rename
			implementation as pixmaps_imp
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_CLUSTER_MANAGER_OBSERVER
		export
			{NONE} all
		undefine
			default_create, copy
		end

	CONF_ACCESS
		undefine
			default_create, copy
		end

	ES_SHARED_PROMPT_PROVIDER
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: like cdd_manager) is
			-- Initialize `Current' with `a_target'.
		require
			a_manager_not_void: a_manager /= Void
			project_initialized: a_manager.is_project_initialized
		do
			cdd_manager := a_manager
			make_with_title ("Create new test class")
		ensure
			cdd_manager_set: cdd_manager = a_manager
		end

	initialize is
			-- Build widgets.
		local
			l_hbox: EV_HORIZONTAL_BOX
			l_vbox: EV_VERTICAL_BOX
			l_cancel_button: EV_BUTTON
			l_cell: EV_CELL
			l_name_label: EV_LABEL
		do
			Precursor

			create l_vbox

				-- Create input field
			create l_hbox
			create l_name_label.make_with_text ("New class name")
			l_name_label.align_text_left
			l_hbox.extend (l_name_label)
			l_hbox.disable_item_expand (l_name_label)
			create name_field
			name_field.change_actions.extend (agent update_change)
			l_hbox.extend (name_field)
			l_vbox.extend (l_hbox)
			l_vbox.disable_item_expand (l_hbox)

				-- Create error label
			create error_label
			error_label.align_text_right
			error_label.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 0, 0))
			l_vbox.extend (error_label)
			l_vbox.disable_item_expand (error_label)

			create l_cell
			l_vbox.extend (l_cell)

				-- Create buttons
			create l_hbox
			create l_cell
			create l_cancel_button.make_with_text ("Cancel")
			create create_button.make_with_text ("Create")
			create_button.select_actions.extend (agent create_class)
			l_hbox.extend (l_cell)
			l_hbox.extend (l_cancel_button)
			l_hbox.disable_item_expand (l_cancel_button)
			l_hbox.extend (create_button)
			l_hbox.disable_item_expand (create_button)
			l_vbox.extend (l_hbox)
			l_vbox.disable_item_expand (l_hbox)

				-- Display everything in `Current'
			extend (l_vbox)

			create_button.enable_default_push_button
			set_default_cancel_button (l_cancel_button)
			set_default_push_button (create_button)
		end

feature -- Access

	cdd_manager: CDD_MANAGER
			-- Manager providing project information

feature {NONE} -- Implementation (Access)

	name_field: EV_TEXT_FIELD
			-- Text field for entering new
			-- test class name

	error_label: EV_LABEL
			-- Label for displaying error messages

	create_button: EV_BUTTON
			-- Create button

	is_valid_name: BOOLEAN is
			-- Does `name_field' contain a valid test class name?
		do
			Result := name_field.text.has_substring ("TEST") and
				syntax_checker.is_valid_class_name (name_field.text)
		end

feature {NONE} -- Implementation

	create_class is
			-- Try to create test class for name in `name_field'.
			-- If error occurs display message, otherwise close
			-- dialog.
		require
			valid_name: is_valid_name
		local
			l_dir: CONF_DIRECTORY_LOCATION
			l_name, l_filename, l_path, l_tmpl: STRING
			l_output: KL_TEXT_OUTPUT_FILE
			l_clsfile: FILE_NAME
			l_input: KL_TEXT_INPUT_FILE
			l_universe: UNIVERSE_I
			l_target: CONF_TARGET
			l_cluster: CONF_CLUSTER
		do
			create l_clsfile.make_from_string (eiffel_layout.Templates_path)
			l_clsfile.set_file_name ("manual_test_class")
			l_clsfile.add_extension ("cls")
			create l_input.make (l_clsfile)
			l_input.open_read
			if l_input.is_open_read then
				l_name := name_field.text
				l_dir := cdd_manager.testing_directory
				l_filename := l_name.as_lower + ".e"
				l_path := l_dir.build_path ("", l_filename)
				create l_output.make (l_path)
				if not l_output.exists then
					l_output.recursive_open_write
					if l_output.is_open_write then
						l_input.read_string (l_input.count)
						l_tmpl := l_input.last_string
						l_tmpl.replace_substring_all ("$classname", l_name)
						l_output.put_string (l_tmpl)
						l_output.close

							-- Add created class to system
						l_universe := cdd_manager.project.universe
						l_target := cdd_manager.test_suite.target
						l_name := l_target.name + "_tests"
						l_cluster := l_universe.cluster_of_name (l_name)
						if l_cluster = Void then
								-- Need to create cdd tests cluster first
							l_cluster := conf_factory.new_cdd_cluster (l_name, l_dir, l_target)
							l_cluster.set_recursive (True)
							l_cluster.set_classes (create {HASH_TABLE [EIFFEL_CLASS_I, STRING]}.make (0))
							l_cluster.set_classes_by_filename (create {HASH_TABLE [EIFFEL_CLASS_I, STRING]}.make (0))

							l_target.add_cluster (l_cluster)
							cdd_manager.project.system.system.set_config_changed (True)
							manager.refresh
						end
						manager.add_class_to_cluster (l_filename, l_cluster, "")
						destroy
					else
						prompts.show_error_prompt ("Could not create new test class file %N" + l_output.name, Current, Void)
					end
				else
					prompts.show_error_prompt ("Class file already exists: %N" + l_output.name, Current, Void)
				end
				l_input.close
			else
				prompts.show_error_prompt ("Could not open input template file: %N" + l_input.name, Current, Void)
			end
		end

	update_change is
			-- Adjust `create_button' to current text
			-- of `name_field.
		do
			if is_valid_name then
				error_label.set_text ("")
				create_button.enable_sensitive
			else
				error_label.set_text ("Name must contain %"TEST%"")
				create_button.disable_sensitive
			end
		end

	syntax_checker: EIFFEL_SYNTAX_CHECKER is
			-- Syntax checker for checking new class name.
		once
			create Result
		end

	conf_factory: CONF_COMP_FACTORY is
			-- Factory for creating CONF_LOCATION
		once
			create Result
		end

invariant
	cdd_manager_not_void: cdd_manager /= Void
	name_field_not_void: name_field /= Void
	error_label_not_void: error_label /= Void
	create_button_not_void: create_button /= Void


end
