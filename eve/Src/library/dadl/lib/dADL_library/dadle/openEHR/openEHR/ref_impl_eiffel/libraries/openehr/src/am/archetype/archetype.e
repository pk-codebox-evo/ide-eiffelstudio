note
	component:   "openEHR Archetype Project"
	description: "Archetype abstraction"
	keywords:    "archetype"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.com>"
	copyright:   "Copyright (c) 2003-2008 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/BRANCHES/specialisation/libraries/openehr/src/am/archetype/archetype.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

deferred class ARCHETYPE

inherit
	ARCHETYPE_DEFINITIONS
		export
			{NONE} all;
			{ANY} deep_twin
		end

	ARCHETYPE_TERM_CODE_TOOLS
		export
			{NONE} all;
			{ANY} valid_concept_code, deep_twin
		end

	AUTHORED_RESOURCE
		rename
			synchronise as synchronise_authored_resource
		end

feature -- Initialisation

	make (an_artefact_type: ARTEFACT_TYPE;
			an_id: like archetype_id;
			an_original_language: STRING;
			a_description: RESOURCE_DESCRIPTION;
			a_definition: like definition;
			an_ontology: like ontology)
				-- make from pieces obtained by parsing
		require
			Artefact_type_attached: an_artefact_type /= Void
			Language_valid: an_original_language /= Void and then not an_original_language.is_empty
		do
			artefact_type := an_artefact_type
			adl_version := 	Latest_adl_version
			archetype_id := an_id
			create original_language.make (Default_language_code_set, an_original_language)

			if a_description = Void then
				create description.default_create
			else
				description := a_description
			end

			definition := a_definition
			ontology := an_ontology
			is_dirty := True
		ensure
			Artefact_type_set: artefact_type = an_artefact_type
			Adl_version_set: adl_version = Latest_adl_version
			Id_set: archetype_id = an_id
			Original_language_set: original_language.code_string.is_equal (an_original_language)
			Definition_set: definition = a_definition
			Ontology_set: ontology = an_ontology
			Is_dirty: is_dirty
		end

	make_all(an_artefact_type: ARTEFACT_TYPE;
			an_adl_version: STRING;
			an_id: like archetype_id;
			a_parent_archetype_id: ARCHETYPE_ID;
			is_controlled_flag: BOOLEAN;
			an_original_language: STRING;
			a_translations: HASH_TABLE [TRANSLATION_DETAILS, STRING];
			a_description: RESOURCE_DESCRIPTION;
			a_definition: like definition;
			an_invariants: ARRAYED_LIST[ASSERTION];
			an_ontology: like ontology)
				-- make from all possible items
		require
			Artefact_type_attached: an_artefact_type /= Void
			Language_valid: an_original_language /= Void and then not an_original_language.is_empty
			Translations_valid: a_translations /= Void implies not a_translations.is_empty
			Invariants_valid: an_invariants /= Void implies not an_invariants.is_empty
		do
			make (an_artefact_type, an_id,
					an_original_language, a_description,
					a_definition, an_ontology)
			parent_archetype_id := a_parent_archetype_id
			translations := a_translations
			adl_version := an_adl_version
			is_controlled := is_controlled_flag
			invariants := an_invariants
		ensure
			Artefact_type_set: artefact_type = an_artefact_type
			Adl_version_set: adl_version = an_adl_version
			Is_controlled_set: is_controlled = is_controlled_flag
			Id_set: archetype_id = an_id
			Parent_id_set: parent_archetype_id = a_parent_archetype_id
			Original_language_set: original_language.code_string.is_equal (an_original_language)
			Translations_set: translations = a_translations
			Definition_set: definition = a_definition
			Invariants_set: invariants = an_invariants
			Ontology_set: ontology = an_ontology
			Is_dirty: is_dirty
		end

