class TEST
create
	make

feature

	make is
		local
			a: TEST2
			b: TEST1 [B]
			c: C
		do
			create a
			a.f (c)
			a.g (c)
			a.h (Void)
			a.k (Void)

			create c.make
			a.f (c)
			a.g (c)
			a.h (a)
			a.k (a)

			create b
			b.f (c)
			b.g (c)
			b.h (b)
			b.k (b)
		end;

end

