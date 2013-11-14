class F_I_COLLECTION

create
	make

feature

	count: INTEGER

	capacity: INTEGER
		require
			reads (Current)
		do
			Result := elements.count
		ensure
			Result = elements.count
		end

	make (cap: INTEGER)
		note
			status: creator
		require
			cap >= 0
		do
			create elements.make (1, cap)
			set_owns ([elements])
		ensure
			capacity = cap
			count = 0
			observers = []
		end

	add (v: INTEGER)
		note
			explicit: contracts
		require
			is_wrapped
			across observers as o all o.item.is_wrapped end

			count < capacity

			modify (Current)
			modify_field ("closed", observers)
		do
			unwrap_all (observers)

			set_observers ([])
			count := count + 1
			elements.put (v, count)
		ensure
			count = old count + 1
			observers = []
			across old observers as o all o.item.is_open end
			elements = old elements
			capacity = old capacity
			is_wrapped
		end

feature {F_I_ITERATOR}

	elements: F_I_ARRAY

invariant
	elements /= Void
	0 <= count and count <= elements.count
	owns = [elements]
	not observers[Current] and not observers[elements]

note
  explicit: observers

end
