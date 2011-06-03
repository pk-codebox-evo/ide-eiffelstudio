/**
 * This file has no copyright assigned and is placed in the Public Domain.
 * This file is part of the w64 mingw-runtime package.
 * No warranty is given; refer to the file DISCLAIMER.PD within this package.
 */
#ifndef _NTDSAPI_H_
#define _NTDSAPI_H_

#include <schedule.h>

#if !defined(_NTDSAPI_)
#define NTDSAPI DECLSPEC_IMPORT
#if !defined(_NTDSAPI_POSTXP_ASLIB_)
#define NTDSAPI_POSTXP DECLSPEC_IMPORT
#else
#define NTDSAPI_POSTXP
#endif
#else
#define NTDSAPI
#define NTDSAPI_POSTXP
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define DS_BEHAVIOR_WIN2000 0
#define DS_BEHAVIOR_WIN2003_WITH_MIXED_DOMAINS 1
#define DS_BEHAVIOR_WIN2003 2

#define DS_DEFAULT_LOCALE (MAKELCID(MAKELANGID(LANG_ENGLISH,SUBLANG_ENGLISH_US),SORT_DEFAULT))
#define DS_DEFAULT_LOCALE_COMPARE_FLAGS (NORM_IGNORECASE | NORM_IGNOREKANATYPE | NORM_IGNORENONSPACE | NORM_IGNOREWIDTH | SORT_STRINGSORT)

#define DS_SYNCED_EVENT_NAME "NTDSInitialSyncsCompleted"
#define DS_SYNCED_EVENT_NAME_W L"NTDSInitialSyncsCompleted"

#ifndef _DS_CONTROL_BITS_DEFINED_
#define _DS_CONTROL_BITS_DEFINED_
#define ACTRL_DS_OPEN 0x00000000
#define ACTRL_DS_CREATE_CHILD 0x00000001
#define ACTRL_DS_DELETE_CHILD 0x00000002
#define ACTRL_DS_LIST 0x00000004
#define ACTRL_DS_SELF 0x00000008
#define ACTRL_DS_READ_PROP 0x00000010
#define ACTRL_DS_WRITE_PROP 0x00000020
#define ACTRL_DS_DELETE_TREE 0x00000040
#define ACTRL_DS_LIST_OBJECT 0x00000080
#define ACTRL_DS_CONTROL_ACCESS 0x00000100

#define DS_GENERIC_READ ((STANDARD_RIGHTS_READ) | (ACTRL_DS_LIST) | (ACTRL_DS_READ_PROP) | (ACTRL_DS_LIST_OBJECT))
#define DS_GENERIC_EXECUTE ((STANDARD_RIGHTS_EXECUTE) | (ACTRL_DS_LIST))
#define DS_GENERIC_WRITE ((STANDARD_RIGHTS_WRITE) | (ACTRL_DS_SELF) | (ACTRL_DS_WRITE_PROP))
#define DS_GENERIC_ALL ((STANDARD_RIGHTS_REQUIRED) | (ACTRL_DS_CREATE_CHILD) | (ACTRL_DS_DELETE_CHILD) | (ACTRL_DS_DELETE_TREE) | (ACTRL_DS_READ_PROP) | (ACTRL_DS_WRITE_PROP) | (ACTRL_DS_LIST) | (ACTRL_DS_LIST_OBJECT) | (ACTRL_DS_CONTROL_ACCESS) | (ACTRL_DS_SELF))
#endif

  typedef enum {
    DS_UNKNOWN_NAME = 0,DS_FQDN_1779_NAME = 1,DS_NT4_ACCOUNT_NAME = 2,DS_DISPLAY_NAME = 3,DS_UNIQUE_ID_NAME = 6,DS_CANONICAL_NAME = 7,
    DS_USER_PRINCIPAL_NAME = 8,DS_CANONICAL_NAME_EX = 9,DS_SERVICE_PRINCIPAL_NAME = 10,DS_SID_OR_SID_HISTORY_NAME = 11,DS_DNS_DOMAIN_NAME = 12
  } DS_NAME_FORMAT;

#define DS_DOMAIN_SIMPLE_NAME DS_USER_PRINCIPAL_NAME
#define DS_ENTERPRISE_SIMPLE_NAME DS_USER_PRINCIPAL_NAME

  typedef enum {
    DS_NAME_NO_FLAGS = 0x0,DS_NAME_FLAG_SYNTACTICAL_ONLY = 0x1,DS_NAME_FLAG_EVAL_AT_DC = 0x2,DS_NAME_FLAG_GCVERIFY = 0x4,
    DS_NAME_FLAG_TRUST_REFERRAL = 0x8
  } DS_NAME_FLAGS;

  typedef enum {
    DS_NAME_NO_ERROR = 0,DS_NAME_ERROR_RESOLVING = 1,DS_NAME_ERROR_NOT_FOUND = 2,DS_NAME_ERROR_NOT_UNIQUE = 3,DS_NAME_ERROR_NO_MAPPING = 4,
    DS_NAME_ERROR_DOMAIN_ONLY = 5,DS_NAME_ERROR_NO_SYNTACTICAL_MAPPING = 6,DS_NAME_ERROR_TRUST_REFERRAL = 7
  } DS_NAME_ERROR;

#define DS_NAME_LEGAL_FLAGS (DS_NAME_FLAG_SYNTACTICAL_ONLY)

  typedef enum {
    DS_SPN_DNS_HOST = 0,DS_SPN_DN_HOST = 1,DS_SPN_NB_HOST = 2,DS_SPN_DOMAIN = 3,DS_SPN_NB_DOMAIN = 4,DS_SPN_SERVICE = 5
  } DS_SPN_NAME_TYPE;

  typedef enum {
    DS_SPN_ADD_SPN_OP = 0,DS_SPN_REPLACE_SPN_OP = 1,DS_SPN_DELETE_SPN_OP = 2
  } DS_SPN_WRITE_OP;

  typedef struct {
    DWORD status;
    LPSTR pDomain;
    LPSTR pName;
  } DS_NAME_RESULT_ITEMA,*PDS_NAME_RESULT_ITEMA;

  typedef struct {
    DWORD cItems;
    PDS_NAME_RESULT_ITEMA rItems;
  } DS_NAME_RESULTA,*PDS_NAME_RESULTA;

  typedef struct {
    DWORD status;
    LPWSTR pDomain;
    LPWSTR pName;
  } DS_NAME_RESULT_ITEMW,*PDS_NAME_RESULT_ITEMW;

  typedef struct {
    DWORD cItems;
    PDS_NAME_RESULT_ITEMW rItems;
  } DS_NAME_RESULTW,*PDS_NAME_RESULTW;

#ifdef UNICODE
#define DS_NAME_RESULT DS_NAME_RESULTW
#define PDS_NAME_RESULT PDS_NAME_RESULTW
#define DS_NAME_RESULT_ITEM DS_NAME_RESULT_ITEMW
#define PDS_NAME_RESULT_ITEM PDS_NAME_RESULT_ITEMW
#else
#define DS_NAME_RESULT DS_NAME_RESULTA
#define PDS_NAME_RESULT PDS_NAME_RESULTA
#define DS_NAME_RESULT_ITEM DS_NAME_RESULT_ITEMA
#define PDS_NAME_RESULT_ITEM PDS_NAME_RESULT_ITEMA
#endif

#define NTDSAPI_BIND_ALLOW_DELEGATION (0x00000001)

#define DS_REPSYNC_ASYNCHRONOUS_OPERATION 0x00000001
#define DS_REPSYNC_WRITEABLE 0x00000002
#define DS_REPSYNC_PERIODIC 0x00000004
#define DS_REPSYNC_INTERSITE_MESSAGING 0x00000008
#define DS_REPSYNC_ALL_SOURCES 0x00000010
#define DS_REPSYNC_FULL 0x00000020
#define DS_REPSYNC_URGENT 0x00000040
#define DS_REPSYNC_NO_DISCARD 0x00000080
#define DS_REPSYNC_FORCE 0x00000100
#define DS_REPSYNC_ADD_REFERENCE 0x00000200
#define DS_REPSYNC_NEVER_COMPLETED 0x00000400
#define DS_REPSYNC_TWO_WAY 0x00000800
#define DS_REPSYNC_NEVER_NOTIFY 0x00001000
#define DS_REPSYNC_INITIAL 0x00002000
#define DS_REPSYNC_USE_COMPRESSION 0x00004000
#define DS_REPSYNC_ABANDONED 0x00008000
#define DS_REPSYNC_INITIAL_IN_PROGRESS 0x00010000
#define DS_REPSYNC_PARTIAL_ATTRIBUTE_SET 0x00020000
#define DS_REPSYNC_REQUEUE 0x00040000
#define DS_REPSYNC_NOTIFICATION 0x00080000
#define DS_REPSYNC_ASYNCHRONOUS_REPLICA 0x00100000
#define DS_REPSYNC_CRITICAL 0x00200000
#define DS_REPSYNC_FULL_IN_PROGRESS 0x00400000
#define DS_REPSYNC_PREEMPTED 0x00800000

