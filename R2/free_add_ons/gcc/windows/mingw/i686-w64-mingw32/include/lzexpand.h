/**
 * This file has no copyright assigned and is placed in the Public Domain.
 * This file is part of the w64 mingw-runtime package.
 * No warranty is given; refer to the file DISCLAIMER.PD within this package.
 */
#ifndef _LZEXPAND_
#define _LZEXPAND_

#ifdef __cplusplus
extern "C" {
#endif

#define LZERROR_BADINHANDLE (-1)
#define LZERROR_BADOUTHANDLE (-2)
#define LZERROR_READ (-3)
#define LZERROR_WRITE (-4)
#define LZERROR_GLOBALLOC (-5)
#define LZERROR_GLOBLOCK (-6)
#define LZERROR_BADVALUE (-7)
#define LZERROR_UNKNOWNALG (-8)

#ifdef UNICODE
#define GetExpandedName GetExpandedNameW
#define LZOpenFile LZOpenFileW
#else
#define GetExpandedName GetExpandedNameA
#define LZOpenFile LZOpenFileA
#endif

  INT WINAPI LZStart(VOID);
  VOID WINAPI LZDone(VOID);
  LONG WINAPI CopyLZFile(INT,INT);
  LONG WINAPI LZCopy(INT,INT);
  INT WINAPI LZInit(INT);
  INT WINAPI GetExpandedNameA(LPSTR,LPSTR);
  INT WINAPI GetExpandedNameW(LPWSTR,LPWSTR);
  INT WINAPI LZOpenFileA(LPSTR,LPOFSTRUCT,WORD);
  INT WINAPI LZOpenFileW(LPWSTR,LPOFSTRUCT,WORD);
  LONG WINAPI LZSeek(INT,LONG,INT);
  INT WINAPI LZRead(INT,LPSTR,INT);
  VOID WINAPI LZClose(INT);

#ifdef __cplusplus
}
#endif
#endif
