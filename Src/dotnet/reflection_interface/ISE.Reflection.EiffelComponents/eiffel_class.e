indexing
	description: "Include all the information needed to produce class Eiffel code and XML file."
	external_name: "ISE.Reflection.EiffelClass"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

class
	EIFFEL_CLASS

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize attributes."
			external_name: "Make"
		do
			create parents.make
			create initialization_features.make
			create access_features.make
			create element_change_features.make
			create basic_operations.make
			create unary_operators_features.make
			create binary_operators_features.make
			create special_features.make
			create implementation_features.make
			create invariants.make
		ensure
			non_void_parents: parents /= Void
			non_void_initialization_features: initialization_features /= Void
			non_void_access_features: access_features /= Void
			non_void_element_change_features: element_change_features /= Void
			non_void_basic_operations: basic_operations /= Void
			non_void_unary_operators_features: unary_operators_features /= Void
			non_void_binary_operators_features: binary_operators_features /= Void
			non_void_special_features: special_features /= Void
			non_void_implementation_features: implementation_features /= Void
			non_void_invariants: invariants /= Void
		end
			
feature -- Access
			
	eiffel_name: STRING
		indexing
			description: "Eiffel name"
			external_name: "EiffelName"
		end
	
	full_external_name: STRING
		indexing
			description: "Full external name (i.e. with namespace)"
			external_name: "FullExternalName"
		end
		
	external_name: STRING 
		indexing
			description: ".NET simple name"
			external_name: "ExternalName"
		end
	
	enum_type: STRING
		indexing
			description: "Enum type (in case current type is an enum)"
			external_name: "EnumType"
		end
		
	assembly_descriptor: ASSEMBLY_DESCRIPTOR
		indexing
			description: "Descriptor of assembly defining current type"
			external_name: "AssemblyDescriptor"
		end
		
	namespace: STRING	
		indexing
			description: "Namespace defining current class"
			external_name: "Namespace"
		end
		
	parents: SYSTEM_COLLECTIONS_HASHTABLE
			-- Key: Parent Eiffel name
			-- Value: Inheritance clauses (ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST [INHERITANCE_CLAUSE]]) 
			-- (array with rename, undefine, redefine, select and export clauses)
		indexing
			description: "Parents"
			external_name: "Parents"
		end
		
	initialization_features: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_FEATURE]
		indexing
			description: "Initialization features"
			external_name: "InitializationFeatures"
		end
		
	access_features: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_FEATURE]
		indexing
			description: "Access features"
			external_name: "AccessFeatures"
		end
		
	element_change_features: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_FEATURE]
		indexing
			description: "Element change features"
			external_name: "ElementChangeFeatures"
		end
		
	basic_operations: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_FEATURE]
		indexing
			description: "Basic operations"
			external_name: "BasicOperations"
		end
		
	unary_operators_features: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_FEATURE]
		indexing
			description: "Unary operators"
			external_name: "UnaryOperatorsFeatures"
		end
		
	binary_operators_features: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_FEATURE]
		indexing
			description: "Binary operators"
			external_name: "BinaryOperatorsFeatures"
		end
		
	special_features: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_FEATURE]	
		indexing
			description: "Special features"
			external_name: "SpecialFeatures"
		end
		
	implementation_features: SYSTEM_COLLECTIONS_ARRAYLIST 
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFEL_FEATURE]		
		indexing
			description: "Implementation features"
			external_name: "ImplementationFeatures"
		end
		
	invariants: SYSTEM_COLLECTIONS_ARRAYLIST
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ARRAY [STRING]] 
			-- | (Array with invariant tag and invariant text)
		indexing
			description: "Class invariants"
			external_name: "Invariants"
		end
	
	generic_derivations: ARRAY [GENERIC_DERIVATION]
		indexing
			description: "List of derivations of the class if it is generic"
			external_name: "GenericDerivations"
		end
	
	constraints: ARRAY [STRING]
		indexing
			description: "Constraints corresponding to the generic types"
			external_name: "Constraints"
		end
		
