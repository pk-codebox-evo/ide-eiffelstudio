note
	description: "[
		A {XP_TAG_ELEMENT} is generated by parsing a "xeb"-file. {XP_TAG_ELEMENT}s
		are combined to trees.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XP_TAG_ELEMENT

inherit
	XU_STRING_MANIPULATION
		redefine
			out
		end

create
	make, make_empty

feature {NONE} -- Initialization

	make (a_namespace: STRING; a_id: STRING; a_class_name: STRING; a_debug_information: STRING)
			-- Creates a XP_TAG_ELEMENT with the specified attributes. No children and no parameters
			-- `a_namespace': The namespace of the the tag
			-- `a_id': The id of the the tag
			-- `a_class_name': The name of the corresponding TAG-class
			-- `a_debug_information': Debug information for the backtrack to the original file
		require
			a_namespace_attached: a_namespace /= Void
			a_id_attached: a_id /= Void
			a_class_name_attached: a_class_name /= Void
			a_debug_information_attached: a_debug_information /= Void
			a_id_valid: not a_id.is_empty
			a_class_name_is_valid: not a_class_name.is_empty
		do
			namespace := a_namespace
			class_name := a_class_name
			id := a_id
			controller_id := ""
			create {ARRAYED_LIST [XP_TAG_ELEMENT]} children.make (3)
			create {HASH_TABLE [XP_TAG_ARGUMENT, STRING]} parameters.make (3)
			debug_information := a_debug_information
		ensure
			controller_id_attached: controller_id /= Void
			debug_information_attached: debug_information /= Void
			class_name_attached: class_name /= Void
			parameters_attached: parameters /= Void
			children_attached: attached children
			id_attached: attached id
			namespace_attached: attached namespace
		end

	make_empty
			-- Creates a new empty {XP_TAG_ELEMENT} with
			-- default values (namespace, id, class_name, debug_info)
		do
			make ("namespace", "id", "class_name", "debug_info")
		ensure
			controller_id_attached: controller_id /= Void
			debug_information_attached: debug_information /= Void
			class_name_attached: class_name /= Void
			parameters_attached: parameters /= Void
			children_attached: attached children
			id_attached: attached id
			namespace_attached: attached namespace
		end

feature -- Access

	date: INTEGER assign set_date
			-- The timestamp of the corresponding file

	retrieve_value (a_id: STRING): detachable XP_TAG_ARGUMENT
			-- Retrieves the value of the parameter with the the id `a_id'
			-- `a_id': The id of the attribute
		require
			a_id_attached: a_id /= Void
		do
			Result := parameters [a_id]
		ensure
			attached_result: attached Result
		end

	controller_id: STRING assign set_controller_id
			-- The id of the controller which should be used

	id: STRING
			-- The tag id

	children: LIST [XP_TAG_ELEMENT] assign set_children
			-- All the children of the tag

feature {NONE} -- Access

	parameters: HASH_TABLE [XP_TAG_ARGUMENT, STRING]
			-- The parameters of the tag [value, parameter id]

	class_name: STRING
			-- The name of the corresponding {XTAG_TAG_SERIALIZER}-class

	debug_information: STRING
			-- Debug information (row and column in the xeb file)	

	namespace: STRING
			-- The namespace (tag library) of the tag

feature -- Status report

	has_attribute (a_name: STRING): BOOLEAN
			-- Does the tag already have an attribute with the id `name'
			-- `a_name': The name to be checked
		require
			a_name_attached: a_name /= Void
		do
			Result := attached parameters [a_name]
		end

	has_children: BOOLEAN
			-- Are there any children?
		do
			Result := not children.is_empty
		end

feature -- Status setting

	set_date (a_date: like date)
			-- Sets the date.
		do
			date := a_date
		ensure
			date_set: date = a_date
		end

	set_controller_id (a_id: like controller_id)
			-- Sets the controller id.
		require
			a_id_attached: a_id /= Void
		do
			controller_id := a_id
		ensure
			controller_id_set: controller_id = a_id
		end

	set_parameters (a_parameters: like parameters)
			-- Sets the parameters.
		require
			a_parameters_valid: a_parameters /= Void
		do
			parameters := a_parameters
		end

	set_children (a_children: like children)
			-- Sets the children.
		do
			children := a_children
		end

	replace_children_by (a_child: XP_TAG_ELEMENT)
			-- Empties the children list and adds `a_child' as unique child
			-- `a_child': The child to be replaced
		do
			children.wipe_out
			children.extend (a_child)
		ensure
			not_more_than_one_child: children.count = 1
		end

