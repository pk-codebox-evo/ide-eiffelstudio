/*-----------------------------------------------------------
Implemented `IContinue' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ICONTINUE_IMPL_PROXY_S_H__
#define __ECOM_CONTROL_LIBRARY_ICONTINUE_IMPL_PROXY_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IContinue_impl_proxy;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IContinue_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IContinue_impl_proxy
{
public:
	IContinue_impl_proxy (IUnknown * a_pointer);
	virtual ~IContinue_impl_proxy ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_fcontinue();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_control_library::IContinue * p_IContinue;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif