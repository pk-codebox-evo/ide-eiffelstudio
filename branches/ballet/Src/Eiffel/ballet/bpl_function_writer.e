indexing
	description: "Write out the functional definition for functions"
	author: "Bernd Schoeller"
	date: "$Date$"
	revision: "$Revision$"

class
	BPL_FUNCTION_WRITER

inherit
	BPL_VISITOR

feature -- Main

	write_function (l_as: FEATURE_AS) is
			-- Write the definition of the function pointed to by `l_as'.
		require
			as_not_void: l_as /= Void
			as_is_attribute: l_as.is_function
		local
			func_name: STRING
			return_type: STRING
		do
			func_name := "fun."+current_class.class_name+"."+l_as.feature_name
			return_type := bpl_type_for (l_as.body.type)
			bpl_out ("// Function: "+l_as.feature_name+" of class "+current_class.class_name+"%N")
			bpl_out ("function "+func_name+"([ref,name]any,ref")



			bpl_out (") returns ("+return_type+");%N")
			bpl_out ("%N")
		end

end
