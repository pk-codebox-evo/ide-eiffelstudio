indexing

	description: 
		"Representation of a eiffel class.";
	date: "$Date$";
	revision: "$Revision $"

class E_CLASS

inherit

	TOPOLOGICAL
		rename
			successors as descendants
		end;
	IDABLE;
	PROJECT_CONTEXT;
	SHARED_WORKBENCH;
	SHARED_SERVER
		export
			{ANY} all
		end;
	SHARED_INSTANTIATOR;
	SHARED_INST_CONTEXT

creation

	make
	
feature -- Initialization

	make (l: CLASS_I) is
			-- Creation
		require
			good_argument: l /= Void;
		do
			lace_class := l;
				-- Creation of the descendant list
			!! descendants.make;
				-- Creation of the supplier list
			!! suppliers.make;
				-- Creation of the client list
			!! clients.make;
				-- Types list creation
			!! types.make;
		end;

feature -- Properties

	id: INTEGER;
			-- Class id

	lace_class: CLASS_I;
			-- Lace class (class type to be changed to E_CLASS)

	parents: FIXED_LIST [CL_TYPE_A];
			-- Parent classes

	descendants: LINKED_LIST [E_CLASS];
			-- Direct descendants of the current class

	clients: LINKED_LIST [E_CLASS];
			-- Clients of the class

	suppliers: SUPPLIER_LIST;
			-- Suppliers of the class in terms of calls
			-- [Useful for incremental type check].

	generics: EIFFEL_LIST [FORMAL_DEC_AS] is
			-- Formal generical parameters
		do
			Result := private_generics
		end;

	topological_id: INTEGER;
			-- Unique number for a class. Could change during a topological
			-- sort on classes.

	reverse_engineered: BOOLEAN;
			-- Does the Storage mechanism for EiffelCase need
			-- to regenerate the EiffelCase description for Current class?

	is_deferred: BOOLEAN;
			-- Is the class deferred ?

	is_expanded: BOOLEAN;
			-- Is the class expanded ?

	obsolete_message: STRING;
			-- Obsolete message
			-- (Void if Current is not obsolete)

	is_debuggable: BOOLEAN is
			-- Is the class able to be debugged?
			-- (not if it doesn't have class types 
			-- or is a special class)
		do
			Result := class_is_debuggable and then	
				has_types
		end;

	name: STRING is
			-- Raw class name
		do
			Result := lace_class.class_name
		end;

	text: STRING is
			-- Class text
		require
			valid_file_name: file_name /= Void
		do
			Result := lace_class.text
		end;

