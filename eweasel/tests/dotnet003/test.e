class TEST 
create
	make
feature

	make is
		local
			t: TEST1
		do
			create t
			t := t.twin
		end

end