feature -- Access

	archetype_id: attached ARCHETYPE_ID

	adl_version: STRING
			-- ADL version of this archetype

	artefact_type: ARTEFACT_TYPE
			-- design type of artefact, archetype, template, template-component, etc

	version: STRING
			-- version of this archetype, according to its id
		do
			Result := archetype_id.version_id
		end

	parent_archetype_id: ARCHETYPE_ID
			-- id of specialisation parent of this archetype

	specialisation_depth: INTEGER
			-- infer number of levels of specialisation from concept code
		do
			Result := specialisation_depth_from_code (concept)
		ensure
			non_negative: Result >= 0
		end

	concept: STRING
			-- at-code of concept of the archetype as a whole and the code of its root node
		do
			Result := definition.node_id
		end

	definition: attached C_COMPLEX_OBJECT

	invariants: ARRAYED_LIST[ASSERTION]

	ontology: attached ARCHETYPE_ONTOLOGY

	physical_paths: ARRAYED_LIST [STRING]
			-- physical paths from definition structure for all objects; if no changes made on archetype,
			-- return cached value
		do
			if path_map = Void then
				build_physical_paths
			end
			Result := physical_paths_cache
		end

	physical_leaf_paths: ARRAYED_LIST [STRING]
			-- physical paths from definition structure for leaf objects only; if no changes made on archetype,
			-- return cached value
		do
			if path_map = Void then
				build_physical_paths
			end
			Result := physical_leaf_paths_cache
		end

	logical_paths (a_lang: STRING; leaves_only: BOOLEAN): ARRAYED_LIST [STRING]
			-- paths with human readable terms substituted
		require
			language_attached: a_lang /= Void
			has_language: ontology.has_language(a_lang)
		local
			phys_paths: ARRAYED_LIST [STRING]
		do
			create Result.make (0)
			Result.compare_objects
			if leaves_only then
				phys_paths := physical_leaf_paths
			else
				phys_paths := physical_paths
			end

			from phys_paths.start until phys_paths.off loop
				Result.extend (ontology.physical_to_logical_path (phys_paths.item, a_lang))
				phys_paths.forth
			end
		end

	physical_to_logical_path (a_phys_path: STRING; a_lang: STRING): STRING
			-- generate a logical path in 'a_lang' from a physical path
		require
			Phys_path_valid: a_phys_path /= Void and then not a_phys_path.is_empty
			Lang_valid: a_lang /= Void and then not a_lang.is_empty
		do
			Result := ontology.physical_to_logical_path(a_phys_path, a_lang)
		end

	c_object_at_path (a_path: STRING): C_OBJECT
			-- find the c_object from the path_map matching the path; uses path map so as to pick up
			-- paths generated by internal references
		require
			a_path_valid: a_path /= Void and has_path(a_path)
		do
			Result := path_map.item (a_path)
		end

feature -- Status Report

	has_adl_version: BOOLEAN
			-- True if adl_version is set
		do
			Result := adl_version /= Void
		end

	is_specialised: BOOLEAN
			-- 	True if this archetype identifies a specialisation parent
		do
			Result := specialisation_depth > 0
		end

	has_physical_path(a_path: STRING): BOOLEAN
			-- true if physical path `a_path' exists in this archetype
		do
			Result := physical_paths.has(a_path)
		end

	has_slots: BOOLEAN
			-- true if there are any slots
		do
			Result := slot_index /= Void and then slot_index.count > 0
		end

	has_suppliers: BOOLEAN
			-- true if there are any external references / fillers, i.e. any C_ARCHETYPE_ROOTs
		do
			Result := suppliers_index /= Void and then suppliers_index.count > 0
		end

	has_invariants: BOOLEAN
			-- true if there are invariants
		do
			Result := invariants /= Void
		end

	has_path (a_path: STRING): BOOLEAN
			-- True if a_path exists in this archetype. If asked on a flat archetype, result indicates whether path exists
			-- anywhere in inheritance-flattened archetype. ; uses path map so as to pick up paths generated by internal references
		require
			a_path_valid: a_path /= Void and then not a_path.is_empty
		do
			Result := physical_paths.has (a_path)
		end

	is_dirty: BOOLEAN
			-- marker to be used to indicate if structure has changed in such a way that cached elements have to be regenerated,
			-- or re-validation is needed. Set to False after validation

	is_valid: BOOLEAN
			-- True if archetype is completely validated, including with respect to specialisation parents, where they exist

	valid_adl_version(a_ver: STRING): BOOLEAN
			-- set adl_version with a string containing only '.' and numbers,
			-- not commencing or finishing in '.'
		require
			Valid_string: a_ver /= Void and then not a_ver.is_empty
		local
			str: STRING
		do
			str := a_ver.twin
			str.prune_all ('.')
			Result := str.is_integer and a_ver.item(1) /= '.' and a_ver.item (a_ver.count) /= '.'
		end

	is_generated: BOOLEAN
			-- True if this archetype was generated from another one, rather than being an original authored archetype

	is_template: BOOLEAN
			-- True if `artefact_type' is any type other than archetype
		do
			Result := artefact_type.is_template
		end

feature -- Status Setting

	set_is_valid(a_validity: BOOLEAN)
			-- set is_valid flag
		do
			is_valid := a_validity
			is_dirty := False
		end

	set_is_generated
			-- set is_generated flag
		do
			is_generated := True
		end

