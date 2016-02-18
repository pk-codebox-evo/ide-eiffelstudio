class A [G]

feature -- Test

	f: G
			-- Test that detachable status of locals and `Result' does not allow to assign Void
			-- if they are of a formal generic type.
		local
			x: G
		do
			if x = Void or else Result = Void then
				Result := x
			end
			Result := x
				-- Error: VEVI for Result.
		ensure
			result_set: attached Result.out -- Error: VUTA(2) because G might be detachable.
		end

end