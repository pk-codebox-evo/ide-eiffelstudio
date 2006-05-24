indexing
	description: "Identifier solution for group, folder, class and feature."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_ID_SOLUTION

inherit
	SHARED_WORKBENCH

feature -- Access (Group)

	id_of_group (a_group: CONF_GROUP): STRING is
			-- Identifier of `a_group'
			-- target_uuid + name_sep + group_name
		require
			a_group_not_void: a_group /= Void
		do
			create Result.make (50)
			Result.append (encode (a_group.target.system.uuid.out))
			Result.extend (name_sep)
			Result.append (encode (a_group.name))
		ensure
			result_not_void: Result /= Void
		end

	group_of_id (a_id: STRING): CONF_GROUP is
			-- Group of `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			uuid: STRING
			group_name: STRING
			l_target: CONF_TARGET
			l_uuid: UUID
		do
			strings := a_id.split (name_sep)
			if strings.count >= 2 then
				uuid := decode (strings.i_th (1))
				group_name := decode (strings.i_th (2))
				if universe.target.system.uuid.out.is_equal (uuid) then
					l_target := universe.target
				else
					create l_uuid
					if l_uuid.is_valid_uuid (uuid) then
						l_target := universe.target.all_libraries.item (create {UUID}.make_from_string (uuid))
					end
				end
				if l_target /= Void then
					Result := l_target.groups.item (group_name)
				end
			end
		ensure
			strings_not_void: strings /= Void
		end

