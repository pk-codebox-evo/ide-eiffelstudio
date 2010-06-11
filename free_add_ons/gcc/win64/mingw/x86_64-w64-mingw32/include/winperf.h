/**
 * This file has no copyright assigned and is placed in the Public Domain.
 * This file is part of the w64 mingw-runtime package.
 * No warranty is given; refer to the file DISCLAIMER.PD within this package.
 */
#ifndef _WINPERF_
#define _WINPERF_

#include <pshpack8.h>

#define PERF_DATA_VERSION 1
#define PERF_DATA_REVISION 1

typedef struct _PERF_DATA_BLOCK {
  WCHAR Signature[4];
  DWORD LittleEndian;
  DWORD Version;
  DWORD Revision;
  DWORD TotalByteLength;
  DWORD HeaderLength;
  DWORD NumObjectTypes;
  LONG DefaultObject;
  SYSTEMTIME SystemTime;
  LARGE_INTEGER PerfTime;
  LARGE_INTEGER PerfFreq;
  LARGE_INTEGER PerfTime100nSec;
  DWORD SystemNameLength;
  DWORD SystemNameOffset;
} PERF_DATA_BLOCK,*PPERF_DATA_BLOCK;

typedef struct _PERF_OBJECT_TYPE {
  DWORD TotalByteLength;
  DWORD DefinitionLength;
  DWORD HeaderLength;
  DWORD ObjectNameTitleIndex;
#ifdef _WIN64
  DWORD ObjectNameTitle;
#else
  LPWSTR ObjectNameTitle;
#endif
  DWORD ObjectHelpTitleIndex;
#ifdef _WIN64
  DWORD ObjectHelpTitle;
#else
  LPWSTR ObjectHelpTitle;
#endif
  DWORD DetailLevel;
  DWORD NumCounters;
  LONG DefaultCounter;
  LONG NumInstances;
  DWORD CodePage;
  LARGE_INTEGER PerfTime;
  LARGE_INTEGER PerfFreq;
} PERF_OBJECT_TYPE,*PPERF_OBJECT_TYPE;

#define PERF_NO_INSTANCES -1
#define PERF_SIZE_DWORD 0x00000000
#define PERF_SIZE_LARGE 0x00000100
#define PERF_SIZE_ZERO 0x00000200
#define PERF_SIZE_VARIABLE_LEN 0x00000300
#define PERF_TYPE_NUMBER 0x00000000
#define PERF_TYPE_COUNTER 0x00000400
#define PERF_TYPE_TEXT 0x00000800
#define PERF_TYPE_ZERO 0x00000C00
#define PERF_NUMBER_HEX 0x00000000
#define PERF_NUMBER_DECIMAL 0x00010000
#define PERF_NUMBER_DEC_1000 0x00020000
#define PERF_COUNTER_VALUE 0x00000000
#define PERF_COUNTER_RATE 0x00010000
#define PERF_COUNTER_FRACTION 0x00020000
#define PERF_COUNTER_BASE 0x00030000
#define PERF_COUNTER_ELAPSED 0x00040000
#define PERF_COUNTER_QUEUELEN 0x00050000
#define PERF_COUNTER_HISTOGRAM 0x00060000
#define PERF_COUNTER_PRECISION 0x00070000
#define PERF_TEXT_UNICODE 0x00000000
#define PERF_TEXT_ASCII 0x00010000
#define PERF_TIMER_TICK 0x00000000
#define PERF_TIMER_100NS 0x00100000
#define PERF_OBJECT_TIMER 0x00200000
#define PERF_DELTA_COUNTER 0x00400000
#define PERF_DELTA_BASE 0x00800000
#define PERF_INVERSE_COUNTER 0x01000000
#define PERF_MULTI_COUNTER 0x02000000

#define PERF_DISPLAY_NO_SUFFIX 0x00000000
#define PERF_DISPLAY_PER_SEC 0x10000000
#define PERF_DISPLAY_PERCENT 0x20000000
#define PERF_DISPLAY_SECONDS 0x30000000
#define PERF_DISPLAY_NOSHOW 0x40000000

