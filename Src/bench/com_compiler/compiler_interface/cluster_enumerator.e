indexing
	description: "Implemented `IEnumCluster' Interface."
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_ENUMERATOR

inherit
	IENUM_CLUSTER_INTERFACE

	ECOM_STUB

	IENUM_STUB [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE]

create 
	make

feature -- Basic Operations

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: like Current): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_EiffelComCompiler::IEnumCluster_impl_stub %"ecom_EiffelComCompiler_IEnumCluster_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- CLUSTER_ENUMERATOR

