indexing
	description	: "System's root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature -- Initialization

	make is
			-- Test CDD_WHIRLPOOL_HASH_CALCULATOR.
		local
			l_total_start, l_start: DATE_TIME
			l_duration: DATE_TIME_DURATION
			l_string: STRING_8
		do
			create check_sum_calculator.make

			create l_total_start.make_now


			create l_start.make_now

			run_nessie_test_vectors

			l_duration := (create {DATE_TIME}.make_now).definite_duration (l_start)
			io.put_string ("%N***%NCalculation of NESSIE test vectors took: ")
			create l_string.make ((2 - l_duration.hour.out.count).max (0))
			l_string.fill_character ('0')
			io.put_string (l_string + l_duration.hour.out + ":")
			create l_string.make ((2 - l_duration.minute.out.count).max (0))
			l_string.fill_character ('0')
			io.put_string (l_string + l_duration.minute.out + ":")
			io.put_string (l_duration.fine_second.out)
			io.put_string ("%N***%N%N")


			create l_start.make_now

			run_iso_test_vectors

			l_duration := (create {DATE_TIME}.make_now).definite_duration (l_start)
			io.put_string ("%N***%NCalculation of ISO test vectors took: ")
			create l_string.make ((2 - l_duration.hour.out.count).max (0))
			l_string.fill_character ('0')
			io.put_string (l_string + l_duration.hour.out + ":")
			create l_string.make ((2 - l_duration.minute.out.count).max (0))
			l_string.fill_character ('0')
			io.put_string (l_string + l_duration.minute.out + ":")
			io.put_string (l_duration.fine_second.out)
			io.put_string ("%N***%N%N")


			create l_start.make_now

			run_custom_tests

			l_duration := (create {DATE_TIME}.make_now).definite_duration (l_start)
			io.put_string ("%N***%NCalculation of custom test vectors took: ")
			create l_string.make ((2 - l_duration.hour.out.count).max (0))
			l_string.fill_character ('0')
			io.put_string (l_string + l_duration.hour.out + ":")
			create l_string.make ((2 - l_duration.minute.out.count).max (0))
			l_string.fill_character ('0')
			io.put_string (l_string + l_duration.minute.out + ":")
			io.put_string (l_duration.fine_second.out)
			io.put_string ("%N***%N%N")


			l_duration := (create {DATE_TIME}.make_now).definite_duration (l_total_start)
			io.put_string ("%N***%NCalculation of ALL test vectors took: ")
			create l_string.make ((2 - l_duration.hour.out.count).max (0))
			l_string.fill_character ('0')
			io.put_string (l_string + l_duration.hour.out + ":")
			create l_string.make ((2 - l_duration.minute.out.count).max (0))
			l_string.fill_character ('0')
			io.put_string (l_string + l_duration.minute.out + ":")
			io.put_string (l_duration.fine_second.out)
			io.put_string ("%N***%N%N")

				-- dummy read line to keep output window open
			io.read_line
		end