#define DS_REPADD_ASYNCHRONOUS_OPERATION 0x00000001
#define DS_REPADD_WRITEABLE 0x00000002
#define DS_REPADD_INITIAL 0x00000004
#define DS_REPADD_PERIODIC 0x00000008
#define DS_REPADD_INTERSITE_MESSAGING 0x00000010
#define DS_REPADD_ASYNCHRONOUS_REPLICA 0x00000020
#define DS_REPADD_DISABLE_NOTIFICATION 0x00000040
#define DS_REPADD_DISABLE_PERIODIC 0x00000080
#define DS_REPADD_USE_COMPRESSION 0x00000100
#define DS_REPADD_NEVER_NOTIFY 0x00000200
#define DS_REPADD_TWO_WAY 0x00000400
#define DS_REPADD_CRITICAL 0x00000800

#define DS_REPDEL_ASYNCHRONOUS_OPERATION 0x00000001
#define DS_REPDEL_WRITEABLE 0x00000002
#define DS_REPDEL_INTERSITE_MESSAGING 0x00000004
#define DS_REPDEL_IGNORE_ERRORS 0x00000008
#define DS_REPDEL_LOCAL_ONLY 0x00000010
#define DS_REPDEL_NO_SOURCE 0x00000020
#define DS_REPDEL_REF_OK 0x00000040

#define DS_REPMOD_ASYNCHRONOUS_OPERATION 0x00000001
#define DS_REPMOD_WRITEABLE 0x00000002
#define DS_REPMOD_UPDATE_FLAGS 0x00000001
#define DS_REPMOD_UPDATE_ADDRESS 0x00000002
#define DS_REPMOD_UPDATE_SCHEDULE 0x00000004
#define DS_REPMOD_UPDATE_RESULT 0x00000008
#define DS_REPMOD_UPDATE_TRANSPORT 0x00000010

#define DS_REPUPD_ASYNCHRONOUS_OPERATION 0x00000001
#define DS_REPUPD_WRITEABLE 0x00000002
#define DS_REPUPD_ADD_REFERENCE 0x00000004
#define DS_REPUPD_DELETE_REFERENCE 0x00000008

#define DS_INSTANCETYPE_IS_NC_HEAD 0x00000001
#define DS_INSTANCETYPE_NC_IS_WRITEABLE 0x00000004
#define DS_INSTANCETYPE_NC_COMING 0x00000010
#define DS_INSTANCETYPE_NC_GOING 0x00000020

#define NTDSDSA_OPT_IS_GC (1 << 0)
#define NTDSDSA_OPT_DISABLE_INBOUND_REPL (1 << 1)
#define NTDSDSA_OPT_DISABLE_OUTBOUND_REPL (1 << 2)
#define NTDSDSA_OPT_DISABLE_NTDSCONN_XLATE (1 << 3)

#define NTDSCONN_OPT_IS_GENERATED (1 << 0)
#define NTDSCONN_OPT_TWOWAY_SYNC (1 << 1)
#define NTDSCONN_OPT_OVERRIDE_NOTIFY_DEFAULT (1 << 2)
#define NTDSCONN_OPT_USE_NOTIFY (1 << 3)
#define NTDSCONN_OPT_DISABLE_INTERSITE_COMPRESSION (1 << 4)
#define NTDSCONN_OPT_USER_OWNED_SCHEDULE (1 << 5)

#define NTDSCONN_KCC_NO_REASON (0)
#define NTDSCONN_KCC_GC_TOPOLOGY (1 << 0)
#define NTDSCONN_KCC_RING_TOPOLOGY (1 << 1)
#define NTDSCONN_KCC_MINIMIZE_HOPS_TOPOLOGY (1 << 2)
#define NTDSCONN_KCC_STALE_SERVERS_TOPOLOGY (1 << 3)
#define NTDSCONN_KCC_OSCILLATING_CONNECTION_TOPOLOGY (1 << 4)
#define NTDSCONN_KCC_INTERSITE_GC_TOPOLOGY (1 << 5)
#define NTDSCONN_KCC_INTERSITE_TOPOLOGY (1 << 6)
#define NTDSCONN_KCC_SERVER_FAILOVER_TOPOLOGY (1 << 7)
#define NTDSCONN_KCC_SITE_FAILOVER_TOPOLOGY (1 << 8)
#define NTDSCONN_KCC_REDUNDANT_SERVER_TOPOLOGY (1 << 9)

#define FRSCONN_PRIORITY_MASK 0x70000000
#define FRSCONN_MAX_PRIORITY 0x8

#define NTDSCONN_OPT_IGNORE_SCHEDULE_MASK 0x80000000
#define NTDSCONN_IGNORE_SCHEDULE(_options_) (((_options_) & NTDSCONN_OPT_IGNORE_SCHEDULE_MASK) >> 31)
#define FRSCONN_GET_PRIORITY(_options_) (((((_options_) & FRSCONN_PRIORITY_MASK) >> 28)!=0) ? (((_options_) & FRSCONN_PRIORITY_MASK) >> 28) : FRSCONN_MAX_PRIORITY)

#define NTDSSETTINGS_OPT_IS_AUTO_TOPOLOGY_DISABLED (1 << 0)
#define NTDSSETTINGS_OPT_IS_TOPL_CLEANUP_DISABLED (1 << 1)
#define NTDSSETTINGS_OPT_IS_TOPL_MIN_HOPS_DISABLED (1 << 2)
#define NTDSSETTINGS_OPT_IS_TOPL_DETECT_STALE_DISABLED (1 << 3)
#define NTDSSETTINGS_OPT_IS_INTER_SITE_AUTO_TOPOLOGY_DISABLED (1 << 4)
#define NTDSSETTINGS_OPT_IS_GROUP_CACHING_ENABLED (1 << 5)
#define NTDSSETTINGS_OPT_FORCE_KCC_WHISTLER_BEHAVIOR (1 << 6)
#define NTDSSETTINGS_OPT_FORCE_KCC_W2K_ELECTION (1 << 7)
#define NTDSSETTINGS_OPT_IS_RAND_BH_SELECTION_DISABLED (1 << 8)
#define NTDSSETTINGS_OPT_IS_SCHEDULE_HASHING_ENABLED (1 << 9)
#define NTDSSETTINGS_OPT_IS_REDUNDANT_SERVER_TOPOLOGY_ENABLED (1 << 10)

#define NTDSSETTINGS_OPT_W2K3_IGNORE_SCHEDULES (1 << 11)
#define NTDSSETTINGS_OPT_W2K3_BRIDGES_REQUIRED (1 << 12)
#define NTDSSETTINGS_DEFAULT_SERVER_REDUNDANCY 2

#define NTDSTRANSPORT_OPT_IGNORE_SCHEDULES (1 << 0)
#define NTDSTRANSPORT_OPT_BRIDGES_REQUIRED (1 << 1)

#define NTDSSITECONN_OPT_USE_NOTIFY (1 << 0)
#define NTDSSITECONN_OPT_TWOWAY_SYNC (1 << 1)
#define NTDSSITECONN_OPT_DISABLE_COMPRESSION (1 << 2)

#define NTDSSITELINK_OPT_USE_NOTIFY (1 << 0)
#define NTDSSITELINK_OPT_TWOWAY_SYNC (1 << 1)
#define NTDSSITELINK_OPT_DISABLE_COMPRESSION (1 << 2)

#define GUID_USERS_CONTAINER_A "a9d1ca15768811d1aded00c04fd8d5cd"
#define GUID_COMPUTRS_CONTAINER_A "aa312825768811d1aded00c04fd8d5cd"
#define GUID_SYSTEMS_CONTAINER_A "ab1d30f3768811d1aded00c04fd8d5cd"
#define GUID_DOMAIN_CONTROLLERS_CONTAINER_A "a361b2ffffd211d1aa4b00c04fd7d83a"
#define GUID_INFRASTRUCTURE_CONTAINER_A "2fbac1870ade11d297c400c04fd8d5cd"
#define GUID_DELETED_OBJECTS_CONTAINER_A "18e2ea80684f11d2b9aa00c04f79f805"
#define GUID_LOSTANDFOUND_CONTAINER_A "ab8153b7768811d1aded00c04fd8d5cd"
#define GUID_FOREIGNSECURITYPRINCIPALS_CONTAINER_A "22b70c67d56e4efb91e9300fca3dc1aa"
#define GUID_PROGRAM_DATA_CONTAINER_A "09460c08ae1e4a4ea0f64aee7daa1e5a"
#define GUID_MICROSOFT_PROGRAM_DATA_CONTAINER_A "f4be92a4c777485e878e9421d53087db"
#define GUID_NTDS_QUOTAS_CONTAINER_A "6227f0af1fc2410d8e3bb10615bb5b0f"