feature -- Eiffel names from .NET reflection info

	creation_routine_from_info (info: SYSTEM_REFLECTION_CONSTRUCTORINFO): EIFFEL_FEATURE is
		indexing
			description: "Creation routine corresponding to .NET `info'"
			external_name: "CreationRoutineFromInfo"
		require
			non_void_info: info /= Void
		do
			if initialization_features.get_count = 0 then
				Result := Void
			else
				if has_creation_routine (info) then
					Result := routine
				else
					Result := Void
				end
			end
		ensure
			non_void_feature_if_creation_routine_found: has_creation_routine (info) implies Result /= Void	
			void_feature_if_no_creation_routine_or_not_found: (initialization_features.get_count = 0 or else not has_creation_routine (info)) implies Result = Void
		end
		
	attribute_from_info (info: SYSTEM_REFLECTION_MEMBERINFO): EIFFEL_FEATURE is
		indexing
			description: "Eiffel attribute corresponding to .NET `info'"
			external_name: "AttributeFromInfo"
		require
			non_void_info: info /= Void
		do
			if has_attribute (info, initialization_features) then
				Result := attribute
			elseif has_attribute (info, access_features) then
				Result := attribute
			elseif has_attribute (info, element_change_features) then
				Result := attribute
			elseif has_attribute (info, basic_operations) then
				Result := attribute
			elseif has_attribute (info, unary_operators_features) then
				Result := attribute
			elseif has_attribute (info, binary_operators_features) then
				Result := attribute
			elseif has_attribute (info, special_features) then
				Result := attribute
			elseif has_attribute (info, implementation_features) then
				Result := attribute
			else
				Result := Void
			end
		ensure
			non_void_attribute_if_is_initialization_feature: has_attribute (info, initialization_features) implies Result /= Void
			non_void_attribute_if_is_access_feature: has_attribute (info, access_features) implies Result /= Void
			non_void_attribute_if_is_element_change_feature: has_attribute (info, element_change_features) implies Result /= Void
			non_void_attribute_if_is_basic_operation: has_attribute (info, basic_operations) implies Result /= Void
			non_void_attribute_if_is_unary_operator: has_attribute (info, unary_operators_features) implies Result /= Void
			non_void_attribute_if_is_binary_operator: has_attribute (info, binary_operators_features) implies Result /= Void
			non_void_attribute_if_is_special_feature: has_attribute (info, special_features) implies Result /= Void
			non_void_attribute_if_is_implementation_feature: has_attribute (info, implementation_features) implies Result /= Void
			not_found_implies_void_result: (not has_attribute (info, initialization_features) 
									and not has_attribute (info, access_features)
									and not has_attribute (info, element_change_features)
									and not has_attribute (info, basic_operations)
									and not has_attribute (info, unary_operators_features)
									and not has_attribute (info, binary_operators_features)
									and not has_attribute (info, special_features)
									and not has_attribute (info, implementation_features)
									)
									implies Result = Void
		end
		
	routine_from_info (info: SYSTEM_REFLECTION_METHODINFO): EIFFEL_FEATURE is
		indexing
			description: "Eiffel routine corresponding to .NET `info'"
			external_name: "RoutineFromInfo"
		require
			non_void_info: info /= Void
		do
			if has_routine (info, initialization_features) then
				Result := routine
			elseif has_routine (info, access_features) then
				Result := routine
			elseif has_routine (info, element_change_features) then
				Result := routine
			elseif has_routine (info, basic_operations) then
				Result := routine
			elseif has_routine (info, unary_operators_features) then
				Result := routine
			elseif has_routine (info, binary_operators_features) then
				Result := routine
			elseif has_routine (info, special_features) then
				Result := routine
			elseif has_routine (info, implementation_features) then
				Result := routine
			else
				Result := Void
			end			
		ensure
			non_void_routine_if_is_initialization_feature: has_routine (info, initialization_features) implies Result /= Void
			non_void_routine_if_is_access_feature: has_routine (info, access_features) implies Result /= Void
			non_void_routine_if_is_element_change_feature: has_routine (info, element_change_features) implies Result /= Void
			non_void_routine_if_is_basic_operation: has_routine (info, basic_operations) implies Result /= Void
			non_void_routine_if_is_unary_operator: has_routine (info, unary_operators_features) implies Result /= Void
			non_void_routine_if_is_binary_operator: has_routine (info, binary_operators_features) implies Result /= Void
			non_void_routine_if_is_special_feature: has_routine (info, special_features) implies Result /= Void
			non_void_routine_if_is_implementation_feature: has_routine (info, implementation_features) implies Result /= Void
			not_found_implies_void_result: (not has_routine (info, initialization_features) 
									and not has_routine (info, access_features)
									and not has_routine (info, element_change_features)
									and not has_routine (info, basic_operations)
									and not has_routine (info, unary_operators_features)
									and not has_routine (info, binary_operators_features)
									and not has_routine (info, special_features)
									and not has_routine (info, implementation_features)
									)
									implies Result = Void
		end
		