feature {ARCHETYPE_VALIDATOR, ARCHETYPE_FLATTENER, C_XREF_BUILDER, EXPR_XREF_BUILDER, ARCH_REP_ARCHETYPE} -- Validation

	build_xrefs
			-- build definition / ontology cross reference tables used for validation and
			-- other purposes
		local
			a_c_iterator: C_VISITOR_ITERATOR
			definition_xref_builder: C_XREF_BUILDER
			expr_iterator: EXPR_VISITOR_ITERATOR
			invariants_xref_builder: EXPR_XREF_BUILDER
		do
			create id_atcodes_index.make(0)
			create data_atcodes_index.make(0)
			create use_node_index.make(0)
			create suppliers_index.make(0)
			create accodes_index.make(0)
			create slot_index.make(0)

			create definition_xref_builder
			definition_xref_builder.initialise(Current)
			create a_c_iterator.make(definition, definition_xref_builder)
			a_c_iterator.do_all

			if has_invariants then
				create invariants_index.make(0)
				create invariants_xref_builder
				from invariants.start until invariants.off loop
					invariants_xref_builder.initialise(Current, invariants.item)
					create expr_iterator.make (invariants.item, invariants_xref_builder)
					expr_iterator.do_all
					invariants.forth
				end
			end
		end

	build_rolled_up_status
			-- set rolled_up_specialisation statuses in nodes of definition
			-- only useful to call for specialised archetypes
		require
			is_specialised
		local
			a_c_iterator: C_VISITOR_ITERATOR
			rollup_builder: C_ROLLUP_BUILDER
		do
			create rollup_builder
			rollup_builder.initialise(ontology, Current.specialisation_depth)
			create a_c_iterator.make(definition, rollup_builder)
			a_c_iterator.do_all
		end

	id_atcodes_index: HASH_TABLE[ARRAYED_LIST[ARCHETYPE_CONSTRAINT], STRING]
			-- table of {list<node>, code} for term codes which identify nodes in archetype (note that there
			-- are other uses of term codes from the ontology, which is why this attribute is not just called
			-- 'term_codes_xref_table')

	data_atcodes_index: HASH_TABLE[ARRAYED_LIST[C_OBJECT], STRING]
			-- table of {list<node>, code} for term codes which appear in archetype nodes as data,
			-- e.g. in C_DV_ORDINAL and C_CODE_PHRASE types

	accodes_index: HASH_TABLE[ARRAYED_LIST[C_OBJECT], STRING]
			-- table of {list<node>, code} for constraint codes in archetype

	use_node_index: HASH_TABLE[ARRAYED_LIST[ARCHETYPE_INTERNAL_REF], STRING]
			-- table of {list<ARCHETYPE_INTERNAL_REF>, target_path}
			-- i.e. <list of use_nodes> keyed by path they point to

	suppliers_index: HASH_TABLE[ARRAYED_LIST[C_ARCHETYPE_ROOT], STRING]
			-- table of {list<C_ARCHETYPE_ROOT>, archetype_id}
			-- i.e. <list of use_archetype nodes> keyed by archetype id they refer to

	invariants_index: HASH_TABLE[ARRAYED_LIST[EXPR_LEAF], STRING]
			-- table of {list<EXPR_LEAF>, target_path}
			-- i.e. <list of invariant leaf nodes> keyed by path they point to

	slot_index: ARRAYED_LIST [ARCHETYPE_SLOT]
			-- list of archetype slots in this archetype

feature -- Modification

	set_adl_version(a_ver: STRING)
			-- set adl_version with a string containing only '.' and numbers,
			-- not commencing or finishing in '.'
		require
			Valid_version: a_ver /= Void and then valid_adl_version(a_ver)
		do
			adl_version := a_ver
		end

	set_archetype_id (an_id: like archetype_id)
		do
			archetype_id := an_id
		end

	set_artefact_type_from_string (s: STRING)
		require
			s /= Void and then (create {ARTEFACT_TYPE}).valid_type_name(s)
		do
			create artefact_type.make_from_type_name(s)
		end

	set_parent_archetype_id (an_id: attached ARCHETYPE_ID)
		do
			parent_archetype_id := an_id
		end

	set_definition (a_node: like definition)
		do
			definition := a_node
		end

	set_invariants(an_assertion_list: ARRAYED_LIST[ASSERTION])
			-- set invariants
		require
			an_assertion_list /= Void
		do
			invariants := an_assertion_list
		end

	set_ontology (a_node: like ontology)
		do
			ontology := a_node
		end

	add_invariant(an_inv: ASSERTION)
			-- add a new invariant
		require
			Invariant_exists: an_inv /= Void
		do
			if invariants = Void then
				create invariants.make(0)
			end
			invariants.extend(an_inv)
		end

	rebuild
			-- rebuild any cached state after changes to definition or invariant structure
		do
			build_xrefs
			build_physical_paths
			if is_specialised then
				build_rolled_up_status
			end
			is_dirty := False
		end

feature -- Output

	as_string: STRING
   		do
   			create Result.make(0)

			Result.append("%N--------------- physical paths -------------%N")
			Result.append(display_paths(physical_paths))

			Result.append("%N--------------- logical paths(en) -------------%N")
			Result.append(display_paths(logical_paths("en", False)))
		end

