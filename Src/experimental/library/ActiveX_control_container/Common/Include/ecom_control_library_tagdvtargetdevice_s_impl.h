/*-----------------------------------------------------------
"Automatically generated by the EiffelCOM Wizard."Added Record tagDVTARGETDEVICE
	tdSize: ULONG
			-- No description available.
	tdDriverNameOffset: USHORT
			-- No description available.
	tdDeviceNameOffset: USHORT
			-- No description available.
	tdPortNameOffset: USHORT
			-- No description available.
	tdExtDevmodeOffset: USHORT
			-- No description available.
	tdData: Pointed Type
			-- No description available.
	
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_TAGDVTARGETDEVICE_S_IMPL_H__
#define __ECOM_CONTROL_LIBRARY_TAGDVTARGETDEVICE_S_IMPL_H__

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagDVTARGETDEVICE_s.h"

#include "ecom_grt_globals_control_interfaces2.h"

#ifdef __cplusplus
extern "C" {
#endif



#ifdef __cplusplus

#define ccom_tag_dvtargetdevice_td_size(_ptr_) (EIF_INTEGER)(ULONG)(((ecom_control_library::tagDVTARGETDEVICE *)_ptr_)->tdSize)

#define ccom_tag_dvtargetdevice_set_td_size(_ptr_, _field_) ((((ecom_control_library::tagDVTARGETDEVICE *)_ptr_)->tdSize) = (ULONG)_field_)

#define ccom_tag_dvtargetdevice_td_driver_name_offset(_ptr_) (EIF_INTEGER)(USHORT)(((ecom_control_library::tagDVTARGETDEVICE *)_ptr_)->tdDriverNameOffset)

#define ccom_tag_dvtargetdevice_set_td_driver_name_offset(_ptr_, _field_) ((((ecom_control_library::tagDVTARGETDEVICE *)_ptr_)->tdDriverNameOffset) = (USHORT)_field_)

#define ccom_tag_dvtargetdevice_td_device_name_offset(_ptr_) (EIF_INTEGER)(USHORT)(((ecom_control_library::tagDVTARGETDEVICE *)_ptr_)->tdDeviceNameOffset)

#define ccom_tag_dvtargetdevice_set_td_device_name_offset(_ptr_, _field_) ((((ecom_control_library::tagDVTARGETDEVICE *)_ptr_)->tdDeviceNameOffset) = (USHORT)_field_)

#define ccom_tag_dvtargetdevice_td_port_name_offset(_ptr_) (EIF_INTEGER)(USHORT)(((ecom_control_library::tagDVTARGETDEVICE *)_ptr_)->tdPortNameOffset)

#define ccom_tag_dvtargetdevice_set_td_port_name_offset(_ptr_, _field_) ((((ecom_control_library::tagDVTARGETDEVICE *)_ptr_)->tdPortNameOffset) = (USHORT)_field_)

#define ccom_tag_dvtargetdevice_td_ext_devmode_offset(_ptr_) (EIF_INTEGER)(USHORT)(((ecom_control_library::tagDVTARGETDEVICE *)_ptr_)->tdExtDevmodeOffset)

#define ccom_tag_dvtargetdevice_set_td_ext_devmode_offset(_ptr_, _field_) ((((ecom_control_library::tagDVTARGETDEVICE *)_ptr_)->tdExtDevmodeOffset) = (USHORT)_field_)

#define ccom_tag_dvtargetdevice_td_data(_ptr_) (EIF_REFERENCE)(rt_ce.ccom_ce_pointed_unsigned_character (((ecom_control_library::tagDVTARGETDEVICE *)_ptr_)->tdData, NULL))

#define ccom_tag_dvtargetdevice_set_td_data(_ptr_, _field_) (grt_ce_control_interfaces2.ccom_free_memory_pointed_15(((ecom_control_library::tagDVTARGETDEVICE *)_ptr_)->tdData), (((ecom_control_library::tagDVTARGETDEVICE *)_ptr_)->tdData) = rt_ec.ccom_ec_pointed_unsigned_character (eif_access (_field_), NULL))

#endif
#ifdef __cplusplus
}
#endif

#endif