feature -- Basic operations	

	run_nessie_test_vectors is
			-- Generate the NESSIE test vector set for Whirlpool.
			-- The test consists of:
			-- 1. hashing all bit strings containing only zero bits
			--    for all lengths from 0 to 1023;
			-- 2. hashing all 512-bit strings containing a single set bit;
			-- 3. the iterated hashing of the 512-bit string of zero bits a large number of times.
		local
			i: INTEGER_32
			l_data: SPECIAL [NATURAL_8]
			l_string: STRING_8
			l_iterations: INTEGER_32
		do
			io.put_string ("Message digests of strings of 0-bits and length L:%N")
			from
				create l_data.make (128)
				i := 0
			until
				i > 1023
			loop
				check_sum_calculator.reset
				check_sum_calculator.add_bits (l_data, i)
				check_sum_calculator.finalize_calculation

				create l_string.make (5 - i.out.count)
				l_string.fill_blank
				io.put_string ("    L =" + l_string + i.out + ": " + check_sum_calculator.digest_hex_string + "%N")
				i := i + 1
			end


			io.put_string ("Message digests of all 512-bit strings S containing a single 1-bit:%N")
			from
				create l_data.make (512 // 8)
				i := 0
			until
				i > 511
			loop
					-- set bit i
				l_data[i // 8] := l_data[i // 8] | ((0x80).to_natural_8 |>> (i \\ 8))
				check_sum_calculator.reset
				check_sum_calculator.add_bits (l_data, 512)
				check_sum_calculator.finalize_calculation
				io.put_string ("    S = " + byte_array_to_hex_string(l_data) + ": " + check_sum_calculator.digest_hex_string + "%N")

					-- reset bit i
				l_data[i // 8] := 0

				i := i + 1
			end

					-- NOTE: the last test below takes VERY VERY long
--			l_iterations := 100000000
--			io.put_string ("Iterated message digest computation (" + l_iterations.out + " times): ")
--			from
--				create l_data.make (64)
--				i := 0
--			until
--				i >= l_iterations
--			loop
--				check_sum_calculator.reset
--				check_sum_calculator.add_bits (l_data, 512)
--				check_sum_calculator.finalize_calculation

--				l_data := check_sum_calculator.digest.area

--				i := i + 1
--			end
--			io.put_string (check_sum_calculator.digest_hex_string + "%N")
		end

	run_iso_test_vectors is
			-- Generate the ISO/IEC 10118-3 test vector set for Whirlpool.
		local
			l_data: SPECIAL [NATURAL_8]
		do
			io.put_string ("1. In this example the data-string is the empty string, i.e. the string of length zero.%N%N")
			check_sum_calculator.reset
			check_sum_calculator.finalize_calculation
			io.put_string ("The hash-code is the following 512-bit string.%N%N" + check_sum_calculator.digest_hex_string + "%N%N")

			io.put_string ("2. In this example the data-string consists of a single byte, namely the ASCII-coded version of the letter 'a'.%N%N")
			check_sum_calculator.reset
			check_sum_calculator.add_string ("a")
			check_sum_calculator.finalize_calculation
			io.put_string ("The hash-code is the following 512-bit string.%N%N" + check_sum_calculator.digest_hex_string + "%N%N")

			io.put_string ("3. In this example the data-string is the three-byte string consisting of the ASCII-coded version of 'abc'.%N%N")
			check_sum_calculator.reset
			check_sum_calculator.add_string ("abc")
			check_sum_calculator.finalize_calculation
			io.put_string ("The hash-code is the following 512-bit string.%N%N" + check_sum_calculator.digest_hex_string + "%N%N")

			io.put_string ("4. In this example the data-string is the 14-byte string consisting of the ASCII-coded version of 'message digest'.%N%N")
			check_sum_calculator.reset
			check_sum_calculator.add_string ("message digest")
			check_sum_calculator.finalize_calculation
			io.put_string ("The hash-code is the following 512-bit string.%N%N" + check_sum_calculator.digest_hex_string + "%N%N")

			io.put_string ("5. In this example the data-string is the 26-byte string consisting of the ASCII-coded version of 'abcdefghijklmnopqrstuvwxyz'.%N%N")
			check_sum_calculator.reset
			check_sum_calculator.add_string ("abcdefghijklmnopqrstuvwxyz")
			check_sum_calculator.finalize_calculation
			io.put_string ("The hash-code is the following 512-bit string.%N%N" + check_sum_calculator.digest_hex_string + "%N%N")

			io.put_string ("6. In this example the data-string is the 62-byte string consisting of the ASCII-coded version of 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'.%N%N")
			check_sum_calculator.reset
			check_sum_calculator.add_string ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")
			check_sum_calculator.finalize_calculation
			io.put_string ("The hash-code is the following 512-bit string.%N%N" + check_sum_calculator.digest_hex_string + "%N%N")

			io.put_string ("7. In this example the data-string is the 80-byte string consisting of the ASCII-coded version of eight repetitions of '1234567890'.%N%N")
			check_sum_calculator.reset
			check_sum_calculator.add_string ("12345678901234567890123456789012345678901234567890123456789012345678901234567890")
			check_sum_calculator.finalize_calculation
			io.put_string ("The hash-code is the following 512-bit string.%N%N" + check_sum_calculator.digest_hex_string + "%N%N")

			io.put_string ("8. In this example the data-string is the 32-byte string consisting of the ASCII-coded version of 'abcdbcdecdefdefgefghfghighijhijk'.%N%N")
			check_sum_calculator.reset
			check_sum_calculator.add_string ("abcdbcdecdefdefgefghfghighijhijk")
			check_sum_calculator.finalize_calculation
			io.put_string ("The hash-code is the following 512-bit string.%N%N" + check_sum_calculator.digest_hex_string + "%N%N")

			io.put_string ("9. In this example the data-string is the 1000000-byte string consisting of the ASCII-coded version of 'a' repeated 10^6 times.%N%N")
			check_sum_calculator.reset
			create l_data.make (1000000)
			l_data.fill_with (('a').code.to_natural_8, l_data.lower, l_data.upper)
			check_sum_calculator.add_bits (l_data, 8 * l_data.count)
			check_sum_calculator.finalize_calculation
			io.put_string ("The hash-code is the following 512-bit string.%N%N" + check_sum_calculator.digest_hex_string + "%N%N")
		end

	run_custom_tests is
			-- Run some custom tests related to successive adding of message parts
		do

		end

feature -- Implementation

	check_sum_calculator: CDD_WHIRLPOOL_HASH_CALCULATOR

	byte_array_to_hex_string (some_bytes: SPECIAL [NATURAL_8]): STRING_8 is
			-- Representation of `some_bytes' as one sequence of hex characters
		local
			i: INTEGER
		do
			from
				create Result.make (some_bytes.count * 2)
				i := some_bytes.lower
			until
				i > some_bytes.upper
			loop
				Result.append_string (some_bytes[i].to_hex_string)
				i := i + 1
			end
		end

end -- class APPLICATION
