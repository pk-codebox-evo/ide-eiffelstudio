indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlTypes.SqlSingle"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DATA_SQL_SINGLE

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals,
			to_string
		end
	DATA_INULLABLE
	ICOMPARABLE

feature -- Initialization

	frozen make_data_sql_single (value: REAL) is
		external
			"IL creator signature (System.Single) use System.Data.SqlTypes.SqlSingle"
		end

	frozen make_data_sql_single_1 (value: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.Data.SqlTypes.SqlSingle"
		end

feature -- Access

	frozen min_value: DATA_SQL_SINGLE is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"MinValue"
		end

	frozen zero: DATA_SQL_SINGLE is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"Zero"
		end

	frozen null: DATA_SQL_SINGLE is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"Null"
		end

	frozen get_is_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.SqlTypes.SqlSingle"
		alias
			"get_IsNull"
		end

	frozen get_value: REAL is
		external
			"IL signature (): System.Single use System.Data.SqlTypes.SqlSingle"
		alias
			"get_Value"
		end

	frozen max_value: DATA_SQL_SINGLE is
		external
			"IL static_field signature :System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"MaxValue"
		end

feature -- Basic Operations

	frozen add (x: DATA_SQL_SINGLE; y: DATA_SQL_SINGLE): DATA_SQL_SINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"Add"
		end

	frozen less_than (x: DATA_SQL_SINGLE; y: DATA_SQL_SINGLE): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"LessThan"
		end

	frozen greater_than (x: DATA_SQL_SINGLE; y: DATA_SQL_SINGLE): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"GreaterThan"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.SqlTypes.SqlSingle"
		alias
			"Equals"
		end

	frozen to_sql_decimal: DATA_SQL_DECIMAL is
		external
			"IL signature (): System.Data.SqlTypes.SqlDecimal use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlDecimal"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlTypes.SqlSingle"
		alias
			"GetHashCode"
		end

	frozen to_sql_double: DATA_SQL_DOUBLE is
		external
			"IL signature (): System.Data.SqlTypes.SqlDouble use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlDouble"
		end

	frozen less_than_or_equal (x: DATA_SQL_SINGLE; y: DATA_SQL_SINGLE): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"LessThanOrEqual"
		end

	frozen to_sql_int64: DATA_SQL_INT64 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt64 use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlInt64"
		end

	frozen compare_to (value: SYSTEM_OBJECT): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.Data.SqlTypes.SqlSingle"
		alias
			"CompareTo"
		end

	frozen greater_than_or_equal (x: DATA_SQL_SINGLE; y: DATA_SQL_SINGLE): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"GreaterThanOrEqual"
		end

	frozen to_sql_int32: DATA_SQL_INT32 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt32 use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlInt32"
		end

	frozen to_sql_money: DATA_SQL_MONEY is
		external
			"IL signature (): System.Data.SqlTypes.SqlMoney use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlMoney"
		end

	frozen equals_sql_single (x: DATA_SQL_SINGLE; y: DATA_SQL_SINGLE): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"Equals"
		end

	frozen to_sql_int16: DATA_SQL_INT16 is
		external
			"IL signature (): System.Data.SqlTypes.SqlInt16 use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlInt16"
		end

	frozen divide (x: DATA_SQL_SINGLE; y: DATA_SQL_SINGLE): DATA_SQL_SINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"Divide"
		end

	frozen to_sql_byte: DATA_SQL_BYTE is
		external
			"IL signature (): System.Data.SqlTypes.SqlByte use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlByte"
		end

	frozen multiply (x: DATA_SQL_SINGLE; y: DATA_SQL_SINGLE): DATA_SQL_SINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"Multiply"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlTypes.SqlSingle"
		alias
			"ToString"
		end

	frozen not_equals (x: DATA_SQL_SINGLE; y: DATA_SQL_SINGLE): DATA_SQL_BOOLEAN is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"NotEquals"
		end

	frozen parse (s: SYSTEM_STRING): DATA_SQL_SINGLE is
		external
			"IL static signature (System.String): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"Parse"
		end

	frozen subtract (x: DATA_SQL_SINGLE; y: DATA_SQL_SINGLE): DATA_SQL_SINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle, System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"Subtract"
		end

	frozen to_sql_string: DATA_SQL_STRING is
		external
			"IL signature (): System.Data.SqlTypes.SqlString use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlString"
		end

	frozen to_sql_boolean: DATA_SQL_BOOLEAN is
		external
			"IL signature (): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"ToSqlBoolean"
		end

feature -- Unary Operators

	frozen prefix "-": DATA_SQL_SINGLE is
		external
			"IL operator signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_UnaryNegation"
		end

feature -- Binary Operators

	frozen infix "|=" (y: DATA_SQL_SINGLE): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Inequality"
		end

	frozen infix ">=" (y: DATA_SQL_SINGLE): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"op_GreaterThanOrEqual"
		end

	frozen infix "#==" (y: DATA_SQL_SINGLE): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Equality"
		end

	frozen infix "-" (y: DATA_SQL_SINGLE): DATA_SQL_SINGLE is
		external
			"IL operator signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Subtraction"
		end

	frozen infix "<=" (y: DATA_SQL_SINGLE): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"op_LessThanOrEqual"
		end

	frozen infix "/" (y: DATA_SQL_SINGLE): DATA_SQL_SINGLE is
		external
			"IL operator signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Division"
		end

	frozen infix "+" (y: DATA_SQL_SINGLE): DATA_SQL_SINGLE is
		external
			"IL operator signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Addition"
		end

	frozen infix ">" (y: DATA_SQL_SINGLE): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"op_GreaterThan"
		end

	frozen infix "<" (y: DATA_SQL_SINGLE): DATA_SQL_BOOLEAN is
		external
			"IL operator signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlBoolean use System.Data.SqlTypes.SqlSingle"
		alias
			"op_LessThan"
		end

	frozen infix "*" (y: DATA_SQL_SINGLE): DATA_SQL_SINGLE is
		external
			"IL operator signature (System.Data.SqlTypes.SqlSingle): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Multiply"
		end

feature -- Specials

	frozen op_implicit_sql_int32 (x: DATA_SQL_INT32): DATA_SQL_SINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt32): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Implicit"
		end

	frozen op_implicit (x: DATA_SQL_INT64): DATA_SQL_SINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt64): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Implicit"
		end

	frozen op_implicit_single (x: REAL): DATA_SQL_SINGLE is
		external
			"IL static signature (System.Single): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Implicit"
		end

	frozen op_explicit_sql_string (x: DATA_SQL_STRING): DATA_SQL_SINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlString): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Explicit"
		end

	frozen op_implicit_sql_byte (x: DATA_SQL_BYTE): DATA_SQL_SINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlByte): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_int16 (x: DATA_SQL_INT16): DATA_SQL_SINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlInt16): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Implicit"
		end

	frozen op_implicit_sql_money (x: DATA_SQL_MONEY): DATA_SQL_SINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlMoney): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Implicit"
		end

	frozen op_explicit (x: DATA_SQL_DOUBLE): DATA_SQL_SINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlDouble): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_boolean (x: DATA_SQL_BOOLEAN): DATA_SQL_SINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlBoolean): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Explicit"
		end

	frozen op_explicit_sql_single (x: DATA_SQL_SINGLE): REAL is
		external
			"IL static signature (System.Data.SqlTypes.SqlSingle): System.Single use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Explicit"
		end

	frozen op_implicit_sql_decimal (x: DATA_SQL_DECIMAL): DATA_SQL_SINGLE is
		external
			"IL static signature (System.Data.SqlTypes.SqlDecimal): System.Data.SqlTypes.SqlSingle use System.Data.SqlTypes.SqlSingle"
		alias
			"op_Implicit"
		end

end -- class DATA_SQL_SINGLE
