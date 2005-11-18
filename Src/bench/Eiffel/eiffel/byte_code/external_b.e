-- Access to a C external

class EXTERNAL_B

inherit
	CALL_ACCESS_B
		rename
			precursor_type as static_class_type,
			set_precursor_type as set_static_class_type
		redefine
			same, is_external, set_parameters, parameters, enlarged,
			is_unsafe, optimized_byte_node,
			calls_special_features, size,
			pre_inlined_code, inlined_byte_code,
			need_target, is_constant_expression
		end

	SHARED_INCLUDE

	SHARED_IL_CONSTANTS
		rename
			static_type as il_static_type
		export
			{NONE} all
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_external_b (Current)
		end

feature

	type: TYPE_I;
			-- Type of the call

	parameters: BYTE_LIST [PARAMETER_B];
			-- Feature parameters: can be Void

feature -- Attributes for externals

	extension: EXTERNAL_EXT_I
			-- Encapsulation of external extensions

	external_name_id: INTEGER
			-- Name ID of C external.

	external_name: STRING is
			-- Name of C external.
		require
			external_name_id_set: external_name_id > 0
		do
			Result := Names_heap.item (external_name_id)
		ensure
			result_not_void: Result /= Void
			result_not_empty: not Result.is_empty
		end

	encapsulated: BOOLEAN;
			-- Has the feature some assertion declared ?

	is_external: BOOLEAN is True;
			-- Access is an external call

	is_static_call: BOOLEAN
			-- Is current external call made through a static access?

	precursor_type: like static_class_type is
		require
			il_generation: System.il_generation
			not_a_static_call: not is_static_call
		do
			Result := static_class_type
		end

feature -- Status report

	is_constant_expression: BOOLEAN is
			-- Is constant expression?
		local
			l_ext: IL_ENUM_EXTENSION_I
		do
				-- For now only a .NET enum type is constant for an external call.
			l_ext ?= extension
			Result := l_ext /= Void
		end

feature -- Routines for externals

	set_extension (e: like extension) is
			-- Assign `e' to `extension'.
		do
			extension := e
		end;

	set_parameters (p: like parameters) is
			-- Assign `p' to `parameters'.
		do
			parameters := p;
		end;

	set_type (t: TYPE_I) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	enable_static_call is
			-- Set `is_static_call' to `True'.
		do
			is_static_call := True
			set_need_invariant (False)
		ensure
			is_static_call_set: is_static_call
		end

	init (f: FEATURE_I) is
			-- Initialization
		require
			good_argument: f /= Void
			is_valid_feature_for_normal_generation: not System.il_generation implies f.is_external
			is_valid_feature_for_il_generation:
				System.il_generation implies (f.is_external or f.is_attribute or f.is_deferred)
		do
			feature_name_id := f.feature_name_id
			routine_id := f.rout_id_set.first
			if System.il_generation and f.is_c_external then
				feature_id := f.origin_feature_id
				written_in := f.origin_class_id
			else
				feature_id := f.feature_id
				written_in := f.written_in
			end
		end;

	set_external_name_id (id: INTEGER) is
			-- Assign `id' to `external_name_id'.
		require
			valid_id: id > 0
		do
			external_name_id := id
		ensure
			external_name_id_set: external_name_id = id
		end

	set_encapsulated (b: BOOLEAN) is
			-- Assign `b' to `encapsulated'
		do
			encapsulated := b;
		end;

feature {STATIC_ACCESS_AS} -- Settings

	set_written_in (id: INTEGER) is
			-- Set `written_in' to `id'.
		require
			valid_id: id > 0
		do
			written_in := id
		ensure
			written_in_set: written_in = id
		end

feature -- Status report

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			external_b: EXTERNAL_B;
		do
			external_b ?= other;
			if external_b /= Void then
				Result := external_name_id = external_b.external_name_id;
			end;
		end;

	enlarged: EXTERNAL_B is
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		local
			external_bl: EXTERNAL_BL
		do
			if context.final_mode then
				create external_bl
			else
				create {EXTERNAL_BW} external_bl.make
			end;
			external_bl.fill_from (Current)
			Result := external_bl
		end;