#define GUID_USERS_CONTAINER_W L"a9d1ca15768811d1aded00c04fd8d5cd"
#define GUID_COMPUTRS_CONTAINER_W L"aa312825768811d1aded00c04fd8d5cd"
#define GUID_SYSTEMS_CONTAINER_W L"ab1d30f3768811d1aded00c04fd8d5cd"
#define GUID_DOMAIN_CONTROLLERS_CONTAINER_W L"a361b2ffffd211d1aa4b00c04fd7d83a"
#define GUID_INFRASTRUCTURE_CONTAINER_W L"2fbac1870ade11d297c400c04fd8d5cd"
#define GUID_DELETED_OBJECTS_CONTAINER_W L"18e2ea80684f11d2b9aa00c04f79f805"
#define GUID_LOSTANDFOUND_CONTAINER_W L"ab8153b7768811d1aded00c04fd8d5cd"
#define GUID_FOREIGNSECURITYPRINCIPALS_CONTAINER_W L"22b70c67d56e4efb91e9300fca3dc1aa"
#define GUID_PROGRAM_DATA_CONTAINER_W L"09460c08ae1e4a4ea0f64aee7daa1e5a"
#define GUID_MICROSOFT_PROGRAM_DATA_CONTAINER_W L"f4be92a4c777485e878e9421d53087db"
#define GUID_NTDS_QUOTAS_CONTAINER_W L"6227f0af1fc2410d8e3bb10615bb5b0f"

#define GUID_USERS_CONTAINER_BYTE "\xa9\xd1\xca\x15\x76\x88\x11\xd1\xad\xed\x00\xc0\x4f\xd8\xd5\xcd"
#define GUID_COMPUTRS_CONTAINER_BYTE "\xaa\x31\x28\x25\x76\x88\x11\xd1\xad\xed\x00\xc0\x4f\xd8\xd5\xcd"
#define GUID_SYSTEMS_CONTAINER_BYTE "\xab\x1d\x30\xf3\x76\x88\x11\xd1\xad\xed\x00\xc0\x4f\xd8\xd5\xcd"
#define GUID_DOMAIN_CONTROLLERS_CONTAINER_BYTE "\xa3\x61\xb2\xff\xff\xd2\x11\xd1\xaa\x4b\x00\xc0\x4f\xd7\xd8\x3a"
#define GUID_INFRASTRUCTURE_CONTAINER_BYTE "\x2f\xba\xc1\x87\x0a\xde\x11\xd2\x97\xc4\x00\xc0\x4f\xd8\xd5\xcd"
#define GUID_DELETED_OBJECTS_CONTAINER_BYTE "\x18\xe2\xea\x80\x68\x4f\x11\xd2\xb9\xaa\x00\xc0\x4f\x79\xf8\x05"
#define GUID_LOSTANDFOUND_CONTAINER_BYTE "\xab\x81\x53\xb7\x76\x88\x11\xd1\xad\xed\x00\xc0\x4f\xd8\xd5\xcd"
#define GUID_FOREIGNSECURITYPRINCIPALS_CONTAINER_BYTE "\x22\xb7\x0c\x67\xd5\x6e\x4e\xfb\x91\xe9\x30\x0f\xca\x3d\xc1\xaa"
#define GUID_PROGRAM_DATA_CONTAINER_BYTE "\x09\x46\x0c\x08\xae\x1e\x4a\x4e\xa0\xf6\x4a\xee\x7d\xaa\x1e\x5a"
#define GUID_MICROSOFT_PROGRAM_DATA_CONTAINER_BYTE "\xf4\xbe\x92\xa4\xc7\x77\x48\x5e\x87\x8e\x94\x21\xd5\x30\x87\xdb"
#define GUID_NTDS_QUOTAS_CONTAINER_BYTE "\x62\x27\xf0\xaf\x1f\xc2\x41\x0d\x8e\x3b\xb1\x06\x15\xbb\x5b\x0f"

  typedef enum _DS_MANGLE_FOR {
    DS_MANGLE_UNKNOWN = 0,DS_MANGLE_OBJECT_RDN_FOR_DELETION,DS_MANGLE_OBJECT_RDN_FOR_NAME_CONFLICT
  } DS_MANGLE_FOR;

#ifdef UNICODE
#define DsBind DsBindW
#define DsBindWithCred DsBindWithCredW
#define DsBindWithSpn DsBindWithSpnW
#define DsBindWithSpnEx DsBindWithSpnExW
#define DsBindToISTG DsBindToISTGW
#define DsUnBind DsUnBindW
#define DsMakePasswordCredentials DsMakePasswordCredentialsW
#define DsCrackNames DsCrackNamesW
#define DsFreeNameResult DsFreeNameResultW
#define DsMakeSpn DsMakeSpnW
#define DsGetSpn DsGetSpnW
#define DsFreeSpnArray DsFreeSpnArrayW
#define DsCrackSpn DsCrackSpnW
#define DsWriteAccountSpn DsWriteAccountSpnW
#define DsClientMakeSpnForTargetServer DsClientMakeSpnForTargetServerW
#define DsServerRegisterSpn DsServerRegisterSpnW
#define DsReplicaSync DsReplicaSyncW
#define DsReplicaAdd DsReplicaAddW
#define DsReplicaDel DsReplicaDelW
#define DsReplicaModify DsReplicaModifyW
#define DsReplicaUpdateRefs DsReplicaUpdateRefsW
#else
#define DsBind DsBindA
#define DsBindWithCred DsBindWithCredA
#define DsBindWithSpn DsBindWithSpnA
#define DsBindWithSpnEx DsBindWithSpnExA
#define DsBindToISTG DsBindToISTGA
#define DsUnBind DsUnBindA
#define DsMakePasswordCredentials DsMakePasswordCredentialsA
#define DsCrackNames DsCrackNamesA
#define DsFreeNameResult DsFreeNameResultA
#define DsMakeSpn DsMakeSpnA
#define DsGetSpn DsGetSpnA
#define DsFreeSpnArray DsFreeSpnArrayA
#define DsCrackSpn DsCrackSpnA
#define DsWriteAccountSpn DsWriteAccountSpnA
#define DsClientMakeSpnForTargetServer DsClientMakeSpnForTargetServerA
#define DsServerRegisterSpn DsServerRegisterSpnA
#define DsReplicaSync DsReplicaSyncA
#define DsReplicaAdd DsReplicaAddA
#define DsReplicaDel DsReplicaDelA
#define DsReplicaModify DsReplicaModifyA
#define DsReplicaUpdateRefs DsReplicaUpdateRefsA
#endif

