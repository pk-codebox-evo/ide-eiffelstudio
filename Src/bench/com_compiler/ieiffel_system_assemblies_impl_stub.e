indexing
	description: "Implemented `IEiffelSystemAssemblies' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_SYSTEM_ASSEMBLIES_IMPL_STUB

inherit
	IEIFFEL_SYSTEM_ASSEMBLIES_INTERFACE

	ECOM_STUB

feature -- Access

	assemblies: IENUM_ASSEMBLY_INTERFACE is
			-- Return all of the assemblies in an enumerator
		do
			-- Put Implementation here.
		end

feature -- Basic Operations

	store is
			-- Save changes.
		do
			-- Put Implementation here.
		end

	add_signed_assembly (assembly_identifier: STRING; a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING) is
			-- Add a signed assembly to the project.
			-- `assembly_identifier' [in].  
			-- `a_name' [in].  
			-- `a_version' [in].  
			-- `a_culture' [in].  
			-- `a_publickey' [in].  
		do
			-- Put Implementation here.
		end

	add_unsigned_assembly (assembly_identifier: STRING; a_path: STRING) is
			-- Add a unsigned (local) assembly to the project.
			-- `assembly_identifier' [in].  
			-- `a_path' [in].  
		do
			-- Put Implementation here.
		end

	remove_assembly (assembly_identifier: STRING) is
			-- Remove an assembly from the project.
			-- `assembly_identifier' [in].  
		do
			-- Put Implementation here.
		end

	assembly_properties (assembly_identifier: STRING): IEIFFEL_ASSEMBLY_PROPERTIES_INTERFACE is
			-- Cluster properties.
			-- `assembly_identifier' [in].  
		do
			-- Put Implementation here.
		end

	is_valid_identifier (assembly_identifier: STRING): BOOLEAN is
			-- Checks to see if a assembly identifier is valid
			-- `assembly_identifier' [in].  
		do
			-- Put Implementation here.
		end

	contains_assembly (assembly_identifier: STRING): BOOLEAN is
			-- Checks to see if a assembly identifier has already been added to the project
			-- `assembly_identifier' [in].  
		do
			-- Put Implementation here.
		end

	contains_signed_assembly (a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING): BOOLEAN is
			-- Checks to see if a signed assembly has already been added to the project
			-- `a_name' [in].  
			-- `a_version' [in].  
			-- `a_culture' [in].  
			-- `a_publickey' [in].  
		do
			-- Put Implementation here.
		end

	contains_unsigned_assembly (a_path: STRING): BOOLEAN is
			-- Checks to see if a unsigned assembly has already been added to the project
			-- `a_path' [in].  
		do
			-- Put Implementation here.
		end

	identifier_from_signed_assembly (a_name: STRING; a_version: STRING; a_culture: STRING; a_publickey: STRING): STRING is
			-- Retrieves the identifier for a signed assembly in the project
			-- `a_name' [in].  
			-- `a_version' [in].  
			-- `a_culture' [in].  
			-- `a_publickey' [in].  
		do
			-- Put Implementation here.
		end

	identifier_from_unsigned_assembly (a_path: STRING): STRING is
			-- Retrieves the identifier for a unsigned assembly in the project
			-- `a_path' [in].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IEIFFEL_SYSTEM_ASSEMBLIES_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_stub %"ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IEIFFEL_SYSTEM_ASSEMBLIES_IMPL_STUB

