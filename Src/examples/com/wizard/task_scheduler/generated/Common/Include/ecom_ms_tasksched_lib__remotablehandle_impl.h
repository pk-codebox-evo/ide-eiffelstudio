/*-----------------------------------------------------------
"Automatically generated by the EiffelCOM Wizard."
Added Record _RemotableHandle
	fContext: LONG
	u: typedef
	
-----------------------------------------------------------*/

#ifndef __ECOM_MS_TASKSCHED_LIB__REMOTABLEHANDLE_IMPL_H__
#define __ECOM_MS_TASKSCHED_LIB__REMOTABLEHANDLE_IMPL_H__

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_MS_TaskSched_lib__RemotableHandle.h"

#include "ecom_grt_globals_mstask_modified_idl_c.h"



#define ccom_x_remotable_handle_f_context(_ptr_) (EIF_INTEGER)(LONG)(((ecom_MS_TaskSched_lib::_RemotableHandle *)_ptr_)->fContext)

#define ccom_x_remotable_handle_set_f_context(_ptr_, _field_) ((((ecom_MS_TaskSched_lib::_RemotableHandle *)_ptr_)->fContext) = (LONG)_field_)

#define ccom_x_remotable_handle_u(_ptr_) (EIF_REFERENCE)(grt_ce_mstask_modified_idl_c.ccom_ce_record_x__midl_iwin_types_0009_union53 (((ecom_MS_TaskSched_lib::_RemotableHandle *)_ptr_)->u))

#define ccom_x_remotable_handle_set_u(_ptr_, _field_) (memcpy (&(((ecom_MS_TaskSched_lib::_RemotableHandle *)_ptr_)->u), (ecom_MS_TaskSched_lib::__MIDL_IWinTypes_0009 *)_field_, sizeof (ecom_MS_TaskSched_lib::__MIDL_IWinTypes_0009)))

#endif