feature -- Status Report

	is_frozen: BOOLEAN
		indexing
			description: "Is class frozen?"
			external_name: "IsFrozen"
		end
		
	is_expanded: BOOLEAN
		indexing
			description: "Is class expanded?"
			external_name: "IsExpanded"
		end
		
	is_deferred: BOOLEAN
		indexing
			description: "Is class deferred?"
			external_name: "IsDeferred"
		end
		
	create_none: BOOLEAN
		indexing
			description: "Does class have `create{NONE}' creation declaration?"
			external_name: "CreateNone"
		end
	
	modified: BOOLEAN
		indexing
			description: "Has current class been modified (i.e. have features been renamed)?"
			external_name: "Modified"
		end
	
	bit_or_infix: BOOLEAN
		indexing
			description: "Has a `bit_or' feature to be generated in current type?"
			external_name: "BitOrInfix"
		end
	
	is_generic: BOOLEAN
		indexing
			description: "Is class generic?"
			external_name: "IsGeneric"
		end
	
feature -- Status Setting

	set_frozen (a_value: BOOLEAN) is
		indexing
			description: "Set `is_frozen' with `a_value'."
			external_name: "SetFrozen"
		do
			is_frozen := a_value
		ensure
			frozen_set: is_frozen = a_value
		end
		
	set_expanded (a_value: BOOLEAN) is
		indexing
			description: "Set `is_expanded' with `expanded'."
			external_name: "SetExpanded"
		do
			is_expanded := a_value
		ensure
			expanded_set: is_expanded = a_value
		end
	
	set_deferred (a_value: BOOLEAN) is
		indexing
			description: "Set `is_deferred' with `deferred'."
			external_name: "SetDeferred"
		do
			is_deferred := a_value
		ensure
			deferred_set: is_deferred = a_value
		end

	set_create_none (a_value: BOOLEAN) is
		indexing
			description: "Set `create_none' with `a_value'."
			external_name: "SetCreateNone"
		do
			create_none := a_value
		ensure
			create_none_set: create_none = a_value
		end
	
	set_modified (a_value: BOOLEAN) is
		indexing
			description: "Set `modified' with `a_value'."
			external_name: "SetModified"
		do
			modified := a_value
		ensure
			modified_set: modified = a_value
		end

	set_bit_or_infix (a_value: BOOLEAN) is
		indexing
			description: "Set `bit_or_infix' with `a_value'."
			external_name: "SetBitOrInfix"
		do
			bit_or_infix := a_value
		ensure
			bit_or_infix_set: bit_or_infix = a_value
		end

	set_generic (a_value: BOOLEAN) is
		indexing
			description: "Set `is_generic' with `a_value'."
			external_name: "SetGeneric"
		do
			is_generic := a_value
		ensure
			is_generic_set: is_generic = a_value
		end
		
	set_eiffel_name (a_name: STRING) is
		indexing
			description: "Set `eiffel_name' with `a_name'."
			external_name: "SetEiffelName"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.get_length > 0
		do
			eiffel_name := a_name
		ensure
			eiffel_name_set: eiffel_name.Equals_String (a_name)
		end
	
	set_external_name (a_name: STRING) is
		indexing
			description: "Set `external_name' with `a_name'."
			external_name: "SetExternalName"
		require
			non_void_name: a_name /= Void
			not_empty_name: a_name.get_length > 0
		do
			external_name := a_name
		ensure
			external_name_set: external_name.Equals_String (a_name)
		end	
	
	set_enum_type (an_enum_type: STRING) is
		indexing
			description: "Set `enum_type' with `an_enum_type'."
			external_name: "SetEnumType"
		require
			non_void_enum_type: an_enum_type /= Void
			not_empty_enum_type: an_enum_type.get_length > 0
		do
			enum_type := an_enum_type
		ensure
			enum_type_set: enum_type.equals_string (an_enum_type)
		end
		
	set_namespace (a_name: STRING) is
		indexing
			description: "Set `namespace' with `a_name'."
			external_name: "SetNamespace"
		require
			non_void_name: a_name /= Void
		do
			namespace := a_name
		ensure
			namespace_set: namespace.Equals_String (a_name)
		end	

	set_external_names (a_full_name: STRING) is 
		indexing
			description: "[
						Set `full_external_name' from `a_full_name'.
						Set `external_name' and `namespace' from `a_full_name'.
					  ]"
			external_name: "SetExternalNames"
		require
			non_void_full_name: a_full_name /= Void
			not_empty_full_name: a_full_name.get_length > 0
		local
			name_elements, namespace_elements: ARRAY [STRING]
			i: INTEGER
		do
			full_external_name := a_full_name
			name_elements := a_full_name.split (<<'.'>>)
			set_external_name (name_elements.item (name_elements.count - 1))
			if name_elements.count > 1 then
				create namespace_elements.make (name_elements.count -1 )
				from
				until
					i > name_elements.count - 2
				loop
					namespace_elements.put (i, name_elements.item (i))
					i := i + 1
				end
				set_namespace (a_full_name.join (".", namespace_elements))
			else
				set_namespace (namespace.empty)
			end
		ensure
			full_external_name_set: full_external_name.Equals_String (a_full_name)
		end

	set_assembly_descriptor (a_descriptor: like assembly_descriptor) is
		indexing
			description: "Set `descriptor' with `a_descriptor'."
			external_name: "SetAssemblyDescriptor"
		require
			non_void_descriptor: a_descriptor /= Void
		do
			assembly_descriptor := a_descriptor
		ensure
			assembly_descriptor_set: assembly_descriptor = a_descriptor
		end
		
	set_full_external_name (a_full_name: STRING) is
		indexing
			description: "Set `full_external_name' from `a_full_name'."
			external_name: "SetFullExternalName"
		require
			non_void_full_name: a_full_name /= Void
			not_empty_full_name: a_full_name.get_length > 0
		do
			full_external_name := a_full_name
		ensure
			full_external_name_set: full_external_name.Equals_String (a_full_name)
		end
	
	set_parents (a_table: like parents) is
		indexing
			description: "Set `parents' with `a_table'."
			external_name: "SetParents"
		require
			non_void_table: a_table /= Void
		do
			parents := a_table
		ensure
			parents_set: parents = a_table
		end

	set_generic_derivations (derivations_table: like generic_derivations) is
		indexing
			description: "Set `generic_derivations' with `derivations_table'."
			external_name: "SetGenericDerivations"
		require
			is_generic: is_generic
			non_void_derivations_table: derivations_table /= Void
		do
			generic_derivations := derivations_table
		ensure
			generic_derivations_set: generic_derivations = derivations_table
		end
	
	set_constraints (constraints_table: like constraints) is
		indexing
			description: "Set `constraints' with `constraints_table'."
			external_name: "SetConstraints"
		require
			is_generic
			non_void_constraints_table: constraints_table /= Void
		do
			constraints	:= constraints_table
		ensure
			constraints_set: constraints = constraints_table
		end
		
