

class S_TOGGLE_B_R1

inherit

	S_BUTTON_R1


creation

	make

	
feature 

	make (node: TOGGLE_B_C) is
		do
			create_node (node);
		end;

	context (a_parent: COMPOSITE_C): TOGGLE_B_C is
		do
			!!Result;
			create_context (Result, a_parent);
		end;

end

