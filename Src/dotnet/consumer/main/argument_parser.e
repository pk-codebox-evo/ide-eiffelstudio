indexing
	description: "Argument parser for Eiffel metadata consumer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_OPTION_PARSER
		rename
			make as make_parser
		export
			{NONE} all
			{APPLICATION} execute
			{ANY} successful
		redefine
			switch_groups
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initializes argument parser
		do
			make_parser (False, False)
			set_use_separated_switch_values (True)
			set_show_switch_arguments_inline (True)
		end

feature -- Access

	assemblies: LIST [STRING] is
			-- List of assemblies to add to cache
		require
			successful: successful
			add_or_removing_assemblies: add_assemblies or remove_assemblies
		once
			if add_assemblies then
				Result := options_values_of_name (add_switch)
			else
				Result := options_values_of_name (remove_switch)
			end

		ensure
			result_attached: Result /= Void
			result_contains_attached_valid_items: Result.for_all (agent (a_item: STRING): BOOLEAN
				do
					Result := a_item /= Void and then not a_item.is_empty
				end)
		end

	reference_paths: LIST [STRING] is
			-- List of assembly reference paths used in resolution
		require
			successful: successful
			add_assemblies: add_assemblies
		once
			Result := options_values_of_name (reference_switch)
		ensure
			result_attached: Result /= Void
			result_contains_attached_valid_items: Result.for_all (agent (a_item: STRING): BOOLEAN
				do
					Result := a_item /= Void and then not a_item.is_empty
				end)
		end

	cache_path: STRING is
			-- A location of a cache
		require
			successful: successful
			use_specified_cache: use_specified_cache
		do
			Result := option_of_name (output_switch).value
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature -- Status report

	add_assemblies: BOOLEAN is
			-- Indiciate if assemblies are to be added to the cache (fake or otherwise)
		require
			successful: successful
		once
			Result := has_option (add_switch)
		end

	add_information_only: BOOLEAN is
			-- Inidicate if only the assembly information should be consumed
		require
			successful: successful
		once
			Result := has_option (info_only_switch)
		end

	remove_assemblies: BOOLEAN is
			-- Indicate if assemblies are to be removed from the cache
		require
			successful: successful
		once
			Result := has_option (remove_switch)
		end

	list_assemblies: BOOLEAN is
			-- Inidicates if contents of cache should be listed
		require
			successful: successful
		once
			Result := has_option (list_switch)
		end

	clean_cache: BOOLEAN is
			-- Inidicates if contents of cache should compacted
		require
			successful: successful
		once
			Result := has_option (clean_switch)
		end

	show_verbose_output: BOOLEAN is
			-- Inidicate if verbose information should be shown
		require
			successful: successful
		once
			Result := has_option (verbose_switch)
		end

	use_specified_cache: BOOLEAN is
			-- Indicates if a specified assembly cache should be used
		require
			successful: successful
		once
			Result := has_option (output_switch)
		end

feature {NONE} -- Usage

	name: STRING = "Eiffel Assembly Metadata %"Consumer%""
			-- Full name of application

	Version: STRING is
			-- Version number of application
		once
			Result := ({EMITTER}).to_cil.assembly.get_name.version.to_string
		end

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
			-- (export status {NONE})
		once
			create Result.make (3)
			Result.extend (create {ARGUMENT_ASSEMBLY_SWITCH}.make (add_switch, "Adds a specified assemblies to the cache.", False, False, loose_argument_name, loose_argument_description, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (info_only_switch, "Forces consumer to ignore all types in added assemblies.", True, False))
			Result.extend (create {ARGUMENT_ASSEMBLY_SWITCH}.make (remove_switch, "Remove all specified assemblies from the cache.", False, False, loose_argument_name, loose_argument_description, False))
			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (reference_switch, "Add a lookup reference path for dependency resolution.", True, False, "path", "A location on disk", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (list_switch, "Lists the content of the cache.", False, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (verbose_switch, "Display verbose output.", True, False))
			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (output_switch, "Location of Eiffel assembly cache to perform operations on.", True, False, "cache", "A location of an Eiffel assembly cache", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (clean_switch, "Cleans and compacts an Eiffel cache.", False, False))
		end

	switch_groups: ARRAYED_LIST [ARGUMENT_GROUP]
			-- Valid switch grouping
		once
			create Result.make (5)
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (add_switch), switch_of_name (info_only_switch), switch_of_name (reference_switch), switch_of_name (output_switch), switch_of_name (verbose_switch)>>, False))
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (remove_switch), switch_of_name (output_switch)>>, False))
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (list_switch), switch_of_name (output_switch), switch_of_name (verbose_switch)>>, False))
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (clean_switch), switch_of_name (output_switch)>>, False))
		end

feature {NONE} -- Switches

	add_switch: STRING = "a"
	info_only_switch: STRING = "g"
	remove_switch: STRING = "r"
	reference_switch: STRING = "i"
	list_switch: STRING = "l"
	verbose_switch: STRING = "v"
	output_switch: STRING = "o"
	clean_switch: STRING = "c"
			-- Switch names

	loose_argument_name: STRING = "assembly"
			-- Name of lose argument, used in usage information

	loose_argument_description: STRING = "Path to a valid .NET assembly";
			-- Description of loose argument, used in usage information

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class {ARGUMENT_PARSER}
