/*

  #####   ####    ####   #        ####           #    #
    #    #    #  #    #  #       #               #    #
    #    #    #  #    #  #        ####           ######
    #    #    #  #    #  #            #   ###    #    #
    #    #    #  #    #  #       #    #   ###    #    #
    #     ####    ####   ######   ####    ###    #    #

	General purpose utility functions.
*/

#ifndef _eif_tools_h_
#define _eif_tools_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Computes hashcode for a string */
RT_LNK EIF_INTEGER hashcode(register char *s, register EIF_INTEGER count);

#ifdef __cplusplus
}
#endif

#endif
