indexing
	description: "[
			Objects calculating a hash code of a message (sequence of bits) using the WHIRLPOOL hash function.
			The WHIRLPOOL hash function is described on [http://paginas.terra.com.br/informatica/paulobarreto/WhirlpoolPage.html].
			This implementation is based on the reference java implementation found on the above mentioned web page.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_WHIRLPOOL_HASH_CALCULATOR

inherit

	CDD_HASH_CALCULATOR

	CDD_WHIRLPOOL_HASH_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Access

	digest: ARRAY [NATURAL_8] is
			-- Result of last hash code calculation
		do
			Result := internal_digest
		end

	hashable_digest: TUPLE [NATURAL_64] is
			-- Result as a unique TUPLE [NATURAL_64].
			-- For Whirlpool, the hash code byte size is 64, and the tuple returned contains 8 NATURAL_64 elements.
		local
			i, j: INTEGER_32
			l_natural_64: NATURAL_64
			l_tuple: TUPLE [NATURAL_64, NATURAL_64, NATURAL_64, NATURAL_64, NATURAL_64, NATURAL_64, NATURAL_64, NATURAL_64]
		do
			create l_tuple.default_create
			from
				i := 1
			until
				i > hash_code_byte_count
			loop
				from
					l_natural_64 := digest[i]
					j := i + 1
				until
					j > i + 7
				loop
					l_natural_64 := l_natural_64 |<< 8
					l_natural_64 := l_natural_64 + digest[j].to_natural_64
					j := j + 1
				end
				l_tuple.put_natural_64 (l_natural_64, ((i - 1) // 8) + 1)
				i := i + 8
			end
			Result := l_tuple
		end

feature -- Basic operations

	add_bits (a_bit_sequence: SPECIAL [NATURAL_8]; a_bit_sequence_length: INTEGER_32) is
			-- Add the `a_bit_sequence_length' first bits of `a_bit_sequence' to message whose hash code is currently calculated.
		local
			l_buffer_rem: INTEGER_32
			l_source_position:INTEGER_32
			l_remaining_bits: INTEGER_32
			l_byte: NATURAL_8

			i: INTEGER_32
			l_bit_sequence_length: NATURAL_32
			l_carry: NATURAL_16
		do
			if a_bit_sequence_length > 0 then


				-- calculate new total length of message.
			l_bit_sequence_length := a_bit_sequence_length.to_natural_32
			from
				i := 31
				l_carry := 0
			until
				i < 0
			loop
				l_carry := l_carry + bit_length[i].as_natural_16 + (l_bit_sequence_length.as_natural_16 & 0x00FF)
				bit_length[i] := l_carry.as_natural_8
				l_carry := l_carry |>> 8
				l_bit_sequence_length := l_bit_sequence_length |>> 8
				i := i - 1
			end


--			                      l_source_pos
--			                      |
--			                      +-------+-------+-------
--			   buffer_position    |||||||||||||||||||||   a_bit_sequence
--			                |     +-------+-------+-------
--			+-------+-------+-------+-------+-------+-------
--			||||||||||||||||||||||                           buffer
--			+-------+-------+-------+-------+-------+-------
--			                |____|
--			             l_buffer_rem
--			
--			

				l_buffer_rem := (buffer_bits & 7) -- occupied bits on buffer[buffer_position].

					-- process data in chunks of 8 bits.
				from
					l_remaining_bits := a_bit_sequence_length
					l_source_position := 0
				until
					l_remaining_bits < 8
				loop
					l_byte := a_bit_sequence[l_source_position]
					buffer[buffer_position] := (l_byte |>> l_buffer_rem) | buffer[buffer_position]
					buffer_position := buffer_position + 1
					buffer_bits := buffer_bits + (8 - l_buffer_rem)
					if buffer_bits = 512 then
						process_buffer
						buffer_bits := 0
						buffer_position := 0
					end
					buffer[buffer_position] := l_byte |<< (8 - l_buffer_rem)
					buffer_bits := buffer_bits + l_buffer_rem

					l_source_position := l_source_position + 1
					l_remaining_bits := l_remaining_bits - 8
				end

					-- process last data chunk (has 0 - 7 bits)
					-- these are contained in the `a_bit_sequence[l_source_position)' byte.
				if l_remaining_bits > 0 then
					l_byte := a_bit_sequence[l_source_position]
					if (l_buffer_rem + l_remaining_bits) < 8 then
						buffer[buffer_position] := (l_byte |>> l_buffer_rem) | buffer[buffer_position]
						buffer_bits := buffer_bits + l_remaining_bits
					else
						buffer[buffer_position] := (l_byte |>> l_buffer_rem) | buffer[buffer_position]
						l_remaining_bits := l_remaining_bits - (8 - l_buffer_rem)
						buffer_bits := buffer_bits + (8 - l_buffer_rem)
						buffer_position := buffer_position + 1
						if buffer_bits = 512 then
							process_buffer
							buffer_bits := 0
							buffer_position := 0
						end
						buffer[buffer_position] := l_byte |<< (8 - l_buffer_rem)
						buffer_bits := buffer_bits + l_remaining_bits
					end
				end
			end
		ensure then
			buffer_not_full: buffer_bits < 512
		end

	finalize_calculation is
			-- Perform final steps of calculation and make result available.
		local
			i: INTEGER_32
			l_byte: NATURAL_8
		do
			check buffer_not_full: buffer_bits < 512 end

			l_byte := (0x80 |>> (buffer_bits.to_natural_32 & 7).as_integer_32 ).as_natural_8
				-- append a 1-bit			
			buffer[buffer_position] := buffer[buffer_position] | l_byte --(0x80 |>> (buffer_bits.to_natural_32 & 0x00000007).as_integer_32 ).as_natural_8, buffer_position)

			l_byte := (0xFF |<< (8 - ((buffer_bits.to_natural_32 & 0x00000007).as_integer_32 + 1))).as_natural_8
				-- set all remaining bits of current byte to 0
			buffer[buffer_position] := buffer[buffer_position] & l_byte -- (0x8F |>> (buffer_bits.to_natural_32 & 0x00000007).as_integer_32 + 1).as_natural_8, buffer_position)

			buffer_position := buffer_position + 1

				-- pad with zero bits to complete 512N + 256 bits:
			if
				buffer_position > 32
			then
				from
				until
					buffer_position > 63
				loop
					buffer[buffer_position] := 0
					buffer_position := buffer_position + 1
				end
				process_buffer
				buffer_position := 0
			end

			from
			until
				buffer_position > 31
			loop
				buffer[buffer_position] := 0
				buffer_position := buffer_position + 1
			end

				-- append bit length of hashed data
			buffer.copy_data (bit_length, 0, 32, 32)

				-- process final data block
			process_buffer

				--  prepare the completed message digest
			from
				create internal_digest.make (1, hash_code_byte_count)
				i := 0
			until
				i > (hash_code_byte_count // 8) - 1
			loop
				internal_digest[8 * i + 1] := (hash[i] |>> 56).as_natural_8
				internal_digest[8 * i + 2] := (hash[i] |>> 48).as_natural_8
				internal_digest[8 * i + 3] := (hash[i] |>> 40).as_natural_8
				internal_digest[8 * i + 4] := (hash[i] |>> 32).as_natural_8
				internal_digest[8 * i + 5] := (hash[i] |>> 24).as_natural_8
				internal_digest[8 * i + 6] := (hash[i] |>> 16).as_natural_8
				internal_digest[8 * i + 7] := (hash[i] |>>  8).as_natural_8
				internal_digest[8 * i + 8] := (hash[i]       ).as_natural_8
				i := i + 1
			end

			is_accepting_input := False
		end

feature {NONE} -- Implementation

	initialize_calculation is
			-- Make `Current' ready for the calculation of a new hash value
		do
			create bit_length.make (32)
			create buffer.make (64)
			buffer_bits := 0
			buffer_position := 0
			create hash.make (8)
			create round_key.make (8)
			create temp_l.make (8)
			create block.make (8)
			create state.make (8)

			is_accepting_input := True
		end

	process_buffer is
			-- Apply core whirlpool transfomrmation to buffer.
		local
			i, j, r, s, t: INTEGER_32
		do
				-- map the buffer to a block.
			from
				i := 0
				j := 0
			until
				i > 7
			loop
				block[i] :=
					(buffer[j    ].to_natural_64 |<< 56).bit_xor
					(buffer[j + 1].to_natural_64 |<< 48).bit_xor
					(buffer[j + 2].to_natural_64 |<< 40).bit_xor
					(buffer[j + 3].to_natural_64 |<< 32).bit_xor
					(buffer[j + 4].to_natural_64 |<< 24).bit_xor
					(buffer[j + 5].to_natural_64 |<< 16).bit_xor
					(buffer[j + 6].to_natural_64 |<<  8).bit_xor
					(buffer[j + 7].to_natural_64       )

				i := i + 1
				j := j + 8
			end

				-- compute and apply K^0 to the cipher state:
			from
				i := 0
			until
				i > 7
			loop
				round_key[i] := hash[i]
				state[i] := block[i].bit_xor (hash[i])

				i := i + 1
			end

				-- iterate over all rounds:
			from
				r := 1
			until
				r > block_calculation_rounds
			loop
					-- compute K^r from K^{r-1}
				from
					i := 0
				until
					i > 7
				loop
					temp_l[i] := 0x0000000000000000
					from
						t := 0
						s := 56
					until
						t > 7
					loop
						temp_l[i] :=
							temp_l[i].bit_xor (
								sbox_at (
									t,
									((round_key[(i - t) & 7] |>> s) & 0x00000000000000ff).to_integer_32
								)
							)

						t := t + 1
						s := s - 8
					end
					i := i + 1
				end
				from
					i := 0
				until
					i > 7
				loop
					round_key[i] := temp_l[i]
					i := i + 1
				end
				round_key[0] := round_key[0].bit_xor (round_constants[r])

					-- apply the r-th round transformation
				from
					i := 0
				until
					i > 7
				loop
					temp_l[i] := round_key[i]
					from
						t := 0
						s := 56
					until
						t > 7
					loop
						temp_l.put (
							temp_l[i].bit_xor (
								sbox_at (
									t,
									((state[(i - t) & 7] |>> s) & 0x00000000000000ff).to_integer_32
								)
							)
							, i
						)

						t := t + 1
						s := s - 8
					end

					i := i + 1
				end
				from
					i := 0
				until
					i > 7
				loop
					state[i] := temp_l[i]
					i := i + 1
				end

				r := r + 1
			end

				-- apply the Miyaguchi-Preneel compression function
			from
				i := 0
			until
				i > 7
			loop
				hash[i] := hash[i].bit_xor (state[i]).bit_xor (block[i])
				i := i + 1
			end
		end

	bit_length: SPECIAL [NATURAL_8]
		-- Global number of hashed bits (256-bit counter)

	buffer: SPECIAL [NATURAL_8]
			-- Buffer of data to hash

	buffer_bits: INTEGER_32
			-- Current number of bits on the buffer

	buffer_position: INTEGER_32
			-- Current (possibly incomplete) byte slot on the buffer

	hash: SPECIAL [NATURAL_64]
		-- Part of the hashing state.

	round_key: SPECIAL [NATURAL_64]
		-- Part of the hashing state

	temp_l: SPECIAL [NATURAL_64]
		-- Part of the hashing state

	block: SPECIAL [NATURAL_64]
		-- Part of the hashing state

	state: SPECIAL [NATURAL_64]
		-- Part of the hashing state

	internal_digest: ARRAY [NATURAL_8]
		-- internal storage for calculated message digest

end
