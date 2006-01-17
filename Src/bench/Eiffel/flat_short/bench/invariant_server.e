indexing
	description: "Server for invariants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class INVARIANT_SERVER

inherit
	LINKED_LIST [INVARIANT_ADAPTER]

	SHARED_TEXT_ITEMS
		undefine
			copy, is_equal
		end

create
	make

feature -- Output

	format (ctxt: FORMAT_CONTEXT) is
			-- Format Current in `ctxt'.
		require
			ctxt_not_void: ctxt /= Void
		local
			is_not_first: BOOLEAN
			target_class: CLASS_C
		do
			if not is_empty then
				target_class := ctxt.class_c
				ctxt.set_in_assertion
				ctxt.begin
				ctxt.put_text_item (ti_before_invariant)
				ctxt.put_text_item_without_tabs (ti_invariant_keyword)
				ctxt.indent
				ctxt.put_new_line
				from
					start
				until
					after
				loop
					ctxt.begin
					if target_class /= item.source_class then
						ctxt.indent
						if is_not_first then
							ctxt.put_new_line
						end
						ctxt.put_text_item (ti_dashdash)
						ctxt.put_space
						ctxt.put_comment_text ("from ")
						ctxt.put_classi (item.source_class.lace_class)
						ctxt.exdent
						ctxt.put_new_line
					end
					item.format (ctxt)
					ctxt.put_new_line
					if ctxt.last_was_printed then
						is_not_first := True
						ctxt.commit
					else
						ctxt.rollback
					end
					forth
				end
				if is_not_first then
					ctxt.put_new_line
					ctxt.commit
					ctxt.put_text_item (ti_after_invariant)
				else
					ctxt.rollback
				end
				ctxt.set_not_in_assertion
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