#define DsFreePasswordCredentialsW DsFreePasswordCredentials
#define DsFreePasswordCredentialsA DsFreePasswordCredentials

  NTDSAPI DWORD WINAPI DsBindW(LPCWSTR DomainControllerName,LPCWSTR DnsDomainName,HANDLE *phDS);
  NTDSAPI DWORD WINAPI DsBindA(LPCSTR DomainControllerName,LPCSTR DnsDomainName,HANDLE *phDS);
  NTDSAPI DWORD WINAPI DsBindWithCredW(LPCWSTR DomainControllerName,LPCWSTR DnsDomainName,RPC_AUTH_IDENTITY_HANDLE AuthIdentity,HANDLE *phDS);
  NTDSAPI DWORD WINAPI DsBindWithCredA(LPCSTR DomainControllerName,LPCSTR DnsDomainName,RPC_AUTH_IDENTITY_HANDLE AuthIdentity,HANDLE *phDS);
  NTDSAPI DWORD WINAPI DsBindWithSpnW(LPCWSTR DomainControllerName,LPCWSTR DnsDomainName,RPC_AUTH_IDENTITY_HANDLE AuthIdentity,LPCWSTR ServicePrincipalName,HANDLE *phDS);
  NTDSAPI DWORD WINAPI DsBindWithSpnA(LPCSTR DomainControllerName,LPCSTR DnsDomainName,RPC_AUTH_IDENTITY_HANDLE AuthIdentity,LPCSTR ServicePrincipalName,HANDLE *phDS);
  NTDSAPI_POSTXP DWORD WINAPI DsBindWithSpnExW(LPCWSTR DomainControllerName,LPCWSTR DnsDomainName,RPC_AUTH_IDENTITY_HANDLE AuthIdentity,LPCWSTR ServicePrincipalName,DWORD BindFlags,HANDLE *phDS);
  NTDSAPI_POSTXP DWORD WINAPI DsBindWithSpnExA(LPCSTR DomainControllerName,LPCSTR DnsDomainName,RPC_AUTH_IDENTITY_HANDLE AuthIdentity,LPCSTR ServicePrincipalName,DWORD BindFlags,HANDLE *phDS);
  NTDSAPI_POSTXP DWORD WINAPI DsBindToISTGW(LPCWSTR SiteName,HANDLE *phDS);
  NTDSAPI_POSTXP DWORD WINAPI DsBindToISTGA(LPCSTR SiteName,HANDLE *phDS);
  NTDSAPI_POSTXP DWORD WINAPI DsBindingSetTimeout(HANDLE hDS,ULONG cTimeoutSecs);
  NTDSAPI DWORD WINAPI DsUnBindW(HANDLE *phDS);
  NTDSAPI DWORD WINAPI DsUnBindA(HANDLE *phDS);
  NTDSAPI DWORD WINAPI DsMakePasswordCredentialsW(LPCWSTR User,LPCWSTR Domain,LPCWSTR Password,RPC_AUTH_IDENTITY_HANDLE *pAuthIdentity);
  NTDSAPI DWORD WINAPI DsMakePasswordCredentialsA(LPCSTR User,LPCSTR Domain,LPCSTR Password,RPC_AUTH_IDENTITY_HANDLE *pAuthIdentity);
  NTDSAPI VOID WINAPI DsFreePasswordCredentials(RPC_AUTH_IDENTITY_HANDLE AuthIdentity);
  NTDSAPI DWORD WINAPI DsCrackNamesW(HANDLE hDS,DS_NAME_FLAGS flags,DS_NAME_FORMAT formatOffered,DS_NAME_FORMAT formatDesired,DWORD cNames,const LPCWSTR *rpNames,PDS_NAME_RESULTW *ppResult);
  NTDSAPI DWORD WINAPI DsCrackNamesA(HANDLE hDS,DS_NAME_FLAGS flags,DS_NAME_FORMAT formatOffered,DS_NAME_FORMAT formatDesired,DWORD cNames,const LPCSTR *rpNames,PDS_NAME_RESULTA *ppResult);
  NTDSAPI void WINAPI DsFreeNameResultW(DS_NAME_RESULTW *pResult);
  NTDSAPI void WINAPI DsFreeNameResultA(DS_NAME_RESULTA *pResult);
  NTDSAPI DWORD WINAPI DsMakeSpnW(LPCWSTR ServiceClass,LPCWSTR ServiceName,LPCWSTR InstanceName,USHORT InstancePort,LPCWSTR Referrer,DWORD *pcSpnLength,LPWSTR pszSpn);
  NTDSAPI DWORD WINAPI DsMakeSpnA(LPCSTR ServiceClass,LPCSTR ServiceName,LPCSTR InstanceName,USHORT InstancePort,LPCSTR Referrer,DWORD *pcSpnLength,LPSTR pszSpn);
  NTDSAPI DWORD WINAPI DsGetSpnA(DS_SPN_NAME_TYPE ServiceType,LPCSTR ServiceClass,LPCSTR ServiceName,USHORT InstancePort,USHORT cInstanceNames,LPCSTR *pInstanceNames,const USHORT *pInstancePorts,DWORD *pcSpn,LPSTR **prpszSpn);
  NTDSAPI DWORD WINAPI DsGetSpnW(DS_SPN_NAME_TYPE ServiceType,LPCWSTR ServiceClass,LPCWSTR ServiceName,USHORT InstancePort,USHORT cInstanceNames,LPCWSTR *pInstanceNames,const USHORT *pInstancePorts,DWORD *pcSpn,LPWSTR **prpszSpn);
  NTDSAPI void WINAPI DsFreeSpnArrayA(DWORD cSpn,LPSTR *rpszSpn);
  NTDSAPI void WINAPI DsFreeSpnArrayW(DWORD cSpn,LPWSTR *rpszSpn);
  NTDSAPI DWORD WINAPI DsCrackSpnA(LPCSTR pszSpn,LPDWORD pcServiceClass,LPSTR ServiceClass,LPDWORD pcServiceName,LPSTR ServiceName,LPDWORD pcInstanceName,LPSTR InstanceName,USHORT *pInstancePort);
  NTDSAPI DWORD WINAPI DsCrackSpnW(LPCWSTR pszSpn,DWORD *pcServiceClass,LPWSTR ServiceClass,DWORD *pcServiceName,LPWSTR ServiceName,DWORD *pcInstanceName,LPWSTR InstanceName,USHORT *pInstancePort);
  NTDSAPI DWORD WINAPI DsWriteAccountSpnA(HANDLE hDS,DS_SPN_WRITE_OP Operation,LPCSTR pszAccount,DWORD cSpn,LPCSTR *rpszSpn);
  NTDSAPI DWORD WINAPI DsWriteAccountSpnW(HANDLE hDS,DS_SPN_WRITE_OP Operation,LPCWSTR pszAccount,DWORD cSpn,LPCWSTR *rpszSpn);
  NTDSAPI DWORD WINAPI DsClientMakeSpnForTargetServerW(LPCWSTR ServiceClass,LPCWSTR ServiceName,DWORD *pcSpnLength,LPWSTR pszSpn);
  NTDSAPI DWORD WINAPI DsClientMakeSpnForTargetServerA(LPCSTR ServiceClass,LPCSTR ServiceName,DWORD *pcSpnLength,LPSTR pszSpn);
  NTDSAPI DWORD WINAPI DsServerRegisterSpnA(DS_SPN_WRITE_OP Operation,LPCSTR ServiceClass,LPCSTR UserObjectDN);
  NTDSAPI DWORD WINAPI DsServerRegisterSpnW(DS_SPN_WRITE_OP Operation,LPCWSTR ServiceClass,LPCWSTR UserObjectDN);
  NTDSAPI DWORD WINAPI DsReplicaSyncA(HANDLE hDS,LPCSTR NameContext,const UUID *pUuidDsaSrc,ULONG Options);
  NTDSAPI DWORD WINAPI DsReplicaSyncW(HANDLE hDS,LPCWSTR NameContext,const UUID *pUuidDsaSrc,ULONG Options);
  NTDSAPI DWORD WINAPI DsReplicaAddA(HANDLE hDS,LPCSTR NameContext,LPCSTR SourceDsaDn,LPCSTR TransportDn,LPCSTR SourceDsaAddress,const PSCHEDULE pSchedule,DWORD Options);
  NTDSAPI DWORD WINAPI DsReplicaAddW(HANDLE hDS,LPCWSTR NameContext,LPCWSTR SourceDsaDn,LPCWSTR TransportDn,LPCWSTR SourceDsaAddress,const PSCHEDULE pSchedule,DWORD Options);
  NTDSAPI DWORD WINAPI DsReplicaDelA(HANDLE hDS,LPCSTR NameContext,LPCSTR DsaSrc,ULONG Options);
  NTDSAPI DWORD WINAPI DsReplicaDelW(HANDLE hDS,LPCWSTR NameContext,LPCWSTR DsaSrc,ULONG Options);
  NTDSAPI DWORD WINAPI DsReplicaModifyA(HANDLE hDS,LPCSTR NameContext,const UUID *pUuidSourceDsa,LPCSTR TransportDn,LPCSTR SourceDsaAddress,const PSCHEDULE pSchedule,DWORD ReplicaFlags,DWORD ModifyFields,DWORD Options);
  NTDSAPI DWORD WINAPI DsReplicaModifyW(HANDLE hDS,LPCWSTR NameContext,const UUID *pUuidSourceDsa,LPCWSTR TransportDn,LPCWSTR SourceDsaAddress,const PSCHEDULE pSchedule,DWORD ReplicaFlags,DWORD ModifyFields,DWORD Options);
  NTDSAPI DWORD WINAPI DsReplicaUpdateRefsA(HANDLE hDS,LPCSTR NameContext,LPCSTR DsaDest,const UUID *pUuidDsaDest,ULONG Options);
  NTDSAPI DWORD WINAPI DsReplicaUpdateRefsW(HANDLE hDS,LPCWSTR NameContext,LPCWSTR DsaDest,const UUID *pUuidDsaDest,ULONG Options);

  typedef enum {
    DS_REPSYNCALL_WIN32_ERROR_CONTACTING_SERVER = 0,DS_REPSYNCALL_WIN32_ERROR_REPLICATING = 1,DS_REPSYNCALL_SERVER_UNREACHABLE = 2
  } DS_REPSYNCALL_ERROR;

  typedef enum {
    DS_REPSYNCALL_EVENT_ERROR = 0,DS_REPSYNCALL_EVENT_SYNC_STARTED = 1,DS_REPSYNCALL_EVENT_SYNC_COMPLETED = 2,DS_REPSYNCALL_EVENT_FINISHED = 3
  } DS_REPSYNCALL_EVENT;

  typedef struct {
    LPSTR pszSrcId;
    LPSTR pszDstId;
    LPSTR pszNC;
    GUID *pguidSrc;
    GUID *pguidDst;
  } DS_REPSYNCALL_SYNCA,*PDS_REPSYNCALL_SYNCA;

  typedef struct {
    LPWSTR pszSrcId;
    LPWSTR pszDstId;
    LPWSTR pszNC;
    GUID *pguidSrc;
    GUID *pguidDst;
  } DS_REPSYNCALL_SYNCW,*PDS_REPSYNCALL_SYNCW;

  typedef struct {
    LPSTR pszSvrId;
    DS_REPSYNCALL_ERROR error;
    DWORD dwWin32Err;
    LPSTR pszSrcId;
  } DS_REPSYNCALL_ERRINFOA,*PDS_REPSYNCALL_ERRINFOA;

  typedef struct {
    LPWSTR pszSvrId;
    DS_REPSYNCALL_ERROR error;
    DWORD dwWin32Err;
    LPWSTR pszSrcId;
  } DS_REPSYNCALL_ERRINFOW,*PDS_REPSYNCALL_ERRINFOW;

  typedef struct {
    DS_REPSYNCALL_EVENT event;
    DS_REPSYNCALL_ERRINFOA *pErrInfo;
    DS_REPSYNCALL_SYNCA *pSync;
  } DS_REPSYNCALL_UPDATEA,*PDS_REPSYNCALL_UPDATEA;

  typedef struct {
    DS_REPSYNCALL_EVENT event;
    DS_REPSYNCALL_ERRINFOW *pErrInfo;
    DS_REPSYNCALL_SYNCW *pSync;
  } DS_REPSYNCALL_UPDATEW,*PDS_REPSYNCALL_UPDATEW;

