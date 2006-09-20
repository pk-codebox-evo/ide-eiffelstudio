indexing
	description: "Automatic generated root class for cdd tester"
	author: "CDD_TESTER_PRINTER"
	date: "$Date$"
	revision: "$Revision$"

class
	 CDD_INTERPRETER 

inherit
	CDD_INTERPRETER_SUPPORT

create
	make

feature {NONE} -- Initialization

	make is
		local
			l_arg: STRING
		do
			l_arg := command_line.argument (1)
			if False then
			elseif l_arg.is_equal ("CDD_TEST_BUGGY_CLASS_01") then
				run_test (create {CDD_TEST_BUGGY_CLASS_01})
			elseif l_arg.is_equal ("CDD_TEST_INTERFACE_CLASS_01") then
				run_test (create {CDD_TEST_INTERFACE_CLASS_01})
			elseif l_arg.is_equal ("CDD_TEST_INTERFACE_CLASS_02") then
				run_test (create {CDD_TEST_INTERFACE_CLASS_02})
			elseif l_arg.is_equal ("CDD_TEST_INTERFACE_CLASS_03") then
				run_test (create {CDD_TEST_INTERFACE_CLASS_03})
			end
		end



end -- CDD_TESTER_INTERPRETER

