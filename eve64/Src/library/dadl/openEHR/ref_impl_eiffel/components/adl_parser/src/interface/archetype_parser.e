indexing
	component:   "openEHR Archetype Project"
	description: "[
				 Archetype parser. This object can parse single archetypes. It is used by the 
				 ARCHETYPE_COMPILER to perform a system-wide or partial system compilation of
				 archetypes found in the ARCHETYPE_DIRECTORY. It can be driven in an ad hoc fashion, 
				 as by the Archetype Editor. For the target archetype, it can then be used to:
				 	- parse (single archetype), 
				 	- save (serialise back to ADL), 
				 	- save-as (serialise to another format).
				 ]"
	keywords:    "test, ADL"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2003-2007 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/components/adl_parser/src/interface/archetype_parser.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class ARCHETYPE_PARSER

inherit
	SHARED_ARCHETYPE_DIRECTORY

	SHARED_APPLICATION_CONTEXT
		export
			{NONE} all
			{ANY} current_language, set_current_language
		end

	SHARED_ARCHETYPE_SERIALISERS
		export
			{NONE} all
			{ANY} has_archetype_serialiser_format, archetype_serialiser_formats
		end

	SHARED_RESOURCES
		export
			{NONE} all
		end

	MESSAGE_BILLBOARD
		export
			{NONE} all
		end

	EXCEPTIONS
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make is
		do
			create status.make_empty
			create adl_engine.make
		end

feature -- Definitions

	openehr_version: STRING is
			-- version of openEHR implem-dev repository containing
			-- this software
		once
			Result := (create {OPENEHR_VERSION}).last_changed
		end

feature -- Access

	target: ARCH_REP_ARCHETYPE
			-- archetype currently being processed by this instance of the compiler

	archetype_differential: DIFFERENTIAL_ARCHETYPE is
			-- Differential form of currently compiled archetype.
		require
			has_context: archetype_parsed
		do
			Result := target.archetype_differential
		end

	archetype_flat: FLAT_ARCHETYPE is
			-- Flat form of currently compiled archetype.
		require
			has_context: archetype_parsed
		do
			Result := target.archetype_flat
		end

	serialised_differential: STRING
			-- archetype in serialised form, after call to serialise_archetype

	serialised_flat: STRING
			-- archetype in serialised form, after call to serialise_archetype

	status: STRING
			-- status of last operation

feature -- Status Report

	has_target: BOOLEAN is
			-- True if the compiler has been set to a target archetype descriptor in the ARCHETYPE_DIRECTORY
		do
			Result := target /= Void
		end

	archetype_parsed: BOOLEAN
			-- Has the archetype been parsed into an ARCHETYPE structure?
		do
			Result := target /= Void and then target.is_parsed
		end

	archetype_valid: BOOLEAN
			-- Has the archetype been parsed into an ARCHETYPE structure and then validated?
		do
			Result := target /= Void and then target.is_valid
		end

	save_succeeded: BOOLEAN
			-- True if last save operation was successful

	exception_encountered: BOOLEAN
			-- True if last operation caused an exception

feature -- Modification

	set_target (ara: ARCH_REP_ARCHETYPE) is
			-- set target of the compiler to designated archetype
		require
			descriptor_exists: ara /= Void
		do
			reset
			target := ara
		ensure
			has_target
		end

	set_target_to_selected is
			-- set target of the compiler to archetype currently selected in archetype_directory
		require
			archetype_available: archetype_directory.has_selected_archetype
		do
			set_target(archetype_directory.selected_archetype)
		ensure
			has_target
		end

	reset is
			-- reset after exception encountered
		do
			exception_encountered := False
			status.wipe_out
		ensure
			Exception_cleared: not exception_encountered
			Status_cleared: status.is_empty
		end