feature --Basic Implementation

	extend_tag (a_child: XP_TAG_ELEMENT)
			-- Adds a tag to the list of children.
			-- `a_child': The child to be added to the list of children
		require
			a_child_attached: a_child /= Void
		do
			children.extend (a_child)
		ensure
			child_has_been_added: old children.count + 1 = children.count
		end

	extend_attribute (a_id: STRING; a_value: XP_TAG_ARGUMENT)
			-- Sets the attribute of this tag.
			-- `a_id': The name of the attribute
			-- `a_value': The value of the attribute			
		require
			a_id_attached: a_id /= Void
			local_part_is_not_empty: not a_id.is_empty
		do
			parameters.extend (a_value, a_id)
		ensure
			attribute_has_been_added: old parameters.count + 1 = parameters.count
		end

	extend_attribute_for_copy (a_id: STRING; a_value: XP_TAG_ARGUMENT)
			-- Sets the attribute of this tag. Only use it for a copy operation
			-- `a_id': The name of the attribute
			-- `a_value': The value of the attribute
		require
			a_id_attached: a_id /= Void
			local_part_is_not_empty: not a_id.is_empty
		do
			extend_attribute (a_id, a_value)
		end

	build_tag_tree (a_feature: XEL_FEATURE_ELEMENT; root_template: XGEN_SERVLET_GENERATOR_GENERATOR)
			-- Adds the needed expressions which build the tree of Current with the correct classes
			-- `a_feature': The featureto which the tag tree building should be written to
			-- `root_template': The template which contains the tag data (root_tag, etc.)

		require
			a_feature_valid: attached a_feature
			root_template_valid: attached root_template
		do
			internal_build_tag_tree (a_feature, root_template, True)
		end

	accept (a_visitor: XP_TAG_ELEMENT_VISITOR)
			-- Element part of the Visitor Pattern
			-- `a_visitor': The visitor which is passed through the tree
		require
			visitor_attached: a_visitor /= Void
		do
			a_visitor.visit_tag_element (Current)
			accept_children (a_visitor)
		end

	resolve_all_dependencies (
				a_templates: HASH_TABLE [XP_TEMPLATE, STRING];
				a_pending: LIST [PROCEDURE [ANY, TUPLE [a_uid: STRING; a_controller_class: STRING]]];
				a_servlet_gen: XGEN_SERVLET_GENERATOR_GENERATOR;
				a_regions: HASH_TABLE [LIST[XP_TAG_ELEMENT], STRING])
			-- Resolves dependencies between xeb files set with page:include statements in the xeb file.
			-- Included templates are retrieved recursively the declared regions filled up with the region
			-- definitions as soon as possible. Controller class/id definitions are passed along with `a_pending'
			-- if they can not be resolved instantaniously (i.e. if there is a controller class defined).
			-- `a_templates': All the templates available index by their names
			-- `a_pending': All the pending controller class/id settings
			-- `a_servlet_gen': The servlet_generator_generator representing the servlet
			-- `a_regions': All defined regions which have not been assign to a declared region yet
		require
			a_templates_attached: attached a_templates
			a_pending_attached: attached a_pending
			a_servlet_gen_attached: attached a_servlet_gen
		local
			l_child: XP_TAG_ELEMENT
			l_cursor: INTEGER
		do
			from
				l_cursor := children.index
				children.start
			until
				children.after
			loop
				l_child := children.item
				l_child.resolve_all_dependencies (a_templates, a_pending, a_servlet_gen, a_regions)
				if l_child.date > date then
					date := l_child.date
				end
				children.forth
			end
			children.go_i_th (l_cursor)
		end

feature -- Copy

	copy_tag_tree: XP_TAG_ELEMENT
			-- Copies the tag and its children and all the attributes
		do
			Result := copy_self
			from
				parameters.start
			until
				parameters.after
			loop
				Result.extend_attribute_for_copy (parameters.key_for_iteration, parameters.item_for_iteration)
				parameters.forth
			end

			from
				children.start
			until
				children.after
			loop
				Result.extend_tag (children.item.copy_tag_tree)
				children.forth
			end
		ensure
			attached_result: attached Result
		end

feature {XP_TAG_ELEMENT} -- Copy

	copy_self: XP_TAG_ELEMENT
			-- Makes a copy of itself
		do
			create Result.make (namespace, id, class_name, debug_information)
		ensure
			attached_result: attached Result
		end

feature {XP_TAG_ELEMENT} -- Visitor

	accept_children (a_visitor: XP_TAG_ELEMENT_VISITOR)
			-- Part of the visitor pattern.
			-- `a_visitor': The visitor used to visit Current
		require
			a_visitor_attached: attached a_visitor
		local
			i: INTEGER
		do
				-- i is used as a iteration variable, so the list can be used in a nested way
			from
				i := 1
			until
				i > children.count
			loop
				children[i].accept (a_visitor)
				i := i + 1
			end
		end

