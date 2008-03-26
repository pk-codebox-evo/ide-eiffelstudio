indexing
	description: "Objects generating a hash code from a message (sequence of bits) in an incremental manner"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_HASH_CALCULATOR

feature -- Initialisation

	make is
			-- Initialize `Current'
		do
			reset
		end

feature -- Access

	digest: ARRAY [NATURAL_8] is
			-- Result of last hash code calculation
		require
			result_ready: is_result_available
		deferred
		ensure
			result_not_void: Result /= Void
			result_valid: Result.count = hash_code_byte_count
		end

	digest_as_natural_64: NATURAL_64 is
			-- Result as NATURAL_64.
			-- NOTE: This query has no preconditions. The least significant bytes of `digest' (highest array indices)
			-- will correspond to the least significant bytes of `Result'.
			-- If `digest' has less bytes than `Result', the remaining most significant bytes of `Result' will be set to 0x00
			-- If `digest' has more bytes than `Result', the exceeding most significant bytes of `digest' will be ignored.
		require
			result_ready: is_result_available
		local
			i: INTEGER_32
		do
			from
				Result := digest[hash_code_byte_count - 8].to_natural_64
				i := (hash_code_byte_count - 7)
			until
				i >= hash_code_byte_count
			loop
				Result := Result |<< 8
				Result := Result + digest[i].to_natural_64
				i := i + 1
			end
		end

	hashable_digest: TUPLE [NATURAL_64] is
			-- Result as a unique TUPLE [NATURAL_64].
			-- NOTE: This query *is required* to return a *unique* tuple for each possible digest.
			-- This can be done by returning a tuple containing more than one NATURAL_64, e.g. TUPLE [NATURAL_64, NATURAL_64, ...]
			-- (see postcondition!).
		require
			result_ready: is_result_available
		deferred
		ensure
			result_not_void: Result /= Void
			result_valid: Result.count = ((hash_code_byte_count - 1) // 8) + 1
			result_has_natural_64_elements: Result.is_uniform_natural_64
		end

	digest_hex_string: STRING_8 is
			-- Result of last hash code calculation as hex string
		require
			result_ready: is_result_available
		local
			i: INTEGER_32
			l_hash_code_byte_array: ARRAY [NATURAL_8]
		do
			l_hash_code_byte_array := digest
			create Result.make (hash_code_byte_count * 2)
			from
				i := l_hash_code_byte_array.lower
			until
				i > l_hash_code_byte_array.upper
			loop
				Result.append_string (l_hash_code_byte_array.item (i).to_hex_string)
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
			result_valid: Result.count = 2 * hash_code_byte_count
		end

feature -- Measurement

	hash_code_byte_count: INTEGER_32 is
			-- Size in bytes of resulting hash code
		deferred
		ensure
			result_positive: Result > 0
		end

feature -- Status report

	is_accepting_input: BOOLEAN
			-- Does 'Current' accept more input for the current ongoing calculation?

	is_result_available: BOOLEAN is
			-- Does 'Current' have successfully calcluated a hash code which can be accessed in `last_calculated_hash_code'?
		do
			Result := not is_accepting_input
		end

feature -- Basic operations

	reset is
			-- Make `Current' ready for the calculation of a new hash value.
			-- Aborts current ongoing calculation if any.
			-- Deletes last calculated `hash_code' if any.
		do
			initialize_calculation
		ensure
			ready_for_calculation: is_accepting_input
		end

	add_byte (a_byte: NATURAL_8) is
			-- Add `a_byte' to message whose hash code is currently calculated.
		require
			is_calculating: is_accepting_input
		local
			l_bit_sequence: SPECIAL [NATURAL_8]
		do
			create l_bit_sequence.make (1)
			l_bit_sequence[0] := a_byte
			add_bits (l_bit_sequence, 8)
		ensure
			is_still_calculating: is_accepting_input
		end

	add_string (a_string: STRING_8) is
			-- Add `a_string' to message whose hash code is currently calculated.
		require
			is_calculating: is_accepting_input
		local
			l_bits: SPECIAL [NATURAL_8]
			i: INTEGER_32
		do
			create l_bits.make (a_string.count)
			from
				i := 1
			until
				i > a_string.count
			loop
				l_bits.put (a_string.item (i).code.to_natural_8, i - 1)
				i := i + 1
			end
			add_bits (l_bits, 8 * a_string.count)
		ensure
			is_still_calculating: is_accepting_input
		end

	add_bits (a_bit_sequence: SPECIAL [NATURAL_8]; a_bit_sequence_length: INTEGER_32) is
			-- Add the `a_bit_sequence_length' first bits of `a_bit_sequence' to message whose hash code is currently calculated.
		require
			is_calculating: is_accepting_input
			a_bit_sequence_not_void: a_bit_sequence /= Void
			a_bit_sequence_length_positive: a_bit_sequence_length >= 0
			a_bit_sequence_length_small_enough: a_bit_sequence_length <= (a_bit_sequence.count * 8)
		deferred
		ensure
			is_still_calculating: is_accepting_input
		end

	finalize_calculation is
			-- Perform final steps of calculation and make result available.
		require
			is_calculating: is_accepting_input
		deferred
		ensure
			result_available: is_result_available
		end

feature {NONE} -- Implementation

	initialize_calculation is
			-- Initialize `Current' for a new calculation
		deferred
		ensure
			calculation_started: is_accepting_input
		end

invariant
	calculating_or_result_available: is_accepting_input xor is_result_available
	result_available_implies_result_valid: is_result_available implies (
												(digest /= Void) and then
												(digest.count = hash_code_byte_count)
												)
end