#define PERF_COUNTER_COUNTER (PERF_SIZE_DWORD | PERF_TYPE_COUNTER | PERF_COUNTER_RATE | PERF_TIMER_TICK | PERF_DELTA_COUNTER | PERF_DISPLAY_PER_SEC)
#define PERF_COUNTER_TIMER (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_RATE | PERF_TIMER_TICK | PERF_DELTA_COUNTER | PERF_DISPLAY_PERCENT)
#define PERF_COUNTER_QUEUELEN_TYPE (PERF_SIZE_DWORD | PERF_TYPE_COUNTER | PERF_COUNTER_QUEUELEN | PERF_TIMER_TICK | PERF_DELTA_COUNTER | PERF_DISPLAY_NO_SUFFIX)
#define PERF_COUNTER_LARGE_QUEUELEN_TYPE (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_QUEUELEN | PERF_TIMER_TICK | PERF_DELTA_COUNTER | PERF_DISPLAY_NO_SUFFIX)
#define PERF_COUNTER_100NS_QUEUELEN_TYPE (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_QUEUELEN | PERF_TIMER_100NS | PERF_DELTA_COUNTER | PERF_DISPLAY_NO_SUFFIX)
#define PERF_COUNTER_OBJ_TIME_QUEUELEN_TYPE (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_QUEUELEN | PERF_OBJECT_TIMER | PERF_DELTA_COUNTER | PERF_DISPLAY_NO_SUFFIX)
#define PERF_COUNTER_BULK_COUNT (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_RATE | PERF_TIMER_TICK | PERF_DELTA_COUNTER | PERF_DISPLAY_PER_SEC)
#define PERF_COUNTER_TEXT (PERF_SIZE_VARIABLE_LEN | PERF_TYPE_TEXT | PERF_TEXT_UNICODE | PERF_DISPLAY_NO_SUFFIX)
#define PERF_COUNTER_RAWCOUNT (PERF_SIZE_DWORD | PERF_TYPE_NUMBER | PERF_NUMBER_DECIMAL | PERF_DISPLAY_NO_SUFFIX)
#define PERF_COUNTER_LARGE_RAWCOUNT (PERF_SIZE_LARGE | PERF_TYPE_NUMBER | PERF_NUMBER_DECIMAL | PERF_DISPLAY_NO_SUFFIX)
#define PERF_COUNTER_RAWCOUNT_HEX (PERF_SIZE_DWORD | PERF_TYPE_NUMBER | PERF_NUMBER_HEX | PERF_DISPLAY_NO_SUFFIX)
#define PERF_COUNTER_LARGE_RAWCOUNT_HEX (PERF_SIZE_LARGE | PERF_TYPE_NUMBER | PERF_NUMBER_HEX | PERF_DISPLAY_NO_SUFFIX)
#define PERF_SAMPLE_FRACTION (PERF_SIZE_DWORD | PERF_TYPE_COUNTER | PERF_COUNTER_FRACTION | PERF_DELTA_COUNTER | PERF_DELTA_BASE | PERF_DISPLAY_PERCENT)
#define PERF_SAMPLE_COUNTER (PERF_SIZE_DWORD | PERF_TYPE_COUNTER | PERF_COUNTER_RATE | PERF_TIMER_TICK | PERF_DELTA_COUNTER | PERF_DISPLAY_NO_SUFFIX)
#define PERF_COUNTER_NODATA (PERF_SIZE_ZERO | PERF_DISPLAY_NOSHOW)
#define PERF_COUNTER_TIMER_INV (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_RATE | PERF_TIMER_TICK | PERF_DELTA_COUNTER | PERF_INVERSE_COUNTER | PERF_DISPLAY_PERCENT)
#define PERF_SAMPLE_BASE (PERF_SIZE_DWORD | PERF_TYPE_COUNTER | PERF_COUNTER_BASE | PERF_DISPLAY_NOSHOW | 0x00000001)
#define PERF_AVERAGE_TIMER (PERF_SIZE_DWORD | PERF_TYPE_COUNTER | PERF_COUNTER_FRACTION | PERF_DISPLAY_SECONDS)
#define PERF_AVERAGE_BASE (PERF_SIZE_DWORD | PERF_TYPE_COUNTER | PERF_COUNTER_BASE | PERF_DISPLAY_NOSHOW | 0x00000002)
#define PERF_AVERAGE_BULK (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_FRACTION | PERF_DISPLAY_NOSHOW)
#define PERF_OBJ_TIME_TIMER (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_RATE | PERF_OBJECT_TIMER | PERF_DELTA_COUNTER | PERF_DISPLAY_PERCENT)
#define PERF_100NSEC_TIMER (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_RATE | PERF_TIMER_100NS | PERF_DELTA_COUNTER | PERF_DISPLAY_PERCENT)
#define PERF_100NSEC_TIMER_INV (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_RATE | PERF_TIMER_100NS | PERF_DELTA_COUNTER | PERF_INVERSE_COUNTER | PERF_DISPLAY_PERCENT)
#define PERF_COUNTER_MULTI_TIMER (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_RATE | PERF_DELTA_COUNTER | PERF_TIMER_TICK | PERF_MULTI_COUNTER | PERF_DISPLAY_PERCENT)
#define PERF_COUNTER_MULTI_TIMER_INV (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_RATE | PERF_DELTA_COUNTER | PERF_MULTI_COUNTER | PERF_TIMER_TICK | PERF_INVERSE_COUNTER | PERF_DISPLAY_PERCENT)
#define PERF_COUNTER_MULTI_BASE (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_BASE | PERF_MULTI_COUNTER | PERF_DISPLAY_NOSHOW)
#define PERF_100NSEC_MULTI_TIMER (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_DELTA_COUNTER | PERF_COUNTER_RATE | PERF_TIMER_100NS | PERF_MULTI_COUNTER | PERF_DISPLAY_PERCENT)
#define PERF_100NSEC_MULTI_TIMER_INV (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_DELTA_COUNTER | PERF_COUNTER_RATE | PERF_TIMER_100NS | PERF_MULTI_COUNTER | PERF_INVERSE_COUNTER | PERF_DISPLAY_PERCENT)
#define PERF_RAW_FRACTION (PERF_SIZE_DWORD | PERF_TYPE_COUNTER | PERF_COUNTER_FRACTION | PERF_DISPLAY_PERCENT)
#define PERF_LARGE_RAW_FRACTION (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_FRACTION | PERF_DISPLAY_PERCENT)
#define PERF_RAW_BASE (PERF_SIZE_DWORD | PERF_TYPE_COUNTER | PERF_COUNTER_BASE | PERF_DISPLAY_NOSHOW | 0x00000003)
#define PERF_LARGE_RAW_BASE (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_BASE | PERF_DISPLAY_NOSHOW)
#define PERF_ELAPSED_TIME (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_ELAPSED | PERF_OBJECT_TIMER | PERF_DISPLAY_SECONDS)
#define PERF_COUNTER_HISTOGRAM_TYPE 0x80000000
#define PERF_COUNTER_DELTA (PERF_SIZE_DWORD | PERF_TYPE_COUNTER | PERF_COUNTER_VALUE | PERF_DELTA_COUNTER | PERF_DISPLAY_NO_SUFFIX)
#define PERF_COUNTER_LARGE_DELTA (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_VALUE | PERF_DELTA_COUNTER | PERF_DISPLAY_NO_SUFFIX)
#define PERF_PRECISION_SYSTEM_TIMER (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_PRECISION | PERF_TIMER_TICK | PERF_DELTA_COUNTER | PERF_DISPLAY_PERCENT)
#define PERF_PRECISION_100NS_TIMER (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_PRECISION | PERF_TIMER_100NS | PERF_DELTA_COUNTER | PERF_DISPLAY_PERCENT)
#define PERF_PRECISION_OBJECT_TIMER (PERF_SIZE_LARGE | PERF_TYPE_COUNTER | PERF_COUNTER_PRECISION | PERF_OBJECT_TIMER | PERF_DELTA_COUNTER | PERF_DISPLAY_PERCENT)

