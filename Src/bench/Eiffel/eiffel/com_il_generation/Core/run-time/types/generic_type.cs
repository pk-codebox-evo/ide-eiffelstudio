/*
indexing
	description: "Representation of an Eiffel type that has been computed
		at runtime. Usually case of a generic class."
	date: "$Date$"
	revision: "$Revision$"
*/
	
using System;

namespace EiffelSoftware.Runtime.Types {

[Serializable]
public class GENERIC_TYPE: CLASS_TYPE {

/*
feature -- Access
*/
	public TYPE[] generics;
		// Type holding information about current generic derivation

	public int count;
		// Number of elements in `generics'

	private byte has_formal_flags;
		// Does current generic type has formals?

/*
feature -- Status Report
*/

	public override TYPE evaluated_type (EIFFEL_TYPE_INFO context_object)
		// Evaluate Current in context of `context_object'.
	{
		GENERIC_TYPE Result;
		TYPE [] l_generics, l_other_generics;
		int i, nb;

		if (has_formal ()) {
			i = 0;
			nb = count;

				// Duplicate current data as after the evaluation in context
				// of `context_object' it will be the same except for `generics'
				// which will only contained fully evaluated types that's why
				// `generics' is created of type `CLASS_TYPE []'.
			Result = (GENERIC_TYPE) MemberwiseClone();
			l_other_generics = new CLASS_TYPE [nb];
			Result.set_generics (l_other_generics);

				// Evaluate all types contained in `generics' in context of `context_object'
			l_generics = generics;
			for (; i < nb ; i ++) {
				#if ASSERTIONS
					ASSERTIONS.CHECK ("Valid element type",
						l_generics [i].evaluated_type (context_object) is CLASS_TYPE);
				#endif
				l_other_generics [i] = l_generics [i].evaluated_type (context_object);
			}
			Result.set_has_formal (false);
		} else {
			Result = this;
		}
		return Result;
	}

	public bool has_formal ()
		// Does Current have formal generic parameter?
	{
		int i, nb;
		byte l_flags = has_formal_flags;
		TYPE[] l_generics;
		
		if ((l_flags & 0x10) == 0x10) {
			return (l_flags & 0x01) == 0x01;
		} else {
			l_generics = generics;

			for (i = 0, nb = count; i < nb; i++) {
				if (l_generics [i] is FORMAL_TYPE) {
					has_formal_flags = 0x11;
					return true;
				}
			}
			has_formal_flags = 0x10;
			return false;
		}
	}

	public override String type_name ()
		// Name of object's generating type who has Current as an EIFFEL_DERIVATION
		// (type of which it is a direct instance)
	{
		String Result = base.type_name ();
		TYPE [] l_generics;
		int i, nb;

		Result = String.Concat (Result, str_open_generics);

		l_generics = generics;
		for (i = 0, nb = count; i < nb; i++) {
			Result = String.Concat (Result, l_generics [i].type_name ());
			if (i + 1 < nb) {
				Result = String.Concat (Result, str_comma);
			}
		}

		Result = String.Concat (Result, str_close_generics);
		return Result;
	}

/*
feature -- Settings
*/
	public void set_generics (TYPE[] an_array)
		// Assign `an_array' to `generics'.
	{
		generics = an_array;
		count = an_array.Length;
	}

	public void set_has_formal (bool v)
		// Assign `v' to `has_formal'.
	{
		if (v) {
			has_formal_flags = 0x11;
		} else {
			has_formal_flags = 0x10;
		}
	}

/*
feature -- Comparison
*/
	public override bool Equals (Object other)
		// Is `other' similar to Current?
	{
		bool Result = false;
		GENERIC_TYPE l_other = other as GENERIC_TYPE;
		TYPE [] l_generics, l_other_generics;
		int i, nb;

		if (l_other != null) {
			nb = count;
			if ((type.Value == l_other.type.Value) && (nb == l_other.count)) {
				Result = true;
				l_generics = generics;
				l_other_generics = l_other.generics;
				for (i = 0; (i < nb) && Result; i++) {
					Result = (l_generics [i]).Equals (l_other_generics [i]);
				}
			}
		}
		return Result;
	}

/*
feature {NONE} -- Implementation
*/

	private static string str_open_generics = " [";
	private static string str_close_generics = "]";
	private static string str_comma = ", ";
		// Constants for type name formatting.

}

}
