note
	description: "Summary description for {AFX_EXPRESSION_EQUALITY_TESTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AFX_EXPRESSION_EQUALITY_TESTER

inherit
	KL_EQUALITY_TESTER [AFX_EXPRESSION]
		redefine
			test
		end

feature -- Status report

	test (v, u: AFX_EXPRESSION): BOOLEAN
		do
			if v = u then
				Result := True
			elseif v = Void then
				Result := False
			elseif u = Void then
				Result := False
			else
					-- Case sensitive comparison is used here,
					-- although insensitive comparion also suffice.
				Result := v.text ~ u.text
			end
		end

end
