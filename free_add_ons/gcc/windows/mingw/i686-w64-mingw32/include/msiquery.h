/**
 * This file has no copyright assigned and is placed in the Public Domain.
 * This file is part of the w64 mingw-runtime package.
 * No warranty is given; refer to the file DISCLAIMER.PD within this package.
 */
#ifndef _MSIQUERY_H_
#define _MSIQUERY_H_
#include "msi.h"

#define MSI_NULL_INTEGER 0x80000000

#define MSIDBOPEN_READONLY (LPCTSTR)0
#define MSIDBOPEN_TRANSACT (LPCTSTR)1
#define MSIDBOPEN_DIRECT (LPCTSTR)2
#define MSIDBOPEN_CREATE (LPCTSTR)3
#define MSIDBOPEN_CREATEDIRECT (LPCTSTR)4
#define MSIDBOPEN_PATCHFILE 32/sizeof(*MSIDBOPEN_READONLY)

typedef enum tagMSIDBSTATE {
  MSIDBSTATE_ERROR =-1,MSIDBSTATE_READ = 0,MSIDBSTATE_WRITE = 1
} MSIDBSTATE;

typedef enum tagMSIMODIFY {
  MSIMODIFY_SEEK =-1,MSIMODIFY_REFRESH = 0,MSIMODIFY_INSERT = 1,MSIMODIFY_UPDATE = 2,MSIMODIFY_ASSIGN = 3,MSIMODIFY_REPLACE = 4,
  MSIMODIFY_MERGE = 5,MSIMODIFY_DELETE = 6,MSIMODIFY_INSERT_TEMPORARY = 7,MSIMODIFY_VALIDATE = 8,MSIMODIFY_VALIDATE_NEW = 9,
  MSIMODIFY_VALIDATE_FIELD = 10,MSIMODIFY_VALIDATE_DELETE = 11
} MSIMODIFY;

typedef enum tagMSICOLINFO {
  MSICOLINFO_NAMES = 0,MSICOLINFO_TYPES = 1
} MSICOLINFO;

typedef enum tagMSICONDITION {
  MSICONDITION_FALSE = 0,MSICONDITION_TRUE = 1,MSICONDITION_NONE = 2,MSICONDITION_ERROR = 3
} MSICONDITION;

typedef enum tagMSICOSTTREE {
  MSICOSTTREE_SELFONLY = 0,MSICOSTTREE_CHILDREN = 1,MSICOSTTREE_PARENTS = 2,MSICOSTTREE_RESERVED = 3
} MSICOSTTREE;

typedef enum tagMSIDBERROR {
  MSIDBERROR_INVALIDARG = -3,MSIDBERROR_MOREDATA = -2,MSIDBERROR_FUNCTIONERROR = -1,MSIDBERROR_NOERROR = 0,MSIDBERROR_DUPLICATEKEY = 1,
  MSIDBERROR_REQUIRED = 2,MSIDBERROR_BADLINK = 3,MSIDBERROR_OVERFLOW = 4,MSIDBERROR_UNDERFLOW = 5,MSIDBERROR_NOTINSET = 6,
  MSIDBERROR_BADVERSION = 7,MSIDBERROR_BADCASE = 8,MSIDBERROR_BADGUID = 9,MSIDBERROR_BADWILDCARD = 10,MSIDBERROR_BADIDENTIFIER = 11,
  MSIDBERROR_BADLANGUAGE = 12,MSIDBERROR_BADFILENAME = 13,MSIDBERROR_BADPATH = 14,MSIDBERROR_BADCONDITION = 15,MSIDBERROR_BADFORMATTED = 16,
  MSIDBERROR_BADTEMPLATE = 17,MSIDBERROR_BADDEFAULTDIR = 18,MSIDBERROR_BADREGPATH = 19,MSIDBERROR_BADCUSTOMSOURCE = 20,MSIDBERROR_BADPROPERTY = 21,
  MSIDBERROR_MISSINGDATA = 22,MSIDBERROR_BADCATEGORY = 23,MSIDBERROR_BADKEYTABLE = 24,MSIDBERROR_BADMAXMINVALUES = 25,MSIDBERROR_BADCABINET = 26,
  MSIDBERROR_BADSHORTCUT = 27,MSIDBERROR_STRINGOVERFLOW = 28,MSIDBERROR_BADLOCALIZEATTRIB = 29
} MSIDBERROR;

