indexing
	description: "[
			Constants for the WHIRLPOOL hash function.
			The WHIRLPOOL hash function is described on [http://paginas.terra.com.br/informatica/paulobarreto/WhirlpoolPage.html].
			This implementation is based on the reference java implementation found on the above mentioned web page.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_WHIRLPOOL_HASH_CONSTANTS

feature -- Access - Measurement

	hash_code_byte_count: INTEGER_32 is 64
			-- Size of hash code in bytes

	hash_code_bit_count: INTEGER_32 is 512
			-- Size of hash code in bits

feature -- Access - Calculation

	block_calculation_rounds: INTEGER_32 is 10
			-- Number of rounds used for processing one message block

feature -- Access - Algorithm constants

	substitution_box: SPECIAL [NATURAL_64] is
			-- The substitution box
		local
			i, j: INTEGER_32
			-- k: INTEGER_32
		once
				-- *** Initialize the "2d array" `substitution_box'

			create Result.make (8 * 256)

				-- Fill first row explicitely
			i := -1
			i := i + 1; Result.put (0x18186018c07830d8, i)
			i := i + 1; Result.put (0x23238c2305af4626, i)
			i := i + 1; Result.put (0xc6c63fc67ef991b8, i)
			i := i + 1; Result.put (0xe8e887e8136fcdfb, i)
			i := i + 1; Result.put (0x878726874ca113cb, i)
			i := i + 1; Result.put (0xb8b8dab8a9626d11, i)
			i := i + 1; Result.put (0x0101040108050209, i)
			i := i + 1; Result.put (0x4f4f214f426e9e0d, i)
			i := i + 1; Result.put (0x3636d836adee6c9b, i)
			i := i + 1; Result.put (0xa6a6a2a6590451ff, i)
			i := i + 1; Result.put (0xd2d26fd2debdb90c, i)
			i := i + 1; Result.put (0xf5f5f3f5fb06f70e, i)
			i := i + 1; Result.put (0x7979f979ef80f296, i)
			i := i + 1; Result.put (0x6f6fa16f5fcede30, i)
			i := i + 1; Result.put (0x91917e91fcef3f6d, i)
			i := i + 1; Result.put (0x52525552aa07a4f8, i)
			i := i + 1; Result.put (0x60609d6027fdc047, i)
			i := i + 1; Result.put (0xbcbccabc89766535, i)
			i := i + 1; Result.put (0x9b9b569baccd2b37, i)
			i := i + 1; Result.put (0x8e8e028e048c018a, i)
			i := i + 1; Result.put (0xa3a3b6a371155bd2, i)
			i := i + 1; Result.put (0x0c0c300c603c186c, i)
			i := i + 1; Result.put (0x7b7bf17bff8af684, i)
			i := i + 1; Result.put (0x3535d435b5e16a80, i)
			i := i + 1; Result.put (0x1d1d741de8693af5, i)
			i := i + 1; Result.put (0xe0e0a7e05347ddb3, i)
			i := i + 1; Result.put (0xd7d77bd7f6acb321, i)
			i := i + 1; Result.put (0xc2c22fc25eed999c, i)
			i := i + 1; Result.put (0x2e2eb82e6d965c43, i)
			i := i + 1; Result.put (0x4b4b314b627a9629, i)
			i := i + 1; Result.put (0xfefedffea321e15d, i)
			i := i + 1; Result.put (0x575741578216aed5, i)
			i := i + 1; Result.put (0x15155415a8412abd, i)
			i := i + 1; Result.put (0x7777c1779fb6eee8, i)
			i := i + 1; Result.put (0x3737dc37a5eb6e92, i)
			i := i + 1; Result.put (0xe5e5b3e57b56d79e, i)
			i := i + 1; Result.put (0x9f9f469f8cd92313, i)
			i := i + 1; Result.put (0xf0f0e7f0d317fd23, i)
			i := i + 1; Result.put (0x4a4a354a6a7f9420, i)
			i := i + 1; Result.put (0xdada4fda9e95a944, i)
			i := i + 1; Result.put (0x58587d58fa25b0a2, i)
			i := i + 1; Result.put (0xc9c903c906ca8fcf, i)
			i := i + 1; Result.put (0x2929a429558d527c, i)
			i := i + 1; Result.put (0x0a0a280a5022145a, i)
			i := i + 1; Result.put (0xb1b1feb1e14f7f50, i)
			i := i + 1; Result.put (0xa0a0baa0691a5dc9, i)
			i := i + 1; Result.put (0x6b6bb16b7fdad614, i)
			i := i + 1; Result.put (0x85852e855cab17d9, i)
			i := i + 1; Result.put (0xbdbdcebd8173673c, i)
			i := i + 1; Result.put (0x5d5d695dd234ba8f, i)
			i := i + 1; Result.put (0x1010401080502090, i)
			i := i + 1; Result.put (0xf4f4f7f4f303f507, i)
			i := i + 1; Result.put (0xcbcb0bcb16c08bdd, i)
			i := i + 1; Result.put (0x3e3ef83eedc67cd3, i)
			i := i + 1; Result.put (0x0505140528110a2d, i)
			i := i + 1; Result.put (0x676781671fe6ce78, i)
			i := i + 1; Result.put (0xe4e4b7e47353d597, i)
			i := i + 1; Result.put (0x27279c2725bb4e02, i)
			i := i + 1; Result.put (0x4141194132588273, i)
			i := i + 1; Result.put (0x8b8b168b2c9d0ba7, i)
			i := i + 1; Result.put (0xa7a7a6a7510153f6, i)
			i := i + 1; Result.put (0x7d7de97dcf94fab2, i)
			i := i + 1; Result.put (0x95956e95dcfb3749, i)
			i := i + 1; Result.put (0xd8d847d88e9fad56, i)
			i := i + 1; Result.put (0xfbfbcbfb8b30eb70, i)
			i := i + 1; Result.put (0xeeee9fee2371c1cd, i)
			i := i + 1; Result.put (0x7c7ced7cc791f8bb, i)
			i := i + 1; Result.put (0x6666856617e3cc71, i)
			i := i + 1; Result.put (0xdddd53dda68ea77b, i)
			i := i + 1; Result.put (0x17175c17b84b2eaf, i)
			i := i + 1; Result.put (0x4747014702468e45, i)
			i := i + 1; Result.put (0x9e9e429e84dc211a, i)
			i := i + 1; Result.put (0xcaca0fca1ec589d4, i)
			i := i + 1; Result.put (0x2d2db42d75995a58, i)
			i := i + 1; Result.put (0xbfbfc6bf9179632e, i)
			i := i + 1; Result.put (0x07071c07381b0e3f, i)
			i := i + 1; Result.put (0xadad8ead012347ac, i)
			i := i + 1; Result.put (0x5a5a755aea2fb4b0, i)
			i := i + 1; Result.put (0x838336836cb51bef, i)
			i := i + 1; Result.put (0x3333cc3385ff66b6, i)
			i := i + 1; Result.put (0x636391633ff2c65c, i)
			i := i + 1; Result.put (0x02020802100a0412, i)
			i := i + 1; Result.put (0xaaaa92aa39384993, i)
			i := i + 1; Result.put (0x7171d971afa8e2de, i)
			i := i + 1; Result.put (0xc8c807c80ecf8dc6, i)
			i := i + 1; Result.put (0x19196419c87d32d1, i)
			i := i + 1; Result.put (0x494939497270923b, i)
			i := i + 1; Result.put (0xd9d943d9869aaf5f, i)
			i := i + 1; Result.put (0xf2f2eff2c31df931, i)
			i := i + 1; Result.put (0xe3e3abe34b48dba8, i)
			i := i + 1; Result.put (0x5b5b715be22ab6b9, i)
			i := i + 1; Result.put (0x88881a8834920dbc, i)
			i := i + 1; Result.put (0x9a9a529aa4c8293e, i)
			i := i + 1; Result.put (0x262698262dbe4c0b, i)
			i := i + 1; Result.put (0x3232c8328dfa64bf, i)
			i := i + 1; Result.put (0xb0b0fab0e94a7d59, i)
			i := i + 1; Result.put (0xe9e983e91b6acff2, i)
			i := i + 1; Result.put (0x0f0f3c0f78331e77, i)
			i := i + 1; Result.put (0xd5d573d5e6a6b733, i)
			i := i + 1; Result.put (0x80803a8074ba1df4, i)
			i := i + 1; Result.put (0xbebec2be997c6127, i)
			i := i + 1; Result.put (0xcdcd13cd26de87eb, i)
			i := i + 1; Result.put (0x3434d034bde46889, i)
			i := i + 1; Result.put (0x48483d487a759032, i)
			i := i + 1; Result.put (0xffffdbffab24e354, i)
			i := i + 1; Result.put (0x7a7af57af78ff48d, i)
			i := i + 1; Result.put (0x90907a90f4ea3d64, i)
			i := i + 1; Result.put (0x5f5f615fc23ebe9d, i)
			i := i + 1; Result.put (0x202080201da0403d, i)
			i := i + 1; Result.put (0x6868bd6867d5d00f, i)
			i := i + 1; Result.put (0x1a1a681ad07234ca, i)
			i := i + 1; Result.put (0xaeae82ae192c41b7, i)
			i := i + 1; Result.put (0xb4b4eab4c95e757d, i)
			i := i + 1; Result.put (0x54544d549a19a8ce, i)
			i := i + 1; Result.put (0x93937693ece53b7f, i)
			i := i + 1; Result.put (0x222288220daa442f, i)
			i := i + 1; Result.put (0x64648d6407e9c863, i)
			i := i + 1; Result.put (0xf1f1e3f1db12ff2a, i)
			i := i + 1; Result.put (0x7373d173bfa2e6cc, i)
			i := i + 1; Result.put (0x12124812905a2482, i)
			i := i + 1; Result.put (0x40401d403a5d807a, i)
			i := i + 1; Result.put (0x0808200840281048, i)
			i := i + 1; Result.put (0xc3c32bc356e89b95, i)
			i := i + 1; Result.put (0xecec97ec337bc5df, i)
			i := i + 1; Result.put (0xdbdb4bdb9690ab4d, i)
			i := i + 1; Result.put (0xa1a1bea1611f5fc0, i)
			i := i + 1; Result.put (0x8d8d0e8d1c830791, i)
			i := i + 1; Result.put (0x3d3df43df5c97ac8, i)
			i := i + 1; Result.put (0x97976697ccf1335b, i)
			i := i + 1; Result.put (0x0000000000000000, i)
			i := i + 1; Result.put (0xcfcf1bcf36d483f9, i)
			i := i + 1; Result.put (0x2b2bac2b4587566e, i)
			i := i + 1; Result.put (0x7676c57697b3ece1, i)
			i := i + 1; Result.put (0x8282328264b019e6, i)
			i := i + 1; Result.put (0xd6d67fd6fea9b128, i)
			i := i + 1; Result.put (0x1b1b6c1bd87736c3, i)
			i := i + 1; Result.put (0xb5b5eeb5c15b7774, i)
			i := i + 1; Result.put (0xafaf86af112943be, i)
			i := i + 1; Result.put (0x6a6ab56a77dfd41d, i)
			i := i + 1; Result.put (0x50505d50ba0da0ea, i)
			i := i + 1; Result.put (0x45450945124c8a57, i)
			i := i + 1; Result.put (0xf3f3ebf3cb18fb38, i)
			i := i + 1; Result.put (0x3030c0309df060ad, i)
			i := i + 1; Result.put (0xefef9bef2b74c3c4, i)
			i := i + 1; Result.put (0x3f3ffc3fe5c37eda, i)
			i := i + 1; Result.put (0x55554955921caac7, i)
			i := i + 1; Result.put (0xa2a2b2a2791059db, i)
			i := i + 1; Result.put (0xeaea8fea0365c9e9, i)
			i := i + 1; Result.put (0x656589650fecca6a, i)
			i := i + 1; Result.put (0xbabad2bab9686903, i)
			i := i + 1; Result.put (0x2f2fbc2f65935e4a, i)
			i := i + 1; Result.put (0xc0c027c04ee79d8e, i)
			i := i + 1; Result.put (0xdede5fdebe81a160, i)
			i := i + 1; Result.put (0x1c1c701ce06c38fc, i)
			i := i + 1; Result.put (0xfdfdd3fdbb2ee746, i)
			i := i + 1; Result.put (0x4d4d294d52649a1f, i)
			i := i + 1; Result.put (0x92927292e4e03976, i)
			i := i + 1; Result.put (0x7575c9758fbceafa, i)
			i := i + 1; Result.put (0x06061806301e0c36, i)
			i := i + 1; Result.put (0x8a8a128a249809ae, i)
			i := i + 1; Result.put (0xb2b2f2b2f940794b, i)
			i := i + 1; Result.put (0xe6e6bfe66359d185, i)
			i := i + 1; Result.put (0x0e0e380e70361c7e, i)
			i := i + 1; Result.put (0x1f1f7c1ff8633ee7, i)
			i := i + 1; Result.put (0x6262956237f7c455, i)
			i := i + 1; Result.put (0xd4d477d4eea3b53a, i)
			i := i + 1; Result.put (0xa8a89aa829324d81, i)
			i := i + 1; Result.put (0x96966296c4f43152, i)
			i := i + 1; Result.put (0xf9f9c3f99b3aef62, i)
			i := i + 1; Result.put (0xc5c533c566f697a3, i)
			i := i + 1; Result.put (0x2525942535b14a10, i)
			i := i + 1; Result.put (0x59597959f220b2ab, i)
			i := i + 1; Result.put (0x84842a8454ae15d0, i)
			i := i + 1; Result.put (0x7272d572b7a7e4c5, i)
			i := i + 1; Result.put (0x3939e439d5dd72ec, i)
			i := i + 1; Result.put (0x4c4c2d4c5a619816, i)
			i := i + 1; Result.put (0x5e5e655eca3bbc94, i)
			i := i + 1; Result.put (0x7878fd78e785f09f, i)
			i := i + 1; Result.put (0x3838e038ddd870e5, i)
			i := i + 1; Result.put (0x8c8c0a8c14860598, i)
			i := i + 1; Result.put (0xd1d163d1c6b2bf17, i)
			i := i + 1; Result.put (0xa5a5aea5410b57e4, i)
			i := i + 1; Result.put (0xe2e2afe2434dd9a1, i)
			i := i + 1; Result.put (0x616199612ff8c24e, i)
			i := i + 1; Result.put (0xb3b3f6b3f1457b42, i)
			i := i + 1; Result.put (0x2121842115a54234, i)
			i := i + 1; Result.put (0x9c9c4a9c94d62508, i)
			i := i + 1; Result.put (0x1e1e781ef0663cee, i)
			i := i + 1; Result.put (0x4343114322528661, i)
			i := i + 1; Result.put (0xc7c73bc776fc93b1, i)
			i := i + 1; Result.put (0xfcfcd7fcb32be54f, i)
			i := i + 1; Result.put (0x0404100420140824, i)
			i := i + 1; Result.put (0x51515951b208a2e3, i)
			i := i + 1; Result.put (0x99995e99bcc72f25, i)
			i := i + 1; Result.put (0x6d6da96d4fc4da22, i)
			i := i + 1; Result.put (0x0d0d340d68391a65, i)
			i := i + 1; Result.put (0xfafacffa8335e979, i)
			i := i + 1; Result.put (0xdfdf5bdfb684a369, i)
			i := i + 1; Result.put (0x7e7ee57ed79bfca9, i)
			i := i + 1; Result.put (0x242490243db44819, i)
			i := i + 1; Result.put (0x3b3bec3bc5d776fe, i)
			i := i + 1; Result.put (0xabab96ab313d4b9a, i)
			i := i + 1; Result.put (0xcece1fce3ed181f0, i)
			i := i + 1; Result.put (0x1111441188552299, i)
			i := i + 1; Result.put (0x8f8f068f0c890383, i)
			i := i + 1; Result.put (0x4e4e254e4a6b9c04, i)
			i := i + 1; Result.put (0xb7b7e6b7d1517366, i)
			i := i + 1; Result.put (0xebeb8beb0b60cbe0, i)
			i := i + 1; Result.put (0x3c3cf03cfdcc78c1, i)
			i := i + 1; Result.put (0x81813e817cbf1ffd, i)
			i := i + 1; Result.put (0x94946a94d4fe3540, i)
			i := i + 1; Result.put (0xf7f7fbf7eb0cf31c, i)
			i := i + 1; Result.put (0xb9b9deb9a1676f18, i)
			i := i + 1; Result.put (0x13134c13985f268b, i)
			i := i + 1; Result.put (0x2c2cb02c7d9c5851, i)
			i := i + 1; Result.put (0xd3d36bd3d6b8bb05, i)
			i := i + 1; Result.put (0xe7e7bbe76b5cd38c, i)
			i := i + 1; Result.put (0x6e6ea56e57cbdc39, i)
			i := i + 1; Result.put (0xc4c437c46ef395aa, i)
			i := i + 1; Result.put (0x03030c03180f061b, i)
			i := i + 1; Result.put (0x565645568a13acdc, i)
			i := i + 1; Result.put (0x44440d441a49885e, i)
			i := i + 1; Result.put (0x7f7fe17fdf9efea0, i)
			i := i + 1; Result.put (0xa9a99ea921374f88, i)
			i := i + 1; Result.put (0x2a2aa82a4d825467, i)
			i := i + 1; Result.put (0xbbbbd6bbb16d6b0a, i)
			i := i + 1; Result.put (0xc1c123c146e29f87, i)
			i := i + 1; Result.put (0x53535153a202a6f1, i)
			i := i + 1; Result.put (0xdcdc57dcae8ba572, i)
			i := i + 1; Result.put (0x0b0b2c0b58271653, i)
			i := i + 1; Result.put (0x9d9d4e9d9cd32701, i)
			i := i + 1; Result.put (0x6c6cad6c47c1d82b, i)
			i := i + 1; Result.put (0x3131c43195f562a4, i)
			i := i + 1; Result.put (0x7474cd7487b9e8f3, i)
			i := i + 1; Result.put (0xf6f6fff6e309f115, i)
			i := i + 1; Result.put (0x464605460a438c4c, i)
			i := i + 1; Result.put (0xacac8aac092645a5, i)
			i := i + 1; Result.put (0x89891e893c970fb5, i)
			i := i + 1; Result.put (0x14145014a04428b4, i)
			i := i + 1; Result.put (0xe1e1a3e15b42dfba, i)
			i := i + 1; Result.put (0x16165816b04e2ca6, i)
			i := i + 1; Result.put (0x3a3ae83acdd274f7, i)
			i := i + 1; Result.put (0x6969b9696fd0d206, i)
			i := i + 1; Result.put (0x09092409482d1241, i)
			i := i + 1; Result.put (0x7070dd70a7ade0d7, i)
			i := i + 1; Result.put (0xb6b6e2b6d954716f, i)
			i := i + 1; Result.put (0xd0d067d0ceb7bd1e, i)
			i := i + 1; Result.put (0xeded93ed3b7ec7d6, i)
			i := i + 1; Result.put (0xcccc17cc2edb85e2, i)
			i := i + 1; Result.put (0x424215422a578468, i)
			i := i + 1; Result.put (0x98985a98b4c22d2c, i)
			i := i + 1; Result.put (0xa4a4aaa4490e55ed, i)
			i := i + 1; Result.put (0x2828a0285d885075, i)
			i := i + 1; Result.put (0x5c5c6d5cda31b886, i)
			i := i + 1; Result.put (0xf8f8c7f8933fed6b, i)
			i := i + 1; Result.put (0x8686228644a411c2, i)

				-- Fill remaining rows by rotating explicitely
			from
				i := 1
			until
				i > 7
			loop
				from
					j := 0
				until
					j > 255
				loop
					Result.put (rotate_right_natural_64 (Result.item (((i - 1) * 256) + j), 8), (i * 256) + j)
					j := j + 1
				end
				i := i + 1
			end


--			from
--				i := 0
--			until
--				i > 7
--			loop
--				io.put_string ("static const u64 C" + i.out + "[256] = {")
--				io.put_new_line
--				from
--					j := 0
--				until
--					j > 63
--				loop
--					io.put_string ("   ")
--					from
--						k := 0
--					until
--						k > 3
--					loop
--						io.put_string (" LL(0x" + Result.item ((i * 256) + ((j * 4) + k)).to_hex_string + "),")
--						k := k + 1
--					end
--					io.put_new_line
--					j := j + 1
--				end
--				io.put_string ("};")
--				io.put_new_line
--				io.put_new_line
--				i := i + 1
--			end
--			io.put_new_line

		end


		round_constants: SPECIAL [NATURAL_64] is
				-- Constants for each round
			local
				i: INTEGER_32
				j: INTEGER_32
			once
				create Result.make (block_calculation_rounds + 1)

				Result.put (0, 0) -- not used (assigment kept only to properly initialize all variables)
				from
					j := 1
				until
					j > block_calculation_rounds
				loop
					i := 8 * (j - 1)
					Result.put (
						(sbox_at (0, i    ) & 0xff00000000000000).bit_xor
						(sbox_at (1, i + 1) & 0x00ff000000000000).bit_xor
						(sbox_at (2, i + 2) & 0x0000ff0000000000).bit_xor
						(sbox_at (3, i + 3) & 0x000000ff00000000).bit_xor
						(sbox_at (4, i + 4) & 0x00000000ff000000).bit_xor
						(sbox_at (5, i + 5) & 0x0000000000ff0000).bit_xor
						(sbox_at (6, i + 6) & 0x000000000000ff00).bit_xor
						(sbox_at (7, i + 7) & 0x00000000000000ff)
						, j)

					j := j + 1
				end

--				io.put_string ("static const u64 rc[R + 1] = {")
--				io.put_new_line
--				from
--					i := 0
--				until
--					i > block_calculation_rounds
--				loop
--					io.put_string ("   LL(0x" + round_constants.item (i).to_hex_string + "),")
--					io.put_new_line

--					i := i + 1
--				end
--				io.put_string ("};")
--				io.put_new_line
--				io.put_new_line
			end

feature -- Support constant functions

	sbox_at (i: INTEGER_32; j: INTEGER_32): NATURAL_64 is
			-- Return item at `i', `j' of `substitution_box', when looked at as 2 dimensional array.
		do
			Result := substitution_box.item ((i * 256) + j)
		end

feature -- Support bit shift functions

	rotate_right_natural_64 (a_natural_64: NATURAL_64; a_positions_to_rotate: INTEGER_32): NATURAL_64 is
			-- Rotate bits `a_natural_64' to the right `a_positions_to_rotate'.
		require
			positions_valid: a_positions_to_rotate >= 0 and a_positions_to_rotate <= 63
		do
			Result := (a_natural_64 |>> a_positions_to_rotate) | (a_natural_64 |<< (64 - a_positions_to_rotate))
		end

end
