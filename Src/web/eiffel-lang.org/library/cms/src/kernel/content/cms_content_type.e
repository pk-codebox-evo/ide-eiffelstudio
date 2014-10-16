note
	description: "Summary description for {CMS_CONTENT_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_CONTENT_TYPE

feature -- Access

	name: READABLE_STRING_8
			-- Internal name
		deferred
		end

	title: READABLE_STRING_8
		deferred
		end

	description: detachable READABLE_STRING_8
			-- Optional description
		deferred
		end

	available_formats: LIST [CONTENT_FORMAT]
		deferred
		end

feature -- Factory

	fill_edit_form (f: CMS_FORM; a_node: detachable CMS_NODE)
			-- Fill the edit form `f'
		deferred
		end

	change_node	(a_execution: CMS_EXECUTION; a_form_data: WSF_FORM_DATA; a_node: like new_node)
			-- Apply data from `a_form_data' to a_node
		require
			a_node.has_id
		deferred
		end

	new_node (a_execution: CMS_EXECUTION; a_form_data: WSF_FORM_DATA; a_node: detachable like new_node): CMS_NODE
			-- New content created with `a_form_data'
		deferred
		ensure
			a_node /= Void implies a_node = Result
		end

feature {NONE} -- Implementation: helper

	formats: CMS_FORMATS
		once
			create Result
		end

invariant

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
