-- This file has been generated by EWG. Do not edit. Changes will be lost!
-- functions wrapper
class CFBASE_FUNCTIONS_EXTERNAL

feature
	frozen cfrange_make_external (loc: INTEGER; len: INTEGER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFIndex, CFIndex):CFRange*"
		alias
			"ewg_function___CFRangeMake"
		end

	frozen cfrange_make_address_external: POINTER is
			-- Address of C function `__CFRangeMake'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) __CFRangeMake"
		end

	frozen cfnull_get_type_id_external: INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] :CFTypeID"
		alias
			"ewg_function_macro_CFNullGetTypeID"
		end

	frozen cfnull_get_type_id_address_external: POINTER is
			-- Address of C function `CFNullGetTypeID'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFNullGetTypeID"
		end

	frozen cfallocator_get_type_id_external: INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] :CFTypeID"
		alias
			"ewg_function_macro_CFAllocatorGetTypeID"
		end

	frozen cfallocator_get_type_id_address_external: POINTER is
			-- Address of C function `CFAllocatorGetTypeID'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFAllocatorGetTypeID"
		end

	frozen cfallocator_set_default_external (allocator: POINTER) is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef)"
		alias
			"ewg_function_macro_CFAllocatorSetDefault"
		end

	frozen cfallocator_set_default_address_external: POINTER is
			-- Address of C function `CFAllocatorSetDefault'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFAllocatorSetDefault"
		end

	frozen cfallocator_get_default_external: POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] :CFAllocatorRef"
		alias
			"ewg_function_macro_CFAllocatorGetDefault"
		end

	frozen cfallocator_get_default_address_external: POINTER is
			-- Address of C function `CFAllocatorGetDefault'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFAllocatorGetDefault"
		end

	frozen cfallocator_create_external (allocator: POINTER; context: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, CFAllocatorContext*):CFAllocatorRef"
		alias
			"ewg_function_macro_CFAllocatorCreate"
		end

	frozen cfallocator_create_address_external: POINTER is
			-- Address of C function `CFAllocatorCreate'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFAllocatorCreate"
		end

	frozen cfallocator_allocate_external (allocator: POINTER; size: INTEGER; hint: INTEGER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, CFIndex, CFOptionFlags):void*"
		alias
			"ewg_function_macro_CFAllocatorAllocate"
		end

	frozen cfallocator_allocate_address_external: POINTER is
			-- Address of C function `CFAllocatorAllocate'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFAllocatorAllocate"
		end

	frozen cfallocator_reallocate_external (allocator: POINTER; ptr: POINTER; newsize: INTEGER; hint: INTEGER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, void*, CFIndex, CFOptionFlags):void*"
		alias
			"ewg_function_macro_CFAllocatorReallocate"
		end

	frozen cfallocator_reallocate_address_external: POINTER is
			-- Address of C function `CFAllocatorReallocate'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFAllocatorReallocate"
		end

	frozen cfallocator_deallocate_external (allocator: POINTER; ptr: POINTER) is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, void*)"
		alias
			"ewg_function_macro_CFAllocatorDeallocate"
		end

	frozen cfallocator_deallocate_address_external: POINTER is
			-- Address of C function `CFAllocatorDeallocate'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFAllocatorDeallocate"
		end

	frozen cfallocator_get_preferred_size_for_size_external (allocator: POINTER; size: INTEGER; hint: INTEGER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, CFIndex, CFOptionFlags):CFIndex"
		alias
			"ewg_function_macro_CFAllocatorGetPreferredSizeForSize"
		end

	frozen cfallocator_get_preferred_size_for_size_address_external: POINTER is
			-- Address of C function `CFAllocatorGetPreferredSizeForSize'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFAllocatorGetPreferredSizeForSize"
		end

	frozen cfallocator_get_context_external (allocator: POINTER; context: POINTER) is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFAllocatorRef, CFAllocatorContext*)"
		alias
			"ewg_function_macro_CFAllocatorGetContext"
		end

	frozen cfallocator_get_context_address_external: POINTER is
			-- Address of C function `CFAllocatorGetContext'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFAllocatorGetContext"
		end

	frozen cfget_type_id_external (cf: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFTypeRef):CFTypeID"
		alias
			"ewg_function_macro_CFGetTypeID"
		end

	frozen cfget_type_id_address_external: POINTER is
			-- Address of C function `CFGetTypeID'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFGetTypeID"
		end

	frozen cfcopy_type_iddescription_external (type_id: INTEGER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFTypeID):CFStringRef"
		alias
			"ewg_function_macro_CFCopyTypeIDDescription"
		end

	frozen cfcopy_type_iddescription_address_external: POINTER is
			-- Address of C function `CFCopyTypeIDDescription'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFCopyTypeIDDescription"
		end

	frozen cfretain_external (cf: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFTypeRef):CFTypeRef"
		alias
			"ewg_function_macro_CFRetain"
		end

	frozen cfretain_address_external: POINTER is
			-- Address of C function `CFRetain'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFRetain"
		end

	frozen cfrelease_external (cf: POINTER) is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFTypeRef)"
		alias
			"ewg_function_macro_CFRelease"
		end

	frozen cfrelease_address_external: POINTER is
			-- Address of C function `CFRelease'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFRelease"
		end

	frozen cfget_retain_count_external (cf: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFTypeRef):CFIndex"
		alias
			"ewg_function_macro_CFGetRetainCount"
		end

	frozen cfget_retain_count_address_external: POINTER is
			-- Address of C function `CFGetRetainCount'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFGetRetainCount"
		end

	frozen cfmake_collectable_external (cf: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFTypeRef):CFTypeRef"
		alias
			"ewg_function_macro_CFMakeCollectable"
		end

	frozen cfmake_collectable_address_external: POINTER is
			-- Address of C function `CFMakeCollectable'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFMakeCollectable"
		end

	frozen cfequal_external (cf1: POINTER; cf2: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFTypeRef, CFTypeRef):Boolean"
		alias
			"ewg_function_macro_CFEqual"
		end

	frozen cfequal_address_external: POINTER is
			-- Address of C function `CFEqual'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFEqual"
		end

	frozen cfhash_external (cf: POINTER): INTEGER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFTypeRef):CFHashCode"
		alias
			"ewg_function_macro_CFHash"
		end

	frozen cfhash_address_external: POINTER is
			-- Address of C function `CFHash'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFHash"
		end

	frozen cfcopy_description_external (cf: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFTypeRef):CFStringRef"
		alias
			"ewg_function_macro_CFCopyDescription"
		end

	frozen cfcopy_description_address_external: POINTER is
			-- Address of C function `CFCopyDescription'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFCopyDescription"
		end

	frozen cfget_allocator_external (cf: POINTER): POINTER is
		external
			"C [macro <ewg_carbon_function_c_glue_code.h>] (CFTypeRef):CFAllocatorRef"
		alias
			"ewg_function_macro_CFGetAllocator"
		end

	frozen cfget_allocator_address_external: POINTER is
			-- Address of C function `CFGetAllocator'
		external
			"C [macro <Carbon/Carbon.h>]: void*"
		alias
			"(void*) CFGetAllocator"
		end

end
