/**
 * This file has no copyright assigned and is placed in the Public Domain.
 * This file is part of the w64 mingw-runtime package.
 * No warranty is given; refer to the file DISCLAIMER.PD within this package.
 */
#ifndef _USERENV_H_
#define _USERENV_H_

#include <wbemcli.h>
#include <profinfo.h>

#if !defined(_USERENV_)
#define USERENVAPI DECLSPEC_IMPORT
#else
#define USERENVAPI
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define PI_NOUI 0x00000001
#define PI_APPLYPOLICY 0x00000002

#ifdef UNICODE
#define LoadUserProfile LoadUserProfileW
#define GetProfilesDirectory GetProfilesDirectoryW
#define DeleteProfile DeleteProfileW
#define GetDefaultUserProfileDirectory GetDefaultUserProfileDirectoryW
#define GetAllUsersProfileDirectory GetAllUsersProfileDirectoryW
#define GetUserProfileDirectory GetUserProfileDirectoryW
#define ExpandEnvironmentStringsForUser ExpandEnvironmentStringsForUserW
#else
#define LoadUserProfile LoadUserProfileA
#define GetProfilesDirectory GetProfilesDirectoryA
#define DeleteProfile DeleteProfileA
#define GetDefaultUserProfileDirectory GetDefaultUserProfileDirectoryA
#define GetAllUsersProfileDirectory GetAllUsersProfileDirectoryA
#define GetUserProfileDirectory GetUserProfileDirectoryA
#define ExpandEnvironmentStringsForUser ExpandEnvironmentStringsForUserA
#endif

  USERENVAPI WINBOOL WINAPI LoadUserProfileA(HANDLE hToken,LPPROFILEINFOA lpProfileInfo);
  USERENVAPI WINBOOL WINAPI LoadUserProfileW(HANDLE hToken,LPPROFILEINFOW lpProfileInfo);
  USERENVAPI WINBOOL WINAPI UnloadUserProfile(HANDLE hToken,HANDLE hProfile);
  USERENVAPI WINBOOL WINAPI GetProfilesDirectoryA(LPSTR lpProfilesDir,LPDWORD lpcchSize);
  USERENVAPI WINBOOL WINAPI GetProfilesDirectoryW(LPWSTR lpProfilesDir,LPDWORD lpcchSize);

#define PT_TEMPORARY 0x00000001
#define PT_ROAMING 0x00000002
#define PT_MANDATORY 0x00000004

  USERENVAPI WINBOOL WINAPI GetProfileType(DWORD *dwFlags);
  USERENVAPI WINBOOL WINAPI DeleteProfileA(LPCSTR lpSidString,LPCSTR lpProfilePath,LPCSTR lpComputerName);
  USERENVAPI WINBOOL WINAPI DeleteProfileW(LPCWSTR lpSidString,LPCWSTR lpProfilePath,LPCWSTR lpComputerName);
  USERENVAPI WINBOOL WINAPI GetDefaultUserProfileDirectoryA(LPSTR lpProfileDir,LPDWORD lpcchSize);
  USERENVAPI WINBOOL WINAPI GetDefaultUserProfileDirectoryW(LPWSTR lpProfileDir,LPDWORD lpcchSize);
  USERENVAPI WINBOOL WINAPI GetAllUsersProfileDirectoryA(LPSTR lpProfileDir,LPDWORD lpcchSize);
  USERENVAPI WINBOOL WINAPI GetAllUsersProfileDirectoryW(LPWSTR lpProfileDir,LPDWORD lpcchSize);
  USERENVAPI WINBOOL WINAPI GetUserProfileDirectoryA(HANDLE hToken,LPSTR lpProfileDir,LPDWORD lpcchSize);
  USERENVAPI WINBOOL WINAPI GetUserProfileDirectoryW(HANDLE hToken,LPWSTR lpProfileDir,LPDWORD lpcchSize);
  USERENVAPI WINBOOL WINAPI CreateEnvironmentBlock(LPVOID *lpEnvironment,HANDLE hToken,WINBOOL bInherit);
  USERENVAPI WINBOOL WINAPI DestroyEnvironmentBlock(LPVOID lpEnvironment);
  USERENVAPI WINBOOL WINAPI ExpandEnvironmentStringsForUserA(HANDLE hToken,LPCSTR lpSrc,LPSTR lpDest,DWORD dwSize);
  USERENVAPI WINBOOL WINAPI ExpandEnvironmentStringsForUserW(HANDLE hToken,LPCWSTR lpSrc,LPWSTR lpDest,DWORD dwSize);
  USERENVAPI WINBOOL WINAPI RefreshPolicy(WINBOOL bMachine);

