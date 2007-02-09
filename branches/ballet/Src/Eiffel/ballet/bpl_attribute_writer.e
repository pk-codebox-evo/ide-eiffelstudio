indexing
	description: "Write out the definition of an attribute"
	author: "Bernd Schoeller"
	date: "$Date$"
	revision: "$Revision$"

class
	BPL_ATTRIBUTE_WRITER

inherit
	BPL_VISITOR

feature -- Main

	write_attribute (l_as: FEATURE_AS) is
			-- Write the definition of the attribute pointed to by `l_as'.
		require
			as_not_void: l_as /= Void
			as_is_attribute: l_as.is_attribute
		local
			field_name: STRING
			func_name: STRING
			return_type: STRING
		do
			field_name := "field."+current_class.class_name+"."+l_as.feature_name
			func_name := "fun."+current_class.class_name+"."+l_as.feature_name
			return_type := bpl_type_for (l_as.body.type)
			bpl_out ("// Attribute: "+l_as.feature_name+" of class "+current_class.class_name+"%N")
			bpl_out ("const "+field_name+":name;%N")
			bpl_out ("function "+func_name+"([ref,name]any,ref) returns ("+return_type+");%N")
			bpl_out ("axiom (forall h:[ref,name]any, Current:ref :: {"+func_name+"(h,Current)} "+
				func_name+"(h,Current) == h[Current,"+field_name+"]);%N")
			bpl_out ("%N")
		end

end
