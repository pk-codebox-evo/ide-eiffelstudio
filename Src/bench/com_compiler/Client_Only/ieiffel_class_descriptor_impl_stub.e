indexing
	description: "Implemented `IEiffelClassDescriptor' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IEIFFEL_CLASS_DESCRIPTOR_IMPL_STUB

inherit
	IEIFFEL_CLASS_DESCRIPTOR_INTERFACE

	ECOM_STUB

feature -- Access

	name: STRING is
			-- Class name.
		do
			-- Put Implementation here.
		end

	description: STRING is
			-- Class description.
		do
			-- Put Implementation here.
		end

	external_name: STRING is
			-- Class external name.
		do
			-- Put Implementation here.
		end

	tool_tip: STRING is
			-- Class Tool Tip.
		do
			-- Put Implementation here.
		end

	is_in_system: BOOLEAN is
			-- Is class in system?
		do
			-- Put Implementation here.
		end

	feature_names: ECOM_ARRAY [STRING] is
			-- List of names of class features.
		do
			-- Put Implementation here.
		end

	features: IENUM_FEATURE_INTERFACE is
			-- List of class features.
		do
			-- Put Implementation here.
		end

	feature_count: INTEGER is
			-- Number of class features.
		do
			-- Put Implementation here.
		end

	flat_features: IENUM_FEATURE_INTERFACE is
			-- List of class features including ancestor features.
		do
			-- Put Implementation here.
		end

	flat_feature_count: INTEGER is
			-- Number of flat class features.
		do
			-- Put Implementation here.
		end

	inherited_features: IENUM_FEATURE_INTERFACE is
			-- List of class inherited features.
		do
			-- Put Implementation here.
		end

	inherited_feature_count: INTEGER is
			-- Number of inherited features.
		do
			-- Put Implementation here.
		end

	creation_routines: IENUM_FEATURE_INTERFACE is
			-- List of class creation routines.
		do
			-- Put Implementation here.
		end

	creation_routine_count: INTEGER is
			-- Number of creation routines.
		do
			-- Put Implementation here.
		end

	clients: IENUM_EIFFEL_CLASS_INTERFACE is
			-- List of class clients.
		do
			-- Put Implementation here.
		end

	client_count: INTEGER is
			-- Number of class clients.
		do
			-- Put Implementation here.
		end

	suppliers: IENUM_EIFFEL_CLASS_INTERFACE is
			-- List of class suppliers.
		do
			-- Put Implementation here.
		end

	supplier_count: INTEGER is
			-- Number of class suppliers.
		do
			-- Put Implementation here.
		end

	ancestors: IENUM_EIFFEL_CLASS_INTERFACE is
			-- List of direct ancestors of class.
		do
			-- Put Implementation here.
		end

	ancestor_count: INTEGER is
			-- Number of direct ancestors.
		do
			-- Put Implementation here.
		end

	descendants: IENUM_EIFFEL_CLASS_INTERFACE is
			-- List of direct descendants of class.
		do
			-- Put Implementation here.
		end

	descendant_count: INTEGER is
			-- Number of direct descendants.
		do
			-- Put Implementation here.
		end

	class_path: STRING is
			-- Full path to file.
		do
			-- Put Implementation here.
		end

	is_deferred: BOOLEAN is
			-- Is class deferred?
		do
			-- Put Implementation here.
		end

	is_external: BOOLEAN is
			-- Is class external?
		do
			-- Put Implementation here.
		end

	is_generic: BOOLEAN is
			-- Is class generic?
		do
			-- Put Implementation here.
		end

	is_library: BOOLEAN is
			-- Is class part of a library?
		do
			-- Put Implementation here.
		end

feature -- Basic Operations

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IEIFFEL_CLASS_DESCRIPTOR_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_EiffelComCompiler::IEiffelClassDescriptor_impl_stub %"ecom_EiffelComCompiler_IEiffelClassDescriptor_impl_stub.h%"](EIF_OBJECT)"
		end

end -- IEIFFEL_CLASS_DESCRIPTOR_IMPL_STUB

