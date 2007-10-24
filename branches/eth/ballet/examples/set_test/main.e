class MAIN

creation
   make

feature
   make is
         -- root creation procedure
         -- init the set s and call some features
      local
         s: MMLED_SET[INTEGER]
      do
         create s.make_empty
         use1(s)    -- s = {1}
         check
            not s.has(2)
         end
         use2(s)    -- s = {1, 2}
         use22(s)   -- s = {1, 2, 22}
         use3(s, 3) -- s = {1, 2, 3, 22}
         use4(s, 2) -- s = {1, 3, 22)
      end

   use1(set: MMLED_SET[INTEGER]) is
         -- adds the first element
      require
         set_not_void: set /= Void
         empty_set: set.is_empty
      do
         set.extend(1)
      ensure
         card_set: set.cardinality = 1
         added: set.has(1)
         subset: (old set).is_subset(set)
      end

   use2(set: MMLED_SET[INTEGER]) is
         -- adds element 2
      require
         set_not_void: set /= Void
         has_no2: not set.has(2)
      do
         set.extend(2)
      ensure
         card: set.cardinality = old set.cardinality + 1
         added: set.has(2)
         subset: set.is_subset(old set)
      end

   use22(set: MMLED_SET[INTEGER]) is
         -- adds element 22
      require
         set_not_void: set /= Void
         has_no22: not set.has(22)
      do
         set.extend(22)
      ensure
         card: set.cardinality = old set.cardinality + 1
         added: set.has(22)
         subset: set.is_subset(old set)
      end   
   
   use3(set: MMLED_SET[INTEGER]; item: INTEGER) is
         -- adds element item
      require
         set_not_void: set /= Void
      do
         set.extend(item)
      ensure
         increased: not old set.has(item) implies set.cardinality = old set.cardinality + 1
         unchanged: old set.has(item) implies set.cardinality = old set.cardinality
         has_item: set.has(item)
         subset: set.is_subset(old set)
      end
         
   use4(set: MMLED_SET[INTEGER]; item: INTEGER) is
         -- removes element item
      require
         set_not_void: set /= Void
         has_item: set.has(item)
      do
         set.prune(item)
      ensure
         decreased: set.cardinality = old set.cardinality - 1
         no_item: not set.has(item)
         subset: (old set).is_subset(set)
      end
            
end
        