feature -- Basic Operations

	add_parent (a_parent: PARENT) is
		indexing
			description: "[
						Add new parent to `parents' with `a_parent' name as key and inheritance clauses as value.
						Inheritance clauses are built from `rename_clauses', `undefine_clauses', `redefine_clauses', `select_clauses', `export_clauses' of `a_parent'.
					  ]"
			external_name: "AddParent"
		require
			non_void_parent: a_parent /= Void
			non_void_name: a_parent.name /= Void
			not_empty_name: a_parent.name.get_length > 0
			non_void_rename_clauses: a_parent.rename_clauses /= Void
			non_void_undefine_clauses: a_parent.undefine_clauses /= Void
			non_void_redefine_clauses: a_parent.redefine_clauses /= Void
			non_void_select_clauses: a_parent.select_clauses /= Void
			non_void_export_clauses: a_parent.export_clauses /= Void
		local
			inheritance_clauses: ARRAY [SYSTEM_COLLECTIONS_ARRAYLIST]
		do
			create inheritance_clauses.make (5)
			inheritance_clauses.put (0, a_parent.rename_clauses)
			inheritance_clauses.put (1, a_parent.undefine_clauses)
			inheritance_clauses.put (2, a_parent.redefine_clauses)
			inheritance_clauses.put (3, a_parent.select_clauses)
			inheritance_clauses.put (4, a_parent.export_clauses)
			
			parents.extend (a_parent.name, inheritance_clauses)
		ensure
			parent_added: parents.contains_key (a_parent.name)
		end
	
	add_initialization_feature (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `initialization_features'."
			external_name: "AddInitializationFeature"
		require
			non_void_feature: a_feature /= Void
		local
			feature_added: INTEGER
		do
			feature_added := initialization_features.extend (a_feature)
		ensure
			feature_added: initialization_features.has (a_feature)
		end
		
	add_access_feature (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `access_features'."
			external_name: "AddAccessFeature"
		require
			non_void_feature: a_feature /= Void
		local
			feature_added: INTEGER
		do
			feature_added := access_features.extend (a_feature)
		ensure
			feature_added: access_features.has (a_feature)
		end
		
	add_element_change_feature (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `element_change_features'."
			external_name: "AddElementChangeFeature"
		require
			non_void_feature: a_feature /= Void
		local
			feature_added: INTEGER
		do
			feature_added := element_change_features.extend (a_feature)
		ensure
			feature_added: element_change_features.has (a_feature)
		end
		
	add_basic_operation (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `basic_operations'."
			external_name: "AddBasicOperation"
		require
			non_void_feature: a_feature /= Void
		local
			feature_added: INTEGER
		do
			feature_added := basic_operations.extend (a_feature)
		ensure
			feature_added: basic_operations.has (a_feature)
		end
		
	add_unary_operator (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `unary_operator_features'."
			external_name: "AddUnaryOperator"
		require
			non_void_feature: a_feature /= Void
		local
			feature_added: INTEGER
		do
			feature_added := unary_operators_features.extend (a_feature)
		ensure
			feature_added: unary_operators_features.has (a_feature)
		end
		
	add_binary_operator (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `binary_operator_features'."
			external_name: "AddBinaryOperator"
		require
			non_void_feature: a_feature /= Void
		local
			feature_added: INTEGER
		do
			feature_added := binary_operators_features.extend (a_feature)
		ensure
			feature_added: binary_operators_features.has (a_feature)
		end
		
	add_special_feature (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `special_features'."
			external_name: "AddSpecialFeature"
		require
			non_void_feature: a_feature /= Void
		local
			feature_added: INTEGER
		do
			feature_added := special_features.extend (a_feature)
		ensure
			feature_added: special_features.has (a_feature)
		end
		
	add_implementation_feature (a_feature: EIFFEL_FEATURE) is
		indexing
			description: "Add `a_feature' to `implementation_features'."
			external_name: "AddImplementationFeature"
		require
			non_void_feature: a_feature /= Void
		local
			feature_added: INTEGER
		do
			feature_added := implementation_features.extend (a_feature)
		ensure
			feature_added: implementation_features.has (a_feature)
		end
	
	add_invariant (a_tag, a_text: STRING) is
		indexing
			description: "Add new invariant (built from `a_tag' and `a_text'  to `invariants'."
			external_name: "AddInvariant"
		require
			non_void_tag: a_tag /= Void
			non_void_text: a_text /= Void
			not_empty_text: a_text.get_length > 0
		local
			invariant_added: INTEGER
			an_invariant: ARRAY [STRING]
		do
			create an_invariant.make (2)
			an_invariant.put (0, a_tag)
			an_invariant.put (1, a_text)
			invariant_added := invariants.extend (an_invariant)	
		end
		
feature {NONE} -- Implementation
		
	has_creation_routine (info: SYSTEM_REFLECTION_CONSTRUCTORINFO): BOOLEAN is
		indexing
			description: "[
						Does current class has creation routine corresponding to `info'?
						If found, make Eiffel feature available in `routine'.
					  ]"
			external_name: "HasCreationRoutine"
		require
			non_void_info: info /= Void
		do
			Result := has_routine (info, initialization_features)
		end

	attribute: EIFFEL_FEATURE
		indexing
			description: "Attribute (Result of `has_attribute' if attribute was found)"
			external_name: "Attribute"
		end
		
	has_attribute (info: SYSTEM_REFLECTION_MEMBERINFO; a_list: SYSTEM_COLLECTIONS_ARRAYLIST): BOOLEAN is
		indexing
			description: "[
						Has `a_table' feature corresponding to `info'?
						If found, make Eiffel feature available in `attribute'.
					  ]"
			external_name: "HasAttribute"
		require
			non_void_info: info /= Void
			non_void_list: a_list /= Void
		local
			i: INTEGER
			eiffel_feature: EIFFEL_FEATURE
			retried: BOOLEAN
		do
			if not retried then
				from
					attribute := Void
				until
					i = a_list.get_count or Result
				loop
					eiffel_feature ?= a_list.get_item (i)
					if eiffel_feature /= Void then
						if info.get_name.equals_String (eiffel_feature.external_name) then
							attribute := eiffel_feature
							Result := True
						end
					end
					i := i + 1
				end
			else
				Result := False
			end
		rescue
			retried := True
			retry
		end

	routine: EIFFEL_FEATURE
		indexing
			description: "Routine (Result of `has_routine' if routine was found)"
			external_name: "Routine"
		end
	
	has_routine (info: SYSTEM_REFLECTION_METHODBASE; a_list: SYSTEM_COLLECTIONS_ARRAYLIST): BOOLEAN is
		indexing
			description: "[
						Has `a_table' feature corresponding to `info'?
						If found, make Eiffel feature available in `routine'.
					  ]"
			external_name: "HasRoutine"
		require
			non_void_info: info /= Void
			non_void_list: a_list /= Void
		local
			i: INTEGER
			eiffel_feature: EIFFEL_FEATURE
			constructor_info: SYSTEM_REFLECTION_CONSTRUCTORINFO
			retried: BOOLEAN
		do
			if not retried then
				constructor_info ?= info
				from
					routine := Void
				until
					i = a_list.get_count or Result
				loop
					eiffel_feature ?= a_list.get_item (i)
					if eiffel_feature /= Void then
						if info.get_name.equals_string (eiffel_feature.external_name) then
							Result := intern_has_routine (eiffel_feature, info)
						elseif constructor_info /= Void then	
							Result := intern_has_routine (eiffel_feature, constructor_info)
						end
					end
					i := i + 1
				end
			else
				Result := False
			end
		rescue
			retried := True
			retry
		end
		
	intern_has_routine (eiffel_feature: EIFFEL_FEATURE; info: SYSTEM_REFLECTION_METHODBASE): BOOLEAN is
		indexing
			description: "[
						Does `eiffel_feature' match with `info'?
						If matching, set `routine' with `eiffel_feature'.
					  ]"
			external_name: "InternHasRoutine"
		require
			non_void_eiffel_feature: eiffel_feature /= Void
			non_void_info: info /= Void
		local
			arguments: SYSTEM_COLLECTIONS_ARRAYLIST
			matching: BOOLEAN		
		do
			arguments := eiffel_feature.arguments
			if arguments.get_count > 0 then
				matching := matching_arguments (info, arguments)
				if matching then
					routine := eiffel_feature
					Result := True
				end
			else
				routine := eiffel_feature
				Result := True
			end
		end
	
	matching_arguments (info: SYSTEM_REFLECTION_METHODBASE; arguments: SYSTEM_COLLECTIONS_ARRAYLIST): BOOLEAN is
		indexing
			description: "Do Eiffel `arguments' match with .NET arguments of `info'?"
			external_name: "MatchingArguments"
		require
			non_void_info: info /= Void
			non_void_arguments: arguments /= Void		
		local
			j: INTEGER	
			an_argument: NAMED_SIGNATURE_TYPE
			retried: BOOLEAN
		do
			if not retried then
				if info.get_parameters /= Void then
					if info.get_parameters.count /= arguments.get_count then
						Result := False
					else
						from
							Result := True
							j := 0
						until
							j = arguments.get_count or not Result
						loop
							an_argument ?= arguments.get_item (j)
							if an_argument /= Void then
								Result := info.get_parameters.item (j).get_parameter_type.get_full_name.equals_String (an_argument.type_full_external_name)
							else
								Result := False
							end
							j := j + 1
						end
					end
				else
					Result := False
				end
			else
				Result := False
			end
		rescue
			retried := True
			retry
		end
		
invariant
	non_void_parents: parents /= Void
	non_void_initialization_features: initialization_features /= Void
	non_void_access_features: access_features /= Void
	non_void_element_change_features: element_change_features /= Void
	non_void_basic_operations: basic_operations /= Void
	non_void_unary_operators_features: unary_operators_features /= Void
	non_void_binary_operators_features: binary_operators_features /= Void
	non_void_special_features: special_features /= Void
	non_void_implementation_features: implementation_features /= Void
	non_void_invariants: invariants /= Void
	frozen_xor_deferred: is_frozen xor is_deferred
	is_expanded_implies_no_creation_routine: is_expanded implies initialization_features.get_count = 0
	not_generic_implies_no_generic_derivations: not is_generic implies generic_derivations = Void
	generic_derivations_implies_generic: generic_derivations /= Void implies is_generic
	
end -- class EIFFEL_CLASS