#ifdef UNICODE
#define DS_REPSYNCALL_SYNC DS_REPSYNCALL_SYNCW
#define DS_REPSYNCALL_ERRINFO DS_REPSYNCALL_ERRINFOW
#define DS_REPSYNCALL_UPDATE DS_REPSYNCALL_UPDATEW
#define PDS_REPSYNCALL_SYNC PDS_REPSYNCALL_SYNCW
#define PDS_REPSYNCALL_ERRINFO PDS_REPSYNCALL_ERRINFOW
#define PDS_REPSYNCALL_UPDATE PDS_REPSYNCALL_UPDATEW
#else
#define DS_REPSYNCALL_SYNC DS_REPSYNCALL_SYNCA
#define DS_REPSYNCALL_ERRINFO DS_REPSYNCALL_ERRINFOA
#define DS_REPSYNCALL_UPDATE DS_REPSYNCALL_UPDATEA
#define PDS_REPSYNCALL_SYNC PDS_REPSYNCALL_SYNCA
#define PDS_REPSYNCALL_ERRINFO PDS_REPSYNCALL_ERRINFOA
#define PDS_REPSYNCALL_UPDATE PDS_REPSYNCALL_UPDATEA
#endif

#define DS_REPSYNCALL_NO_OPTIONS 0x00000000
#define DS_REPSYNCALL_ABORT_IF_SERVER_UNAVAILABLE 0x00000001
#define DS_REPSYNCALL_SYNC_ADJACENT_SERVERS_ONLY 0x00000002
#define DS_REPSYNCALL_ID_SERVERS_BY_DN 0x00000004
#define DS_REPSYNCALL_DO_NOT_SYNC 0x00000008
#define DS_REPSYNCALL_SKIP_INITIAL_CHECK 0x00000010
#define DS_REPSYNCALL_PUSH_CHANGES_OUTWARD 0x00000020
#define DS_REPSYNCALL_CROSS_SITE_BOUNDARIES 0x00000040

#ifdef UNICODE
#define DsReplicaSyncAll DsReplicaSyncAllW
#define DsRemoveDsServer DsRemoveDsServerW
#define DsRemoveDsDomain DsRemoveDsDomainW
#define DsListSites DsListSitesW
#define DsListServersInSite DsListServersInSiteW
#define DsListDomainsInSite DsListDomainsInSiteW
#define DsListServersForDomainInSite DsListServersForDomainInSiteW
#define DsListInfoForServer DsListInfoForServerW
#define DsListRoles DsListRolesW
#else
#define DsReplicaSyncAll DsReplicaSyncAllA
#define DsRemoveDsServer DsRemoveDsServerA
#define DsRemoveDsDomain DsRemoveDsDomainA
#define DsListSites DsListSitesA
#define DsListServersInSite DsListServersInSiteA
#define DsListDomainsInSite DsListDomainsInSiteA
#define DsListServersForDomainInSite DsListServersForDomainInSiteA
#define DsListInfoForServer DsListInfoForServerA
#define DsListRoles DsListRolesA
#endif

#define DS_LIST_DSA_OBJECT_FOR_SERVER 0
#define DS_LIST_DNS_HOST_NAME_FOR_SERVER 1
#define DS_LIST_ACCOUNT_OBJECT_FOR_SERVER 2

#define DS_ROLE_SCHEMA_OWNER 0
#define DS_ROLE_DOMAIN_OWNER 1
#define DS_ROLE_PDC_OWNER 2
#define DS_ROLE_RID_OWNER 3
#define DS_ROLE_INFRASTRUCTURE_OWNER 4

  NTDSAPI DWORD WINAPI DsReplicaSyncAllA (HANDLE hDS,LPCSTR pszNameContext,ULONG ulFlags,WINBOOL (WINAPI *pFnCallBack) (LPVOID,PDS_REPSYNCALL_UPDATEA),LPVOID pCallbackData,PDS_REPSYNCALL_ERRINFOA **pErrors);
  NTDSAPI DWORD WINAPI DsReplicaSyncAllW (HANDLE hDS,LPCWSTR pszNameContext,ULONG ulFlags,WINBOOL (WINAPI *pFnCallBack) (LPVOID,PDS_REPSYNCALL_UPDATEW),LPVOID pCallbackData,PDS_REPSYNCALL_ERRINFOW **pErrors);
  NTDSAPI DWORD WINAPI DsRemoveDsServerW(HANDLE hDs,LPWSTR ServerDN,LPWSTR DomainDN,WINBOOL *fLastDcInDomain,WINBOOL fCommit);
  NTDSAPI DWORD WINAPI DsRemoveDsServerA(HANDLE hDs,LPSTR ServerDN,LPSTR DomainDN,WINBOOL *fLastDcInDomain,WINBOOL fCommit);
  NTDSAPI DWORD WINAPI DsRemoveDsDomainW(HANDLE hDs,LPWSTR DomainDN);
  NTDSAPI DWORD WINAPI DsRemoveDsDomainA(HANDLE hDs,LPSTR DomainDN);
  NTDSAPI DWORD WINAPI DsListSitesA(HANDLE hDs,PDS_NAME_RESULTA *ppSites);
  NTDSAPI DWORD WINAPI DsListSitesW(HANDLE hDs,PDS_NAME_RESULTW *ppSites);
  NTDSAPI DWORD WINAPI DsListServersInSiteA(HANDLE hDs,LPCSTR site,PDS_NAME_RESULTA *ppServers);
  NTDSAPI DWORD WINAPI DsListServersInSiteW(HANDLE hDs,LPCWSTR site,PDS_NAME_RESULTW *ppServers);
  NTDSAPI DWORD WINAPI DsListDomainsInSiteA(HANDLE hDs,LPCSTR site,PDS_NAME_RESULTA *ppDomains);
  NTDSAPI DWORD WINAPI DsListDomainsInSiteW(HANDLE hDs,LPCWSTR site,PDS_NAME_RESULTW *ppDomains);
  NTDSAPI DWORD WINAPI DsListServersForDomainInSiteA(HANDLE hDs,LPCSTR domain,LPCSTR site,PDS_NAME_RESULTA *ppServers);
  NTDSAPI DWORD WINAPI DsListServersForDomainInSiteW(HANDLE hDs,LPCWSTR domain,LPCWSTR site,PDS_NAME_RESULTW *ppServers);
  NTDSAPI DWORD WINAPI DsListInfoForServerA(HANDLE hDs,LPCSTR server,PDS_NAME_RESULTA *ppInfo);
  NTDSAPI DWORD WINAPI DsListInfoForServerW(HANDLE hDs,LPCWSTR server,PDS_NAME_RESULTW *ppInfo);
  NTDSAPI DWORD WINAPI DsListRolesA(HANDLE hDs,PDS_NAME_RESULTA *ppRoles);
  NTDSAPI DWORD WINAPI DsListRolesW(HANDLE hDs,PDS_NAME_RESULTW *ppRoles);

  typedef struct {
    DWORD errorCode;
    DWORD cost;
  } DS_SITE_COST_INFO,*PDS_SITE_COST_INFO;

#ifdef UNICODE
#define DsQuerySitesByCost DsQuerySitesByCostW
#else
#define DsQuerySitesByCost DsQuerySitesByCostA
#endif

  NTDSAPI_POSTXP DWORD WINAPI DsQuerySitesByCostW(HANDLE hDS,LPWSTR pwszFromSite,LPWSTR *rgwszToSites,DWORD cToSites,DWORD dwFlags,PDS_SITE_COST_INFO *prgSiteInfo);
  NTDSAPI_POSTXP DWORD WINAPI DsQuerySitesByCostA(HANDLE hDS,LPSTR pwszFromSite,LPSTR *rgwszToSites,DWORD cToSites,DWORD dwFlags,PDS_SITE_COST_INFO *prgSiteInfo);
  VOID DsQuerySitesFree(PDS_SITE_COST_INFO rgSiteInfo);