feature -- IL code generation

	need_target: BOOLEAN is
			-- Does current call need a target to be performed?
			-- Meaning that it is not a static call.
		local
			il_ext: IL_EXTENSION_I
		do
			if System.il_generation then
				il_ext ?= extension
					-- It can either be a C externals or an IL static external
				Result := il_ext = Void or else need_current (il_ext.type)
			else
				Result := False
			end
		end

	generate_il_creation is
			-- Generate byte code for call to an external creation feature.
		do
			internal_generate_il_call (False, True)
		end

	generate_il_call (invariant_checked: BOOLEAN) is
			-- Generate byte code for call to an external feature.
		do
			internal_generate_il_call (invariant_checked, False)
		end

	generate_il_c_call (inv_checked: BOOLEAN) is
			-- Generate IL code for feature call.
			-- If `invariant_checked' generates invariant check
			-- before call.
		local
			cl_type: CL_TYPE_I
			return_type: TYPE_I
			class_type: CLASS_TYPE
			invariant_checked: BOOLEAN
			class_c: CLASS_C
			real_metamorphose: BOOLEAN
			basic_type: BASIC_I
			need_generation: BOOLEAN
			l_count: INTEGER
		do
				-- Get type on which call will be performed.
			cl_type ?= context_type
			check
				valid_type: cl_type /= Void
			end

				-- Let's find out if we are performing a call on a basic type
				-- or on an enum type. This happens only when we are calling
				-- magically added feature on basic types.
			basic_type ?= cl_type

			class_type := cl_type.associated_class_type
			class_c := class_type.associated_class

			invariant_checked := (context.workbench_mode or class_c.assertion_level.check_invariant)
				and then (not is_first or inv_checked)

			if cl_type.is_expanded then
					-- Current type is expanded. We need to find out if
					-- we need to generate a box operation, meaning that
					-- the feature is inherited from a non-expanded class.
				real_metamorphose := need_real_metamorphose (cl_type)
			end

			if is_first then
					-- First call in dot expression, we need to generate Current
					-- only when we do not call a static feature.
				if cl_type.is_reference then
						-- Normal call, we simply push current object.
					if is_static_call then
							-- Bug fix until we generate direct static access
							-- to C external.
						(create {CREATE_TYPE}.make (il_generator.implemented_type
							(written_in, cl_type))).generate_il
					else
						il_generator.generate_current
					end
				else
					il_generator.generate_current
					if real_metamorphose then
							-- Feature is written in an inherited class of current
							-- expanded class. We need to box.
						il_generator.generate_metamorphose (cl_type)
					end
				end
			elseif cl_type.is_expanded then
					-- A metamorphose is required to perform call.
				generate_il_metamorphose (cl_type, Void, real_metamorphose)
			end

			if invariant_checked then
				generate_il_call_invariant_leading (cl_type, inv_checked)
			end

			if parameters /= Void then
					-- Generate parameters if any.
				parameters.generate_il
				l_count := parameters.count
			end

			return_type := real_type (type)

			need_generation := True

			if need_generation then
					-- Perform call to feature
					-- FIXME: performance problem here since we are retrieving the
					-- FEATURE_TABLE. This could be avoided if at creation of FEATURE_B
					-- node we add the feature_id in the parent class.
				if is_static_call or else precursor_type /= Void then
						-- In IL, if you can call Precursor, it means that parent is
						-- not expanded and therefore we can safely generate a static
						-- call to Precursor feature.
					il_generator.generate_feature_access (
						il_generator.implemented_type (written_in, cl_type),
						feature_id, l_count, not return_type.is_void, False)
				else
					il_generator.generate_feature_access (
						il_generator.implemented_type (written_in, cl_type),
						feature_id, l_count, not return_type.is_void,
						cl_type.is_reference or else real_metamorphose)
				end
				if System.il_verifiable then
					if
						not return_type.is_expanded and then
						not return_type.is_none and then
						not return_type.is_void
					then
						il_generator.generate_check_cast (Void, return_type)
					end
				end
				if invariant_checked then
					generate_il_call_invariant_trailing (cl_type, return_type)
				end
			end
		end

feature {NONE} -- Implementation

	internal_generate_il_call (invariant_checked, is_creation: BOOLEAN) is
			-- Generate byte code for call to an external feature.
		require
			il_generation: system.il_generation
		local
			cl_type: CL_TYPE_I
			il_ext: IL_EXTENSION_I
			real_metamorphose: BOOLEAN
			real_target: like target
		do
			if not extension.is_il then
					-- Generate call to C external.
				generate_il_c_call (invariant_checked)
			else
				il_ext ?= extension
					-- Type of object on which we are performing call to Current.
				cl_type ?= context_type

				check
					il_ext_not_void: il_ext /= Void
					cl_type_not_void: cl_type /= Void
				end

				if cl_type.is_expanded then
						-- Current type is expanded. We need to find out if
						-- we need to generate a box operation, meaning that
						-- the feature is inherited from a non-expanded class.
					real_metamorphose := need_real_metamorphose (cl_type)
				end

				if is_first and then need_current (il_ext.type) then
						-- First call in dot expression, we need to generate Current
						-- only when we do not call a static feature.
					if cl_type.is_reference then
							-- Normal call, we simply push current object.
						il_generator.generate_current
					else
						if real_metamorphose then
								-- Feature is written in an inherited class of current
								-- expanded class. We need to box.
							il_generator.generate_metamorphose (cl_type)
						end
					end
				elseif cl_type.is_expanded then
						-- No need to do anything special in case of a call to
						-- a constructor. The generation of `target' of current call already
						-- did any special transformation to perfom call.
						-- Same goes with `operators' as the result of the previous
						-- call will be used as target of the current one.
					if
						il_ext.type /= creator_type and
						il_ext.type /= operator_type and parent /= Void
					then
						if is_message then
							real_target := parent.target
						else
							if parent.parent = Void then
								real_target := parent.target
							else
								real_target := parent.parent.target
							end
						end
						if real_target.is_predefined or real_target.is_attribute then
								-- For same reason we don't do anything for a call to
								-- a constructor, when `real_target' is predefined or is
								-- an attribute any special transformation have already been done.
							if real_metamorphose then
									-- Feature is written in an inherited class of current
									-- expanded class. We need to box.
								il_generator.generate_metamorphose (cl_type)
							end
						else
								-- In all other cases we will generate the metamorphose.
							if written_in = cl_type.class_id then
