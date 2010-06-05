indexing
	component:   "openEHR Archetype Project"
	description: "[
				 Object Graph Tree iterator. This iterator currently supplies the standard 'do_all'
				 function which performs an action on entry to each node, descends, and then performs
				 an action on exiting each node; there are two agent actions supplied: node_enter_action
				 and node_exit_action. This allows signficantly more power than just a single action per 
				 node type.
				 
				 It also supports a more esoteric iteration function called do_at_surface, which iterates
				 from the top until a 'surface' of nodes is hit (which test true according to the supplied
				 'is_at_surface' agent); performs a single action to each such node, and does not continue
				 past these nodes.
				 ]"
	keywords:    "object graph, recursive iterator"
	author:      "Thomas Beale"
	support:     "Ocean Informatics <support@OceanInformatics.biz>"
	copyright:   "Copyright (c) 2003,2004 Ocean Informatics Pty Ltd"
	license:     "See notice at bottom of class"

	file:        "$URL: http://www.openehr.org/svn/ref_impl_eiffel/TRUNK/libraries/common_libs/src/structures/object_graph/og_iterator.e $"
	revision:    "$LastChangedRevision$"
	last_change: "$LastChangedDate$"

class OG_ITERATOR

create
	make

feature -- Initialisation

	make(a_target: OG_OBJECT_NODE) is
		require
			a_target /= Void
		do
			target := a_target
		end

feature -- Access

	target: OG_OBJECT_NODE

feature -- Traversal

	do_all(node_enter_action, node_exit_action: PROCEDURE[ANY, TUPLE[OG_ITEM, INTEGER]]) is
			-- do enter_action and exit_action to all nodes in the structure
		require
			Enter_action_valid: node_enter_action /= Void
			Exit_action_valid: node_exit_action /= Void
		do
			depth := 0
			do_all_nodes(target, node_enter_action, node_exit_action)
		end

	do_at_surface(node_action: PROCEDURE[ANY, TUPLE[OG_ITEM, INTEGER]]; node_is_included: FUNCTION[ANY, TUPLE[OG_ITEM], BOOLEAN]) is
			-- Do action only to nodes at surface, where membership is defined by `node_is_included'.
		require
			Node_action_valid: node_action /= Void
			Surface_test_action_valid: node_is_included /= Void
		do
			do_at_surface_nodes(target, node_action, node_is_included)
		end

	do_until_surface(node_action: PROCEDURE[ANY, TUPLE[OG_ITEM, INTEGER]]; node_is_included: FUNCTION[ANY, TUPLE[OG_ITEM], BOOLEAN]) is
			-- Do action only to nodes from top until surface (inclusive), where membership is defined by `node_is_included'.
		require
			Node_action_valid: node_action /= Void
			Surface_test_action_valid: node_is_included /= Void
		do
			do_until_surface_nodes(target, node_action, node_is_included)
		end

feature {NONE} -- Implementation

	do_all_nodes(a_target: OG_NODE; node_enter_action, node_exit_action: PROCEDURE[ANY, TUPLE[OG_ITEM, INTEGER]]) is
		require
			Target_exists: a_target /= Void
		local
			a_node: OG_NODE
		do
			depth := depth + 1
			node_enter_action.call([a_target, depth])
			from
				a_target.start
			until
				a_target.off
			loop
				a_node ?= a_target.item_for_iteration
				if a_node /= Void then
					do_all_nodes(a_node, node_enter_action, node_exit_action)
				else -- terminal child node
					node_enter_action.call([a_target.item_for_iteration, depth+1])
					node_exit_action.call([a_target.item_for_iteration, depth+1])
				end

				a_target.forth
			end
			node_exit_action.call([a_target, depth])
			depth := depth - 1
		end

	do_at_surface_nodes(a_target: OG_NODE; node_action: PROCEDURE[ANY, TUPLE[OG_ITEM, INTEGER]]; node_is_at_surface: FUNCTION[ANY, TUPLE[OG_ITEM], BOOLEAN]) is
			-- Do action only to nodes at surface, where membership is defined by `node_is_at_surface'.
		require
			Target_exists: a_target /= Void
		local
			a_node: OG_NODE
		do
			if node_is_at_surface.item([a_target]) then
				node_action.call([a_target, 0])
			else -- haven't hit the surface yet, descend...
				from
					a_target.start
				until
					a_target.off
				loop
					a_node ?= a_target.item_for_iteration
					if a_node /= Void then
						do_at_surface_nodes(a_node, node_action, node_is_at_surface)
					else -- terminal child node
						if node_is_at_surface.item ([a_target.item_for_iteration]) then
							node_action.call([a_target.item_for_iteration, 0])
						end
					end
					a_target.forth
				end
			end
		end

	do_until_surface_nodes(a_target: OG_NODE; node_action: PROCEDURE[ANY, TUPLE[OG_ITEM, INTEGER]]; node_is_included: FUNCTION[ANY, TUPLE[OG_ITEM], BOOLEAN]) is
			-- Do action only to nodes from top down to surface, where membership is defined by `node_is_included'.
		require
			Target_exists: a_target /= Void
		local
			a_node: OG_NODE
		do
			if node_is_included.item([a_target]) then
				node_action.call([a_target, 0])
				from
					a_target.start
				until
					a_target.off
				loop
					a_node ?= a_target.item_for_iteration
					if a_node /= Void then
						do_until_surface_nodes(a_node, node_action, node_is_included)
					else -- terminal child node
						if node_is_included.item ([a_target.item_for_iteration]) then
							node_action.call([a_target.item_for_iteration, 0])
						end
					end
					a_target.forth
				end
			end
		end

	depth: INTEGER

invariant
	target_exists: target /= Void

end


--|
--| ***** BEGIN LICENSE BLOCK *****
--| Version: MPL 1.1/GPL 2.0/LGPL 2.1
--|
--| The contents of this file are subject to the Mozilla Public License Version
--| 1.1 (the 'License'); you may not use this file except in compliance with
--| the License. You may obtain a copy of the License at
--| http://www.mozilla.org/MPL/
--|
--| Software distributed under the License is distributed on an 'AS IS' basis,
--| WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
--| for the specific language governing rights and limitations under the
--| License.
--|
--| The Original Code is cadl_tree_iterator.e.
--|
--| The Initial Developer of the Original Code is Thomas Beale.
--| Portions created by the Initial Developer are Copyright (C) 2003-2004
--| the Initial Developer. All Rights Reserved.
--|
--| Contributor(s):
--|
--| Alternatively, the contents of this file may be used under the terms of
--| either the GNU General Public License Version 2 or later (the 'GPL'), or
--| the GNU Lesser General Public License Version 2.1 or later (the 'LGPL'),
--| in which case the provisions of the GPL or the LGPL are applicable instead
--| of those above. If you wish to allow use of your version of this file only
--| under the terms of either the GPL or the LGPL, and not to allow others to
--| use your version of this file under the terms of the MPL, indicate your
--| decision by deleting the provisions above and replace them with the notice
--| and other provisions required by the GPL or the LGPL. If you do not delete
--| the provisions above, a recipient may use your version of this file under
--| the terms of any one of the MPL, the GPL or the LGPL.
--|
--| ***** END LICENSE BLOCK *****
--|