#define DS_SCHEMA_GUID_NOT_FOUND 0
#define DS_SCHEMA_GUID_ATTR 1
#define DS_SCHEMA_GUID_ATTR_SET 2
#define DS_SCHEMA_GUID_CLASS 3
#define DS_SCHEMA_GUID_CONTROL_RIGHT 4

  typedef struct {
    GUID guid;
    DWORD guidType;
    LPSTR pName;
  } DS_SCHEMA_GUID_MAPA,*PDS_SCHEMA_GUID_MAPA;

  typedef struct {
    GUID guid;
    DWORD guidType;
    LPWSTR pName;
  } DS_SCHEMA_GUID_MAPW,*PDS_SCHEMA_GUID_MAPW;

  NTDSAPI DWORD WINAPI DsMapSchemaGuidsA(HANDLE hDs,DWORD cGuids,GUID *rGuids,DS_SCHEMA_GUID_MAPA **ppGuidMap);
  NTDSAPI VOID WINAPI DsFreeSchemaGuidMapA(PDS_SCHEMA_GUID_MAPA pGuidMap);
  NTDSAPI DWORD WINAPI DsMapSchemaGuidsW(HANDLE hDs,DWORD cGuids,GUID *rGuids,DS_SCHEMA_GUID_MAPW **ppGuidMap);
  NTDSAPI VOID WINAPI DsFreeSchemaGuidMapW(PDS_SCHEMA_GUID_MAPW pGuidMap);

#ifdef UNICODE
#define DS_SCHEMA_GUID_MAP DS_SCHEMA_GUID_MAPW
#define PDS_SCHEMA_GUID_MAP PDS_SCHEMA_GUID_MAPW
#define DsMapSchemaGuids DsMapSchemaGuidsW
#define DsFreeSchemaGuidMap DsFreeSchemaGuidMapW
#else
#define DS_SCHEMA_GUID_MAP DS_SCHEMA_GUID_MAPA
#define PDS_SCHEMA_GUID_MAP PDS_SCHEMA_GUID_MAPA
#define DsMapSchemaGuids DsMapSchemaGuidsA
#define DsFreeSchemaGuidMap DsFreeSchemaGuidMapA
#endif

  typedef struct {
    LPSTR NetbiosName;
    LPSTR DnsHostName;
    LPSTR SiteName;
    LPSTR ComputerObjectName;
    LPSTR ServerObjectName;
    WINBOOL fIsPdc;
    WINBOOL fDsEnabled;
  } DS_DOMAIN_CONTROLLER_INFO_1A,*PDS_DOMAIN_CONTROLLER_INFO_1A;

  typedef struct {
    LPWSTR NetbiosName;
    LPWSTR DnsHostName;
    LPWSTR SiteName;
    LPWSTR ComputerObjectName;
    LPWSTR ServerObjectName;
    WINBOOL fIsPdc;
    WINBOOL fDsEnabled;
  } DS_DOMAIN_CONTROLLER_INFO_1W,*PDS_DOMAIN_CONTROLLER_INFO_1W;

  typedef struct {
    LPSTR NetbiosName;
    LPSTR DnsHostName;
    LPSTR SiteName;
    LPSTR SiteObjectName;
    LPSTR ComputerObjectName;
    LPSTR ServerObjectName;
    LPSTR NtdsDsaObjectName;
    WINBOOL fIsPdc;
    WINBOOL fDsEnabled;
    WINBOOL fIsGc;
    GUID SiteObjectGuid;
    GUID ComputerObjectGuid;
    GUID ServerObjectGuid;
    GUID NtdsDsaObjectGuid;
  } DS_DOMAIN_CONTROLLER_INFO_2A,*PDS_DOMAIN_CONTROLLER_INFO_2A;

  typedef struct {
    LPWSTR NetbiosName;
    LPWSTR DnsHostName;
    LPWSTR SiteName;
    LPWSTR SiteObjectName;
    LPWSTR ComputerObjectName;
    LPWSTR ServerObjectName;
    LPWSTR NtdsDsaObjectName;
    WINBOOL fIsPdc;
    WINBOOL fDsEnabled;
    WINBOOL fIsGc;
    GUID SiteObjectGuid;
    GUID ComputerObjectGuid;
    GUID ServerObjectGuid;
    GUID NtdsDsaObjectGuid;
  } DS_DOMAIN_CONTROLLER_INFO_2W,*PDS_DOMAIN_CONTROLLER_INFO_2W;

  NTDSAPI DWORD WINAPI DsGetDomainControllerInfoA(HANDLE hDs,LPCSTR DomainName,DWORD InfoLevel,DWORD *pcOut,VOID **ppInfo);
  NTDSAPI DWORD WINAPI DsGetDomainControllerInfoW(HANDLE hDs,LPCWSTR DomainName,DWORD InfoLevel,DWORD *pcOut,VOID **ppInfo);
  NTDSAPI VOID WINAPI DsFreeDomainControllerInfoA(DWORD InfoLevel,DWORD cInfo,VOID *pInfo);
  NTDSAPI VOID WINAPI DsFreeDomainControllerInfoW(DWORD InfoLevel,DWORD cInfo,VOID *pInfo);

#ifdef UNICODE
#define DS_DOMAIN_CONTROLLER_INFO_1 DS_DOMAIN_CONTROLLER_INFO_1W
#define DS_DOMAIN_CONTROLLER_INFO_2 DS_DOMAIN_CONTROLLER_INFO_2W
#define PDS_DOMAIN_CONTROLLER_INFO_1 PDS_DOMAIN_CONTROLLER_INFO_1W
#define PDS_DOMAIN_CONTROLLER_INFO_2 PDS_DOMAIN_CONTROLLER_INFO_2W
#define DsGetDomainControllerInfo DsGetDomainControllerInfoW
#define DsFreeDomainControllerInfo DsFreeDomainControllerInfoW
#else
#define DS_DOMAIN_CONTROLLER_INFO_1 DS_DOMAIN_CONTROLLER_INFO_1A
#define DS_DOMAIN_CONTROLLER_INFO_2 DS_DOMAIN_CONTROLLER_INFO_2A
#define PDS_DOMAIN_CONTROLLER_INFO_1 PDS_DOMAIN_CONTROLLER_INFO_1A
#define PDS_DOMAIN_CONTROLLER_INFO_2 PDS_DOMAIN_CONTROLLER_INFO_2A
#define DsGetDomainControllerInfo DsGetDomainControllerInfoA
#define DsFreeDomainControllerInfo DsFreeDomainControllerInfoA
#endif

  typedef enum {
    DS_KCC_TASKID_UPDATE_TOPOLOGY = 0
  } DS_KCC_TASKID;

#define DS_KCC_FLAG_ASYNC_OP (1 << 0)

#define DS_KCC_FLAG_DAMPED (1 << 1)

#ifdef UNICODE
#define DsReplicaVerifyObjects DsReplicaVerifyObjectsW
#else
#define DsReplicaVerifyObjects DsReplicaVerifyObjectsA
#endif

  NTDSAPI DWORD WINAPI DsReplicaConsistencyCheck(HANDLE hDS,DS_KCC_TASKID TaskID,DWORD dwFlags);
  NTDSAPI DWORD WINAPI DsReplicaVerifyObjectsW(HANDLE hDS,LPCWSTR NameContext,const UUID *pUuidDsaSrc,ULONG ulOptions);
  NTDSAPI DWORD WINAPI DsReplicaVerifyObjectsA(HANDLE hDS,LPCSTR NameContext,const UUID *pUuidDsaSrc,ULONG ulOptions);

#define DS_EXIST_ADVISORY_MODE (0x1)

  typedef enum _DS_REPL_INFO_TYPE {
    DS_REPL_INFO_NEIGHBORS = 0,DS_REPL_INFO_CURSORS_FOR_NC = 1,DS_REPL_INFO_METADATA_FOR_OBJ = 2,DS_REPL_INFO_KCC_DSA_CONNECT_FAILURES = 3,
    DS_REPL_INFO_KCC_DSA_LINK_FAILURES = 4,DS_REPL_INFO_PENDING_OPS = 5,DS_REPL_INFO_METADATA_FOR_ATTR_VALUE = 6,DS_REPL_INFO_CURSORS_2_FOR_NC = 7,
    DS_REPL_INFO_CURSORS_3_FOR_NC = 8,DS_REPL_INFO_METADATA_2_FOR_OBJ = 9,DS_REPL_INFO_METADATA_2_FOR_ATTR_VALUE = 10,DS_REPL_INFO_TYPE_MAX
  } DS_REPL_INFO_TYPE;

#define DS_REPL_INFO_FLAG_IMPROVE_LINKED_ATTRS (0x00000001)

#define DS_REPL_NBR_WRITEABLE (0x00000010)
#define DS_REPL_NBR_SYNC_ON_STARTUP (0x00000020)
#define DS_REPL_NBR_DO_SCHEDULED_SYNCS (0x00000040)
#define DS_REPL_NBR_USE_ASYNC_INTERSITE_TRANSPORT (0x00000080)
#define DS_REPL_NBR_TWO_WAY_SYNC (0x00000200)
#define DS_REPL_NBR_RETURN_OBJECT_PARENTS (0x00000800)
#define DS_REPL_NBR_FULL_SYNC_IN_PROGRESS (0x00010000)
#define DS_REPL_NBR_FULL_SYNC_NEXT_PACKET (0x00020000)
#define DS_REPL_NBR_NEVER_SYNCED (0x00200000)
#define DS_REPL_NBR_PREEMPTED (0x01000000)
#define DS_REPL_NBR_IGNORE_CHANGE_NOTIFICATIONS (0x04000000)
#define DS_REPL_NBR_DISABLE_SCHEDULED_SYNC (0x08000000)
#define DS_REPL_NBR_COMPRESS_CHANGES (0x10000000)
#define DS_REPL_NBR_NO_CHANGE_NOTIFICATIONS (0x20000000)
#define DS_REPL_NBR_PARTIAL_ATTRIBUTE_SET (0x40000000)