feature -- Commands

	parse_archetype is
			-- Parse and validate `target', in differential form if available, else in flat form.
		require
			Has_target: has_target
		local
			a_diff_arch: DIFFERENTIAL_ARCHETYPE
			a_flat_arch: FLAT_ARCHETYPE
		do
			if not exception_encountered then
				clear_billboard
				target.set_parse_attempted

				if target.has_differential_file then
					post_info (Current, "parse_archetype", "parse_archetype_i3", Void)
					target.read_differential
					a_diff_arch := adl_engine.parse_differential (target.differential_text)

					if a_diff_arch = Void then
						post_error (Current, "parse_archetype", "parse_archetype_e1", <<adl_engine.parse_error_text>>)
					else
						post_info (Current, "parse_archetype", "parse_archetype_i1", <<target.id.as_string>>)

						-- Put the archetype into its directory node; note that this runs its validator(s).
						target.set_archetype_differential (a_diff_arch)
					end
				else
					target.read_flat
					a_flat_arch := adl_engine.parse_flat (target.flat_text)

					if a_flat_arch = Void then
						post_error (Current, "parse_archetype", "parse_archetype_e1", <<adl_engine.parse_error_text>>)
					else
						post_info (Current, "parse_archetype", "parse_archetype_i1", <<target.id.as_string>>)

						-- Put the archetype into its directory node; note that this runs its validator(s).
						target.set_archetype_flat (a_flat_arch)
					end
				end

				-- Make sure that the language is set, and that it is one of the languages in the archetype.
				if archetype_valid then
					if current_language = Void or not archetype_differential.has_language (current_language) then
						set_current_language (archetype_differential.original_language.code_string)
					end
				end
			else
				post_error (Current, "parse_archetype", "parse_archetype_e3", Void)
			end

			status.wipe_out
			status.append (billboard_content)
			target.set_compiler_status (billboard_content)
			clear_billboard
		rescue
			post_error (Current, "parse_archetype", "report_exception", <<exception.out, exception_trace>>)
			exception_encountered := True
			retry
		end

	create_new_archetype(a_im_originator, a_im_name, a_im_entity, a_primary_language: STRING) is
			-- create a new top-level differential archetype and install it into the directory according to its id
		require
			Info_model_originator_valid: a_im_originator /= void and then not a_im_originator.is_empty
			Info_model_name_valid: a_im_name /= void and then not a_im_name.is_empty
			Info_model_entity_valid: a_im_entity /= void and then not a_im_entity.is_empty
			Primary_language_valid: a_primary_language /= void and then not a_primary_language.is_empty
		local
			an_archetype: DIFFERENTIAL_ARCHETYPE
		do
			if not exception_encountered then
				create an_archetype.make_minimal (create {!ARCHETYPE_ID}.make (a_im_originator, a_im_name, a_im_entity, "UNKNOWN", "draft"), a_primary_language, 0)
				set_current_language (a_primary_language)

				-- FIXME: now add this archetype into the ARCHETYPE_DIRECTORY

				-- set it as the target
			else
				post_error(Current, "create_new_archetype", "create_new_archetype_e1", Void)
			end

			status.wipe_out
			status.append(billboard_content)
			clear_billboard
		ensure
			-- FIXME: make the new archetype the target??
		rescue
			post_error(Current, "create_new_archetype", "report_exception", <<exception.out, exception_trace>>)
			exception_encountered := True
			retry
		end

	create_new_specialised_archetype(specialised_domain_concept: STRING) is
			-- create a new specialised archetype as a child of the target archetype and install it in
			-- the directory
		require
			Has_target: has_target
			Concept_valid: specialised_domain_concept /= Void and then not specialised_domain_concept.is_empty
		local
			an_archetype: DIFFERENTIAL_ARCHETYPE
		do
			if not exception_encountered then
				create an_archetype.make_specialised_child(archetype_differential, specialised_domain_concept)

				-- FIXME: now add this archetype into the ARCHETYPE_DIRECTORY
			else
				post_error(Current, "create_new_specialised_archetype", "create_new_specialised_archetype_e1", Void)
			end
			status.wipe_out
			status.append(billboard_content)
			clear_billboard
		rescue
			post_error(Current, "create_new_specialised_archetype", "report_exception", <<exception.out, exception_trace>>)
			exception_encountered := True
			retry
		end

	save_archetype_differential is
			-- Save current target archetype to its file in its source form
		require
			Has_target: has_target
		do
			if not exception_encountered then
				status.wipe_out
				save_succeeded := False
				if archetype_valid then
					serialised_differential := adl_engine.serialise(archetype_differential, "adl")
					target.save_differential (serialised_differential)
					save_succeeded := True
				else
					post_error(Current, "save_archetype_differential", "save_archetype_e2", Void)
				end
			else
				post_error(Current, "save_archetype_differential", "save_archetype_e3", Void)
			end
			status.wipe_out
			status.append(billboard_content)
			clear_billboard
		ensure
			save_succeeded or else not status.is_empty
		rescue
			post_error(Current, "save_archetype_differential", "report_exception", <<exception.out, exception_trace>>)
			exception_encountered := True
			retry
		end

	save_archetype_flat is
			-- Save current target archetype to its file in its flat form
		require
			Has_target: has_target
		do
			if not exception_encountered then
				status.wipe_out
				save_succeeded := False
				if archetype_valid then
					serialised_flat := adl_engine.serialise(archetype_flat, "adl")
					target.save_flat (serialised_flat)
					save_succeeded := True
				else
					post_error(Current, "save_archetype_flat", "save_archetype_e2", Void)
				end
			else
				post_error(Current, "save_archetype_flat", "save_archetype_e3", Void)
			end
			status.wipe_out
			status.append(billboard_content)
			clear_billboard
		ensure
			save_succeeded or else not status.is_empty
		rescue
			post_error(Current, "save_archetype_flat", "report_exception", <<exception.out, exception_trace>>)
			exception_encountered := True
			retry
		end

	save_archetype_differential_as(a_full_path: STRING; serialise_format: STRING) is
			-- Save current source archetype to `a_full_path' in `serialise_format'.
		require
			Has_target: has_target
			path_valid: a_full_path /= Void and then not a_full_path.is_empty
			Serialise_format_valid: serialise_format /= Void and then has_archetype_serialiser_format(serialise_format)
		do
			if not exception_encountered then
				status.wipe_out
				save_succeeded := False

				if archetype_valid then
					serialised_differential := adl_engine.serialise(archetype_differential, serialise_format)

					if serialise_format.same_string ("adl") then
						target.save_differential_as (a_full_path, serialised_differential)
					else
						target.file_repository.save_text_to_file (a_full_path, serialised_differential)
					end

					save_succeeded := True
				else
					post_error (Current, "save_archetype", "save_archetype_e2", Void)
				end
			else
				post_error (Current, "save_archetype", "save_archetype_e3", Void)
			end

			status.wipe_out
			status.append(billboard_content)
			clear_billboard
		ensure
			save_succeeded or else not status.is_empty
		rescue
			post_error(Current, "save_archetype", "report_exception", <<exception.out, exception_trace>>)
			exception_encountered := True
			retry
		end

	save_archetype_flat_as(a_full_path: STRING; serialise_format: STRING) is
			-- Save current flat archetype to `a_full_path' in `serialise_format'.
		require
			Has_target: has_target
			path_valid: a_full_path /= Void and then not a_full_path.is_empty
			Serialise_format_valid: serialise_format /= Void and then has_archetype_serialiser_format(serialise_format)
		do
			if not exception_encountered then
				status.wipe_out
				save_succeeded := False

				if archetype_valid then
					serialised_flat := adl_engine.serialise(archetype_flat, serialise_format)

					if serialise_format.same_string ("adl") then
						target.save_flat_as (a_full_path, serialised_flat)
					else
						target.file_repository.save_text_to_file (a_full_path, serialised_flat)
					end

					save_succeeded := True
				else
					post_error (Current, "save_archetype", "save_archetype_e2", Void)
				end
			else
				post_error (Current, "save_archetype", "save_archetype_e3", Void)
			end

			status.wipe_out
			status.append(billboard_content)
			clear_billboard
		ensure
			save_succeeded or else not status.is_empty
		rescue
			post_error(Current, "save_archetype", "report_exception", <<exception.out, exception_trace>>)
			exception_encountered := True
			retry
		end

	serialise_archetype(serialise_format: STRING) is
			-- Serialise archetype into string for both flat and differential forms
			-- result available in `serialised_flat' and `serialised_differential'
		require
			Has_target: has_target and archetype_valid
			Serialise_format_valid: serialise_format /= Void and then has_archetype_serialiser_format(serialise_format)
		do
			if not exception_encountered then
				serialised_differential := adl_engine.serialise(archetype_differential, serialise_format)
				serialised_flat := adl_engine.serialise(archetype_flat, serialise_format)
			else
				post_error(Current, "serialise_archetype", "serialise_archetype_e2", Void)
			end
			status.wipe_out
			status.append(billboard_content)
			clear_billboard
		ensure
			(serialised_differential /= Void and serialised_flat /= Void) or else not status.is_empty
		rescue
			post_error(Current, "serialise_archetype", "report_exception", <<exception.out, exception_trace>>)
			exception_encountered := True
			retry
		end

