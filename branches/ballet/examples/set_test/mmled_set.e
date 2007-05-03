class MMLED_SET [G]

inherit
	MML_COMPARISON
		undefine
			is_equal,
			copy
		end

   
create
   make_empty

feature -- object creation
   make_empty is
      do
         create impl_set.make
      ensure
         empty: is_empty
      end

feature -- Status Report
   is_empty: BOOLEAN is
      do
         Result := impl_set.is_empty
      ensure
         valid: Result = model.is_empty
         model_inv: equal_value(model, old model)
      end

   has(item: G): BOOLEAN is
      do
         Result := impl_set.has(item)
      ensure
         correct: Result = model.contains(item)
         model_inv: equal_value(model, old model)                  
      end

   cardinality: INTEGER is
      do
         Result := impl_set.count
      ensure
         correct: Result = model.count
         model_inv: equal_value(model, old model)
      end

   is_equal (other: like Current): BOOLEAN is
         -- Does `other' contain the same elements?
      do
         Result := impl_set.is_equal(other.impl_set)
      ensure then
         definition: Result = equal_value(model, other.model) = Result -- is this ok???
         unchanged1: equal_value(model, old model)
         unchanged2: equal_value(other, old other)
      end
   
feature -- Element Change
   extend(item: G) is
      do
         impl_set.extend(item)
      ensure
         definition: equal_value(model, old model.extended(item))
      end

   prune(item: G) is
      do
         impl_set.prune(item)
      ensure
         definition: equal_value(model, old model.pruned(item))
      end

   copy (other: like Current) is
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
      do
         impl_set.copy(other.impl_set)
      ensure then
         eq: equal_value(model, other.model)
      end

   is_subset (other: MMLED_SET[G]): BOOLEAN is
         -- is `other' a subset of `Current'
      require
         valid_other: other /= Void
      local
         l: LINEAR[G]
      do
         from
            l := other.impl_set.linear_representation
            l.start
            Result := other.cardinality <= cardinality
         until
            l.after or not Result
         loop
            Result := has(l.item)
            l.forth
         end
      ensure
         model_inv: equal_value(model, old model)
         model_inv2: equal_value(other, old other)
         model_definition: Result = other.model.is_subset_of(model)
      end
   
feature {MMLED_SET} -- internal storage
   impl_set: LINKED_SET[G]

feature {MMLED_SET} -- {MML_SECIFICATION} -- Model
   model: MML_SET[G] is
         -- model representation of the set
      do
         from
            create {MML_DEFAULT_SET[G]}Result.make_empty
            impl_set.start
         until
            impl_set.after
         loop
            Result := Result.extended(impl_set.item)
            impl_set.forth
         end
      ensure
         not_void: Result /= Void
      end


invariant
   empty_def: is_empty = (cardinality = 0)
   impl_set_not_void: impl_set /= Void
end