#define DS_REPL_NBR_MODIFIABLE_MASK (DS_REPL_NBR_SYNC_ON_STARTUP | DS_REPL_NBR_DO_SCHEDULED_SYNCS | DS_REPL_NBR_TWO_WAY_SYNC | DS_REPL_NBR_IGNORE_CHANGE_NOTIFICATIONS | DS_REPL_NBR_DISABLE_SCHEDULED_SYNC | DS_REPL_NBR_COMPRESS_CHANGES | DS_REPL_NBR_NO_CHANGE_NOTIFICATIONS)

  typedef struct _DS_REPL_NEIGHBORW {
    LPWSTR pszNamingContext;
    LPWSTR pszSourceDsaDN;
    LPWSTR pszSourceDsaAddress;
    LPWSTR pszAsyncIntersiteTransportDN;
    DWORD dwReplicaFlags;
    DWORD dwReserved;
    UUID uuidNamingContextObjGuid;
    UUID uuidSourceDsaObjGuid;
    UUID uuidSourceDsaInvocationID;
    UUID uuidAsyncIntersiteTransportObjGuid;
    USN usnLastObjChangeSynced;
    USN usnAttributeFilter;
    FILETIME ftimeLastSyncSuccess;
    FILETIME ftimeLastSyncAttempt;
    DWORD dwLastSyncResult;
    DWORD cNumConsecutiveSyncFailures;
  } DS_REPL_NEIGHBORW;

  typedef struct _DS_REPL_NEIGHBORW_BLOB {
    DWORD oszNamingContext;
    DWORD oszSourceDsaDN;
    DWORD oszSourceDsaAddress;
    DWORD oszAsyncIntersiteTransportDN;
    DWORD dwReplicaFlags;
    DWORD dwReserved;
    UUID uuidNamingContextObjGuid;
    UUID uuidSourceDsaObjGuid;
    UUID uuidSourceDsaInvocationID;
    UUID uuidAsyncIntersiteTransportObjGuid;
    USN usnLastObjChangeSynced;
    USN usnAttributeFilter;
    FILETIME ftimeLastSyncSuccess;
    FILETIME ftimeLastSyncAttempt;
    DWORD dwLastSyncResult;
    DWORD cNumConsecutiveSyncFailures;
  } DS_REPL_NEIGHBORW_BLOB;

  typedef struct _DS_REPL_NEIGHBORSW {
    DWORD cNumNeighbors;
    DWORD dwReserved;
    DS_REPL_NEIGHBORW rgNeighbor[1];
  } DS_REPL_NEIGHBORSW;

  typedef struct _DS_REPL_CURSOR {
    UUID uuidSourceDsaInvocationID;
    USN usnAttributeFilter;
  } DS_REPL_CURSOR;

  typedef struct _DS_REPL_CURSOR_2 {
    UUID uuidSourceDsaInvocationID;
    USN usnAttributeFilter;
    FILETIME ftimeLastSyncSuccess;
  } DS_REPL_CURSOR_2;

  typedef struct _DS_REPL_CURSOR_3W {
    UUID uuidSourceDsaInvocationID;
    USN usnAttributeFilter;
    FILETIME ftimeLastSyncSuccess;
    LPWSTR pszSourceDsaDN;
  } DS_REPL_CURSOR_3W;

  typedef struct _DS_REPL_CURSOR_BLOB {
    UUID uuidSourceDsaInvocationID;
    USN usnAttributeFilter;
    FILETIME ftimeLastSyncSuccess;
    DWORD oszSourceDsaDN;
  } DS_REPL_CURSOR_BLOB;

  typedef struct _DS_REPL_CURSORS {
    DWORD cNumCursors;
    DWORD dwReserved;
    DS_REPL_CURSOR rgCursor[1];
  } DS_REPL_CURSORS;

  typedef struct _DS_REPL_CURSORS_2 {
    DWORD cNumCursors;
    DWORD dwEnumerationContext;
    DS_REPL_CURSOR_2 rgCursor[1];
  } DS_REPL_CURSORS_2;

  typedef struct _DS_REPL_CURSORS_3W {
    DWORD cNumCursors;
    DWORD dwEnumerationContext;
    DS_REPL_CURSOR_3W rgCursor[1];
  } DS_REPL_CURSORS_3W;

  typedef struct _DS_REPL_ATTR_META_DATA {
    LPWSTR pszAttributeName;
    DWORD dwVersion;
    FILETIME ftimeLastOriginatingChange;
    UUID uuidLastOriginatingDsaInvocationID;
    USN usnOriginatingChange;
    USN usnLocalChange;
  } DS_REPL_ATTR_META_DATA;

  typedef struct _DS_REPL_ATTR_META_DATA_2 {
    LPWSTR pszAttributeName;
    DWORD dwVersion;
    FILETIME ftimeLastOriginatingChange;
    UUID uuidLastOriginatingDsaInvocationID;
    USN usnOriginatingChange;
    USN usnLocalChange;
    LPWSTR pszLastOriginatingDsaDN;
  } DS_REPL_ATTR_META_DATA_2;

  typedef struct _DS_REPL_ATTR_META_DATA_BLOB {
    DWORD oszAttributeName;
    DWORD dwVersion;
    FILETIME ftimeLastOriginatingChange;
    UUID uuidLastOriginatingDsaInvocationID;
    USN usnOriginatingChange;
    USN usnLocalChange;
    DWORD oszLastOriginatingDsaDN;
  } DS_REPL_ATTR_META_DATA_BLOB;

  typedef struct _DS_REPL_OBJ_META_DATA {
    DWORD cNumEntries;
    DWORD dwReserved;
    DS_REPL_ATTR_META_DATA rgMetaData[1];
  } DS_REPL_OBJ_META_DATA;

  typedef struct _DS_REPL_OBJ_META_DATA_2 {
    DWORD cNumEntries;
    DWORD dwReserved;
    DS_REPL_ATTR_META_DATA_2 rgMetaData[1];
  } DS_REPL_OBJ_META_DATA_2;

  typedef struct _DS_REPL_KCC_DSA_FAILUREW {
    LPWSTR pszDsaDN;
    UUID uuidDsaObjGuid;
    FILETIME ftimeFirstFailure;
    DWORD cNumFailures;
    DWORD dwLastResult;
  } DS_REPL_KCC_DSA_FAILUREW;

  typedef struct _DS_REPL_KCC_DSA_FAILUREW_BLOB {
    DWORD oszDsaDN;
    UUID uuidDsaObjGuid;
    FILETIME ftimeFirstFailure;
    DWORD cNumFailures;
    DWORD dwLastResult;
  } DS_REPL_KCC_DSA_FAILUREW_BLOB;

  typedef struct _DS_REPL_KCC_DSA_FAILURESW {
    DWORD cNumEntries;
    DWORD dwReserved;
    DS_REPL_KCC_DSA_FAILUREW rgDsaFailure[1];
  } DS_REPL_KCC_DSA_FAILURESW;

  typedef enum _DS_REPL_OP_TYPE {
    DS_REPL_OP_TYPE_SYNC = 0,DS_REPL_OP_TYPE_ADD,DS_REPL_OP_TYPE_DELETE,DS_REPL_OP_TYPE_MODIFY,DS_REPL_OP_TYPE_UPDATE_REFS
  } DS_REPL_OP_TYPE;

  typedef struct _DS_REPL_OPW {
    FILETIME ftimeEnqueued;
    ULONG ulSerialNumber;
    ULONG ulPriority;
    DS_REPL_OP_TYPE OpType;
    ULONG ulOptions;
    LPWSTR pszNamingContext;
    LPWSTR pszDsaDN;
    LPWSTR pszDsaAddress;
    UUID uuidNamingContextObjGuid;
    UUID uuidDsaObjGuid;
  } DS_REPL_OPW;

  typedef struct _DS_REPL_OPW_BLOB {
    FILETIME ftimeEnqueued;
    ULONG ulSerialNumber;
    ULONG ulPriority;
    DS_REPL_OP_TYPE OpType;
    ULONG ulOptions;
    DWORD oszNamingContext;
    DWORD oszDsaDN;
    DWORD oszDsaAddress;
    UUID uuidNamingContextObjGuid;
    UUID uuidDsaObjGuid;
  } DS_REPL_OPW_BLOB;

  typedef struct _DS_REPL_PENDING_OPSW {
    FILETIME ftimeCurrentOpStarted;
    DWORD cNumPendingOps;
    DS_REPL_OPW rgPendingOp[1];
  } DS_REPL_PENDING_OPSW;

  typedef struct _DS_REPL_VALUE_META_DATA {
    LPWSTR pszAttributeName;
    LPWSTR pszObjectDn;
    DWORD cbData;
    BYTE *pbData;
    FILETIME ftimeDeleted;
    FILETIME ftimeCreated;
    DWORD dwVersion;
    FILETIME ftimeLastOriginatingChange;
    UUID uuidLastOriginatingDsaInvocationID;
    USN usnOriginatingChange;
    USN usnLocalChange;
  } DS_REPL_VALUE_META_DATA;

  typedef struct _DS_REPL_VALUE_META_DATA_2 {
    LPWSTR pszAttributeName;
    LPWSTR pszObjectDn;
    DWORD cbData;
    BYTE *pbData;
    FILETIME ftimeDeleted;
    FILETIME ftimeCreated;
    DWORD dwVersion;
    FILETIME ftimeLastOriginatingChange;
    UUID uuidLastOriginatingDsaInvocationID;
    USN usnOriginatingChange;
    USN usnLocalChange;
    LPWSTR pszLastOriginatingDsaDN;
  } DS_REPL_VALUE_META_DATA_2;

  typedef struct _DS_REPL_VALUE_META_DATA_BLOB {
    DWORD oszAttributeName;
    DWORD oszObjectDn;
    DWORD cbData;
    DWORD obData;
    FILETIME ftimeDeleted;
    FILETIME ftimeCreated;
    DWORD dwVersion;
    FILETIME ftimeLastOriginatingChange;
    UUID uuidLastOriginatingDsaInvocationID;
    USN usnOriginatingChange;
    USN usnLocalChange;
    DWORD oszLastOriginatingDsaDN;
  } DS_REPL_VALUE_META_DATA_BLOB;

  typedef struct _DS_REPL_ATTR_VALUE_META_DATA {
    DWORD cNumEntries;
    DWORD dwEnumerationContext;
    DS_REPL_VALUE_META_DATA rgMetaData[1];
  } DS_REPL_ATTR_VALUE_META_DATA;

  typedef struct _DS_REPL_ATTR_VALUE_META_DATA_2 {
    DWORD cNumEntries;
    DWORD dwEnumerationContext;
    DS_REPL_VALUE_META_DATA_2 rgMetaData[1];
  } DS_REPL_ATTR_VALUE_META_DATA_2;

  typedef struct _DS_REPL_QUEUE_STATISTICSW {
    FILETIME ftimeCurrentOpStarted;
    DWORD cNumPendingOps;
    FILETIME ftimeOldestSync;
    FILETIME ftimeOldestAdd;
    FILETIME ftimeOldestMod;
    FILETIME ftimeOldestDel;
    FILETIME ftimeOldestUpdRefs;
  } DS_REPL_QUEUE_STATISTICSW;

  typedef struct _DS_REPL_QUEUE_STATISTICSW DS_REPL_QUEUE_STATISTICSW_BLOB;

  NTDSAPI DWORD WINAPI DsReplicaGetInfoW(HANDLE hDS,DS_REPL_INFO_TYPE InfoType,LPCWSTR pszObject,UUID *puuidForSourceDsaObjGuid,VOID **ppInfo);
  NTDSAPI DWORD WINAPI DsReplicaGetInfo2W(HANDLE hDS,DS_REPL_INFO_TYPE InfoType,LPCWSTR pszObject,UUID *puuidForSourceDsaObjGuid,LPCWSTR pszAttributeName,LPCWSTR pszValue,DWORD dwFlags,DWORD dwEnumerationContext,VOID **ppInfo);
  NTDSAPI void WINAPI DsReplicaFreeInfo(DS_REPL_INFO_TYPE InfoType,VOID *pInfo);

