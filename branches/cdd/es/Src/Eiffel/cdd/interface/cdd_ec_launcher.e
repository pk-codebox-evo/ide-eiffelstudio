indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_EC_LAUNCHER

inherit
	EB_PROCESS_LAUNCHER

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

create
	make_with_target

feature -- Initialization

	make_with_target (a_target: CONF_TARGET) is
			--
		local
			l_list: ARRAYED_LIST [STRING]
		do
			create data_storage.make
			create l_list.make (3)
			l_list.extend ("-config")
			l_list.extend (eiffel_ace.file_name)
			l_list.extend ("-target")
			l_list.extend (a_target.name)
			l_list.extend ("-c_compile")
			prepare_command_line ("ec", l_list, eiffel_project.name)
		end

feature -- Access

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Process data storage

	data_storage: EB_PROCESS_IO_STORAGE

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
