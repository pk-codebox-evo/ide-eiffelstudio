indexing
	description: "Objects that store routine invocations on a one stack per feature basis"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_ROUTINE_INVOCATION_CACHE

create
	make


feature -- Inititalization

	make is
			-- Initialize `Current'.
		do
			create {DS_HASH_TABLE [DS_STACK [CDD_ROUTINE_INVOCATION], TUPLE [INTEGER, INTEGER, INTEGER, INTEGER, INTEGER]]} storage.make (10)
		end

feature -- Access

	cached_routine_invocation (a_feature: E_FEATURE): CDD_ROUTINE_INVOCATION is
			-- Most recent cached routine invocation covering `a_feature'
		require
			cached_routine_invocation_available: has_cached_routine_invocation (a_feature)
		do
			Result := storage.item (key (a_feature)).item
		ensure
			result_not_void: Result /= Void
		end

	last_popped_routine_invocation: CDD_ROUTINE_INVOCATION
			-- Store for the last popped routine invocation
			-- NOTE: this is part of a workaround for invariant exceptions, which can be thrown after last detectable point before routine exit.

feature -- Status report

	has_cached_routine_invocation (a_feature: E_FEATURE): BOOLEAN is
			-- Does a routine invocation covering `a_feature' exist in storage?
		require
			a_feature_not_void: a_feature /= Void
		do
			Result := storage.has (key (a_feature)) and then not storage.item (key (a_feature)).is_empty
		end

	is_empty: BOOLEAN is
			-- Is `Current' empty?
		local
			l_cursor: DS_SPARSE_TABLE_CURSOR [DS_STACK [CDD_ROUTINE_INVOCATION], TUPLE [INTEGER, INTEGER, INTEGER, INTEGER, INTEGER]]
		do
			from
				l_cursor := storage.new_cursor
				l_cursor.start
				Result := True
			until
				l_cursor.after or else not Result
			loop
				Result := l_cursor.item.is_empty
				l_cursor.forth
			end
		end

feature -- Element change

	cache_routine_invocation (a_routine_invocation: CDD_ROUTINE_INVOCATION) is
			-- Add `a_routine_invocation' to storage.
		require
			a_routine_invocation_not_void: a_routine_invocation /= Void
		local
			l_stack: DS_STACK [CDD_ROUTINE_INVOCATION]
		do
			if storage.has (key (a_routine_invocation.represented_feature)) then
				storage.item (key (a_routine_invocation.represented_feature)).put (a_routine_invocation)
			else
				create {DS_ARRAYED_STACK [CDD_ROUTINE_INVOCATION]} l_stack.make (10)
				l_stack.put (a_routine_invocation)
				storage.put_new (l_stack, key (a_routine_invocation.represented_feature))
			end
		ensure
			routine_invocation_inserted: has_cached_routine_invocation (a_routine_invocation.represented_feature)
		end

feature -- Removal

	pop_cached_routine_invocation (a_feature: E_FEATURE) is
			-- Pop cached routine invocation from `storage'.
		require
			cached_routine_invocation_available: has_cached_routine_invocation (a_feature)
		do
			last_popped_routine_invocation := storage.item (key (a_feature)).item
			storage.item (key (a_feature)).remove
		ensure
			-- number_of_cached_entries_for_a_feature_decreased: <currently unexpressible>
		end

	wipe_out is
			-- Wipe out all cached routine invocations.
		do
			storage.wipe_out
			last_popped_routine_invocation := Void
		ensure
			cache_is_empty: storage.is_empty
		end

feature {NONE} -- Implementation

	storage: DS_SPARSE_TABLE [DS_STACK [CDD_ROUTINE_INVOCATION], TUPLE [class_id:INTEGER; feature_id: INTEGER; body_index: INTEGER; written_in: INTEGER; written_feature_id: INTEGER]]
			-- storage for extracted test routines


	key (a_feature: E_FEATURE): TUPLE [class_id:INTEGER; feature_id: INTEGER; body_index: INTEGER; written_in: INTEGER; written_feature_id: INTEGER] is
			-- Hashing key for `a_feature'
		do
			Result := [a_feature.associated_class.class_id, a_feature.body_index, a_feature.feature_id, a_feature.written_in, a_feature.written_feature_id]
		end

invariant
	storage_not_void: storage /= Void

end