#ifdef UNICODE
#define DsReplicaGetInfo DsReplicaGetInfoW
#define DsReplicaGetInfo2 DsReplicaGetInfo2W
#define DS_REPL_NEIGHBOR DS_REPL_NEIGHBORW
#define DS_REPL_NEIGHBORS DS_REPL_NEIGHBORSW
#define DS_REPL_CURSOR_3 DS_REPL_CURSOR_3W
#define DS_REPL_CURSORS_3 DS_REPL_CURSORS_3W
#define DS_REPL_KCC_DSA_FAILURES DS_REPL_KCC_DSA_FAILURESW
#define DS_REPL_KCC_DSA_FAILURE DS_REPL_KCC_DSA_FAILUREW
#define DS_REPL_OP DS_REPL_OPW
#define DS_REPL_PENDING_OPS DS_REPL_PENDING_OPSW
#endif

#ifdef UNICODE
#define DsAddSidHistory DsAddSidHistoryW
#define DsInheritSecurityIdentity DsInheritSecurityIdentityW
#else
#define DsAddSidHistory DsAddSidHistoryA
#define DsInheritSecurityIdentity DsInheritSecurityIdentityA
#endif

  NTDSAPI DWORD WINAPI DsAddSidHistoryW(HANDLE hDS,DWORD Flags,LPCWSTR SrcDomain,LPCWSTR SrcPrincipal,LPCWSTR SrcDomainController,RPC_AUTH_IDENTITY_HANDLE SrcDomainCreds,LPCWSTR DstDomain,LPCWSTR DstPrincipal);
  NTDSAPI DWORD WINAPI DsAddSidHistoryA(HANDLE hDS,DWORD Flags,LPCSTR SrcDomain,LPCSTR SrcPrincipal,LPCSTR SrcDomainController,RPC_AUTH_IDENTITY_HANDLE SrcDomainCreds,LPCSTR DstDomain,LPCSTR DstPrincipal);
  NTDSAPI DWORD WINAPI DsInheritSecurityIdentityW(HANDLE hDS,DWORD Flags,LPCWSTR SrcPrincipal,LPCWSTR DstPrincipal);
  NTDSAPI DWORD WINAPI DsInheritSecurityIdentityA(HANDLE hDS,DWORD Flags,LPCSTR SrcPrincipal,LPCSTR DstPrincipal);

#ifdef UNICODE
#define DsQuoteRdnValue DsQuoteRdnValueW
#define DsUnquoteRdnValue DsUnquoteRdnValueW
#define DsCrackUnquotedMangledRdn DsCrackUnquotedMangledRdnW
#define DsIsMangledRdnValue DsIsMangledRdnValueW
#define DsIsMangledDn DsIsMangledDnW
#else
#define DsQuoteRdnValue DsQuoteRdnValueA
#define DsUnquoteRdnValue DsUnquoteRdnValueA
#define DsCrackUnquotedMangledRdn DsCrackUnquotedMangledRdnA
#define DsIsMangledRdnValue DsIsMangledRdnValueA
#define DsIsMangledDn DsIsMangledDnA
#endif

  NTDSAPI DWORD WINAPI DsQuoteRdnValueW(DWORD cUnquotedRdnValueLength,LPCWCH psUnquotedRdnValue,DWORD *pcQuotedRdnValueLength,LPWCH psQuotedRdnValue);
  NTDSAPI DWORD WINAPI DsQuoteRdnValueA(DWORD cUnquotedRdnValueLength,LPCCH psUnquotedRdnValue,DWORD *pcQuotedRdnValueLength,LPCH psQuotedRdnValue);
  NTDSAPI DWORD WINAPI DsUnquoteRdnValueW(DWORD cQuotedRdnValueLength,LPCWCH psQuotedRdnValue,DWORD *pcUnquotedRdnValueLength,LPWCH psUnquotedRdnValue);
  NTDSAPI DWORD WINAPI DsUnquoteRdnValueA(DWORD cQuotedRdnValueLength,LPCCH psQuotedRdnValue,DWORD *pcUnquotedRdnValueLength,LPCH psUnquotedRdnValue);
  NTDSAPI DWORD WINAPI DsGetRdnW(LPCWCH *ppDN,DWORD *pcDN,LPCWCH *ppKey,DWORD *pcKey,LPCWCH *ppVal,DWORD *pcVal);
  NTDSAPI WINBOOL WINAPI DsCrackUnquotedMangledRdnW(LPCWSTR pszRDN,DWORD cchRDN,GUID *pGuid,DS_MANGLE_FOR *peDsMangleFor);
  NTDSAPI WINBOOL WINAPI DsCrackUnquotedMangledRdnA(LPCSTR pszRDN,DWORD cchRDN,GUID *pGuid,DS_MANGLE_FOR *peDsMangleFor);
  NTDSAPI WINBOOL WINAPI DsIsMangledRdnValueW(LPCWSTR pszRdn,DWORD cRdn,DS_MANGLE_FOR eDsMangleForDesired);
  NTDSAPI WINBOOL WINAPI DsIsMangledRdnValueA(LPCSTR pszRdn,DWORD cRdn,DS_MANGLE_FOR eDsMangleForDesired);
  NTDSAPI WINBOOL WINAPI DsIsMangledDnA(LPCSTR pszDn,DS_MANGLE_FOR eDsMangleFor);
  NTDSAPI WINBOOL WINAPI DsIsMangledDnW(LPCWSTR pszDn,DS_MANGLE_FOR eDsMangleFor);

#ifdef __cplusplus
}
#endif
#endif
