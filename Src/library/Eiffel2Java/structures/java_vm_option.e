indexing
	description: "Description of the JavaVMOption structure."
	date: "$Date$"
	revision: "$Revision$"

class
	JAVA_VM_OPTION

inherit
	MEMORY_STRUCTURE

create
	make

feature -- Access

	option_string: STRING is
			-- Associated option string.
		do
			if internal_option /= Void then
				Result := internal_option.string
			else
				create internal_option.make_by_pointer (c_option_string (item))
			end
		end
		
feature -- Settings

	set_option_string (an_option: STRING) is
			-- Set `an_option' to `option_string'.
		do
			create internal_option.make (an_option)
			c_set_option_string (item, internal_option.item)
		end
		
feature -- Measurement

	structure_size: INTEGER is
			-- Size of structure being allocated.
		do
			Result := c_structure_size
		end
		
feature {NONE} -- Implementation

	internal_option: C_STRING
			-- To hold data.

	c_structure_size: INTEGER is
			-- Size of `JavaVMOption' structure.
		external
			"C macro use %"jni.h%""
		alias
			"sizeof(JavaVMOption)"
		end
		
	c_option_string (an_item: POINTER): POINTER is
			-- Access to `optionString'.
		external
			"C struct JavaVMOption access optionString use %"jni.h%""
		end

	c_extra_info (an_item: POINTER): POINTER is
			-- Access to `extraInfo'.
		external
			"C struct JavaVMOption access extraInfo use %"jni.h%""
		end

	c_set_option_string (an_item: POINTER; l_val: POINTER) is
			-- Access to `optionString'.
		external
			"C struct JavaVMOption access optionString type char * use %"jni.h%""
		end

end -- class JAVA_VM_OPTION

--|----------------------------------------------------------------
--| Eiffel2Java: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