feature {XP_TAG_ELEMENT} -- Implementation

	internal_build_tag_tree (a_feature: XEL_FEATURE_ELEMENT; a_root_template: XGEN_SERVLET_GENERATOR_GENERATOR;	a_is_root: BOOLEAN)
			-- Adds the needed expressions which build the tree of Current with the correct classes (recursively)
			-- `a_feature': The feature on which the tag tree code should be written
			-- `a_root_template': The root template which provides the data for the tag tree building
			-- `a_is_root': Is the tag the root tag?				
		require
			root_template_attached: attached a_root_template
			a_feature_attached: attached a_feature
		do
			a_feature.append_comment (debug_information)
			a_feature.append_expression ("create {" + class_name + "} temp.make")
			a_feature.append_expression ("temp.debug_information := %"" + debug_information + "%"" )
			if a_is_root then
				a_feature.append_expression ("l_root_tag := temp")
			else
				a_feature.append_expression ("stack.item.add_to_body (temp)")
			end
			build_attributes (a_feature, parameters)
			if attached controller_id then
				a_feature.append_expression ("temp.current_controller_id := %"" + controller_id + "%"")
			end
			a_feature.append_expression ("temp.tag_id := %"" + id + "%"")

			if has_children then
				a_feature.append_expression ("stack.put (temp)")
				from
					children.start
				until
					children.after
				loop
					children.item.internal_build_tag_tree (a_feature, a_root_template, False)
					children.forth
				end
				a_feature.append_expression ("stack.remove")
			end
		end

	build_attributes (a_feature: XEL_FEATURE_ELEMENT; a_attributes: HASH_TABLE [XP_TAG_ARGUMENT, STRING])
			-- Adds expressions which put the right attributes to the tags
			--`a_feature': The feature to which the attributes should be written
			-- `a_attributes': The attributes which should be written
		require
			a_feature_attached: attached a_feature
			attributes_attached: attached a_attributes
		local
			l_attribute_value: XP_TAG_ARGUMENT
		do
			from
				a_attributes.start
			until
				a_attributes.after
			loop
				l_attribute_value := a_attributes.item_for_iteration
				a_feature.append_expression ("temp." + l_attribute_value.put_attribute_type + "(%""
						+ a_attributes.key_for_iteration + "%", "
						+ "%"" + escape_string(l_attribute_value.value) + "%")"
					)
				a_attributes.forth
			end
		end

	out: STRING
			-- Prints out most important attributes of the Tag (namespace, id and parameters)
		do
			Result := "(TAG: " + namespace + ":" + id + ")"
			from
				parameters.start
			until
				parameters.after
			loop
				Result := Result + " " + parameters.item_for_iteration.value
				parameters.forth
			end
		end

invariant

	controller_id_attached: attached controller_id
	debug_information_attached: attached debug_information
	class_name_attached: attached class_name
	parameters_attached: attached parameters
	children_attached: attached children
	id_attached: attached id
	namespace_attached: attached namespace

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
