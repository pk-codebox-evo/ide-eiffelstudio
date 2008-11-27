indexing
	description: "Objects that keep a reference to the debug value indexed by address..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUG_VALUE_KEEPER

inherit
	ICOR_EXPORTER

create {SHARED_DEBUG_VALUE_KEEPER}
	make

feature {NONE} -- Initialization

	make is
		do
			initialize
		end

feature {EIFNET_EXPORTER, APPLICATION_EXECUTION_DOTNET, DEBUGGER_MANAGER} -- Operation

	initialize is
		do
			create debug_value_kept.make (10)
			debug_value_kept.compare_objects
		end

	terminate is
		do
			recycle
		end

	recycle is
		do
			if debug_value_kept /= Void then
				debug_value_kept.wipe_out
			end
		end

feature -- Change

	keep (dv: ABSTRACT_DEBUG_VALUE) is
		require
			dv /= Void
		local
			ddv: EIFNET_ABSTRACT_DEBUG_VALUE
		do
			ddv ?= dv
			if ddv /= Void then
				keep_dotnet_value (ddv)
			end
		end

	keep_dotnet_value (ddv: EIFNET_ABSTRACT_DEBUG_VALUE) is
		require
			ddv /= Void
		local
			l_address: DBG_ADDRESS
		do
			l_address := ddv.address
			if l_address /= Void then
				if debug_value_kept /= Void then
					if not debug_value_kept.has (l_address) then
						debug_value_kept.put (ddv, l_address)
					end
				end
			end
		end

feature -- Access

	know_about (l_k: DBG_ADDRESS): BOOLEAN is
			-- Has a Debug Value object address by `l_k'
		do
			if debug_value_kept /= Void then
				if debug_value_kept.valid_key (l_k) then
					Result := debug_value_kept.has (l_k)
				end
			end
		end

	item (l_k: DBG_ADDRESS): ABSTRACT_DEBUG_VALUE is
			-- Refreshed debug value object address by `l_k'.
		require
			know_about (l_k)
		do
			Result := raw_item (l_k, True)
		ensure
			Result /= Void
		end

	raw_item (l_k: DBG_ADDRESS; a_refresh_requested: BOOLEAN): ABSTRACT_DEBUG_VALUE is
			-- Debug Value object address by `l_k'
			-- refreshed if `a_refresh_requested' is True.
		require
			know_about (l_k)
		do
			Result := debug_value_kept.item (l_k)
			if a_refresh_requested then
				Result.reset_children
			end
		ensure
			result_not_void: Result /= Void
		end

feature {SHARED_DEBUG_VALUE_KEEPER} -- Implementation

	keep_only (l_addresses: LIST [DBG_ADDRESS]) is
			-- Clean all the value except the one from l_addresses
		local
			l_add: DBG_ADDRESS
			l_val: like item
		do
			if debug_value_kept /= Void then
				from
					debug_value_kept.start
				until
					debug_value_kept.after
				loop
					l_add := debug_value_kept.key_for_iteration
					if l_addresses = Void or else not l_addresses.has (l_add) then
						debug_value_kept.remove (l_add)
					else
						l_val := debug_value_kept.item_for_iteration
						if l_val /= Void then
							l_val.reset_children
						end
						debug_value_kept.forth
					end
				end
			end
		end

feature {NONE} -- restricted access

	debug_value_kept: HASH_TABLE [ABSTRACT_DEBUG_VALUE, DBG_ADDRESS]
			-- Debug value indexed by `dbg_address'

;indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