feature -- Serialisation

	synchronise
			-- synchronise object representation of archetype to forms suitable for
			-- serialisation
		do
			synchronise_authored_resource
			ontology.synchronise_to_tree
		end

feature {NONE} -- Implementation

	build_physical_paths
			-- generate physical paths from definition structure; if no changes made on archetype
		local
			src_node_path: OG_PATH
			src_node_path_str: STRING
			src_nodes: ARRAYED_LIST [ARCHETYPE_INTERNAL_REF]
			tgt_path_c_objects: HASH_TABLE [C_OBJECT, STRING]
			tgt_path_str: STRING
			tgt_path: OG_PATH
			c_o: C_OBJECT
			use_refs_csr: CURSOR
			sorted_physical_paths, sorted_physical_leaf_paths: SORTED_TWO_WAY_LIST [STRING]
		do
			path_map := definition.all_paths

			-- Add full paths of internal references thus giving full set of actual paths
			use_refs_csr := use_node_index.cursor
			from use_node_index.start until use_node_index.off loop
				-- Hash table with arrayed list of ARCHETYPE_INTERNAL_REFs and Key of target
				-- (ie the ref path of the internal reference)
				src_nodes := use_node_index.item_for_iteration
				tgt_path_str := use_node_index.key_for_iteration

				-- only generate derived paths if we are in a flat archetype that has them all, or else in a
				-- differential archetype that happens to have them
				if definition.has_object_path (tgt_path_str) then
					create tgt_path.make_from_string(tgt_path_str)
					tgt_path_c_objects := definition.all_paths_at_path (tgt_path_str)
					c_o ?= definition.c_object_at_path (tgt_path_str)

					-- now add the paths below it
					from src_nodes.start until src_nodes.off loop
						src_node_path := src_nodes.item.representation.path
						src_node_path.last.set_object_id(tgt_path.last.object_id)
						src_node_path_str := src_node_path.as_string

						path_map.force (c_o, src_node_path_str)

						from
							tgt_path_c_objects.start
						until
							tgt_path_c_objects.off
						loop
							path_map.put (tgt_path_c_objects.item_for_iteration,
								src_node_path_str + "/" + tgt_path_c_objects.key_for_iteration)
							tgt_path_c_objects.forth
						end
						src_nodes.forth
					end
				end
				use_node_index.forth
			end
			use_node_index.go_to (use_refs_csr)

			create sorted_physical_paths.make
			create sorted_physical_leaf_paths.make
			from path_map.start until path_map.off loop
				sorted_physical_paths.extend(path_map.key_for_iteration)
				if path_map.item_for_iteration /= Void and path_map.item_for_iteration.is_leaf then
					sorted_physical_leaf_paths.extend(path_map.key_for_iteration)
				end
				path_map.forth
			end

			create physical_paths_cache.make(0)
			physical_paths_cache.append (sorted_physical_paths)
			physical_paths_cache.compare_objects

			create physical_leaf_paths_cache.make(0)
			physical_leaf_paths_cache.append (sorted_physical_leaf_paths)
			physical_leaf_paths_cache.compare_objects
		end

	physical_paths_cache: ARRAYED_LIST [STRING]

	physical_leaf_paths_cache: ARRAYED_LIST [STRING]

	path_map: HASH_TABLE [C_OBJECT, STRING]
			-- complete map of object nodes keyed by path, including paths implied by
			-- use_nodes in definition structure.

	display_arrayed_list (str_lst: ARRAYED_LIST [STRING]): STRING
			--
		require
			str_lst /= Void
		do
			create Result.make(0)
			from
				str_lst.start
			until
				str_lst.off
			loop
				if not str_lst.isfirst then
					Result.append(", ")
				end
				Result.append(str_lst.item)
				str_lst.forth
			end
		end

	display_paths (path_list: ARRAYED_LIST [STRING]): STRING
			-- display terminal paths
		require
			path_list /= Void
		do
			create Result.make(0)
			from path_list.start until path_list.off loop
				if path_list.islast then
					Result.append(path_list.item)
					Result.append("%N")
				end
				path_list.forth
			end
		end

invariant
	Artefact_type_set: artefact_type /= Void
	Concept_valid: concept /= Void and then concept.is_equal (ontology.concept_code)
	Invariants_valid: invariants /= Void implies not invariants.is_empty
	RM_type_validity: definition.rm_type_name.as_lower.is_equal (archetype_id.rm_entity.as_lower)
	Specialisation_validity: is_specialised implies (specialisation_depth > 0 and parent_archetype_id /= Void)

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
--| The Original Code is adl_archetype.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2003-2004
--| the Initial Developer. All Rights Reserved.
--|
--| Contributor(s):
--|	Sam Heard
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
