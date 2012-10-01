/*
	description: "Some useful macros for bitmasks manipulation (for select() masks)."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _eif_bitmask_h_
#define _eif_bitmask_h_

#ifdef I_LIMITS
#include <limits.h>			/* For WORD_BIT */
#endif
#if !defined(__VMS) && !defined(VXWORKS)
#include <sys/param.h>		/* For NOFILE */
#endif /* not VMS */

#undef BPI
#ifdef WORD_BIT				/* Some systems may not define this */
#define BPI	WORD_BIT		/* Bits per int */
#else
#define BPI	(8 * sizeof(int))
#endif

#ifndef NOFILE
#define NOFILE VAL_NOFILE	/* File descriptor limit */
#endif

#endif
