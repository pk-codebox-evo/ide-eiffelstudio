indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.CodeTypeOfExpression"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CODE_TYPE_OF_EXPRESSION

inherit
	SYSTEM_DLL_CODE_EXPRESSION

create
	make_system_dll_code_type_of_expression_1,
	make_system_dll_code_type_of_expression_2,
	make_system_dll_code_type_of_expression_3,
	make_system_dll_code_type_of_expression

feature {NONE} -- Initialization

	frozen make_system_dll_code_type_of_expression_1 (type: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL creator signature (System.CodeDom.CodeTypeReference) use System.CodeDom.CodeTypeOfExpression"
		end

	frozen make_system_dll_code_type_of_expression_2 (type: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.CodeTypeOfExpression"
		end

	frozen make_system_dll_code_type_of_expression_3 (type: TYPE) is
		external
			"IL creator signature (System.Type) use System.CodeDom.CodeTypeOfExpression"
		end

	frozen make_system_dll_code_type_of_expression is
		external
			"IL creator use System.CodeDom.CodeTypeOfExpression"
		end

feature -- Access

	frozen get_type_code_type_reference: SYSTEM_DLL_CODE_TYPE_REFERENCE is
		external
			"IL signature (): System.CodeDom.CodeTypeReference use System.CodeDom.CodeTypeOfExpression"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_type (value: SYSTEM_DLL_CODE_TYPE_REFERENCE) is
		external
			"IL signature (System.CodeDom.CodeTypeReference): System.Void use System.CodeDom.CodeTypeOfExpression"
		alias
			"set_Type"
		end

end -- class SYSTEM_DLL_CODE_TYPE_OF_EXPRESSION
