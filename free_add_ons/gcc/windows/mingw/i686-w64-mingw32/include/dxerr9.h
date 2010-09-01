/*
 * Copyright (C) 2004 Robert Reif
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
 */

#ifndef __WINE_DXERR9_H
#define __WINE_DXERR9_H

#include <_mingw_dxhelper.h>

#ifdef __cplusplus
extern "C" {
#endif /* defined(__cplusplus) */

const char*     WINAPI DXGetErrorString9A(HRESULT hr);
const WCHAR*    WINAPI DXGetErrorString9W(HRESULT hr);
#define DXGetErrorString9 WINELIB_NAME_AW(DXGetErrorString9)

const char*     WINAPI DXGetErrorDescription9A(HRESULT hr);
const WCHAR*    WINAPI DXGetErrorDescription9W(HRESULT hr);
#define DXGetErrorDescription9 WINELIB_NAME_AW(DXGetErrorDescription9)

HRESULT WINAPI DXTraceA(const char* strFile, DWORD dwLine, HRESULT hr, const char*  strMsg, BOOL bPopMsgBox);
HRESULT WINAPI DXTraceW(const char* strFile, DWORD dwLine, HRESULT hr, const WCHAR* strMsg, BOOL bPopMsgBox);
#define DXTrace WINELIB_NAME_AW(DXTrace)

#if defined(DEBUG) || defined(_DEBUG)
#define DXTRACE_MSG(str)                DXTrace(__FILE__, (DWORD)__LINE__, 0,  str, FALSE)
#define DXTRACE_ERR(str,hr)             DXTrace(__FILE__, (DWORD)__LINE__, hr, str, TRUE)
#define DXTRACE_ERR_NOMSGBOX(str,hr)    DXTrace(__FILE__, (DWORD)__LINE__, hr, str, FALSE)
#else
#define DXTRACE_MSG(str)                (0L)
#define DXTRACE_ERR(str,hr)             (hr)
#define DXTRACE_ERR_NOMSGBOX(str,hr)    (hr)
#endif

#ifdef __cplusplus
} /* extern "C" */
#endif /* defined(__cplusplus) */

#endif /* __WINE_DXERR9_H */
