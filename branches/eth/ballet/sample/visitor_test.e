indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	VISITOR_TEST

feature -- Access
	test (e1, e2: EXPRESSION) is
			-- test the VISITOR FRAMEs
		require
			not_overlapping: e1 /= e2
		local
			printer: EXPRESSION_PRINTER
			--simplifier: EXPRESSiON_SIMPLIFIER
		do
			create printer.make
--			create simplifier
			e1.accept (printer)
			io.put_string (printer.output)
--			e2.accept (simplifier)
		end

end