feature -- Access (Folder)

	id_of_folder (a_folder: EB_FOLDER): STRING is
			-- Id of `a_folder'
			-- `id_of_group' + `name_sep' + path
		require
			a_folder_not_void: a_folder /= Void
		local
			l_group : CONF_GROUP
		do
			l_group := a_folder.cluster
			Result := id_of_group (l_group)
			Result.extend (name_sep)
			Result.append (encode (a_folder.path))
		ensure
			result_not_void: Result /= Void
		end

	folder_of_id (a_id: STRING): EB_FOLDER is
			-- Folder of `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			l_path: STRING
			l_cluster: CONF_CLUSTER
			l_dir: KL_DIRECTORY
		do
			l_cluster ?= group_of_id (a_id)
			if l_cluster /= Void and then strings.count >= 3 then
				l_path := decode (strings.i_th (3))
				create l_dir.make (l_cluster.location.build_path (l_path, ""))
				if l_dir.exists then
					create Result.make (l_cluster, l_path)
				end
			end
		end

feature -- Access (Class)

	id_of_class (a_class: CONF_CLASS): STRING is
			-- Unique id of a class in the system
			-- `id_of_group' + `name_sep' + class_name
		require
			a_class_not_void: a_class /= Void
		local
			l_group: CONF_GROUP
		do
			l_group := a_class.group
			Result := id_of_group (l_group)
			Result.extend (name_sep)
			Result.append (encode (a_class.name))
		ensure
			result_not_void: Result /= Void
		end

	class_of_id (a_id: STRING): CONF_CLASS is
			-- Class of `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			class_name: STRING
			l_group: CONF_CLUSTER
		do
			l_group ?= group_of_id (a_id)
			if l_group /= Void and then l_group.classes /= Void and then strings.count >= 3 then
				class_name := decode (strings.i_th (3))
				Result := l_group.classes.item (class_name)
			end
		end

feature -- Access (Feature)

	feature_of_id (a_id: STRING): E_FEATURE is
			-- Class of `a_id'
		require
			a_id_not_void: a_id /= Void
		local
			l_class: CLASS_I
			l_class_c: CLASS_C
		do
			l_class ?= class_of_id (a_id)
			if l_class /= Void and then strings.count >= 4 then
				l_class_c := l_class.compiled_representation
				if l_class_c /= Void then
					Result := l_class_c.feature_with_name (decode (strings.i_th (4)))
				end
			end
		end

	id_of_feature (a_feature: E_FEATURE): STRING is
			-- Unique id of a feature in the system
			-- `id_of_class'(associate class) + name_sep + feature_name
		require
			a_feature_not_void: a_feature /= Void
		local
			l_class: CONF_CLASS
		do
			l_class ?= a_feature.associated_class.lace_class
			Result := id_of_class (l_class)
			Result.extend (name_sep)
			Result.append (encode (a_feature.name))
		ensure
			result_not_void: Result /= Void
		end

feature -- UUID generation

	generate_uuid: STRING is
			-- Generate uuid
		do
			Result := uuid_gen.generate_uuid.out
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation. Encoding/Decoding

	name_sep: CHARACTER is '&'
			-- Name separator

	escape_char: CHARACTER is '%%'

	name_sep_code: NATURAL_32 is 0x26

	escape_char_code: NATURAL_32 is 0x25

	hex_strings: ARRAY [STRING] is
		once
			Result := <<
			    "%%00", "%%01", "%%02", "%%03", "%%04", "%%05", "%%06", "%%07",
			    "%%08", "%%09", "%%0a", "%%0b", "%%0c", "%%0d", "%%0e", "%%0f",
			    "%%10", "%%11", "%%12", "%%13", "%%14", "%%15", "%%16", "%%17",
			    "%%18", "%%19", "%%1a", "%%1b", "%%1c", "%%1d", "%%1e", "%%1f",
			    "%%20", "%%21", "%%22", "%%23", "%%24", "%%25", "%%26", "%%27",
			    "%%28", "%%29", "%%2a", "%%2b", "%%2c", "%%2d", "%%2e", "%%2f",
			    "%%30", "%%31", "%%32", "%%33", "%%34", "%%35", "%%36", "%%37",
			    "%%38", "%%39", "%%3a", "%%3b", "%%3c", "%%3d", "%%3e", "%%3f",
			    "%%40", "%%41", "%%42", "%%43", "%%44", "%%45", "%%46", "%%47",
			    "%%48", "%%49", "%%4a", "%%4b", "%%4c", "%%4d", "%%4e", "%%4f",
			    "%%50", "%%51", "%%52", "%%53", "%%54", "%%55", "%%56", "%%57",
			    "%%58", "%%59", "%%5a", "%%5b", "%%5c", "%%5d", "%%5e", "%%5f",
			    "%%60", "%%61", "%%62", "%%63", "%%64", "%%65", "%%66", "%%67",
			    "%%68", "%%69", "%%6a", "%%6b", "%%6c", "%%6d", "%%6e", "%%6f",
			    "%%70", "%%71", "%%72", "%%73", "%%74", "%%75", "%%76", "%%77",
			    "%%78", "%%79", "%%7a", "%%7b", "%%7c", "%%7d", "%%7e", "%%7f",
			    "%%80", "%%81", "%%82", "%%83", "%%84", "%%85", "%%86", "%%87",
			    "%%88", "%%89", "%%8a", "%%8b", "%%8c", "%%8d", "%%8e", "%%8f",
			    "%%90", "%%91", "%%92", "%%93", "%%94", "%%95", "%%96", "%%97",
			    "%%98", "%%99", "%%9a", "%%9b", "%%9c", "%%9d", "%%9e", "%%9f",
			    "%%a0", "%%a1", "%%a2", "%%a3", "%%a4", "%%a5", "%%a6", "%%a7",
			    "%%a8", "%%a9", "%%aa", "%%ab", "%%ac", "%%ad", "%%ae", "%%af",
			    "%%b0", "%%b1", "%%b2", "%%b3", "%%b4", "%%b5", "%%b6", "%%b7",
			    "%%b8", "%%b9", "%%ba", "%%bb", "%%bc", "%%bd", "%%be", "%%bf",
			    "%%c0", "%%c1", "%%c2", "%%c3", "%%c4", "%%c5", "%%c6", "%%c7",
			    "%%c8", "%%c9", "%%ca", "%%cb", "%%cc", "%%cd", "%%ce", "%%cf",
			    "%%d0", "%%d1", "%%d2", "%%d3", "%%d4", "%%d5", "%%d6", "%%d7",
			    "%%d8", "%%d9", "%%da", "%%db", "%%dc", "%%dd", "%%de", "%%df",
			    "%%e0", "%%e1", "%%e2", "%%e3", "%%e4", "%%e5", "%%e6", "%%e7",
			    "%%e8", "%%e9", "%%ea", "%%eb", "%%ec", "%%ed", "%%ee", "%%ef",
			    "%%f0", "%%f1", "%%f2", "%%f3", "%%f4", "%%f5", "%%f6", "%%f7",
			    "%%f8", "%%f9", "%%fa", "%%fb", "%%fc", "%%fd", "%%fe", "%%ff"
  			>>
  		end

	encode (a_string: STRING): STRING is
			-- Encode `a_string' so that it does not contain `name_sep'.
		require
			a_string_not_void: a_string /= Void
		local
			l_code : NATURAL_32
			i : INTEGER
		do
			create Result.make (a_string.count)
			from
				i := 1
			until
				i > a_string.count
			loop
				l_code := a_string.code (i)

				if ('A').natural_32_code <= l_code and l_code <= ('Z').natural_32_code then -- A...Z
					Result.append_code (l_code)
				elseif ('a').natural_32_code <= l_code and l_code <= ('z').natural_32_code then -- a...z
					Result.append_code (l_code)
				elseif ('0').natural_32_code <= l_code and l_code <= ('9').natural_32_code then -- 0...9
					Result.append_code (l_code)
				elseif ('-').natural_32_code = l_code or else ('_').natural_32_code = l_code then -- '-', '_'
					Result.append_code (l_code)
				elseif l_code <= 0x007f then
					Result.append (hex_strings.item (l_code.as_integer_32 + 1))
				else
					Result.append_code (l_code)
				end
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
			Result_not_contain_name_sep: not Result.has (name_sep)
		end

	decode (a_string: STRING): STRING is
			-- Decode `a_string' to be original one.
		require
			a_string_not_void: a_string /= Void
		local
			i: INTEGER
			l_code, c, hc, lc: NATURAL_32
		do
			create Result.make (a_string.count)
			from
				i := 1
			until
				i > a_string.count
			loop
				l_code := a_string.code (i)
				if l_code = escape_char_code and then a_string.count - i >= 2 then
						i := i + 1
						hc := a_string.code (i)
						i := i + 1
						lc := a_string.code (i)
						c := natural_of_code (hc, lc)
						Result.append_code (c)
				else
					Result.append_code (l_code)
				end
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
		end

	natural_of_code (hc, lc: NATURAL_32): NATURAL_32 is
			-- Natural that comprises of charactors whose code are `hc' and `lc'
		do
			if ('a').natural_32_code <= hc and then hc <= ('f').natural_32_code then
				Result := (hc - ('a').natural_32_code) & 0xf + 10
			elseif ('0').natural_32_code <= hc and then hc <= ('9').natural_32_code then
				Result := (hc - ('0').natural_32_code)
			end
			if ('a').natural_32_code <= lc and then lc <= ('f').natural_32_code then
				Result := (Result |<< 4) | ((lc - ('a').natural_32_code) & 0xf + 10)
			elseif ('0').natural_32_code <= lc and then lc <= ('9').natural_32_code then
				Result := (Result |<< 4) | ((lc - ('0').natural_32_code))
			end
		end

feature {NONE} -- Implementation

	strings: LIST [STRING]
			-- Strings splitted

	uuid_gen: UUID_GENERATOR is
			-- UUID generator
		once
			create Result
		end

invariant
	invariant_clause: True -- Your invariant here

end
