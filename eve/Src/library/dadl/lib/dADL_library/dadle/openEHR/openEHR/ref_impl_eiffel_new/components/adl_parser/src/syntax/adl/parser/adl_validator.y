%{
indexing
	component:   "openEHR Archetype Project"
	description: "Validating parser for Archetype Description Language (ADL)"
	keywords:    "ADL"
	author:      "Thomas Beale <thomas@deepthought.com.au>"
	support:     "Deep Thought Informatics <support@deepthought.com.au>"
	copyright:   "Copyright (c) 2003-2005 Deep Thought Informatics Pty Ltd"
	license:     "The Eiffel Forum Open Source License version 1"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/components/adl_parser/src/syntax/adl/parser/adl_validator.y $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class ADL_VALIDATOR

inherit
	YY_PARSER_SKELETON
		rename
			make as make_parser_skeleton
		redefine
			report_error
		end

	ADL_SCANNER
		rename
			make as make_eiffel_scanner
		end

	ADL_SYNTAX_CONVERTER

	KL_SHARED_EXCEPTIONS
	KL_SHARED_ARGUMENTS

create
	make

%}

%token <STRING> V_IDENTIFIER
%token <STRING> V_ARCHETYPE_ID
%token <STRING> V_LOCAL_TERM_CODE_REF
%token <STRING> V_DADL_TEXT V_CADL_TEXT V_ASSERTION_TEXT
%token <STRING> V_VERSION_STRING

%token SYM_ARCHETYPE SYM_CONCEPT SYM_SPECIALIZE
%token SYM_DEFINITION SYM_LANGUAGE
%token SYM_DESCRIPTION SYM_ONTOLOGY SYM_INVARIANT
%token SYM_ADL_VERSION SYM_IS_CONTROLLED SYM_IS_GENERATED

%%

input: archetype	
		{
			accept
		}
	| error
		{
			abort
		}
	;

archetype: arch_identification 
	   	arch_specialisation 
		arch_concept 
		arch_language 
		arch_description 
		arch_definition 
		arch_invariant
		arch_ontology
	;

arch_identification: arch_head V_ARCHETYPE_ID 
		{
			create archetype_id.make_from_string($2) -- FIXME - should be other make routine
		}
	| SYM_ARCHETYPE error
		{
			raise_error
			report_error("In 'archetype' clause; expecting archetype id (model_issuer-ref_model-model_class.concept.version)")
			abort
		}
	;

arch_head: SYM_ARCHETYPE 
	| SYM_ARCHETYPE arch_meta_data
	;

arch_meta_data: '(' arch_meta_data_items ')'
	;

arch_meta_data_items: arch_meta_data_item
	| arch_meta_data_items ';' arch_meta_data_item
	;

arch_meta_data_item: SYM_ADL_VERSION '=' V_VERSION_STRING
		{
			adl_version := $3
		}
	| SYM_IS_CONTROLLED
		{
			is_controlled := True
		}
	| SYM_IS_GENERATED
		{
			is_generated := True
		}
	;

arch_specialisation: -- empty is ok
	| SYM_SPECIALIZE V_ARCHETYPE_ID 
		{
			create parent_archetype_id.make_from_string($2) -- FIXME - should be other make routine
			if not parent_archetype_id.semantic_id.is_equal(archetype_id.semantic_parent_id) then
				raise_error
				report_error("Archetype id not based on specialisation parent archetype id")
				abort
			end
		}
	| SYM_SPECIALIZE error
		{
			raise_error
			report_error("In 'specialise' clause; expecting parent archetype id (model_issuer-ref_model-model_class.concept.version)")
			abort
		}
	;

arch_concept: SYM_CONCEPT V_LOCAL_TERM_CODE_REF 
		{
			concept := $2
			debug("ADL_parse")
				io.put_string("concept = " + concept + "%N")
			end
		}
	| SYM_CONCEPT error
		{
			raise_error
			report_error("In 'concept' clause; expecting TERM_CODE reference")
			abort
		}
	;

arch_language: -- empty is ok for ADL 1.4 tools
	| SYM_LANGUAGE V_DADL_TEXT
		{
			convert_dadl_language($2)
			language_text := $2
		}
	| SYM_LANGUAGE error
		{
			raise_error
			report_error("Error in language section")
			abort
		}
	;

arch_description: -- no meta-data ok
	| SYM_DESCRIPTION V_DADL_TEXT 
		{ 
			convert_dadl_language($2)
			description_text := $2
		}
	| SYM_DESCRIPTION error
		{
			raise_error
			report_error("Error in description section")
			abort
		}
	;
		

arch_definition:	SYM_DEFINITION V_CADL_TEXT	
		{
			definition_text := $2
		}
	| SYM_DEFINITION error
		{
			raise_error
			report_error("Error in definition section")
			abort
		}
	;

arch_invariant: -- no invariant ok
	| SYM_INVARIANT V_ASSERTION_TEXT
		{
			invariant_text := $2
		}
	| SYM_INVARIANT error
		{
			raise_error
			report_error("Error in invariant section")
			abort
		}
	;

arch_ontology: SYM_ONTOLOGY V_DADL_TEXT
		{
			ontology_text := $2
		}
	| SYM_ONTOLOGY error
		{
			raise_error
			report_error("Error in ontology section")
			abort
		}
	;

%%

feature -- Initialization

	make is
			-- Create a new Eiffel parser.
		do
			make_eiffel_scanner
			make_parser_skeleton
		end

	execute(in_text:STRING) is
		do
			reset
			create error_text.make(0)
			set_input_buffer (new_string_buffer (in_text))
			parse
		end

feature {YY_PARSER_ACTION} -- Basic Operations

	report_error (a_message: STRING) is
			-- Print error message.
		local
			f_buffer: YY_FILE_BUFFER
		do
			f_buffer ?= input_buffer
			if f_buffer /= Void then
				error_text.append (f_buffer.file.name + ", line ")
			else
				error_text.append ("line ")
			end
			error_text.append (in_lineno.out + ": " + a_message + " [last token = " + token_name(last_token) + "]%N")
		end

feature -- Parse Output

	archetype_id: ARCHETYPE_ID

	adl_version: STRING

	is_controlled: BOOLEAN

	is_generated: BOOLEAN

	parent_archetype_id: ARCHETYPE_ID

	concept: STRING

	language_text: STRING

	description_text: STRING

	definition_text: STRING

	invariant_text: STRING
	
	ontology_text: STRING

feature -- Access

	error_text: STRING

feature {NONE} -- Implementation 

	str: STRING

end
