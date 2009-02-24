note
	description: "[
		Objects representing delayed calls to a function,
		with some arguments possibly still open.
		Notes: Features are the same as those of ROUTINE,
		with `apply' made effective, and the addition
		of `last_result' and `item'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FUNCTION [BASE_TYPE, OPEN_ARGS -> TUPLE create default_create end, RESULT_TYPE]

inherit
	ROUTINE [BASE_TYPE, OPEN_ARGS]
		redefine
			is_equal, copy
		end

feature -- Access

	last_result: detachable RESULT_TYPE
			-- Result of last call, if any.

	item (args: detachable OPEN_ARGS): RESULT_TYPE
			-- Result of calling function with `args' as operands.
		require
			valid_operands: valid_operands (args)
			callable: callable
		local
			l_rout_disp: like rout_disp
			l_spec: like internal_special
			l_result_type: detachable RESULT_TYPE
		do
			set_operands (args)
			clear_last_result
			l_rout_disp := rout_disp
			check l_rout_disp_attached: l_rout_disp /= Void end
			l_result_type ?= l_rout_disp.invoke (target_object, internal_operands)
			if attached {RESULT_TYPE} l_result_type as l_result then
				Result := l_result
			else
				l_spec := internal_special
				if l_spec = Void then
					create l_spec.make (1)
					internal_special := l_spec
				end
				Result := l_spec.item (0)
			end
			if is_cleanup_needed then
				remove_gc_reference
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is associated function the same as the one
			-- associated with `other'?
		do
			Result := Precursor (other) and then
					 equal (last_result, other.last_result)
		end

feature -- Duplication

	copy (other: like Current)
			-- Use same function as `other'.
		do
			Precursor (other)
			last_result := other.last_result
		end

feature -- Basic operations

	apply
			-- Call function with `operands' as last set.
		local
			l_rout_disp: like rout_disp
		do
			l_rout_disp := rout_disp
			check l_rout_disp_attached: l_rout_disp /= Void end
			last_result ?= l_rout_disp.invoke (target_object, internal_operands)
		end

feature -- Obsolete

	eval (args: detachable OPEN_ARGS): RESULT_TYPE
			-- Result of evaluating function for `args'.
		obsolete
			"Please use `item' instead"
		require
			valid_operands: valid_operands (args)
			callable: callable
		do
			Result := item (args)
		end

feature -- Removal

	clear_last_result
			-- Reset content of `last_result' to its default value
		local
			l_result: detachable RESULT_TYPE
		do
			last_result := l_result
		end

feature {NONE} -- Hack

	internal_special: detachable SPECIAL [RESULT_TYPE];
			-- Once per object behavior.

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class FUNCTION

