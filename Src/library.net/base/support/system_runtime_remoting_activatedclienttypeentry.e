indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.ActivatedClientTypeEntry"

external class
	SYSTEM_RUNTIME_REMOTING_ACTIVATEDCLIENTTYPEENTRY

inherit
	SYSTEM_RUNTIME_REMOTING_TYPEENTRY
		redefine
			to_string
		end

create
	make_activated_client_type_entry,
	make_activated_client_type_entry_1

feature {NONE} -- Initialization

	frozen make_activated_client_type_entry (typeName2: STRING; assemblyName2: STRING; appUrl: STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Runtime.Remoting.ActivatedClientTypeEntry"
		end

	frozen make_activated_client_type_entry_1 (type: SYSTEM_TYPE; appUrl: STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.Runtime.Remoting.ActivatedClientTypeEntry"
		end

feature -- Access

	frozen get_application_url: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.ActivatedClientTypeEntry"
		alias
			"get_ApplicationUrl"
		end

	frozen get_object_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Remoting.ActivatedClientTypeEntry"
		alias
			"get_ObjectType"
		end

	frozen get_context_attributes: ARRAY [SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTATTRIBUTE] is
		external
			"IL signature (): System.Runtime.Remoting.Contexts.IContextAttribute[] use System.Runtime.Remoting.ActivatedClientTypeEntry"
		alias
			"get_ContextAttributes"
		end

feature -- Element Change

	frozen set_context_attributes (value: ARRAY [SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTATTRIBUTE]) is
		external
			"IL signature (System.Runtime.Remoting.Contexts.IContextAttribute[]): System.Void use System.Runtime.Remoting.ActivatedClientTypeEntry"
		alias
			"set_ContextAttributes"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.ActivatedClientTypeEntry"
		alias
			"ToString"
		end

end -- class SYSTEM_RUNTIME_REMOTING_ACTIVATEDCLIENTTYPEENTRY
