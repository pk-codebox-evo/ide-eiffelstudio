indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RAMACK_TEST

feature {NONE} -- Implementation
	test is
			--
		local
			a: ABS_INT_STORE
			ct: COUNTER_TEST
		do
			create a.make
			create x.make(a)
			xf := 5
			a.set_item(xff)
			check
				value_set: a.item = 5
			end
		ensure
			xx: x.item = 5
		end

	fun(arg_val: INTEGER): INTEGER is
			--
		require
			ok: arg_val = 1
		do
			Result := arg_val + 1
			test
		ensure
			okres: Result = arg_val + 1
		end

	x: REL_INT_STORE

	xf: INTEGER

	xff: INTEGER is
		require
			m: xf > 0
			ff: fun(xf) > fun(xf + 1)
		do
			Result := xf
		ensure
			ok: Result = xf
		end

	cc: INTEGER is 5

invariant
	ii: 3 = 1 + 2 - fun(xff)
	x_set: x /= Void
	constcc: cc = 5
end