#define RP_FORCE 1

  USERENVAPI WINBOOL WINAPI RefreshPolicyEx(WINBOOL bMachine,DWORD dwOptions);
  USERENVAPI HANDLE WINAPI EnterCriticalPolicySection(WINBOOL bMachine);
  USERENVAPI WINBOOL WINAPI LeaveCriticalPolicySection(HANDLE hSection);
  USERENVAPI WINBOOL WINAPI RegisterGPNotification(HANDLE hEvent,WINBOOL bMachine);
  USERENVAPI WINBOOL WINAPI UnregisterGPNotification(HANDLE hEvent);

#define GPC_BLOCK_POLICY 0x00000001

#define GPO_FLAG_DISABLE 0x00000001
#define GPO_FLAG_FORCE 0x00000002

  typedef enum _GPO_LINK {
    GPLinkUnknown = 0,GPLinkMachine,GPLinkSite,GPLinkDomain,GPLinkOrganizationalUnit
  } GPO_LINK,*PGPO_LINK;

  typedef struct _GROUP_POLICY_OBJECTA {
    DWORD dwOptions;
    DWORD dwVersion;
    LPSTR lpDSPath;
    LPSTR lpFileSysPath;
    LPSTR lpDisplayName;
    CHAR szGPOName[50];
    GPO_LINK GPOLink;
    LPARAM lParam;
    struct _GROUP_POLICY_OBJECTA *pNext;
    struct _GROUP_POLICY_OBJECTA *pPrev;
    LPSTR lpExtensions;
    LPARAM lParam2;
    LPSTR lpLink;
  } GROUP_POLICY_OBJECTA,*PGROUP_POLICY_OBJECTA;

  typedef struct _GROUP_POLICY_OBJECTW {
    DWORD dwOptions;
    DWORD dwVersion;
    LPWSTR lpDSPath;
    LPWSTR lpFileSysPath;
    LPWSTR lpDisplayName;
    WCHAR szGPOName[50];
    GPO_LINK GPOLink;
    LPARAM lParam;
    struct _GROUP_POLICY_OBJECTW *pNext;
    struct _GROUP_POLICY_OBJECTW *pPrev;
    LPWSTR lpExtensions;
    LPARAM lParam2;
    LPWSTR lpLink;
  } GROUP_POLICY_OBJECTW,*PGROUP_POLICY_OBJECTW;

#ifdef UNICODE
  typedef GROUP_POLICY_OBJECTW GROUP_POLICY_OBJECT;
  typedef PGROUP_POLICY_OBJECTW PGROUP_POLICY_OBJECT;
#else
  typedef GROUP_POLICY_OBJECTA GROUP_POLICY_OBJECT;
  typedef PGROUP_POLICY_OBJECTA PGROUP_POLICY_OBJECT;
#endif

#define GPO_LIST_FLAG_MACHINE 0x00000001
#define GPO_LIST_FLAG_SITEONLY 0x00000002
#define GPO_LIST_FLAG_NO_WMIFILTERS 0x00000004

