-- System level real body id counter.

class REAL_BODY_ID_COUNTER

inherit

	COMPILER_COUNTER
		rename
			make as old_make
		redefine
			next_id, current_subcounter, init_counter
		end

creation

	make

feature -- Initialization

	make is
			-- Create a new real body id counter.
		do
			old_make;
			!! dle_subcounter.make;
			!! debug_subcounter.make;
			!! dle_debug_subcounter.make
		end

	init_counter is
			-- Renumber ids already generated so far and continue
			-- generation from there.
		local
			compilation_id: INTEGER
			new_offset: INTEGER
		do
			compilation_id := System.compilation_id;
			if Compilation_modes.is_extending then
				current_subcounter := dle_subcounter
			else
				new_offset := total_count
				current_subcounter := new_subcounter (compilation_id);
				current_subcounter.set_offset (new_offset)
			end
			put (current_subcounter, compilation_id)
		end

	new_subcounter (compilation_id: INTEGER): REAL_BODY_ID_SUBCOUNTER is
			-- New real body id counter associated with `compilation_id'
		do
			if Compilation_modes.is_precompiling then
				!P_REAL_BODY_ID_SUBCOUNTER! Result.make (compilation_id)
			elseif Compilation_modes.is_extending then
				!DLE_REAL_BODY_ID_SUBCOUNTER! Result.make
			else
				!REAL_BODY_ID_SUBCOUNTER! Result.make
			end
		end

feature -- Access

	next_id: REAL_BODY_ID is
			-- Next real body id
		do
			Result := current_subcounter.next_id
		end

	debuggable_body_id (old_id: REAL_BODY_ID): REAL_BODY_ID is
			-- New real body id for debuggable byte array
		require
			old_id_not_void: old_id /= Void
		do
			if old_id.is_dynamic then
				if old_id.id <= dle_frozen_level then
						-- The routine was frozen in the dynamic system.
						-- Generate a new id in the dynamic melted area.
					Result := dle_debug_subcounter.next_id
				else
						-- The routine was melted in the dynamic system.
						-- Keep the same id.
					Result := old_id
				end
			else
				if old_id.id <= frozen_level then
						-- The routine was frozen in the static system.
						-- Generate a new id in the static melted area.
					Result := debug_subcounter.next_id
				else
						-- The routine was melted in the static system.
						-- Keep the same id.
					Result := old_id
				end
			end
		ensure
			new_id_not_void: Result /= Void
		end

feature -- Levels

	frozen_level: INTEGER;
			-- Melted/Frozen limit

	dle_level: INTEGER is
			-- Limit between static and dynamic system
		do
			Result := dle_subcounter.offset
		end

	dle_frozen_level: INTEGER;
			-- Melted/Frozen limit in the DC-set

feature -- Setting

	set_frozen_level (i: INTEGER) is
			-- Set `frozen_level' to `i'.
		do
			frozen_level := i
		end

	set_dle_level (i: INTEGER) is
			-- Set `dle_level' to `i'.
		do
			dle_subcounter.set_offset (i)
		end

	set_dle_frozen_level (i: INTEGER) is
			-- Set `dle_frozen_level' to `i'.
		do
			dle_frozen_level := i
		end

	set_levels is
			-- Keep track of the different levels after each compilation.
		local
			nb: INTEGER
		do
			nb := total_count;
			if Compilation_modes.is_extending then
				dle_debug_subcounter.set_offset (nb)
			else
				debug_subcounter.set_offset (nb);
					-- `dle_level' has to take into account the fact that
					-- frozen routines of the static system we want to
					-- debug (i.e. supermelt or melt on the fly) will
					-- require a body_id less than `dle_level'.
				dle_subcounter.set_offset (nb + frozen_level);
				dle_frozen_level := dle_level;
				dle_debug_subcounter.set_offset (dle_level)
			end
		end

	reset_debug_counter is
			-- Reset `debug_counter' and `dle_debug_counter'.
		do
			debug_subcounter.reset;
			dle_debug_subcounter.reset
		end

feature {NONE} -- Implementation

	current_subcounter: REAL_BODY_ID_SUBCOUNTER;
			-- Current body id subcounter

	dle_subcounter: DLE_REAL_BODY_ID_SUBCOUNTER;
			-- DLE body id subcounter

feature {DEBUG_BODY_ID} -- Implementation

	debug_subcounter: DEBUG_BODY_ID_SUBCOUNTER;
			-- Supermelted body id subcounter

feature {DLE_DEBUG_BODY_ID} -- Implementation

	dle_debug_subcounter: DLE_DEBUG_BODY_ID_SUBCOUNTER;
			-- DLE supermelted body id subcounter

invariant

	debug_subcounter_not_void: debug_subcounter /= Void;
	dle_subcounter_not_void: dle_subcounter /= Void;
	dle_debug_subcounter_not_void: dle_debug_subcounter /= Void

end -- class REAL_BODY_ID_COUNTER