#define PERF_PRECISION_TIMESTAMP PERF_LARGE_RAW_BASE

#define PERF_DETAIL_NOVICE 100
#define PERF_DETAIL_ADVANCED 200
#define PERF_DETAIL_EXPERT 300
#define PERF_DETAIL_WIZARD 400

typedef struct _PERF_COUNTER_DEFINITION {
  DWORD ByteLength;
  DWORD CounterNameTitleIndex;
#ifdef _WIN64
  DWORD CounterNameTitle;
#else
  LPWSTR CounterNameTitle;
#endif
  DWORD CounterHelpTitleIndex;
#ifdef _WIN64
  DWORD CounterHelpTitle;
#else
  LPWSTR CounterHelpTitle;
#endif
  LONG DefaultScale;
  DWORD DetailLevel;
  DWORD CounterType;
  DWORD CounterSize;
  DWORD CounterOffset;
} PERF_COUNTER_DEFINITION,*PPERF_COUNTER_DEFINITION;

#define PERF_NO_UNIQUE_ID -1

typedef struct _PERF_INSTANCE_DEFINITION {
  DWORD ByteLength;
  DWORD ParentObjectTitleIndex;
  DWORD ParentObjectInstance;
  LONG UniqueID;
  DWORD NameOffset;
  DWORD NameLength;
} PERF_INSTANCE_DEFINITION,*PPERF_INSTANCE_DEFINITION;

typedef struct _PERF_COUNTER_BLOCK {
  DWORD ByteLength;

} PERF_COUNTER_BLOCK,*PPERF_COUNTER_BLOCK;

#define PERF_QUERY_OBJECTS ((LONG)0x80000000)
#define PERF_QUERY_GLOBAL ((LONG)0x80000001)
#define PERF_QUERY_COSTLY ((LONG)0x80000002)

typedef DWORD (WINAPI PM_OPEN_PROC)(LPWSTR);
typedef DWORD (WINAPI PM_COLLECT_PROC)(LPWSTR,LPVOID *,LPDWORD,LPDWORD);
typedef DWORD (WINAPI PM_CLOSE_PROC)(void);
typedef DWORD (WINAPI PM_QUERY_PROC)(LPDWORD,LPVOID *,LPDWORD,LPDWORD);

#define MAX_PERF_OBJECTS_IN_QUERY_FUNCTION (64L)

#define WINPERF_LOG_NONE 0
#define WINPERF_LOG_USER 1
#define WINPERF_LOG_DEBUG 2
#define WINPERF_LOG_VERBOSE 3

#include <poppack.h>
#endif