feature -- External Java Interface

	set_status(a_str: STRING) is
			-- set status from external wrapper
		do
			status := a_str
		end

	set_exception_encountered is
			--
		do
			exception_encountered := True
		end

feature {NONE} -- Implementation

	adl_engine: !ADL_ENGINE

end



--|
--| ***** BEGIN LICENSE BLOCK *****
--| Version: MPL 1.1/GPL 2.0/LGPL 2.1
--|
--| The contents of this file are subject to the Mozilla Public License Version
--| 1.1 (the 'License'); you may not use this file except in compliance with
--| the License. You may obtain a copy of the License at
--| http://www.mozilla.org/MPL/
--|
--| Software distributed under the License is distributed on an 'AS IS' basis,
--| WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
--| for the specific language governing rights and limitations under the
--| License.
--|
--| The Original Code is adl_interface.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2003-2004
--| the Initial Developer. All Rights Reserved.
--|
--| Contributor(s):
--|
--| Alternatively, the contents of this file may be used under the terms of
--| either the GNU General Public License Version 2 or later (the 'GPL'), or
--| the GNU Lesser General Public License Version 2.1 or later (the 'LGPL'),
--| in which case the provisions of the GPL or the LGPL are applicable instead
--| of those above. If you wish to allow use of your version of this file only
--| under the terms of either the GPL or the LGPL, and not to allow others to
--| use your version of this file under the terms of the MPL, indicate your
--| decision by deleting the provisions above and replace them with the notice
--| and other provisions required by the GPL or the LGPL. If you do not delete
--| the provisions above, a recipient may use your version of this file under
--| the terms of any one of the MPL, the GPL or the LGPL.
--|
--| ***** END LICENSE BLOCK *****
--|
