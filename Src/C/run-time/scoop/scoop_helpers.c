/*
	description:	"Helper functions used by the SCOOP runtime."
	date:		"$Date$"
	revision:	"$Revision: 96304 $"
	copyright:	"Copyright (c) 2010-2012, Eiffel Software.",
				"Copyright (c) 2014 Scott West <scott.gregory.west@gmail.com>"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="scoop_helpers.c" header="rt_scoop_helpers.h" version="$Id$" summary="Helper functions used by the SCOOP runtime.">
*/

#include "rt_processor_registry.h"
#include "rt_processor.h"

#include "rt_scoop_helpers.h"

#include "eif_interp.h"
#include "rt_wbench.h"
#include "rt_struct.h"
#include "rt_assert.h"

#ifdef __cplusplus
extern "C" {
#endif


/* Call logging */

#ifdef WORKBENCH
rt_shared void rt_apply_wcall (call_data *data)
{
	uint32            pid = 0; /* Pattern id of the frozen feature */
	EIF_NATURAL_32    i;
	EIF_NATURAL_32    n;
	BODY_INDEX        body_id;
	EIF_TYPED_VALUE * v;

	REQUIRE("has data", data);
	REQUIRE("has target", data->target);

		/* Push arguments to the evaluation stack */
	for (n = data->count, i = 0; i < n; i++) {
		v = iget ();
		* v = data->argument [i];
		if ((v->it_r) && (v->type & SK_HEAD) == SK_REF) {
			v->it_r = v->it_r;
		}
	}
		/* Push current to the evaluation stack */
	v = iget ();
	v->it_r = data->target;
	v->type = SK_REF;
		/* Make a call */
	CBodyId(body_id, data->routine_id,Dtype(data->target));
	if (egc_frozen [body_id]) {		/* We are below zero Celsius, i.e. ice */
		pid = (uint32) FPatId(body_id);
		(pattern[pid].toc)(egc_frozen[body_id]); /* Call pattern */
	} else {
		/* The proper way to start the interpretation of a melted feature is to call `xinterp'
		 * in order to initialize the calling context (which is not done by `interpret').
		 * `tagval' will therefore be set, but we have to resynchronize the registers anyway.
		 */
		xinterp(MTC melt[body_id], 0);
	}
		/* Save result of a call if any. */
	v = data->result;
	if (v) {
		* v = * opop ();
	}
}
#endif

/*
doc:	<routine name="rt_scoop_setup" return_type="void" export="shared">
doc:		<summary> Initialize the SCOOP subsystem and mark the root thread as a processor with ID 0. </summary>
doc:		<param name="is_scoop_enabled" type="int"> Whether SCOOP was enabled in the project settings. Depending on this value initialization may be partially skipped. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during program startup. </synchronization>
doc:	</routine>
*/
rt_public void rt_scoop_setup (int is_scoop_enabled)
{
		/* Note: We initialize the SCOOP processor_registry in any case,
		 * because of a bug in the interpreter which may sometimes execute RTS_OU
		 * even in non-SCOOP systems. */
	int error = rt_processor_registry_init ();

	if (T_OK == error && is_scoop_enabled) {
			/* Record that the current thread is associated with a processor of a PID 0. */
		eif_set_processor_id (0);
	}

	if (T_OK != error) {
		eif_panic ("Could not initialize SCOOP subsystem.");
	}
}

/*
doc:	<routine name="rt_scoop_reclaim" return_type="void" export="shared">
doc:		<summary> Reclaim all resources in the SCOOP subsystem. </summary>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during program termination. </synchronization>
doc:	</routine>
*/
rt_public void rt_scoop_reclaim (void)
{
	rt_processor_registry_deinit();
}


#ifdef __cplusplus
}
#endif

/*
doc:</file>
*/
