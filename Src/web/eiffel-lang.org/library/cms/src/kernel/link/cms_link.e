note
	description: "Summary description for {CMS_MENU}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_LINK

inherit
	REFACTORING_HELPER

	DEBUG_OUTPUT

	ITERABLE [CMS_LINK]

feature -- Access	

	title: READABLE_STRING_32

	location: READABLE_STRING_8

	options: detachable CMS_API_OPTIONS

feature -- status report	

	is_active: BOOLEAN
		deferred
		end

	is_expanded: BOOLEAN
			-- Is expanded and visually expanded?
		deferred
		end

	is_collapsed: BOOLEAN
			-- Is expanded, but visually collapsed?
		deferred
		ensure
			Result implies is_expandable
		end

	is_expandable: BOOLEAN
			-- Is expandable?	
		deferred
		end

	has_children: BOOLEAN
		deferred
		end

feature -- Query

	parent: detachable CMS_LINK

	children: detachable LIST [CMS_LINK]
		deferred
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [CMS_LINK]
			-- Fresh cursor associated with current structure
		do
			if attached children as lst then
				Result := lst.new_cursor
			else
				Result := (create {ARRAYED_LIST [CMS_LINK]}.make (0)).new_cursor
			end
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := title.as_string_8 + " -> " + location
		end

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
