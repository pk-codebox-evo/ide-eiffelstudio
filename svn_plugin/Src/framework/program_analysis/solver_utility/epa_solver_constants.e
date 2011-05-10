note
	description: "Summary description for {AFX_SMTLIB_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EPA_SOLVER_CONSTANTS

inherit
	EPA_SOLVER_FACTORY

feature -- SMTLIB

	smtlib_function_header: STRING = ":extrafuns "
			-- Header for a SMTLIB function

	smtlib_axiom_header: STRING = ":assumption "
			-- Header for a SMTLIB axiom

feature -- Boogie

	boogie_function_header: STRING = "function "
			-- Header for a Boogie function

	boogie_axiom_header: STRING = "axiom "
			-- Header for a Boogie axiom

	boogie_procedure_name_header: STRING = "proc.ANY.afx_formula_"
			-- Header for BPL procedure

	boogie_verified_tag: STRING = "verified"
			-- String to indicate that a procedure/function is verfied.

	boogie_error_tag: STRING = "error"
			-- String to indicate that a procedure/function is not verified.

feature -- Access

	solver_function_header: STRING
			-- Header for a function
		do
			if is_for_smtlib then
				Result := smtlib_function_header
			else
				Result := boogie_function_header
			end
		end

	solver_axiom_header: STRING
			-- Header for an axiom
		do
			if is_for_smtlib then
				Result := smtlib_axiom_header
			else
				Result := boogie_axiom_header
			end
		end

feature -- Access

	expr_prefix_opener: STRING = "{{"
			-- Opener for a class prefix inside an expression
			-- Used to handle qualified call

	expr_prefix_closer: STRING = "}}"
			-- Closer for a class prefix inside an expression
			-- Used to handle qualified call

end
