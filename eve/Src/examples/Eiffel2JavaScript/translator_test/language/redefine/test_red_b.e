note
	description: "Summary description for {TEST_RED_B}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_RED_B
inherit
	TEST_RED_A
		redefine f end
feature
	f: attached STRING
		do
			Result := "B.f"
		end

end