typedef enum tagMSIRUNMODE {
  MSIRUNMODE_ADMIN = 0,MSIRUNMODE_ADVERTISE = 1,MSIRUNMODE_MAINTENANCE = 2,MSIRUNMODE_ROLLBACKENABLED = 3,MSIRUNMODE_LOGENABLED = 4,
  MSIRUNMODE_OPERATIONS = 5,MSIRUNMODE_REBOOTATEND = 6,MSIRUNMODE_REBOOTNOW = 7,MSIRUNMODE_CABINET = 8,MSIRUNMODE_SOURCESHORTNAMES= 9,
  MSIRUNMODE_TARGETSHORTNAMES= 10,MSIRUNMODE_RESERVED11 = 11,MSIRUNMODE_WINDOWS9X = 12,MSIRUNMODE_ZAWENABLED = 13,MSIRUNMODE_RESERVED14 = 14,
  MSIRUNMODE_RESERVED15 = 15,MSIRUNMODE_SCHEDULED = 16,MSIRUNMODE_ROLLBACK = 17,MSIRUNMODE_COMMIT = 18
} MSIRUNMODE;

#define INSTALLMESSAGE_TYPEMASK 0xFF000000L

typedef enum tagMSITRANSFORM_ERROR {
  MSITRANSFORM_ERROR_ADDEXISTINGROW = 0x00000001,MSITRANSFORM_ERROR_DELMISSINGROW = 0x00000002,MSITRANSFORM_ERROR_ADDEXISTINGTABLE = 0x00000004,
  MSITRANSFORM_ERROR_DELMISSINGTABLE = 0x00000008,MSITRANSFORM_ERROR_UPDATEMISSINGROW = 0x00000010,MSITRANSFORM_ERROR_CHANGECODEPAGE = 0x00000020,
  MSITRANSFORM_ERROR_VIEWTRANSFORM = 0x00000100
} MSITRANSFORM_ERROR;

typedef enum tagMSITRANSFORM_VALIDATE {
  MSITRANSFORM_VALIDATE_LANGUAGE = 0x00000001,MSITRANSFORM_VALIDATE_PRODUCT = 0x00000002,MSITRANSFORM_VALIDATE_PLATFORM = 0x00000004,
  MSITRANSFORM_VALIDATE_MAJORVERSION = 0x00000008,MSITRANSFORM_VALIDATE_MINORVERSION = 0x00000010,MSITRANSFORM_VALIDATE_UPDATEVERSION = 0x00000020,
  MSITRANSFORM_VALIDATE_NEWLESSBASEVERSION = 0x00000040,MSITRANSFORM_VALIDATE_NEWLESSEQUALBASEVERSION = 0x00000080,
  MSITRANSFORM_VALIDATE_NEWEQUALBASEVERSION = 0x00000100,MSITRANSFORM_VALIDATE_NEWGREATEREQUALBASEVERSION = 0x00000200,
  MSITRANSFORM_VALIDATE_NEWGREATERBASEVERSION = 0x00000400,MSITRANSFORM_VALIDATE_UPGRADECODE = 0x00000800
} MSITRANSFORM_VALIDATE;

