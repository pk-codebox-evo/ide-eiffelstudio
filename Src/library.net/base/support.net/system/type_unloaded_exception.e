indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.TypeUnloadedException"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	TYPE_UNLOADED_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_type_unloaded_exception,
	make_type_unloaded_exception_2,
	make_type_unloaded_exception_1

feature {NONE} -- Initialization

	frozen make_type_unloaded_exception is
		external
			"IL creator use System.TypeUnloadedException"
		end

	frozen make_type_unloaded_exception_2 (message: SYSTEM_STRING; inner_exception: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.TypeUnloadedException"
		end

	frozen make_type_unloaded_exception_1 (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.TypeUnloadedException"
		end

end -- class TYPE_UNLOADED_EXCEPTION
