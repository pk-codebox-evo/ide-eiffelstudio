indexing

	description: "Abstract class for Eiffel basic types. Bench version.";
	date: "$Date$";
	revision: "$Revision$"

deferred class BASIC_TYPE_B

inherit

	BASIC_TYPE
		undefine
			is_deep_equal, same_as
		redefine
			associated_eiffel_class,
			append_to
		end;
	TYPE_B
		redefine 
			format, append_to
		end

feature -- Signature

	append_to (cw: OUTPUT_WINDOW) is
		do
			actual_type.append_to (cw)
		end;

feature -- Stoning

	associated_eiffel_class (reference_class: E_CLASS): E_CLASS is
		do
			Result := actual_type.associated_eclass
		end;

feature -- Formatting

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.put_class_name (actual_type.associated_class);
		end;

end -- class BASIC_TYPE_B
