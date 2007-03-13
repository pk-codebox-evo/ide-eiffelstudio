indexing
	description	: "superclass for the ast visitors in ballet"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
   BPL_VISITOR

inherit

	AST_ROUNDTRIP_ITERATOR
		redefine
			process_feature_as,
			process_symbol_as
		end

	SHARED_BPL_ENVIRONMENT

feature{NONE} -- Initialization

	make (a_class: CLASS_C) is
			-- Class to process.
		require
			not_void: a_class /= Void
		do
			create factory
			current_class := a_class
		ensure
			class_set: current_class = a_class
		end

feature -- Access

	current_class: CLASS_C
			-- Current class

	current_feature: FEATURE_I
			-- Current feature

feature -- Setup

	set_current_class (a_class: CLASS_C) is
			-- Set the `current_class' to `a_class'.
		require
			not_void: a_class /= Void
		do
			current_class := a_class
		ensure
			value_set: current_class = a_class
		end

	set_current_feature (a_feature: FEATURE_I) is
			-- Set the `current_feature' to `a_feature'.
		do
			current_feature := a_feature
		ensure
			value_set: current_feature = a_feature
		end

feature -- Processing

	process_feature_as (l_as: FEATURE_AS) is
		do
			current_feature := current_class.feature_named (l_as.feature_name)
			Precursor (l_as)
			current_feature := Void
		end

	process_symbol_as (l_as: SYMBOL_AS) is
			-- Do nothing here (causes problems).
		do

		end


feature -- Helper

	type_for (l_as: EXPR_AS): TYPE_A is
			-- Type for `l_as'.
		require
			has_current_feature: current_feature /= Void
			not_void: l_as /= Void
		local
			ntf: NULL_TEXT_FORMATTER
			tfd: TEXT_FORMATTER_DECORATOR
			ados: BPL_AST_TYPE_INFERER
			routine: ROUTINE_AS
		do
			create ntf
			create tfd.make_for_appending (ntf)
			create ados.make (tfd)
			ados.set_current_class (current_class)
			ados.set_current_feature (current_feature)
			ados.reset_last_class_and_type
			ados.reset_locals
			ados.set_source_class (current_class)
			routine ?= current_feature.body.body.content
			if routine /= Void and then routine.locals /= Void then
				ados.set_processing_locals (True)
				routine.locals.process (ados)
				ados.set_processing_locals (False)
			end
			Result := ados.expr_type (l_as)
			check
				no_error: not ados.has_error
			end
		ensure
			not_void: Result /= Void
		end

	nested_as_to_nested_expr_as (a_nested_as: NESTED_AS): NESTED_EXPR_AS is
			-- Transform a NESTED_AS subtree into a NESTED_EXPR_AS subtree
		require
			not_void: a_nested_as /= Void
		local
			sub_n: NESTED_AS
			sub_ne: NESTED_EXPR_AS
			new_expr: EXPR_CALL_AS
		do
			sub_n ?= a_nested_as.message
			new_expr := factory.new_expr_call_as (a_nested_as.target)
			if sub_n /= Void then
				sub_ne := nested_as_to_nested_expr_as (sub_n)
				Result := prefix_expression (new_expr,sub_ne)
			else
				Result := factory.new_nested_expr_as (new_expr,a_nested_as.message,a_nested_as.dot_symbol,Void,Void)
			end
		ensure
			not_void: Result /= Void
		end

	prefix_expression (e: EXPR_CALL_AS; ne: NESTED_EXPR_AS): NESTED_EXPR_AS is
			-- Prefix the call of `ne' with a target `e'.
		local
			sub_ne: NESTED_EXPR_AS
			new_expr: EXPR_CALL_AS
		do
			sub_ne ?= ne.target
			if sub_ne /= Void then
				new_expr := factory.new_expr_call_as (prefix_expression (e,sub_ne))
				Result := factory.new_nested_expr_as (new_expr, ne.message, Void, Void, Void)
			else
				new_expr ?= ne.target
				check
					must_be_expr_call: new_expr /= Void
				end
				sub_ne := factory.new_nested_expr_as (e,new_expr.call, Void, Void, Void)
				new_expr := factory.new_expr_call_as (sub_ne)
				Result := factory.new_nested_expr_as (new_expr,ne.message, Void, Void, Void)
			end
		end

	factory: AST_FACTORY

	location_info (pos: AST_EIFFEL; tag: STRING): STRING is
			-- The information tag for `x'.
		do
			Result := "// eiffel:"
			Result.append (current_class.name)
			Result.append (";")
			Result.append (pos.start_location.line.out)
			Result.append (";")
			Result.append (pos.start_location.column.out)
			Result.append (";")
			Result.append (pos.end_location.line.out)
			Result.append (";")
			Result.append (pos.end_location.column.out)
			Result.append (";")
			if tag /= Void then
				Result.append (tag)
			end
			Result.append ("%N")
		end


invariant
	factory_exists: factory /= Void

indexing
	copyright:	"Copyright (c) 2006, Raphael Mack and Bernd Schoeller"
	license:	"GPL version 2 or later"
	copying: "[

             This program is free software; you can redistribute it and/or
             modify it under the terms of the GNU General Public License as
             published by the Free Software Foundation; either version 2 of
             the License, or (at your option) any later version.
             
             This program is distributed in the hope that it will be useful,
             but WITHOUT ANY WARRANTY; without even the implied warranty of
             MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
             GNU General Public License for more details.
             
             You should have received a copy of the GNU General Public
             License along with this program; if not, write to the Free Software
             Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
             MA 02110-1301  USA

		]"

end -- class BPL_VISITOR
