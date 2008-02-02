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
			implementation as pixmaps_implementation
		export
			{NONE} all
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
			make_with_title ("Create new test class")
			cdd_manager := a_manager
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
		do
			Precursor

			create l_hbox
			create l_vbox
			create name_field
			create error_label
			l_vbox.extend (name_field)
			l_vbox.extend (error_label)
			l_hbox.extend (l_vbox)

			create l_vbox
			l_vbox.extend (l_hbox)

			create l_hbox
			create l_cell
			create l_cancel_button.make_with_text ("Cancel")
			create create_button.make_with_text ("Create")
			create_button.enable_default_push_button
			l_hbox.extend (l_cell)
			l_hbox.extend (l_cancel_button)
			l_hbox.disable_item_expand (l_cancel_button)
			l_hbox.extend (create_button)
			l_hbox.disable_item_expand (create_button)
			l_vbox.extend (l_hbox)
			extend (l_vbox)
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

feature {NONE} -- Implementation

	cancel is
			-- Close window without creating new class.
		require
			not_destroyed: not is_destroyed
		do
			destroy
		ensure
			destroyed: is_destroyed
		end

invariant
	cdd_manager_not_void: cdd_manager /= Void
	name_field_not_void: name_field /= Void
	error_label_not_void: error_label /= Void
	create_button_not_void: create_button /= Void


end