#ifdef __cplusplus
extern "C" {
#endif

  UINT WINAPI MsiDatabaseOpenViewA(MSIHANDLE hDatabase,LPCSTR szQuery,MSIHANDLE *phView);
  UINT WINAPI MsiDatabaseOpenViewW(MSIHANDLE hDatabase,LPCWSTR szQuery,MSIHANDLE *phView);
#ifdef UNICODE
#define MsiDatabaseOpenView MsiDatabaseOpenViewW
#else
#define MsiDatabaseOpenView MsiDatabaseOpenViewA
#endif

  MSIDBERROR WINAPI MsiViewGetErrorA(MSIHANDLE hView,LPSTR szColumnNameBuffer,DWORD *pcchBuf);
  MSIDBERROR WINAPI MsiViewGetErrorW(MSIHANDLE hView,LPWSTR szColumnNameBuffer,DWORD *pcchBuf);
#ifdef UNICODE
#define MsiViewGetError MsiViewGetErrorW
#else
#define MsiViewGetError MsiViewGetErrorA
#endif

  UINT WINAPI MsiViewExecute(MSIHANDLE hView,MSIHANDLE hRecord);
  UINT WINAPI MsiViewFetch(MSIHANDLE hView,MSIHANDLE *phRecord);
  UINT WINAPI MsiViewModify(MSIHANDLE hView,MSIMODIFY eModifyMode,MSIHANDLE hRecord);
  UINT WINAPI MsiViewGetColumnInfo(MSIHANDLE hView,MSICOLINFO eColumnInfo,MSIHANDLE *phRecord);
  UINT WINAPI MsiViewClose(MSIHANDLE hView);
  UINT WINAPI MsiDatabaseGetPrimaryKeysA(MSIHANDLE hDatabase,LPCSTR szTableName,MSIHANDLE *phRecord);
  UINT WINAPI MsiDatabaseGetPrimaryKeysW(MSIHANDLE hDatabase,LPCWSTR szTableName,MSIHANDLE *phRecord);
#ifdef UNICODE
#define MsiDatabaseGetPrimaryKeys MsiDatabaseGetPrimaryKeysW
#else
#define MsiDatabaseGetPrimaryKeys MsiDatabaseGetPrimaryKeysA
#endif

  MSICONDITION WINAPI MsiDatabaseIsTablePersistentA(MSIHANDLE hDatabase,LPCSTR szTableName);
  MSICONDITION WINAPI MsiDatabaseIsTablePersistentW(MSIHANDLE hDatabase,LPCWSTR szTableName);
#ifdef UNICODE
#define MsiDatabaseIsTablePersistent MsiDatabaseIsTablePersistentW
#else
#define MsiDatabaseIsTablePersistent MsiDatabaseIsTablePersistentA
#endif

  UINT WINAPI MsiGetSummaryInformationA(MSIHANDLE hDatabase,LPCSTR szDatabasePath,UINT uiUpdateCount,MSIHANDLE *phSummaryInfo);
  UINT WINAPI MsiGetSummaryInformationW(MSIHANDLE hDatabase,LPCWSTR szDatabasePath,UINT uiUpdateCount,MSIHANDLE *phSummaryInfo);
#ifdef UNICODE
#define MsiGetSummaryInformation MsiGetSummaryInformationW
#else
#define MsiGetSummaryInformation MsiGetSummaryInformationA
#endif

  UINT WINAPI MsiSummaryInfoGetPropertyCount(MSIHANDLE hSummaryInfo,UINT *puiPropertyCount);
  UINT WINAPI MsiSummaryInfoSetPropertyA(MSIHANDLE hSummaryInfo,UINT uiProperty,UINT uiDataType,INT iValue,FILETIME *pftValue,LPCSTR szValue);
  UINT WINAPI MsiSummaryInfoSetPropertyW(MSIHANDLE hSummaryInfo,UINT uiProperty,UINT uiDataType,INT iValue,FILETIME *pftValue,LPCWSTR szValue);
#ifdef UNICODE
#define MsiSummaryInfoSetProperty MsiSummaryInfoSetPropertyW
#else
#define MsiSummaryInfoSetProperty MsiSummaryInfoSetPropertyA
#endif

  UINT WINAPI MsiSummaryInfoGetPropertyA(MSIHANDLE hSummaryInfo,UINT uiProperty,UINT *puiDataType,INT *piValue,FILETIME *pftValue,LPSTR szValueBuf,DWORD *pcchValueBuf);
  UINT WINAPI MsiSummaryInfoGetPropertyW(MSIHANDLE hSummaryInfo,UINT uiProperty,UINT *puiDataType,INT *piValue,FILETIME *pftValue,LPWSTR szValueBuf,DWORD *pcchValueBuf);
#ifdef UNICODE
#define MsiSummaryInfoGetProperty MsiSummaryInfoGetPropertyW
#else
#define MsiSummaryInfoGetProperty MsiSummaryInfoGetPropertyA
#endif

  UINT WINAPI MsiSummaryInfoPersist(MSIHANDLE hSummaryInfo);
  UINT WINAPI MsiOpenDatabaseA(LPCSTR szDatabasePath,LPCSTR szPersist,MSIHANDLE *phDatabase);
  UINT WINAPI MsiOpenDatabaseW(LPCWSTR szDatabasePath,LPCWSTR szPersist,MSIHANDLE *phDatabase);
#ifdef UNICODE
#define MsiOpenDatabase MsiOpenDatabaseW
#else
#define MsiOpenDatabase MsiOpenDatabaseA
#endif

  UINT WINAPI MsiDatabaseImportA(MSIHANDLE hDatabase,LPCSTR szFolderPath,LPCSTR szFileName);
  UINT WINAPI MsiDatabaseImportW(MSIHANDLE hDatabase,LPCWSTR szFolderPath,LPCWSTR szFileName);
#ifdef UNICODE
#define MsiDatabaseImport MsiDatabaseImportW
#else
#define MsiDatabaseImport MsiDatabaseImportA
#endif

  UINT WINAPI MsiDatabaseExportA(MSIHANDLE hDatabase,LPCSTR szTableName,LPCSTR szFolderPath,LPCSTR szFileName);
  UINT WINAPI MsiDatabaseExportW(MSIHANDLE hDatabase,LPCWSTR szTableName,LPCWSTR szFolderPath,LPCWSTR szFileName);
#ifdef UNICODE
#define MsiDatabaseExport MsiDatabaseExportW
#else
#define MsiDatabaseExport MsiDatabaseExportA
#endif

  UINT WINAPI MsiDatabaseMergeA(MSIHANDLE hDatabase,MSIHANDLE hDatabaseMerge,LPCSTR szTableName);
  UINT WINAPI MsiDatabaseMergeW(MSIHANDLE hDatabase,MSIHANDLE hDatabaseMerge,LPCWSTR szTableName);
#ifdef UNICODE
#define MsiDatabaseMerge MsiDatabaseMergeW
#else
#define MsiDatabaseMerge MsiDatabaseMergeA
#endif

  UINT WINAPI MsiDatabaseGenerateTransformA(MSIHANDLE hDatabase,MSIHANDLE hDatabaseReference,LPCSTR szTransformFile,int iReserved1,int iReserved2);
  UINT WINAPI MsiDatabaseGenerateTransformW(MSIHANDLE hDatabase,MSIHANDLE hDatabaseReference,LPCWSTR szTransformFile,int iReserved1,int iReserved2);
#ifdef UNICODE
#define MsiDatabaseGenerateTransform MsiDatabaseGenerateTransformW
#else
#define MsiDatabaseGenerateTransform MsiDatabaseGenerateTransformA
#endif

  UINT WINAPI MsiDatabaseApplyTransformA(MSIHANDLE hDatabase,LPCSTR szTransformFile,int iErrorConditions);
  UINT WINAPI MsiDatabaseApplyTransformW(MSIHANDLE hDatabase,LPCWSTR szTransformFile,int iErrorConditions);
#ifdef UNICODE
#define MsiDatabaseApplyTransform MsiDatabaseApplyTransformW
#else
#define MsiDatabaseApplyTransform MsiDatabaseApplyTransformA
#endif

  UINT WINAPI MsiCreateTransformSummaryInfoA(MSIHANDLE hDatabase,MSIHANDLE hDatabaseReference,LPCSTR szTransformFile,int iErrorConditions,int iValidation);
  UINT WINAPI MsiCreateTransformSummaryInfoW(MSIHANDLE hDatabase,MSIHANDLE hDatabaseReference,LPCWSTR szTransformFile,int iErrorConditions,int iValidation);
#ifdef UNICODE
#define MsiCreateTransformSummaryInfo MsiCreateTransformSummaryInfoW
#else
#define MsiCreateTransformSummaryInfo MsiCreateTransformSummaryInfoA
#endif

  UINT WINAPI MsiDatabaseCommit(MSIHANDLE hDatabase);
  MSIDBSTATE WINAPI MsiGetDatabaseState(MSIHANDLE hDatabase);
  MSIHANDLE WINAPI MsiCreateRecord(UINT cParams);
  WINBOOL WINAPI MsiRecordIsNull(MSIHANDLE hRecord,UINT iField);
  UINT WINAPI MsiRecordDataSize(MSIHANDLE hRecord,UINT iField);
  UINT WINAPI MsiRecordSetInteger(MSIHANDLE hRecord,UINT iField,int iValue);
  UINT WINAPI MsiRecordSetStringA(MSIHANDLE hRecord,UINT iField,LPCSTR szValue);
  UINT WINAPI MsiRecordSetStringW(MSIHANDLE hRecord,UINT iField,LPCWSTR szValue);
#ifdef UNICODE
#define MsiRecordSetString MsiRecordSetStringW
#else
#define MsiRecordSetString MsiRecordSetStringA
#endif

  int WINAPI MsiRecordGetInteger(MSIHANDLE hRecord,UINT iField);

  UINT WINAPI MsiRecordGetStringA(MSIHANDLE hRecord,UINT iField,LPSTR szValueBuf,DWORD *pcchValueBuf);
  UINT WINAPI MsiRecordGetStringW(MSIHANDLE hRecord,UINT iField,LPWSTR szValueBuf,DWORD *pcchValueBuf);
#ifdef UNICODE
#define MsiRecordGetString MsiRecordGetStringW
#else
#define MsiRecordGetString MsiRecordGetStringA
#endif

  UINT WINAPI MsiRecordGetFieldCount(MSIHANDLE hRecord);
  UINT WINAPI MsiRecordSetStreamA(MSIHANDLE hRecord,UINT iField,LPCSTR szFilePath);
  UINT WINAPI MsiRecordSetStreamW(MSIHANDLE hRecord,UINT iField,LPCWSTR szFilePath);
#ifdef UNICODE
#define MsiRecordSetStream MsiRecordSetStreamW
#else
#define MsiRecordSetStream MsiRecordSetStreamA
#endif

  UINT WINAPI MsiRecordReadStream(MSIHANDLE hRecord,UINT iField,char *szDataBuf,DWORD *pcbDataBuf);
  UINT WINAPI MsiRecordClearData(MSIHANDLE hRecord);
  MSIHANDLE WINAPI MsiGetActiveDatabase(MSIHANDLE hInstall);
  UINT WINAPI MsiSetPropertyA(MSIHANDLE hInstall,LPCSTR szName,LPCSTR szValue);
  UINT WINAPI MsiSetPropertyW(MSIHANDLE hInstall,LPCWSTR szName,LPCWSTR szValue);
#ifdef UNICODE
#define MsiSetProperty MsiSetPropertyW
#else
#define MsiSetProperty MsiSetPropertyA
#endif

  UINT WINAPI MsiGetPropertyA(MSIHANDLE hInstall,LPCSTR szName,LPSTR szValueBuf,DWORD *pcchValueBuf);
  UINT WINAPI MsiGetPropertyW(MSIHANDLE hInstall,LPCWSTR szName,LPWSTR szValueBuf,DWORD *pcchValueBuf);
#ifdef UNICODE
#define MsiGetProperty MsiGetPropertyW
#else
#define MsiGetProperty MsiGetPropertyA
#endif

  LANGID WINAPI MsiGetLanguage(MSIHANDLE hInstall);
  WINBOOL WINAPI MsiGetMode(MSIHANDLE hInstall,MSIRUNMODE eRunMode);
  UINT WINAPI MsiSetMode(MSIHANDLE hInstall,MSIRUNMODE eRunMode,WINBOOL fState);
  UINT WINAPI MsiFormatRecordA(MSIHANDLE hInstall,MSIHANDLE hRecord,LPSTR szResultBuf,DWORD *pcchResultBuf);
  UINT WINAPI MsiFormatRecordW(MSIHANDLE hInstall,MSIHANDLE hRecord,LPWSTR szResultBuf,DWORD *pcchResultBuf);
#ifdef UNICODE
#define MsiFormatRecord MsiFormatRecordW
#else
#define MsiFormatRecord MsiFormatRecordA
#endif

  UINT WINAPI MsiDoActionA(MSIHANDLE hInstall,LPCSTR szAction);
  UINT WINAPI MsiDoActionW(MSIHANDLE hInstall,LPCWSTR szAction);
#ifdef UNICODE
#define MsiDoAction MsiDoActionW
#else
#define MsiDoAction MsiDoActionA
#endif

  UINT WINAPI MsiSequenceA(MSIHANDLE hInstall,LPCSTR szTable,INT iSequenceMode);
  UINT WINAPI MsiSequenceW(MSIHANDLE hInstall,LPCWSTR szTable,INT iSequenceMode);
#ifdef UNICODE
#define MsiSequence MsiSequenceW
#else
#define MsiSequence MsiSequenceA
#endif

  int WINAPI MsiProcessMessage(MSIHANDLE hInstall,INSTALLMESSAGE eMessageType,MSIHANDLE hRecord);
  MSICONDITION WINAPI MsiEvaluateConditionA(MSIHANDLE hInstall,LPCSTR szCondition);
  MSICONDITION WINAPI MsiEvaluateConditionW(MSIHANDLE hInstall,LPCWSTR szCondition);
#ifdef UNICODE
#define MsiEvaluateCondition MsiEvaluateConditionW
#else
#define MsiEvaluateCondition MsiEvaluateConditionA
#endif

  UINT WINAPI MsiGetFeatureStateA(MSIHANDLE hInstall,LPCSTR szFeature,INSTALLSTATE *piInstalled,INSTALLSTATE *piAction);
  UINT WINAPI MsiGetFeatureStateW(MSIHANDLE hInstall,LPCWSTR szFeature,INSTALLSTATE *piInstalled,INSTALLSTATE *piAction);
#ifdef UNICODE
#define MsiGetFeatureState MsiGetFeatureStateW
#else
#define MsiGetFeatureState MsiGetFeatureStateA
#endif

  UINT WINAPI MsiSetFeatureStateA(MSIHANDLE hInstall,LPCSTR szFeature,INSTALLSTATE iState);
  UINT WINAPI MsiSetFeatureStateW(MSIHANDLE hInstall,LPCWSTR szFeature,INSTALLSTATE iState);
#ifdef UNICODE
#define MsiSetFeatureState MsiSetFeatureStateW
#else
#define MsiSetFeatureState MsiSetFeatureStateA
#endif

#if (_WIN32_MSI >= 110)

  UINT WINAPI MsiSetFeatureAttributesA(MSIHANDLE hInstall,LPCSTR szFeature,DWORD dwAttributes);
  UINT WINAPI MsiSetFeatureAttributesW(MSIHANDLE hInstall,LPCWSTR szFeature,DWORD dwAttributes);
#ifdef UNICODE
#define MsiSetFeatureAttributes MsiSetFeatureAttributesW
#else
#define MsiSetFeatureAttributes MsiSetFeatureAttributesA
#endif
#endif

  UINT WINAPI MsiGetComponentStateA(MSIHANDLE hInstall,LPCSTR szComponent,INSTALLSTATE *piInstalled,INSTALLSTATE *piAction);
  UINT WINAPI MsiGetComponentStateW(MSIHANDLE hInstall,LPCWSTR szComponent,INSTALLSTATE *piInstalled,INSTALLSTATE *piAction);
#ifdef UNICODE
#define MsiGetComponentState MsiGetComponentStateW
#else
#define MsiGetComponentState MsiGetComponentStateA
#endif

  UINT WINAPI MsiSetComponentStateA(MSIHANDLE hInstall,LPCSTR szComponent,INSTALLSTATE iState);
  UINT WINAPI MsiSetComponentStateW(MSIHANDLE hInstall,LPCWSTR szComponent,INSTALLSTATE iState);
#ifdef UNICODE
#define MsiSetComponentState MsiSetComponentStateW
#else
#define MsiSetComponentState MsiSetComponentStateA
#endif

  UINT WINAPI MsiGetFeatureCostA(MSIHANDLE hInstall,LPCSTR szFeature,MSICOSTTREE iCostTree,INSTALLSTATE iState,INT *piCost);
  UINT WINAPI MsiGetFeatureCostW(MSIHANDLE hInstall,LPCWSTR szFeature,MSICOSTTREE iCostTree,INSTALLSTATE iState,INT *piCost);
#ifdef UNICODE
#define MsiGetFeatureCost MsiGetFeatureCostW
#else
#define MsiGetFeatureCost MsiGetFeatureCostA
#endif

#if (_WIN32_MSI >= 150)
#ifdef UNICODE
#define MsiEnumComponentCosts MsiEnumComponentCostsW
#else
#define MsiEnumComponentCosts MsiEnumComponentCostsA
#endif
  UINT WINAPI MsiEnumComponentCostsA(MSIHANDLE hInstall,LPCSTR szComponent,DWORD dwIndex,INSTALLSTATE iState,LPSTR szDriveBuf,DWORD *pcchDriveBuf,INT *piCost,INT *piTempCost);
  UINT WINAPI MsiEnumComponentCostsW(MSIHANDLE hInstall,LPCWSTR szComponent,DWORD dwIndex,INSTALLSTATE iState,LPWSTR szDriveBuf,DWORD *pcchDriveBuf,INT *piCost,INT *piTempCost);
#endif

#ifdef UNICODE
#define MsiGetFeatureValidStates MsiGetFeatureValidStatesW
#define MsiGetSourcePath MsiGetSourcePathW
#define MsiGetTargetPath MsiGetTargetPathW
#define MsiSetTargetPath MsiSetTargetPathW
#define MsiPreviewDialog MsiPreviewDialogW
#define MsiPreviewBillboard MsiPreviewBillboardW
#else
#define MsiGetFeatureValidStates MsiGetFeatureValidStatesA
#define MsiGetSourcePath MsiGetSourcePathA
#define MsiGetTargetPath MsiGetTargetPathA
#define MsiSetTargetPath MsiSetTargetPathA
#define MsiPreviewDialog MsiPreviewDialogA
#define MsiPreviewBillboard MsiPreviewBillboardA
#endif

  UINT WINAPI MsiSetInstallLevel(MSIHANDLE hInstall,int iInstallLevel);
  UINT WINAPI MsiGetFeatureValidStatesA(MSIHANDLE hInstall,LPCSTR szFeature,DWORD *dwInstallStates);
  UINT WINAPI MsiGetFeatureValidStatesW(MSIHANDLE hInstall,LPCWSTR szFeature,DWORD *dwInstallStates);
  UINT WINAPI MsiGetSourcePathA(MSIHANDLE hInstall,LPCSTR szFolder,LPSTR szPathBuf,DWORD *pcchPathBuf);
  UINT WINAPI MsiGetSourcePathW(MSIHANDLE hInstall,LPCWSTR szFolder,LPWSTR szPathBuf,DWORD *pcchPathBuf);
  UINT WINAPI MsiGetTargetPathA(MSIHANDLE hInstall,LPCSTR szFolder,LPSTR szPathBuf,DWORD *pcchPathBuf);
  UINT WINAPI MsiGetTargetPathW(MSIHANDLE hInstall,LPCWSTR szFolder,LPWSTR szPathBuf,DWORD *pcchPathBuf);
  UINT WINAPI MsiSetTargetPathA(MSIHANDLE hInstall,LPCSTR szFolder,LPCSTR szFolderPath);
  UINT WINAPI MsiSetTargetPathW(MSIHANDLE hInstall,LPCWSTR szFolder,LPCWSTR szFolderPath);
  UINT WINAPI MsiVerifyDiskSpace(MSIHANDLE hInstall);
  UINT WINAPI MsiEnableUIPreview(MSIHANDLE hDatabase,MSIHANDLE *phPreview);
  UINT WINAPI MsiPreviewDialogA(MSIHANDLE hPreview,LPCSTR szDialogName);
  UINT WINAPI MsiPreviewDialogW(MSIHANDLE hPreview,LPCWSTR szDialogName);
  UINT WINAPI MsiPreviewBillboardA(MSIHANDLE hPreview,LPCSTR szControlName,LPCSTR szBillboard);
  UINT WINAPI MsiPreviewBillboardW(MSIHANDLE hPreview,LPCWSTR szControlName,LPCWSTR szBillboard);
  MSIHANDLE WINAPI MsiGetLastErrorRecord();

#ifdef __cplusplus
}
#endif
#endif
