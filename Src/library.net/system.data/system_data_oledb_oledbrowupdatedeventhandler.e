indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.OleDb.OleDbRowUpdatedEventHandler"

frozen external class
	SYSTEM_DATA_OLEDB_OLEDBROWUPDATEDEVENTHANDLER

inherit
	SYSTEM_MULTICASTDELEGATE
		rename
			is_equal as equals_object	
		end
	SYSTEM_ICLONEABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			is_equal as equals_object
		end

create
	make_oledbrowupdatedeventhandler

feature {NONE} -- Initialization

	frozen make_oledbrowupdatedeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Data.OleDb.OleDbRowUpdatedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_DATA_OLEDB_OLEDBROWUPDATEDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Data.OleDb.OleDbRowUpdatedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Data.OleDb.OleDbRowUpdatedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Data.OleDb.OleDbRowUpdatedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_DATA_OLEDB_OLEDBROWUPDATEDEVENTARGS) is
		external
			"IL signature (System.Object, System.Data.OleDb.OleDbRowUpdatedEventArgs): System.Void use System.Data.OleDb.OleDbRowUpdatedEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DATA_OLEDB_OLEDBROWUPDATEDEVENTHANDLER
