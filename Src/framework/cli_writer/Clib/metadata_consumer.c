

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


 /* File created by MIDL compiler version 6.00.0366 */
/* at Tue Jul 24 12:18:23 2007
 */
/* Compiler settings for metadata_consumer.idl:
    Oicf, W1, Zp8, env=Win64 (32b run)
    protocol : dce , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
//@@MIDL_FILE_HEADING(  )

#pragma warning( disable: 4049 )  /* more than 64k source lines */


#ifdef __cplusplus
extern "C"{
#endif 


#include <rpc.h>
#include <rpcndr.h>

#ifdef _MIDL_USE_GUIDDEF_

#ifndef INITGUID
#define INITGUID
#include <guiddef.h>
#undef INITGUID
#else
#include <guiddef.h>
#endif

#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
        DEFINE_GUID(name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8)

#else // !_MIDL_USE_GUIDDEF_

#ifndef __IID_DEFINED__
#define __IID_DEFINED__

typedef struct _IID
{
    unsigned long x;
    unsigned short s1;
    unsigned short s2;
    unsigned char  c[8];
} IID;

#endif // __IID_DEFINED__

#ifndef CLSID_DEFINED
#define CLSID_DEFINED
typedef IID CLSID;
#endif // CLSID_DEFINED

#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
        const type name = {l,w1,w2,{b1,b2,b3,b4,b5,b6,b7,b8}}

#endif !_MIDL_USE_GUIDDEF_

MIDL_DEFINE_GUID(IID, LIBID_EiffelSoftware_MetadataConsumer,0x3A1E9458,0xD7EE,0x3E85,0xAE,0x85,0x7A,0x51,0xF2,0x70,0x63,0x9D);


MIDL_DEFINE_GUID(IID, IID_EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER,0xE1FFE1AC,0xA8FB,0x44AE,0x94,0x51,0x0D,0x55,0x95,0xE8,0xE6,0x20);


MIDL_DEFINE_GUID(CLSID, CLSID_EiffelSoftware_MetadataConsumer_Interop_COM_CACHE_MANAGER,0xE1FFE1AC,0xC5BD,0x492B,0x92,0x4A,0x8D,0xBC,0x9D,0x21,0x12,0xF5);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



