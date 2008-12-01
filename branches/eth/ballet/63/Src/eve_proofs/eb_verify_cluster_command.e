indexing
	description:
		"[
			Command to statically verify a cluster.
		]"
	date: "$Date$"
	revision: "$Revision$"

class EB_VERIFY_CLUSTER_COMMAND

inherit

	EB_VERIFY_COMMAND

create
	make

feature -- Execution

	execute is
			-- Execute menu command.
		do
			-- TODO: anything to do?
		end

feature -- Context menu

	context_menu_name (a_cluster_stone: CLUSTER_STONE; a_name: STRING_GENERAL): STRING_32
			-- Name of context menu for `a_cluster_stone'
		do
			if a_cluster_stone.group.is_library then
				Result := names.verify_library_context_menu_name (a_name)
			else
				Result := names.verify_cluster_context_menu_name (a_name)
			end
		end

feature {NONE} -- Implementation

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			Result := names.verify_cluster_menu_name
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := names.verify_cluster_menu_name
		end

	tooltext: STRING_GENERAL
			-- Text for the toolbar button.
		do
			Result := names.verify_cluster_menu_name
		end

	description: STRING_GENERAL
			-- Description for this command.
		do
			Result := names.verify_cluster_menu_description
		end

	name: STRING_GENERAL
			-- Name of the command. Used to store the command in the
			-- preferences.
		do
			Result := "Verify_cluster"
		end

feature {NONE} -- Implementation

	droppable (a_pebble: ANY): BOOLEAN is
			-- Can user drop `a_pebble' on `Current'?
		local
			l_class_stone: CLUSTER_STONE
		do
			l_class_stone ?= a_pebble
			Result := l_class_stone /= Void
		end

end
