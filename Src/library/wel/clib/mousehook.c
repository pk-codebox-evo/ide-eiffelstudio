/*****************************************************************************/
/* mousehook.c                                                               */
/*****************************************************************************/
/* Used to monitor mouse messages for the pick and drop mechanism under      */
/* Windows                                                                   */
/*****************************************************************************/
#include "eif_eiffel.h"
#include <windows.h>
#include "wel_mousehook.h"
#include <stdio.h>

static EIF_BOOLEAN bIsMouseHooked = FALSE;

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_is_mouse_hooked                                                */
/*---------------------------------------------------------------------------*/
/* Return TRUE if the mouse hook is currently running, FALSE otherwise.      */
/*---------------------------------------------------------------------------*/
EIF_BOOLEAN cwel_is_mouse_hooked()
	{
	return bIsMouseHooked;
	}

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_hook_mouse                                                     */
/* ARGS: hHookWindow: Handle of the window registering the hook.             */
/*---------------------------------------------------------------------------*/
/* Capture all mouse messages and redirect them to `hWnd'.                   */
/* Return TRUE if everything went fine, FALSE otherwise. If `wel_hook.dll'   */
/* cannot be loaded an error box is displayed                                */
/*---------------------------------------------------------------------------*/
EIF_BOOLEAN cwel_hook_mouse(HWND hWnd)
	{
	HINSTANCE hLibrary;
	FARPROC hook_mouse_func;
	
	if (!bIsMouseHooked)
		{
		hLibrary = LoadLibrary("wel_hook.dll");
		if (hLibrary == NULL)
			{
			// Display an error box
			MessageBox(hWnd, "An error occurred while loading the file 'wel_hook.dll'\nCheck that it can be found in your path or your working directory", "Unable to load a DLL..", MB_OK | MB_ICONERROR | MB_TOPMOST);
			return FALSE;
			}

		hook_mouse_func = GetProcAddress(hLibrary, "hook_mouse");
		if (hook_mouse_func == NULL)
			return FALSE;		// Unable to locate the function inside the DLL
		
		// Everything went ok, execute the function and return the value returned
		// by the function.
		bIsMouseHooked = (EIF_BOOLEAN) ((FUNCTION_CAST_TYPE(int, __stdcall, (HWND)) hook_mouse_func)(hWnd));
		return bIsMouseHooked;
		}
	else
		return FALSE;
	}

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_unhook_mouse                                                   */
/* ARGS:                                                                     */
/*---------------------------------------------------------------------------*/
/* Stop capturing all mouse messages                                         */
/* Return TRUE if everything went fine, FALSE otherwise.                     */
/*---------------------------------------------------------------------------*/
EIF_BOOLEAN cwel_unhook_mouse()
	{
	if (bIsMouseHooked)
		{
		HINSTANCE hLibrary;
		FARPROC unhook_mouse_func;
		EIF_BOOLEAN bRes;
		
		// Get the module of the library WITHOUT loading it.
		hLibrary = GetModuleHandle("wel_hook.dll");

		// The library is not loaded, so no hook is defined.. do nothing
		// and return an error
		if (hLibrary == NULL)
			return FALSE;
		
		unhook_mouse_func = GetProcAddress(hLibrary, "unhook_mouse");
		if (unhook_mouse_func == NULL)
			return FALSE;		// Unable to locate the function inside the DLL

		// Everything went ok, execute the function and return the value returned
		// by the function.
		bRes = (EIF_BOOLEAN) ((FUNCTION_CAST_TYPE(int, __stdcall, ()) unhook_mouse_func)());
		bIsMouseHooked = !bRes;
		FreeLibrary(hLibrary);
		return bRes;
		}
	else
		return FALSE;
	}