#ifdef UNICODE
#define GetGPOList GetGPOListW
#define FreeGPOList FreeGPOListW
#define GetAppliedGPOList GetAppliedGPOListW
#else
#define GetGPOList GetGPOListA
#define FreeGPOList FreeGPOListA
#define GetAppliedGPOList GetAppliedGPOListA
#endif

  USERENVAPI WINBOOL WINAPI GetGPOListA(HANDLE hToken,LPCSTR lpName,LPCSTR lpHostName,LPCSTR lpComputerName,DWORD dwFlags,PGROUP_POLICY_OBJECTA *pGPOList);
  USERENVAPI WINBOOL WINAPI GetGPOListW(HANDLE hToken,LPCWSTR lpName,LPCWSTR lpHostName,LPCWSTR lpComputerName,DWORD dwFlags,PGROUP_POLICY_OBJECTW *pGPOList);
  USERENVAPI WINBOOL WINAPI FreeGPOListA(PGROUP_POLICY_OBJECTA pGPOList);
  USERENVAPI WINBOOL WINAPI FreeGPOListW(PGROUP_POLICY_OBJECTW pGPOList);
  USERENVAPI DWORD WINAPI GetAppliedGPOListA(DWORD dwFlags,LPCSTR pMachineName,PSID pSidUser,GUID *pGuidExtension,PGROUP_POLICY_OBJECTA *ppGPOList);
  USERENVAPI DWORD WINAPI GetAppliedGPOListW(DWORD dwFlags,LPCWSTR pMachineName,PSID pSidUser,GUID *pGuidExtension,PGROUP_POLICY_OBJECTW *ppGPOList);

#define GP_DLLNAME TEXT("DllName")
#define GP_ENABLEASYNCHRONOUSPROCESSING TEXT("EnableAsynchronousProcessing")
#define GP_MAXNOGPOLISTCHANGESINTERVAL TEXT("MaxNoGPOListChangesInterval")
#define GP_NOBACKGROUNDPOLICY TEXT("NoBackgroundPolicy")
#define GP_NOGPOLISTCHANGES TEXT("NoGPOListChanges")
#define GP_NOMACHINEPOLICY TEXT("NoMachinePolicy")
#define GP_NOSLOWLINK TEXT("NoSlowLink")
#define GP_NOTIFYLINKTRANSITION TEXT("NotifyLinkTransition")
#define GP_NOUSERPOLICY TEXT("NoUserPolicy")
#define GP_PERUSERLOCALSETTINGS TEXT("PerUserLocalSettings")
#define GP_PROCESSGROUPPOLICY TEXT("ProcessGroupPolicy")
#define GP_REQUIRESSUCCESSFULREGISTRY TEXT("RequiresSuccessfulRegistry")

#define GPO_INFO_FLAG_MACHINE 0x00000001
#define GPO_INFO_FLAG_BACKGROUND 0x00000010
#define GPO_INFO_FLAG_SLOWLINK 0x00000020
#define GPO_INFO_FLAG_VERBOSE 0x00000040
#define GPO_INFO_FLAG_NOCHANGES 0x00000080
#define GPO_INFO_FLAG_LINKTRANSITION 0x00000100

#define GPO_INFO_FLAG_LOGRSOP_TRANSITION 0x00000200

#define GPO_INFO_FLAG_FORCED_REFRESH 0x00000400
#define GPO_INFO_FLAG_SAFEMODE_BOOT 0x00000800
#define GPO_INFO_FLAG_ASYNC_FOREGROUND 0x00001000
#define GPO_INFO_FLAG_REPORT 0x00002000

  typedef UINT_PTR ASYNCCOMPLETIONHANDLE;
  typedef DWORD (*PFNSTATUSMESSAGECALLBACK)(WINBOOL bVerbose,LPWSTR lpMessage);
  typedef DWORD(*PFNPROCESSGROUPPOLICY)(DWORD dwFlags,HANDLE hToken,HKEY hKeyRoot,PGROUP_POLICY_OBJECT pDeletedGPOList,PGROUP_POLICY_OBJECT pChangedGPOList,ASYNCCOMPLETIONHANDLE pHandle,WINBOOL *pbAbort,PFNSTATUSMESSAGECALLBACK pStatusCallback);
  typedef DWORD(*PFNPROCESSGROUPPOLICYEX)(DWORD dwFlags,HANDLE hToken,HKEY hKeyRoot,PGROUP_POLICY_OBJECT pDeletedGPOList,PGROUP_POLICY_OBJECT pChangedGPOList,ASYNCCOMPLETIONHANDLE pHandle,WINBOOL *pbAbort,PFNSTATUSMESSAGECALLBACK pStatusCallback,IWbemServices *pWbemServices,HRESULT *pRsopStatus);
  typedef PVOID PRSOPTOKEN;

  typedef struct _RSOP_TARGET {
    WCHAR *pwszAccountName;
    WCHAR *pwszNewSOM;
    SAFEARRAY *psaSecurityGroups;
    PRSOPTOKEN pRsopToken;
    PGROUP_POLICY_OBJECT pGPOList;
    IWbemServices *pWbemServices;
  } RSOP_TARGET,*PRSOP_TARGET;

  typedef DWORD(*PFNGENERATEGROUPPOLICY)(DWORD dwFlags,WINBOOL *pbAbort,WCHAR *pwszSite,PRSOP_TARGET pComputerTarget,PRSOP_TARGET pUserTarget);

