indexing
	description: "Access to Java array of 'long'"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	JAVA_LONG_ARRAY

inherit
	JAVA_ARRAY 

create
	make,
	make_from_pointer
	
feature -- Initialization

	make (size: INTEGER) is
			-- Create a new Java array and an Eiffel accessor object
			-- Note: Java arrays are indexed from zero
		require
			size_ok: size > 0		
		do
			jarray := jni.new_long_array (size)
			create jvalue.make
		ensure
			array_ok: jarray /= default_pointer	
		end

feature -- Access

	item (index: INTEGER): INTEGER_64 is
			-- Item at `index'.
		require
			valid_index: valid_index (index)
		local
			l_array_ptr: POINTER
		do
			l_array_ptr := jni.get_long_array_elements (jarray, default_pointer)
			jvalue.make_by_pointer (l_array_ptr + index * sizeof_jlong)
			Result := jvalue.long_value
			jni.release_long_array_elements (jarray, l_array_ptr, 0)
		end

feature -- Element change

	put (an_item: INTEGER_64; index: INTEGER) is
			-- Put `an_item' at `index'. 
		require
			valid_index: valid_index (index)
		local
			l_array_ptr: POINTER
		do
			l_array_ptr := jni.get_long_array_elements (jarray, default_pointer)
			jvalue.make_by_pointer (l_array_ptr + index * sizeof_jlong)
			jvalue.set_long_value (an_item)
			jni.release_long_array_elements (jarray, l_array_ptr, 0)
		ensure
			inserted: item (index) = an_item
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end

