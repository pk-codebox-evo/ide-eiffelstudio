/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
  Declaration of variables generated by compiler, later assigned to variables from `eif_project.h'.
  Not used by run-time.
*/

#ifndef _egc_include_h_
#define _egc_include_h_

#include "eif_struct.h"

#ifdef __cplusplus
extern "C" {
#endif

extern struct ctable egc_ce_type_init;
extern struct ctable egc_ce_exp_type_init;
extern struct cnode egc_fsystem_init [];
extern struct conform *egc_fco_table_init [];
extern void egc_system_mod_init_init (void);
extern struct eif_par_types *egc_partab_init [];
extern int egc_partab_size_init;

#ifdef WORKBENCH

extern fnptr egc_frozen_init [];
extern int egc_fpatidtab_init [];
extern struct eif_opt egc_foption_init [];
extern fnptr **egc_address_table_init;
extern struct p_interface egc_fpattern_init [];

extern void egc_einit_init (void);
extern void egc_tabinit_init (void);

extern int32 *egc_fcall_init [];
extern struct rout_info egc_forg_table_init [];
extern int16 egc_fdtypes_init [];

#else

extern struct ctable egc_ce_rname_init[];
extern long egc_fnbref_init[];
extern long egc_fsize_init[]; 

#endif

#ifdef __cplusplus
}
#endif

#endif
