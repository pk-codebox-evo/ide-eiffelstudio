indexing
	description: "Representation of a select clause"
	external_name: "ISE.Reflection.SelectClause"
	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute ((create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE}).auto_dual) end

class
	SELECT_CLAUSE
	
inherit
 	INHERITANCE_CLAUSE
 
 create
 	make
feature -- Access

	eiffel_keyword: STRING is
		indexing
			description: "Eiffel keyword for inheritance clause"
			external_name: "EiffelKeyword"
		do
			Result := Select_keyword
		end

	Select_keyword: STRING is "select"
		indexing
			description: "Select keyword"
			external_name: "SelectKeyword"
		end
		
feature -- Basic Operations

	string_representation: STRING is
		indexing
			description: "Give a string representation of the inheritance clause."
			external_name: "StringRepresentation"
		do
			Result := source_name
		end
	
 end -- class SELECT_CLAUSE
 
