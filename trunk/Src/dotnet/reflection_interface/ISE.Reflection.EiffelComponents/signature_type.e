indexing
	description: "Signature type"
	external_name: "ISE.Reflection.SignatureType"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

class
	SIGNATURE_TYPE

inherit
	SIGNATURE_TYPE_INTERFACE
	
create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Creation routine"
			external_name: "Make"
		do
		end

feature -- Access

	type_eiffel_name: STRING is
		indexing
			description: "Type Eiffel name"
			external_name: "TypeEiffelName"
		do
			Result := internal_type_eiffel_name
		end
	
	type_full_external_name: STRING is
		indexing
			description: "Type external name (full name)"
			external_name: "TypeFullExternalName"
		do
			Result := internal_type_full_external_name
		end
		
feature -- Status Setting

	set_type_eiffel_name (a_name: STRING) is
		indexing
			description: "Set `type_eiffel_name' with `a_name'."
			external_name: "SetTypeEiffelName"
		do
			internal_type_eiffel_name := a_name
		end

	set_type_full_external_name (a_name: STRING) is
		indexing
			description: "Set `type_full_external_name' with `a_name'."
			external_name: "SetTypeFullExternalName"
		do
			internal_type_full_external_name := a_name
		end

feature {NONE} -- Implementation

	internal_type_eiffel_name: STRING 
		indexing
			description: "Value returned by `type_eiffel_name'"
			external_name: "InternalTypeEiffelName"
		end

	internal_type_full_external_name: STRING 
		indexing
			description: "Value returned by `type_full_external_name'"
			external_name: "InternalTypeFullExternalName"
		end
		
end -- class SIGNATURE_TYPE
