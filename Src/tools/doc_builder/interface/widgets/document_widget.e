indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_WIDGET

inherit
	DOCUMENT_WIDGET_IMP

	SHARED_OBJECTS
		undefine
			copy,
			default_create,
			is_equal
		end

	UTILITY_FUNCTIONS
		undefine
			copy,
			default_create,
			is_equal
		end

create
	make

feature -- Creation
		
	make (a_document: DOCUMENT) is
			-- New widget based on `a_document'
		do
			document := a_document
			default_create			
		end		

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do	
				-- Edit widget
			create internal_edit_widget.make (document)
			--internal_edit_widget.resize_actions.force_extend (agent editor_resized)
			set_first (internal_edit_widget)
			update
			internal_edit_widget.resize_actions.force_extend (agent editor_resized)
		end

feature -- Access

	title: STRING is
			-- Title to display
		do
			Result := document.short_name (document.name)
		end

feature -- Commands
	
	update is
			-- Update
		local
			l_split_pos: INTEGER
		do
			l_split_pos := shared_document_editor.split_position
			internal_edit_widget.resize_actions.block
			if not has (internal_html_widget) then	
				if internal_html_widget.parent /= Void then
					internal_html_widget.parent.prune (internal_html_widget)
				end
				set_second (internal_html_widget)	
			end
			internal_edit_widget.resize_actions.resume
			internal_html_widget.set_document (document)
			set_split_position (l_split_pos)
			shared_document_editor.set_split_position (l_split_pos)
		end

feature -- Implementation

	document: DOCUMENT
			-- Associated document

	internal_edit_widget: DOCUMENT_TEXT_WIDGET
			-- Internal editing widget
			
	internal_xml_widget: DOCUMENT_BROWSER
			-- Internal XML widget
			
	internal_html_widget: DOCUMENT_BROWSER is
			-- Internal HTML Browser widget
		once
			Result := Shared_web_browser			
		end

	editor_resized is
			-- Editor was resized
		do
			shared_document_editor.set_split_position (split_position)
		end		

end -- class WIDGET_BUILDER_NOT_FOR_SYSTEM