feature -- Access

	name_in_upper: STRING is
			-- Class name in upper case
		do
			Result := clone (name);
			Result.to_upper
		end;

	ast: CLASS_AS is
			-- Associated AST structure
		do
			if Ast_server.has (id) then
				Result := Ast_server.item (id);
			elseif Tmp_ast_server.has (id) then
				Result := Tmp_ast_server.item (id);
			end;
		ensure
			non_void_result_if: has_ast implies Result /= Void 
		end;

	has_types: BOOLEAN is
			-- Are there any generic instantiations of Current
			-- in the system or is Current a non generic class?
		do
			Result :=
					(types /= Void) and then (not types.empty)
		end;

	is_obsolete: BOOLEAN is
			-- Is Current feature obsolete?
		do
			Result := obsolete_message /= Void
		end;

	feature_with_name (n: STRING): E_FEATURE is
			-- Feature whose internal name is `n'
		require
			valid_n: n /= Void;
			has_feature_table: has_feature_table
		local
			f: FEATURE_I
		do
			f := comp_feature_table.item (n);
			if f /= Void then
				Result := f.api_feature
			end
		end;

	feature_with_body_id (bid: INTEGER): E_FEATURE is
			-- Feature whose body id `bid'.
		require
			valid_body_id: bid > 0;
			has_feature_table: has_feature_table
		local
			feat: FEATURE_I
		do
			feat := comp_feature_table.feature_of_body_id (bid);
			if feat /= Void then
				Result := feat.api_feature
			end
		end;

	feature_with_rout_id (rout_id: ROUTINE_ID): E_FEATURE is
			-- Feature whose routine id `rout_id'.
		require
			valid_rout_id: rout_id /= Void;
			has_feature_table: has_feature_table
		local
			feat: FEATURE_I
		do
			feat := comp_feature_table.origin_table.item (rout_id);
			if feat /= Void then
				Result := feat.api_feature
			end
		end;

	feature_table: E_FEATURE_TABLE is	
			-- Feature table for current class
		require
			has_feature_table: has_feature_table
		do
			Result := comp_feature_table.api_table
		ensure
			valid_result: Result /= Void
		end;

	once_functions: SORTED_TWO_WAY_LIST [E_FEATURE] is
			-- List of once functions
		local
			f_table: FEATURE_TABLE;
			feat: FEATURE_I
		do
			!! Result.make;
			f_table := comp_feature_table;
			from
				f_table.start
			until
				f_table.after
			loop
				feat := f_table.item_for_iteration;
				if feat.is_once and then feat.is_function then
					Result.put_front (feat.api_feature)
				end
				f_table.forth
			end;
			Result.sort
		ensure
			non_void_result: Result /= Void;
			result_sorted: Result.sorted
		end;

feature -- Precompilation Access

	is_precompiled: BOOLEAN is
		do	
			Result := id <= System.max_precompiled_id
		end;

feature -- Server Access

	has_ast: BOOLEAN is
			-- Does Current class have an AST structure?
		do
			Result := Ast_server.has (id) or else
				Tmp_ast_server.has (id)
		end;

	has_feature_table: BOOLEAN is
			-- Does Current class have a feature table?
		do
			Result := Feat_tbl_server.has (id)
		end;

	click_list: CLICK_LIST is
		require
			has_ast: has_ast
		local
			ast_clicks: CLICK_LIST
		do
			if Tmp_ast_server.has (id) then
				Result := Tmp_ast_server.item (id).click_list
			else
				Result := Ast_server.item (id).click_list
			end;
		end;

	cluster: CLUSTER_I is
			-- Cluster to which the class belongs to
		do
			Result := lace_class.cluster
		end;

	hidden: BOOLEAN is
			-- Is the class hidden in the precompilation sets?
		do
			Result := lace_class.hidden
		ensure
			hide_only_when_precompiled: Result implies is_precompiled
		end;

	file_name: STRING is
			-- FIle name of the class
		do
			Result := lace_class.file_name
		end;

feature -- Comparison

	infix "<" (other: E_CLASS): BOOLEAN is
			-- Order relation on classes
		do
			Result := topological_id < other.topological_id;
		end;

feature -- Output

	signature: STRING is
			-- Signature of class
		local
			formal_dec: FORMAL_DEC_AS_B;
			constraint_type: TYPE_B;
			error: BOOLEAN;
			old_cluster: CLUSTER_I;
			gens: like private_generics
		do
			if not error then
				old_cluster := Inst_context.cluster;
				Inst_context.set_cluster (cluster);
				!!Result.make (50);
				Result.append (name);
				gens := private_generics;
				if gens /= Void then
					Result.append (" [");
					from
						gens.start
					until
						gens.after
					loop
						formal_dec := gens.item;
						Result.append (formal_dec.formal_name);
						constraint_type := formal_dec.constraint;
						if constraint_type /= Void then
							Result.append (" -> ");
							Result.append (constraint_type.dump)
						end;
						gens.forth;
						if not gens.after then
							Result.append (", ")
						end
					end;
					Result.append ("]")
				end;
				Result.to_upper;
				Inst_context.set_cluster (old_cluster);
			end;
		end;

	append_signature (ow: OUTPUT_WINDOW) is
			-- Append the signature of current class in `ow'
		require
			non_void_ow: ow /= Void
		local
			formal_dec: FORMAL_DEC_AS_B;
			constraint_type: TYPE_B;
			c_name: STRING;
			error: BOOLEAN;
			old_cluster: CLUSTER_I;
			gens: like private_generics
		do
			if not error then
				old_cluster := Inst_context.cluster;
				Inst_context.set_cluster (cluster);
				append_name (ow);
				gens := private_generics;
				if gens /= Void then
					ow.put_string (" [");
					from
						gens.start
					until
						gens.after
					loop
						formal_dec := gens.item;
						c_name := clone (formal_dec.formal_name);
						c_name.to_upper;
						ow.put_string (c_name);
						constraint_type := formal_dec.constraint;
						if constraint_type /= Void then
							ow.put_string (" -> ");
							constraint_type.append_to (ow)
						end;
						gens.forth;
						if not gens.after then
							ow.put_string (", ");
						end;
					end;
					ow.put_char (']');
				end;
				Inst_context.set_cluster (old_cluster);
			end;
		end;

	append_name (ow: OUTPUT_WINDOW) is
			-- Append the name ot the current class in `ow'
		require
			non_void_ow: ow /= Void
		local
			c_name: STRING;
		do
			c_name := clone (name)
			c_name.to_upper;
			ow.put_class (Current, c_name)
		end;

feature {COMPILER_EXPORTER} -- Implementation

	class_is_debuggable: BOOLEAN;
			-- Is the class debuggable

	compiled_info: CLASS_C;
			-- Information for compiling Current eiffel class

feature {CLASS_C} -- Implementation

	private_generics: EIFFEL_LIST_B [FORMAL_DEC_AS_B];
			 -- Formal generical parameters

	set_compiled_info (c: like compiled_info) is
		do
			compiled_info := c
		end;

	set_is_debuggable (b: BOOLEAN) is
			-- Set `class_is_debuggable' to `b'
		do
			class_is_debuggable := b
		end;