#define REGISTRY_EXTENSION_GUID { 0x35378EAC,0x683F,0x11D2,0xA8,0x9A,0x00,0xC0,0x4F,0xBB,0xCF,0xA2 }

  typedef GUID *REFGPEXTENSIONID;

  USERENVAPI DWORD WINAPI ProcessGroupPolicyCompleted(REFGPEXTENSIONID extensionId,ASYNCCOMPLETIONHANDLE pAsyncHandle,DWORD dwStatus);
  USERENVAPI DWORD WINAPI ProcessGroupPolicyCompletedEx(REFGPEXTENSIONID extensionId,ASYNCCOMPLETIONHANDLE pAsyncHandle,DWORD dwStatus,HRESULT RsopStatus);
  USERENVAPI HRESULT WINAPI RsopAccessCheckByType(PSECURITY_DESCRIPTOR pSecurityDescriptor,PSID pPrincipalSelfSid,PRSOPTOKEN pRsopToken,DWORD dwDesiredAccessMask,POBJECT_TYPE_LIST pObjectTypeList,DWORD ObjectTypeListLength,PGENERIC_MAPPING pGenericMapping,PPRIVILEGE_SET pPrivilegeSet,LPDWORD pdwPrivilegeSetLength,LPDWORD pdwGrantedAccessMask,LPBOOL pbAccessStatus);
  USERENVAPI HRESULT WINAPI RsopFileAccessCheck(LPWSTR pszFileName,PRSOPTOKEN pRsopToken,DWORD dwDesiredAccessMask,LPDWORD pdwGrantedAccessMask,LPBOOL pbAccessStatus);

  typedef enum _SETTINGSTATUS {
    RSOPUnspecified = 0,RSOPApplied,RSOPIgnored,RSOPFailed,RSOPSubsettingFailed
  } SETTINGSTATUS;

  typedef struct _POLICYSETTINGSTATUSINFO {
    LPWSTR szKey;
    LPWSTR szEventSource;
    LPWSTR szEventLogName;
    DWORD dwEventID;
    DWORD dwErrorCode;
    SETTINGSTATUS status;
    SYSTEMTIME timeLogged;
  } POLICYSETTINGSTATUSINFO,*LPPOLICYSETTINGSTATUSINFO;

  USERENVAPI HRESULT WINAPI RsopSetPolicySettingStatus(DWORD dwFlags,IWbemServices *pServices,IWbemClassObject *pSettingInstance,DWORD nInfo,POLICYSETTINGSTATUSINFO *pStatus);
  USERENVAPI HRESULT WINAPI RsopResetPolicySettingStatus(DWORD dwFlags,IWbemServices *pServices,IWbemClassObject *pSettingInstance);

#define FLAG_NO_GPO_FILTER 0x80000000
#define FLAG_NO_CSE_INVOKE 0x40000000
#define FLAG_ASSUME_SLOW_LINK 0x20000000
#define FLAG_LOOPBACK_MERGE 0x10000000
#define FLAG_LOOPBACK_REPLACE 0x08000000

#define FLAG_ASSUME_USER_WQLFILTER_TRUE 0x04000000
#define FLAG_ASSUME_COMP_WQLFILTER_TRUE 0x02000000

#define FLAG_PLANNING_MODE 0x01000000

#define FLAG_NO_USER 0x00000001
#define FLAG_NO_COMPUTER 0x00000002
#define FLAG_FORCE_CREATENAMESPACE 0x00000004

#define RSOP_USER_ACCESS_DENIED 0x00000001

#define RSOP_COMPUTER_ACCESS_DENIED 0x00000002

#define RSOP_TEMPNAMESPACE_EXISTS 0x00000004

#ifdef __cplusplus
}
#endif

#endif /* _USERENV_H_ */
