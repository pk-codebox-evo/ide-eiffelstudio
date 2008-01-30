indexing
	description: "Objects that display all CDD relevant output"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_OUTPUT_TOOL

inherit

	ES_TOOL [CDD_OUTPUT_TOOL_PANEL]

create {NONE}
	default_create

feature -- Access

	title: STRING_32 is
			-- Title for `Current'
		do
			Result := "CDD Output"
		end

	shortcut_preference_name: STRING_32
			-- An optional shortcut preference name, for automatic preference binding.
			-- Note: The preference should be registered in the default.xml file
			--       as well as in the {EB_MISC_SHORTCUT_DATA} class.
		do
		end

	icon: EV_PIXEL_BUFFER
			-- Tool icon
			-- Note: Do not call `tool.icon' as it will create the tool unnecessarly!
		do
			Result := stock_pixmaps.tool_external_output_icon_buffer
		end

	icon_pixmap: EV_PIXMAP
			-- Tool icon pixmap
			-- Note: Do not call `tool.icon' as it will create the tool unnecessarly!
		do
			Result := stock_pixmaps.tool_external_output_icon
		end

feature {NONE} -- Factory

	create_tool: CDD_OUTPUT_TOOL_PANEL
			-- Creates the tool for first use on the development `window'
		do
			create Result.make (window, Current)
		end

end
