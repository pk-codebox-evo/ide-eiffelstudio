indexing
	description	: 	"ast visitor to generate bpl"
	legal: 			"See notice at end of class."
	status: 		"See notice at end of class."
	date		: 	"$Date$"
	revision	: 	"$Revision$"

class
	BPL_GENERATOR

inherit

	SHARED_SERVER
		export
			{NONE} all
		end

	SHARED_WORKBENCH

	BPL_VISITOR
		redefine
			process_class_as,
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: CLASS_C) is
			-- Initialization routine.
		do
			Precursor {BPL_VISITOR}(a_class)
			already_processed := False
		end

feature -- Actual Processing of a class

	process_class_as (l_as: CLASS_AS) is
			-- Process a class and generate BoogiePL
		do
			if already_processed then
				add_error (create {BPL_ERROR}.make ("Ballet can not handle multiple class definitions in one file."))
			else
				already_processed := True
				analyse_usage
				define_attributes
				define_functions
				define_signatures
			end
		end

feature {NONE} -- Implementation

	already_processed: BOOLEAN
		-- A class has already been processed, so there has to be more than one class definition in the file.

	usage_analyser: BPL_USAGE_ANALYSER

	analyse_usage is
			-- Analyse the usage.
		local
			a_list: LIST [FEATURE_AS]
		do
			create usage_analyser.make (current_class)
			usage_analyser.setup (current_class.ast,match_list,will_process_leading_leaves,will_process_trailing_leaves)
			usage_analyser.analyse

			bpl_out ("// FEATURE LISTS ------------------------------------------%N")
			a_list := usage_analyser.query_list
			from a_list.start until a_list.off loop
				bpl_out ("// Query: "+a_list.item.feature_name+"%N")
				a_list.forth
			end
			a_list := usage_analyser.command_list
			from a_list.start until a_list.off loop
				bpl_out ("// Command: "+a_list.item.feature_name+"%N")
				a_list.forth
			end
			a_list := usage_analyser.deferred_command_list
			from a_list.start until a_list.off loop
				bpl_out ("// Def. Command: "+a_list.item.feature_name+"%N")
				a_list.forth
			end
			a_list := usage_analyser.deferred_query_list
			from a_list.start until a_list.off loop
				bpl_out ("// Def. Query: "+a_list.item.feature_name+"%N")
				a_list.forth
			end
			a_list := usage_analyser.attribute_list
			from a_list.start until a_list.off loop
				bpl_out ("// Attribute: "+a_list.item.feature_name+"%N")
				a_list.forth
			end
			a_list := usage_analyser.function_list
			from a_list.start until a_list.off loop
				bpl_out ("// Function: "+a_list.item.feature_name+"%N")
				a_list.forth
			end
			a_list := usage_analyser.procedure_list
			from a_list.start until a_list.off loop
				bpl_out ("// Procedure: "+a_list.item.feature_name+"%N")
				a_list.forth
			end
			bpl_out ("%N")
		end

	attribute_writer: BPL_ATTRIBUTE_WRITER

	define_attributes is
			-- Define all attributes of the current class.
		local
			a_list: LIST [FEATURE_AS]
		do
			create attribute_writer.make (current_class)
			attribute_writer.setup (current_class.ast,match_list,will_process_leading_leaves,will_process_trailing_leaves)

			a_list := usage_analyser.attribute_list
			from a_list.start until a_list.off loop
				attribute_writer.write_attribute (a_list.item)
				a_list.forth
			end
		end

	function_writer: BPL_FUNCTION_WRITER

	define_functions is
			-- Define all functions of the current class.
		local
			a_list: LIST [FEATURE_AS]
		do
			create function_writer.make (current_class)
			function_writer.setup (current_class.ast,match_list,will_process_leading_leaves,will_process_trailing_leaves)

			a_list := usage_analyser.deferred_query_list
			from a_list.start until a_list.off loop
				function_writer.write_function (current_class.feature_named (a_list.item.feature_name))
				a_list.forth
			end
			a_list := usage_analyser.function_list
			from a_list.start until a_list.off loop
				function_writer.write_function (current_class.feature_named (a_list.item.feature_name))
				a_list.forth
			end
		end

	signature_writer: BPL_SIGNATURE_WRITER

	define_signatures is
			-- Define all signatures of the current class.
		local
			a_list: LIST [FEATURE_AS]
		do
			create signature_writer.make (current_class)

			a_list := usage_analyser.deferred_command_list
			from a_list.start until a_list.off loop
				signature_writer.write_signature (current_class.feature_named (a_list.item.feature_name))
				a_list.forth
			end
			a_list := usage_analyser.deferred_query_list
			from a_list.start until a_list.off loop
				signature_writer.write_signature (current_class.feature_named (a_list.item.feature_name))
				a_list.forth
			end
			a_list := usage_analyser.function_list
			from a_list.start until a_list.off loop
				signature_writer.write_signature (current_class.feature_named (a_list.item.feature_name))
				a_list.forth
			end
			a_list := usage_analyser.procedure_list
			from a_list.start until a_list.off loop
				signature_writer.write_signature (current_class.feature_named (a_list.item.feature_name))
				a_list.forth
			end
		end


indexing
	copyright:	"Copyright (c) 2006, Raphael Mack"
	license:	"GPL version 2 or later"
	copying: "[

				 This program is free software; you can redistribute it and/or
				 modify it under the terms of the GNU General Public License as
				 published by the Free Software Foundation; either version 2 of
				 the License, or (at your option) any later version.
				 
				 This program is distributed in the hope that it will be useful,
				 but WITHOUT ANY WARRANTY; without even the implied warranty of
				 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
				 GNU General Public License for more details.
				 
				 You should have received a copy of the GNU General Public
				 License along with this program; if not, write to the Free Software
				 Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
				 MA 02110-1301  USA

		]"

end -- class BPL_GENERATOR
