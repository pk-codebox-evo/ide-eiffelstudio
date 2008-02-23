indexing
	description: "Byte node for object test."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_TEST_BL

inherit
	OBJECT_TEST_B
		rename
			make as make_b,
			register as result_register
		redefine
			analyze,
			free_register,
			generate,
			result_register,
			print_register,
			unanalyze
		end

create
	make

feature {NONE} -- Creation

	make (other: OBJECT_TEST_B)
			-- Create enlarged object from `other'.
		require
			other_attached: other /= Void
		do
			make_b (other.target.enlarged, other.expression.enlarged, other.info)
		end

feature -- C code generation

	analyze is
			-- Analyze reverse assignment
		local
			source_type: TYPE_A
			target_type: TYPE_A
			gen_type: GEN_TYPE_A
		do
				-- The target is always expanded in-line for de-referencing.
				-- Ensure propagation in any generation mode (the propagation
				-- of No_register in workbench mode is prevented to force
				-- expression splitting).
			target.set_register (No_register)
			target.analyze
			info.analyze
			source_type := context.real_type (expression.type)
			target_type := context.creation_type (target.type)
			if not target_type.is_expanded then
				register := target
			elseif source_type.is_reference then
					-- Source might need to be cloned before reattachment.
				create {REGISTER} register.make (expression.c_type)
			else
				create {REGISTER} register.make (target.c_type)
			end
			context.init_propagation;
				-- We won't attempt a propagation of the target if the
				-- target is a reference and the source is a basic type
				-- or an expanded.
			if not target_type.is_none and then not target_type.is_expanded and then source_type.is_expanded then
				expression.propagate (No_register)
				register_for_metamorphosis := True
				create {REGISTER} register.make (target.c_type)
			else
				expression.propagate (register)
				register_propagated := context.propagated
			end
				-- Current needed in the access if target is generic.
			gen_type ?= target_type
			if gen_type /= Void then
				context.add_dftype_current
			end
			expression.analyze
			create result_register.make (boolean_type.c_type)
			expression.free_register
			if register.is_temporary and not register_propagated then
				register.free_register
			end
		end

	free_register
			-- Free the registers.
		do
--			if not register.is_temporary or else register_propagated then
--				register.free_register
--			end
			result_register.free_register
		end

	unanalyze
			-- Unanalyze expression.
		do
			expression.unanalyze
			target.unanalyze
			register := Void
			result_register := Void
		end

	generate is
			-- Generate object test
		local
			buf: GENERATION_BUFFER
			target_type: TYPE_A
			source_type: TYPE_A
			source_class_type: CL_TYPE_A
			target_class_type: CL_TYPE_A
			basic_source_type: BASIC_A
		do
			buf := buffer
			target_type := context.real_type (target.type)
			source_type := context.real_type (expression.type)
				-- First pre-compute the source and put it in the register
				-- so that we can use it inside macro (where the argument is
				-- evaluated more than once).
			expression.generate
			if target_type.is_expanded and source_type.is_none then
					-- Assigning Void to expanded.
				result_value := false_constant
			else
					-- Prepare source of reattachment if required
				if source_type.is_expanded and then target_type.is_reference then
					if source_type.is_basic then
							-- Reattachment of basic type to reference.
						basic_source_type ?= context.real_type (expression.type)
						basic_source_type.metamorphose (register, expression, buf)
						buf.put_character (';')
					else
							-- Reattachment of expanded type to reference.
						buf.put_new_line
						register.print_register
						buf.put_string (" = ")
							-- Call redefined version of `twin'/`cloned'.
						buf.put_string ("RTRCL(")
						expression.print_register
						buf.put_string (gc_rparan_semi_c)
					end
				end
				info.generate_start (buf)
				info.generate_gen_type_conversion (0)
					-- If register was propagated, then the assignment was already
					-- generated by the `generate' call unless the source is not
					-- a simple expression.
				if not (register_propagated and expression.is_simple_expr) and then not register_for_metamorphosis then
					buf.put_new_line
					register.print_register
					buf.put_string (" = ")
					if source_type.is_reference then
							-- Clone object of a boxed expanded type.
						expression.generate_dynamic_clone (expression, source_type)
					elseif source_type.is_true_expanded then
						buf.put_string ("RTRCL")
						buf.put_character ('(')
						expression.print_register
						buf.put_character (')')
					else
						expression.print_register
					end
					buf.put_character (';')
				end
				if target_type.is_none then
						-- Assignment on something of type NONE always fails.
					result_value := false_constant
				elseif target_type.is_expanded then
					if source_type.is_expanded then
							-- NOP if classes are different or normal assignment otherwise.
						source_class_type ?= source_type
						target_class_type ?= target_type
						if
							target_class_type /= Void and then source_class_type /= Void and then
							target_class_type.class_id = source_class_type.class_id
						then
								-- Do normal assignment.
							if target_type.is_basic then
								buf.put_new_line
								target.print_register
								buf.put_string (" = ")
								expression_print_register
								buf.put_character (';')
							else
								buf.put_new_line
								buf.put_string ("memmove(")
								target.print_register
								buf.put_string (gc_comma)
								expression_print_register
								buf.put_string (gc_comma)
								if context.workbench_mode then
									target_class_type.associated_class_type (context.context_class_type.type).skeleton.generate_workbench_size (buf)
								else
									target_class_type.associated_class_type (context.context_class_type.type).skeleton.generate_size (buf)
								end
								buf.put_string (gc_rparan_semi_c)
							end
							result_value := true_constant
						else
							result_value := false_constant
						end
					else
						buf.put_new_line
						if target_type.is_basic then
								-- Attachment to entity of basic type.
							buf.put_string ("RTOB(")
							buf.put_character ('*')
							target.c_type.generate_access_cast (buf)
							buf.put_string (gc_comma)
						else
								-- Attachment to entity of non-basic expanded type.
							buf.put_string ("RTOE(")
						end
						info.generate_type_id (buf, context.final_mode, 0)
						buf.put_string (gc_comma)
						expression_print_register
						buf.put_string (gc_comma)
						target.print_register
						buf.put_string (gc_comma)
						result_register.print_register
						buf.put_string (gc_rparan_semi_c)
						result_value := result_variable
					end
				else
					if source_type.is_expanded and then register = target then
							-- Expanded object is already attached to reference target.
						result_value := true_constant
					else
						buf.put_new_line
						target.print_register
						buf.put_string (" = ")
						buf.put_string ("RTRV(")
						info.generate_type_id (buf, context.final_mode, 0)
						buf.put_string (gc_comma)
						if source_type.is_expanded then
							register.print_register
						else
							expression_print_register
						end
						buf.put_string (gc_rparan_semi_c)
						result_value := target_variable
					end
				end
				info.generate_end (buf)
			end
		end

	print_register
			-- Print register.
		do
			inspect result_value
			when false_constant then
				buffer.put_string ("(EIF_FALSE)")
			when true_constant then
				buffer.put_string ("(EIF_TRUE)")
			when result_variable then
				result_register.print_register
			when target_variable then
				buffer.put_string ("EIF_TEST(")
				target.print_register
				buffer.put_string (")")
			end
		end

feature {NONE} -- C code generation

	expression_print_register
			-- Print register holding the expression value.
		do
			if not (register_propagated and expression.is_simple_expr)
				and not register_for_metamorphosis
			then
				register.print_register
			else
				expression.print_register
			end
		end

	register: REGISTRABLE
			-- Register for temporary values

	register_for_metamorphosis: BOOLEAN
			-- Is register used to held metamorphosed value?

	register_propagated: BOOLEAN
			-- Has target been propagated?

feature {NONE} -- Object test value

	result_register: REGISTER
			-- Register that stores result of an expression

	result_value: NATURAL_8
			-- Value of the expression: one of `false_constant', `true_constant', `register_variable'

	false_constant: NATURAL_8 = 0
			-- Expression statically evaluates to `False'

	true_constant: NATURAL_8 = 1
			-- Expression statically evaluates to `True'

	result_variable: NATURAL_8 = 2
			-- Expression value is stored in a special result register

	target_variable: NATURAL_8 = 3;
			-- Expression value is stored in a target register

indexing
	copyright:	"Copyright (c) 2007-2008, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
