/*

   ##    #####    ####   #    #          #    #
  #  #   #    #  #    #  #    #          #    #
 #    #  #    #  #       #    #          ######
 ######  #####   #  ###  #    #   ###    #    #
 #    #  #   #   #    #   #  #    ###    #    #
 #    #  #    #   ####     ##     ###    #    #

	Argument vectors.
*/

#ifndef _eif_argv_h_
#define _eif_argv_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK int eif_argc;			/* Initial argc value (argument count) */
RT_LNK char **eif_argv;			/* Copy of initial argv (argument vector) */
RT_LNK EIF_INTEGER arg_number(void);
RT_LNK EIF_REFERENCE arg_option(EIF_INTEGER num);	/* Eiffel string of argv[num] */

#ifdef __cplusplus
}
#endif

#endif

