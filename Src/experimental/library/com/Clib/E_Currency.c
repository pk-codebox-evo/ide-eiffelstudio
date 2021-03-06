/*
indexing
	description: "EiffelCOM: library of reusable components for COM."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#include "E_Currency.h"

#ifdef __cplusplus
  extern "C" {
#endif

EIF_DOUBLE ccom_currency_to_double (CY * a_value)
{
  EIF_DOUBLE dbl_value =0;
  HRESULT hr = VarR8FromCy (*a_value, &dbl_value);

  if (FAILED (hr))
    dbl_value = 0;
  return dbl_value;
}

void ccom_currency_value_zero (CY * a_value)
{
  long zero = 0;
  VarCyFromI4 (zero, a_value);
}

// One value
void ccom_currency_value_one (CY * a_value)
{
  long one = 1;
  VarCyFromI4 (one, a_value);
}

EIF_REFERENCE ccom_currency_convert_to_eiffel_currency (CY * a_value)
{
  EIF_OBJECT currency_object;
  EIF_TYPE_ID currency_tid;
  EIF_PROCEDURE make_currency;

  currency_tid = eif_type_id ("ECOM_CURRENCY");
  if (currency_tid == EIF_NO_TYPE)
    return NULL;

  currency_object = eif_create (currency_tid);
  make_currency = eif_procedure ("make_by_pointer", currency_tid);
  make_currency ( eif_access (currency_object), a_value);

  return eif_wean (currency_object);
}

#ifdef __cplusplus
  }
#endif