feature {CLASS_C, CLASS_SORTER} -- Setting

	set_topological_id (i: INTEGER) is
			-- Assign `i' to `topological_id'.
		do
			topological_id := i;
		end;

	set_is_deferred (b: BOOLEAN) is
			-- Assign `b' to `is_deferred'.
		do
			is_deferred := b;
		end;

	set_is_expanded (b: BOOLEAN) is
			-- Assign `b' to `is_expanded'.
		do
			is_expanded := b;
		end;

	set_id (i: INTEGER) is
			-- Assign `i' to `id'.
		do
			id := i;
		end;

	set_parents (p: like parents) is
			-- Assign `p' to `parents'.
		do
			parents := p
		end;

	set_suppliers (s: like suppliers) is
			-- Assign `s' to `suppliers'.
		do
			suppliers := s
		end;

	set_generics (g: like private_generics) is
			-- Assign `g' to `generics'.
		do
			private_generics := g
		end;

	set_reverse_engineered (b: BOOLEAN) is
			-- Set reversed_engineered to `b'.
		do
			reverse_engineered := b
		ensure
			reverse_engineered_set: reverse_engineered = b
		end;

	set_obsolete_message (m: like obsolete_message) is
			-- Set `obsolete_message' to `m'.
		do
			obsolete_message := m
		end;

feature {COMPILER_EXPORTER} -- Implementation

	types: TYPE_LIST;
			-- Meta-class types associated to the class: it contains
			-- only one type if the class is not generic

feature {NONE} -- Implementation

	comp_feature_table: FEATURE_TABLE is
			-- Compiler feature table
		require
			has_feature_table: Feat_tbl_server.has (id)
		do
			Result := Feat_tbl_server.item (id)
		ensure
			valid_result: Result /= Void
		end;

invariant

	lace_class_exists: lace_class /= Void;

end -- class E_CLASS
