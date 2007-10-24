
indexing
	description: "Generated by MATISSE ODL tool (release 4.0.0 of mt_odl)"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"

class
	MT_CONTAINER_TYPES

feature {NONE}

	container_class_for_relationship (rel_name: STRING): STRING is
		-- Find the class name for a MATISSE relationship 'rel_name'
		-- Default class is MT_LINKED_LIST.
		do
			container_class_names.search (rel_name)
			if container_class_names.found then
				Result := container_class_names.found_item
			else
				Result := "MT_LINKED_LIST"
			end
		end

	Container_class_names: HASH_TABLE[STRING, STRING] is
		-- Value is a container class name in upper case.
		-- Key is a MATISSE relationship name.
		once
			create Result.make(20)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