--								generate_il_metamorphose (cl_type, cl_type, real_metamorphose)
							else
								generate_il_metamorphose (cl_type, Void, real_metamorphose)
							end
						end
					end
				end

				if parameters /= Void then
						-- Generate parameters if any.
					parameters.generate_il
				end

				if is_creation or else il_ext.type /= creator_type then
						-- We are not performing a creation call, neither a call
						-- to a constructor.
					if is_static_call or else precursor_type /= Void then
							-- A call to precursor or a static call is never polymorphic.
						il_ext.generate_call (False)
					else
							-- Standard call to an external feature.
							-- Call will be polymorphic if it target of call is a reference
							-- or if target has been boxed, or if type of external
							-- forces a static binding (eg static features).
						il_ext.generate_call (cl_type.is_reference or else real_metamorphose)
					end
				else
						-- Current external is a creation, we perform a slightly different
						-- call to constructor, but basically it is very close to `generate_call'
						-- but doing a static binding.
					il_ext.generate_creation_call
				end
			end
		end

feature -- Array optimization

	is_unsafe: BOOLEAN is
		do
				-- An external call can have access to the entire system
				-- and move. resize objects. Thus it is unsafe to call
				-- an external feature.
			Result := True
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			if parameters /= Void then
				parameters := parameters.optimized_byte_node
			end
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			if parameters /= Void then
				Result := parameters.calls_special_features (array_desc)
			end
		end

feature -- Inlining

	size: INTEGER is
		do
			if parameters /= Void then
				Result := 1 + parameters.size
			else
				Result := 1
			end
		end

	pre_inlined_code: CALL_B is
		local
			inlined_current_b: INLINED_CURRENT_B
		do
			if parent /= Void then
				Result := Current
			else
				create parent;

				create inlined_current_b;
				parent.set_target (inlined_current_b);
				inlined_current_b.set_parent (parent);

				parent.set_message (Current);

				Result := parent;
			end
			type := real_type (type)
			if static_class_type /= Void then
				static_class_type ?= real_type (static_class_type)
			end
			if parameters /= Void then
				parameters := parameters.pre_inlined_code
			end
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			type := real_type (type)
			if static_class_type /= Void then
				static_class_type ?= real_type (static_class_type)
			end
			if parameters /= Void then
				parameters := parameters.inlined_byte_code
			end
		end

end
