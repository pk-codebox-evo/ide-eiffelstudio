note
	description: "Summary description for {WDOCS_MODULE_HELPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WDOCS_MODULE_HELPER

inherit
	WDOCS_SHARED_ENCODER

	WDOCS_HELPER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	REFACTORING_HELPER

feature -- Access URI

	wiki_name_text_path_parameter (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL; a_default: detachable READABLE_STRING_32): detachable READABLE_STRING_32
			-- STRING path parameter associated with `a_name' if it exists.
			-- If Result is Void, return `a_default' value.
		do
			if attached {WSF_STRING} req.path_parameter (a_name) as l_param then
				Result := url_encoded_string_to_wiki_name (l_param.url_encoded_value)
			else
				Result := a_default
			end
		end

	text_path_parameter (req: WSF_REQUEST; a_name: READABLE_STRING_GENERAL; a_default: detachable READABLE_STRING_32): detachable READABLE_STRING_32
			-- STRING path parameter associated with `a_name' if it exists.
			-- If Result is Void, return `a_default' value.
		do
			if attached {WSF_STRING} req.path_parameter (a_name) as l_param then
				Result := l_param.value
			else
				Result := a_default
			end
		end

	wiki_to_xhtml (a_wdocs_api: detachable WDOCS_API; a_title: detachable READABLE_STRING_GENERAL; a_source: READABLE_STRING_GENERAL; pg: detachable WIKI_BOOK_PAGE; a_manager: WDOCS_MANAGER): STRING
			-- XHTML rendering for `a_source'
		local
			l_xhtml: STRING
			l_preview_pg: WIKI_PAGE
			utf: UTF_CONVERTER
			wvis: WDOCS_WIKI_XHTML_GENERATOR
			l_title, l_parent_key: detachable READABLE_STRING_8
		do
			if pg /= Void then
				l_title := pg.title
				l_parent_key := pg.parent_key
			end
			if a_title /= Void then
				l_title := utf.utf_32_string_to_utf_8_string_8 (a_title)
			elseif l_title = Void then
				l_title := "?"
			end
			if l_parent_key = Void then
				l_parent_key := l_title
			end
			l_preview_pg := a_manager.new_wiki_page (l_title, l_parent_key)
			l_preview_pg.set_text (create {WIKI_CONTENT_TEXT}.make_from_string (utf.utf_32_string_to_utf_8_string_8 (a_source)))
			create l_xhtml.make_empty
			create wvis.make (l_xhtml)
			wvis.set_link_resolver (a_manager)
			wvis.set_image_resolver (a_manager)
			wvis.set_template_resolver (a_manager)
			wvis.set_file_resolver (a_manager)
			if attached a_wdocs_api as l_wdocs_api then
				across
					l_wdocs_api.settings.interwiki_mapping as ic
				loop
					wvis.interwiki_mappings.force (ic.item, ic.key)
				end
			end

			wvis.code_aliases.force ("eiffel") -- Support <eiffel>..</eiffel> as <code lang=eiffel>

			wvis.visit_page_with_title (l_preview_pg, l_title)

			Result := l_xhtml
		end

feature -- Access date and time

	http_date_format_to_date (s: READABLE_STRING_8): detachable DATE_TIME
		local
			d: HTTP_DATE
		do
			create d.make_from_string (s)
			if not d.has_error then
				Result := d.date_time
			end
		end

	file_date (p: PATH): DATE_TIME
		require
			path_exists: (create {FILE_UTILITIES}).file_path_exists (p)
		do
			Result := timestamp_to_date (file_timestamp (p))
		end

	file_timestamp (p: PATH): INTEGER_32
		require
			path_exists: (create {FILE_UTILITIES}).file_path_exists (p)
		local
			f: RAW_FILE
		do
			create f.make_with_path (p)
			Result := f.date
		end

	timestamp_to_date (n: INTEGER): DATE_TIME
		local
			d: HTTP_DATE
		do
			create d.make_from_timestamp (n)
			Result := d.date_time
		end

end
