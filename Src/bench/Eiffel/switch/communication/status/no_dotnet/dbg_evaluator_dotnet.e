indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EVALUATOR_DOTNET

create
	make

feature {NONE} -- Initialization

	make is
		do
		end

feature

	init is
		do
		end

feature -- Access

	last_once_available: BOOLEAN
	last_once_failed: BOOLEAN
	
	dotnet_metamorphose_basic_to_reference_value (dmp: DUMP_VALUE): DUMP_VALUE is
		do
		end

	dotnet_metamorphose_basic_to_value (dmp: DUMP_VALUE): DUMP_VALUE is
		do
		end

	dotnet_evaluate_once_function (addr: STRING;  dvalue: DUMP_VALUE; f: E_FEATURE; params: LIST [DUMP_VALUE]): DUMP_VALUE is
		do
		end
		
	dotnet_evaluate_static_function (f: FEATURE_I; ctype: CLASS_TYPE; a_params: ARRAY [DUMP_VALUE]): DUMP_VALUE is
		do
			
		end
		

	dotnet_evaluate_function (addr: STRING; dvalue: DUMP_VALUE; f: FEATURE_I; ctype: CLASS_TYPE; a_params: ARRAY [DUMP_VALUE]): DUMP_VALUE is
		do
		end

end 
