note
	description: "Summary description for {WDOCS_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_MODULE

inherit
	CMS_MODULE

	CMS_HOOK_BLOCK

	CMS_HOOK_AUTO_REGISTER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	SHARED_HTML_ENCODER

	SHARED_WSF_PERCENT_ENCODER

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			name := "wdocs"
			version := "1.0"
			description := "Wiki Documentation"
			package := "doc"

				-- FIXME: maybe have a WDOCS_MODULE_EXECUTION to get those info when needed...
				-- Note those values are really set in `register'
			create root_dir.make_current
			temp_dir := root_dir.extended ("tmp")
			documentation_dir := root_dir.extended ("data").extended ("documentation")
			default_version_id := "current"
			cache_duration := 0
		end

feature {CMS_SERVICE} -- Registration

	service: detachable CMS_SERVICE

	register (a_service: CMS_SERVICE)
		local
			fs: WSF_FILE_SYSTEM_HANDLER
			cfg: detachable WDOCS_CONFIG
		do
			service := a_service

				-- FIXME: this code could/should be retarded to when it is really needed
				-- then if the module is disabled, it won't take CPU+memory for nothing.
			cfg := configuration (a_service.site_var_dir)
			root_dir := cfg.root_dir
			temp_dir := cfg.temp_dir
			documentation_dir := cfg.documentation_dir
			cache_duration := cfg.cache_duration
			default_version_id := cfg.documentation_default_version

			a_service.map_uri_template ("/learn", agent handle_learn (a_service, ?, ?))
			a_service.map_uri_template ("/book/", agent handle_book (a_service, ?, ?))
			a_service.map_uri_template ("/book/{bookid}/_images/{filename}", agent handle_wiki_image (a_service, ?, ?))
			a_service.map_uri_template ("/book/{bookid}", agent handle_book (a_service, ?, ?))
			a_service.map_uri_template ("/book/{bookid}/{wikipageid}", agent handle_wikipage (a_service, ?, ?))

			a_service.map_uri_template ("/version/{version_id}/book/", agent handle_book (a_service, ?, ?))
			a_service.map_uri_template ("/version/{version_id}/book/{bookid}/_images/{filename}", agent handle_wiki_image (a_service, ?, ?))
			a_service.map_uri_template ("/version/{version_id}/book/{bookid}", agent handle_book (a_service, ?, ?))
			a_service.map_uri_template ("/version/{version_id}/book/{bookid}/{wikipageid}", agent handle_wikipage (a_service, ?, ?))

			a_service.map_uri_template ("/images/{image_id}", agent handle_wiki_image (a_service, ?, ?))
			a_service.map_uri_template ("/version/{version_id}/images/{image_id}", agent handle_wiki_image (a_service, ?, ?))

			create fs.make_with_path (a_service.theme_location.extended ("res").extended ("images"))
			fs.disable_index
			a_service.router.handle ("/theme/images", fs)
		end

feature -- Access: config

	configuration (a_dir: PATH): WDOCS_CONFIG
			-- Configuration setup.
		local
			cfg: detachable WDOCS_CONFIG
			p: detachable PATH
			ut: FILE_UTILITIES
		do
			if attached execution_environment.item ("WDOCS_CONFIG") as s then
				create p.make_from_string (s)
				if not ut.file_path_exists (p) then
					p := a_dir.extended (s)
					if not ut.file_path_exists (p) then
						p := Void
					end
				end
			end
			if p /= Void then
				if attached p.extension as ext then
					if ext.is_case_insensitive_equal_general ("ini") then
						create {WDOCS_INI_CONFIG} cfg.make (p)
					elseif ext.is_case_insensitive_equal_general ("json") then
						create {WDOCS_JSON_CONFIG} cfg.make (p)
					end
				end
				if cfg = Void then
					create {WDOCS_INI_CONFIG} Result.make (p)
				end
			else
				p := a_dir.extended ("eiffel-lang.ini")
				if ut.file_path_exists (p) then
					create {WDOCS_INI_CONFIG} cfg.make (p)
				else
					p := a_dir.extended ("eiffel-lang.json")
					if ut.file_path_exists (p) then
						create {WDOCS_JSON_CONFIG} cfg.make (p)
					end
				end
			end

			if cfg /= Void then
				Result := cfg
			else
					-- Default
				create {WDOCS_DEFAULT_CONFIG} Result.make_default
			end
		end

feature -- Access: docs

	root_dir: PATH

	temp_dir: PATH

	documentation_dir: PATH

	default_version_id: READABLE_STRING_GENERAL

	documentation_wiki_dir (a_version_id: READABLE_STRING_GENERAL): PATH
		require
			a_version_id_not_blank: not a_version_id.is_whitespace
		do
			Result := documentation_dir.extended (a_version_id)
		end

	cache_duration: INTEGER
			-- Caching duration
			--|  0: disable
			--| -1: cache always valie
			--| nb: cache expires after nb seconds.

	cache_disabled: BOOLEAN
		do
			Result := cache_duration = 0
		end

	manager (a_version_id: detachable READABLE_STRING_GENERAL): WDOCS_MANAGER
		do
			if a_version_id = Void then
				create Result.make (documentation_wiki_dir (default_version_id), a_version_id, temp_dir)
			else
				create Result.make (documentation_wiki_dir (a_version_id), a_version_id, temp_dir)
			end
		end

feature -- Hooks

	block_list: ITERABLE [like {CMS_BLOCK}.name]
		do
			Result := <<"wdocs-tree">>
			debug ("wdocs")
				Result := <<"wdocs-tree", "wdocs-page-info">>
			end
		end

	get_block_view (a_block_id: detachable READABLE_STRING_8; a_execution: CMS_EXECUTION)
		local
			l_menublock: CMS_MENU_BLOCK
			l_content_block: CMS_CONTENT_BLOCK
			m: CMS_MENU
			s: STRING
			l_version_id, l_book_name, l_page_name: detachable READABLE_STRING_GENERAL
		do
			if attached {READABLE_STRING_GENERAL} a_execution.values.item ("wiki_version_id") as t then
				l_version_id := t
			end
			if attached {READABLE_STRING_GENERAL} a_execution.values.item ("wiki_book_name") as t then
				l_book_name := t
			end
			if attached {READABLE_STRING_GENERAL} a_execution.values.item ("wiki_page_name") as t then
				l_page_name := t
			end
			if a_block_id /= Void then
				if a_block_id.same_string_general ("wdocs-tree") then
					m := wdocs_cms_menu (l_version_id, l_book_name, l_page_name, True)
					create l_menublock.make (m)
					a_execution.add_block (l_menublock, "doc_sidebar")
				elseif a_block_id.same_string_general ("wdocs-page-info") then
					if
						l_book_name /= Void and then l_page_name /= Void and then
						attached manager (l_version_id) as mng and then
						attached {WIKI_PAGE} mng.page (l_book_name, l_page_name) as wp
					then
						create s.make_empty
						s.append ("<strong>title:</strong>")
						s.append (wp.title)
						s.append ("%N")

						s.append ("<strong>key:</strong>")
						s.append (wp.key)
						s.append ("%N")

						s.append ("<strong>src:</strong>")
						s.append (wp.src)
						s.append ("%N")

						if attached wp.path as l_path then
							s.append ("<strong>path:</strong>")
							s.append (l_path.name.as_string_8)
							s.append ("%N")
						end

						if attached mng.metadata (wp, Void) as md then
							across
								md as ic
							loop
								s.append_string (ic.key.as_string_8)
								s.append_character ('=')
								s.append_string (ic.item.as_string_8)
								s.append_character ('%N')
							end
						end
						create l_content_block.make (a_block_id, "Page info", s, a_execution.formats.filtered_html)
						a_execution.add_block (l_content_block, "doc_sidebar")
					end
				end
			else
			end
		end

	wdocs_page_cms_menu_link (a_version_id: detachable READABLE_STRING_GENERAL; a_book: WIKI_BOOK; a_page: detachable WIKI_PAGE; a_current_page_name: detachable READABLE_STRING_GENERAL; is_full: BOOLEAN): CMS_LOCAL_LINK
		local
			l_book_name: READABLE_STRING_32
			l_page: detachable WIKI_PAGE
		do
			l_book_name := a_book.name.as_string_32

			if a_page = Void then
				create Result.make (l_book_name, wdocs_book_link_location (a_version_id, l_book_name))
			else
				create Result.make (a_page.title, wdocs_page_link_location (a_version_id, l_book_name, a_page.title))
			end
			Result.set_expandable (True)
			if a_page /= Void then
				l_page := a_page
			else
				l_page := a_book.root_page
			end
			if l_page /= Void then
				wdocs_append_pages_to_link (a_version_id, l_book_name, a_current_page_name, a_book.top_pages, Result, is_full)
			end
		end

	wdocs_cms_menu (a_version_id, a_book_name, a_page_name: detachable READABLE_STRING_GENERAL; is_full: BOOLEAN): CMS_MENU
			-- CMS Menu for wdocs books (version `a_version_id', with `a_book_name':`a_page_name' optionally selected.
		local
			ln: CMS_LOCAL_LINK
			loc: STRING
			mng: like manager
			wb: detachable WIKI_BOOK
			l_parent: detachable WIKI_PAGE
		do
			create Result.make_with_title ("wdocs-tree", "Documentation", 3)
			mng := manager (a_version_id)
			if is_full then
				across
					mng.book_names as ic
				loop
					if
						attached mng.book (ic.item) as i_wb and then
						attached i_wb.root_page as l_root_page
					then
						l_root_page.sort
						if
							a_book_name /= Void and then
							i_wb.name.is_case_insensitive_equal_general (a_book_name)
						then
							ln := wdocs_page_cms_menu_link (a_version_id, i_wb, l_root_page, a_page_name, is_full)
							ln.set_expanded (True)
						else
							ln := wdocs_page_cms_menu_link (a_version_id, i_wb, l_root_page, Void, is_full)
							ln.set_collapsed (not i_wb.top_pages.is_empty)
						end
						Result.extend (ln)
					end
				end
			else
				if a_book_name /= Void then
					if a_page_name = Void then
						create ln.make (a_book_name.to_string_32, wdocs_book_link_location (a_version_id, a_book_name))
						ln.set_expandable (True)
						Result.extend (ln)
						wb := mng.book (a_book_name)
						if wb /= Void then
							if attached wb.root_page as wp then
								wp.sort
								if attached wp.pages as l_wp_pages then
									ln.set_expanded (not l_wp_pages.is_empty)
									wdocs_append_pages_to_link (a_version_id, a_book_name, a_page_name, l_wp_pages, ln, is_full)
								end
							else
								wdocs_append_pages_to_link (a_version_id, a_book_name, a_page_name, wb.top_pages, ln, is_full)
							end
						end
					else
						if a_book_name /= Void then
							wb := mng.book (a_book_name)
							loc := wdocs_page_link_location (a_version_id, a_book_name, a_page_name)
						else
							loc := wdocs_page_link_location (a_version_id, "???", a_page_name)
						end

						if wb /= Void and then attached wb.page (a_page_name) as wp then
							l_parent := wb.page_by_key (wp.parent_key)
							if l_parent /= Void then
								create ln.make ({STRING_32} "Parent <" + l_parent.title + ">", wdocs_page_link_location (a_version_id, wb.name, l_parent.title))
								ln.set_expandable (True)
								Result.extend (ln)

								l_parent.sort
								if attached l_parent.pages as l_wp_pages and then not l_wp_pages.is_empty then
									wdocs_append_pages_to_link (a_version_id, a_book_name, a_page_name, l_wp_pages, ln, is_full)
								else
									check has_wp: False end
								end
							else
								create ln.make ({STRING_32} "Book %"" +wb.name + "%"", wdocs_book_link_location (a_version_id, wb.name))
								ln.set_expandable (True)
								Result.extend (ln)

								if attached wb.top_pages as l_pages and then not l_pages.is_empty then
									wdocs_append_pages_to_link (a_version_id, a_book_name, a_page_name, l_pages, ln, is_full)
								end

	--								-- Is top  ..?
	--							create ln.make (a_page_name.to_string_32, loc)
	--							Result.extend (ln)
	--							if attached wp.pages as l_wp_pages and then not l_wp_pages.is_empty then
	--								ln.set_expandable (True)
	--								wdocs_append_pages_to_link (a_version_id, a_book_name, a_page_name, l_wp_pages, ln)
	--							end
							end

						else
							create ln.make (a_page_name.to_string_32, loc)
							Result.extend (ln)
						end
					end
				end
				across
					mng.book_names as ic
				loop
					if
						a_book_name = Void
						or else not a_book_name.is_case_insensitive_equal (ic.item)
					then
						create ln.make (ic.item, wdocs_book_link_location (a_version_id, ic.item))
						Result.extend (ln)
					end
				end
			end
		end

	wdocs_append_pages_to_link (a_version_id: detachable READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL; a_active_page_name: detachable READABLE_STRING_GENERAL; a_pages: LIST [WIKI_PAGE]; a_link: CMS_LOCAL_LINK; is_full: BOOLEAN)
			-- Append pages `a_pages' to link `a_link', for book `a_book_name' version `a_version_id'.
			-- If `is_full' recursively appends sub pages as well.
			-- Set page named `a_active_page_name' as active if any.
		require
			is_expandable: a_link.is_expandable
		local
			sub_ln: CMS_LOCAL_LINK
			wp: WIKI_PAGE
			l_is_active: BOOLEAN
		do
			if a_pages.is_empty then
				a_link.set_expandable (False)
			else
				a_link.set_expandable (True)
				if not a_link.is_expanded and is_full then
					a_link.set_collapsed (True)
				end
				across
					a_pages as ic
				loop
					wp := ic.item
					create sub_ln.make (wp.title, wdocs_page_link_location (a_version_id, a_book_name, wp.title))
					l_is_active := a_active_page_name /= Void and then
									a_active_page_name.is_case_insensitive_equal (wp.title)
					if l_is_active then
						a_link.set_expanded (True)
					end
					if wp.has_page then
						sub_ln.set_expandable (wp.has_page)

						if is_full or l_is_active then
								-- FIXME: find a way to mark it as current doc!
							wp.sort
							if
								attached wp.pages as l_wp_pages and then
								not l_wp_pages.is_empty
							then
								wdocs_append_pages_to_link (a_version_id, a_book_name, a_active_page_name, l_wp_pages, sub_ln, is_full)
								if sub_ln.is_expanded and then not a_link.is_expanded then
									a_link.set_expanded (True)
								end
							end
						end
					else
					end
					a_link.add_link (sub_ln)
				end

			end
		end

feature -- Handler		

	handle_learn (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			handle_book (cms, req, res)
		end

	handle_book (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			e: CMS_EXECUTION
			b: STRING
			l_version_id, l_bookid: detachable READABLE_STRING_32
			mnger: WDOCS_MANAGER
		do
			debug ("refactor_fixme")
				to_implement ("Find a way to extract presentation [html code] outside Eiffel")
			end

			if req.is_get_request_method then
				create {ANY_CMS_EXECUTION} e.make (req, res, cms)
			else
				create {NOT_FOUND_CMS_EXECUTION} e.make (req, res, cms)
			end

			l_version_id := version_id (req, Void)
			l_bookid := book_id (req, Void)

			e.values.force (l_version_id, "wiki_version_id")

			if l_bookid /= Void then
				e.set_optional_content_type ("doc")
				e.set_title (l_bookid)
				e.values.force (l_bookid, "wiki_book_name")
				create b.make_from_string ("<h1>Book # "+ html_encoded (l_bookid) +"</h1>")
				mnger := manager (l_version_id)
				if attached mnger.book (l_bookid) as l_book then
					if attached l_book.root_page as wp then
						b.append ("<li>")
						append_wiki_page_link (req, l_version_id, l_bookid, wp, True, b)
						b.append ("</li>")
					else
						across
							l_book.top_pages as ic
						loop
							b.append ("<li>")
							append_wiki_page_link (req, l_version_id, l_bookid, ic.item, True, b)
							b.append ("</li>")
						end
					end
				end
			else
				e.set_optional_content_type ("doc")
				e.set_title ("Book list ...")
				create b.make_from_string ("<ul class=%"books%">")
				mnger := manager (l_version_id)
				across
					mnger.book_names as ic
				loop
					b.append ("<li>")
					if l_version_id /= Void then
						b.append ("<a href=%""+ req.script_url ("/version/" + percent_encoder.percent_encoded_string (l_version_id) + "/book/" + percent_encoder.percent_encoded_string (ic.item)) +"/index%">")
					else
						b.append ("<a href=%""+ req.script_url ("/book/" + percent_encoder.percent_encoded_string (ic.item)) +"/index%">")
					end
					b.append (html_encoded (ic.item))
					b.append ("</a>")
					b.append ("</li>")
				end
				b.append ("</ul>")
			end
			debug ("wdocs")
				append_navigation_to (req, b)
			end

			e.set_main_content (b)
			e.execute
		end

	handle_wikipage (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_version_id, l_bookid, l_wiki_id: detachable READABLE_STRING_32
			mnger: WDOCS_MANAGER
			pg: detachable WIKI_PAGE
			e: CMS_EXECUTION
			s: STRING
		do
			debug ("refactor_fixme")
				to_implement ("Find a way to extract presentation [html code] outside Eiffel")
			end

			if req.is_get_request_method then
				create {ANY_CMS_EXECUTION} e.make (req, res, cms)
			else
				create {NOT_FOUND_CMS_EXECUTION} e.make (req, res, cms)
			end

			e.set_optional_content_type ("doc")

			l_version_id := version_id (req, Void)
			l_bookid := book_id (req, Void)
			l_wiki_id := wikipage_id (req, Void)
			mnger := manager (l_version_id)

			e.values.force (l_version_id, "wiki_version_id")

			if l_bookid /= Void then
				e.values.force (l_bookid, "wiki_book_name")
				pg := mnger.page (l_bookid, l_wiki_id)
				if pg = Void and l_wiki_id /= Void then
					if l_wiki_id.is_case_insensitive_equal_general ("index") then
						pg := mnger.page (l_bookid, l_bookid)
					elseif l_wiki_id.is_case_insensitive_equal_general (l_bookid) then
						pg := mnger.page (l_bookid, "index")
					end
					if
						pg = Void and then
						attached mnger.book (l_bookid) as wb
					then
						pg := wb.root_page
						if pg = Void then
							create pg.make (wb.name, wb.name)
							across
								wb.top_pages as ic
							loop
								pg.extend (ic.item)
							end
							pg.sort
						end
					end
				end
			end

			e.add_additional_head_line ("[
						<style>
							table {border: solid 1px blue;}
							td {border: solid 1px blue;}
						</style>
					]", False
				)

			if pg /= Void then
				e.set_title (pg.title)
				e.values.force (pg.title, "wiki_page_name")
				create s.make_empty

--				debug ("wdocs")
--					if l_wiki_id /= Void then
--						s.append ("<h1><a href="+ req.request_uri +">Wiki page # "+ html_encoded (l_wiki_id) +"</a></h1>")
--					else
--						s.append ("<h1>Wiki page #???</h1>")
--					end
--				end

				append_wiki_page_xhtml_to (pg, l_bookid, mnger, s, req)

				if attached {WSF_STRING} req.query_parameter ("debug") as s_debug and then not s_debug.is_case_insensitive_equal ("no") then
					s.append ("<hr/>")
					if attached pg.path as l_path then
						s.append ("File: ")
						s.append (html_encoded (l_path.absolute_path.canonical_path.name))
						s.append ("<br/>")
						if attached wiki_text (l_path) as l_wiki_text then
							s.append ("Wiki text:<pre style=%"border: solid 1px #000; background-color: #ffa; white-space: pre-wrap; %">%N")
							s.append (l_wiki_text)
							s.append ("%N</pre>")
						end
					end
					s.append ("HTML rendering:<pre style=%"border: solid 1px #000; background-color: #afa; white-space: pre-wrap;%">%N")
					s.append (html_encoded (s))
					s.append ("</pre>")
				end
			else
				e.set_title ("Wiki page not found!")
				create s.make_from_string ("Page not found")
			end

			debug ("wdocs")
				append_navigation_to (req, s)
			end

			e.set_main_content (s)
			e.execute
		end

	handle_wiki_image (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
			--|	map: "/book/_images/{filename}"
		local
			l_version_id,
			l_bookid,
			l_filename: detachable READABLE_STRING_32
			l_not_found: WSF_NOT_FOUND_RESPONSE
			l_file_response: WSF_FILE_RESPONSE
			mnger: WDOCS_MANAGER
			p: PATH
			h: HTTP_HEADER
			dt: DATE_TIME
			ut: FILE_UTILITIES
		do
			l_version_id := version_id (req, Void)
			l_bookid := book_id (req, Void)
			l_filename := text_path_parameter (req, "filename", Void)
			if l_bookid /= Void and l_filename /= Void then
				mnger := manager (l_version_id)
				p := mnger.wiki_database_path.extended (l_bookid).extended ("_images").extended (l_filename)
				if not ut.file_path_exists (p) then
					p := mnger.wiki_database_path.extended ("_images").extended (l_filename)
				end

				if ut.file_path_exists (p) then
					if
						attached req.meta_string_variable ("HTTP_IF_MODIFIED_SINCE") as s_if_modified_since and then
						attached http_date_format_to_date (s_if_modified_since) as l_if_modified_since_date and then
						attached file_date (p) as f_date and then
						f_date <= l_if_modified_since_date
					then
						create dt.make_now_utc
						create h.make
						h.put_cache_control ("private, max-age=" + (cache_duration).out) -- 24 hours
						h.put_utc_date (dt)
						if cache_duration > 0 then
							dt := dt.twin
							dt.second_add (cache_duration)
						end
						h.put_expires_date (dt)
						h.put_last_modified (f_date)
						res.set_status_code ({HTTP_STATUS_CODE}.not_modified)
						res.put_header_lines (h)
						res.flush
					else
						create l_file_response.make (p.name)
		--				l_file_response.set_expires_in_seconds (24*60*60)
						res.send (l_file_response)
					end
				else
					create l_not_found.make (req)
					res.send (l_not_found)
				end
			elseif attached text_path_parameter (req, "image_id", Void) as l_img_id then
				mnger := manager (l_version_id)
				if attached mnger.data.image_path (l_img_id, Void) as l_img_path then
					create l_file_response.make (l_img_path.name)
	--				l_file_response.set_expires_in_seconds (24*60*60)
					res.send (l_file_response)
				else
					create l_not_found.make (req)
					l_not_found.add_suggested_text ("Not Yet Implemented .. ", Void)
					if attached req.http_referer as ref then
						l_not_found.add_suggested_location (ref, "Back to previous page [" + ref + "]", Void)
					end
					res.send (l_not_found)
				end
			else
				create l_not_found.make (req)
				res.send (l_not_found)
			end
		end

feature {NONE} -- Implementation: wiki render	


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

	version_id (req: WSF_REQUEST; a_default: detachable READABLE_STRING_32): detachable READABLE_STRING_32
		do
			Result := text_path_parameter (req, "version_id", a_default)
		end

	book_id (req: WSF_REQUEST; a_default: detachable READABLE_STRING_32): detachable READABLE_STRING_32
		do
			Result := text_path_parameter (req, "bookid", a_default)
		end

	wikipage_id (req: WSF_REQUEST; a_default: detachable READABLE_STRING_32): detachable READABLE_STRING_32
		do
			Result := text_path_parameter (req, "wikipageid", a_default)
		end

	append_navigation_to (req: WSF_REQUEST; s: STRING)
		do
			debug ("refactor_fixme")
				to_implement ("Find a way to extract presentation [html code] outside Eiffel")
			end
			s.append ("<li><a href=%"" + req.script_url ("/") + "%">back to home</a></li>")
			if attached req.http_referer as l_ref then
				s.append ("<li><a href=%"" + l_ref + "%">back to "+ l_ref +"</a></li>")
			end
			s.append ("<li>Location: " + req.request_uri + "</li>")
		end

	append_wiki_page_xhtml_to (a_wiki_page: WIKI_PAGE; a_book_name: detachable READABLE_STRING_GENERAL; a_manager: WDOCS_MANAGER; a_output: STRING; req: WSF_REQUEST)
		local
			l_cache: detachable WDOCS_FILE_STRING_8_CACHE
			l_xhtml: detachable STRING_8
			wvis: WIKI_XHTML_GENERATOR
			p: PATH
			d: DIRECTORY
			f: PLAIN_TEXT_FILE
			l_wiki_page_date_time: detachable DATE_TIME
			client_request_no_server_cache: BOOLEAN
			l_version_id: like version_id
		do
			l_version_id := version_id (req, Void)
			p := wiki_cache_directory (a_manager)
			if a_book_name /= Void then
				p := p.extended (a_book_name)
			end
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end
			p := p.extended (a_wiki_page.title).appended_with_extension ("xhtml")

			if
				cache_disabled
			then
					-- No cache!
			else
				create l_cache.make (p)
				if attached a_wiki_page.path as l_pg_path then
					create f.make_with_path (l_pg_path)
					if f.exists and then f.is_access_readable then
						create l_wiki_page_date_time.make_from_epoch (f.date)
					end
				end
			end

			client_request_no_server_cache := attached req.meta_string_variable ("HTTP_CACHE_CONTROL") as s_cache_control and then
						s_cache_control.is_case_insensitive_equal_general ("no-cache")


			if
				not client_request_no_server_cache and then
				l_cache /= Void and then -- i.e: cache enabled
				l_cache.exists and then
				not l_cache.expired (l_wiki_page_date_time, cache_duration)
			then
				create l_xhtml.make (l_cache.file_size)
				l_cache.append_to (l_xhtml)

				l_xhtml.append ("<div class=%"cache-info%">cached: " + l_cache.cache_date_time.out + "</div>")
			else
				create l_xhtml.make_empty

				create wvis.make (l_xhtml)
				wvis.set_link_resolver (a_manager)
				wvis.set_image_resolver (a_manager)
				wvis.set_template_resolver (a_manager)
				wvis.visit_page (a_wiki_page)

				l_xhtml.append ("<ul class=%"wdocs-index%">")
				if
					a_book_name /= Void and then
					attached a_manager.page (a_book_name, a_wiki_page.parent_key) as l_parent_page and then
					l_parent_page /= a_wiki_page
				then
					l_xhtml.append ("<li><em>Parent</em> &lt;")
					append_wiki_page_link (req, l_version_id, a_book_name, l_parent_page, False, l_xhtml)
					l_xhtml.append ("&gt;</li>")
				end

				a_wiki_page.sort
				if attached a_wiki_page.pages as l_sub_pages then
					across
						l_sub_pages as ic
					loop
						l_xhtml.append ("<li>")
						append_wiki_page_link (req, l_version_id, a_book_name, ic.item, False, l_xhtml)
						l_xhtml.append ("</li>")
					end
				end
				l_xhtml.append ("</ul>")
				if l_cache /= Void then
					l_cache.put (l_xhtml)
				end
			end
			a_output.append (l_xhtml)
		end

	wiki_text (fn: PATH): detachable STRING
		local
			f: RAW_FILE
		do
			create f.make_with_path (fn)
			if f.exists and then f.is_access_readable then
				create Result.make (f.count)
				f.open_read
				from
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream (1_024)
					Result.append (f.last_string)
				end
				f.close
			end
		end

feature {NONE} -- implementation: wiki docs

	wiki_cache_directory (a_manager: WDOCS_MANAGER): PATH
			-- Directory to store wikitext page output.
		local
			p: PATH
		do
			p := a_manager.wiki_database_path
			if attached p.entry as e then
				Result := temp_dir.extended ("cache").extended_path (e)
			else
				Result := p.appended_with_extension ("cache")
			end
		end

	last_segment (s: READABLE_STRING_8): READABLE_STRING_8
		local
			i: INTEGER
		do
			i := s.last_index_of ('/', s.count)
			if i > 0 then
				Result := s.substring (i + 1, s.count)
			else
				Result := s
			end
			if Result.is_case_insensitive_equal_general ("index") then
				if s.last_index_of ('/', i - 1) > 0 then
					Result := last_segment (s.substring (1, i - 1))
				end
			end
		end

	append_wiki_page_link (req: WSF_REQUEST; a_version_id, a_book_id: detachable READABLE_STRING_GENERAL; a_page: WIKI_PAGE; is_recursive: BOOLEAN; a_output: STRING)
		local
			l_pages: detachable LIST [WIKI_PAGE]
			loc: STRING
		do
			debug ("refactor_fixme")
				to_implement ("Find a way to extract presentation [html code] outside Eiffel")
			end
			a_page.sort
			l_pages := a_page.pages
			if l_pages /= Void and then l_pages.is_empty then
				l_pages := Void
			end

			if a_book_id /= Void then
				loc := wdocs_page_link_location (a_version_id, a_book_id, last_segment (a_page.src))
				a_output.append ("<a href=%""+ req.script_url (loc) + "%"")
			else
				a_output.append ("<a href=%"../" + percent_encoder.percent_encoded_string (last_segment (a_page.src)) + "%"")
			end
			if l_pages /= Void then
				a_output.append (" class=%"wdocslink folder%"")
			else
				a_output.append (" class=%"wdocslink%"")
			end
			a_output.append (">")
			a_output.append (html_encoder.general_encoded_string (a_page.title))
			a_output.append ("</a>")

			if l_pages /= Void then
				check pages_not_empty: not l_pages.is_empty end
				if is_recursive then
					a_output.append ("<ul>")
					across
						l_pages as ic
					loop
						a_output.append ("<li>")
						append_wiki_page_link (req, a_version_id, a_book_id, ic.item, is_recursive, a_output)
						a_output.append ("</li>")
					end
					a_output.append ("</ul>")
				end
			end
		end

	wdocs_book_link_location (a_version_id: detachable READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL): STRING
		do
			if a_version_id /= Void then
				create Result.make_from_string ("/version/" + percent_encoder.percent_encoded_string (a_version_id))
			else
				create Result.make_empty
			end
			Result.append ("/book/")
			Result.append (percent_encoder.percent_encoded_string (a_book_name))
		end

	wdocs_page_link_location (a_version_id: detachable READABLE_STRING_GENERAL; a_book_name: READABLE_STRING_GENERAL; a_page_name: READABLE_STRING_GENERAL): STRING
		do
			Result := wdocs_book_link_location (a_version_id, a_book_name)
			Result.append ("/")
			Result.append (percent_encoder.percent_encoded_string (a_page_name))
		end

feature {NONE} -- Implementation: date and time

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
		local
			f: RAW_FILE
		do
			create f.make_with_path (p)
			Result := timestamp_to_date (f.date)
		end

	timestamp_to_date (n: INTEGER): DATE_TIME
		local
			d: HTTP_DATE
		do
			create d.make_from_timestamp (n)
			Result := d.date_time
		end

feature {NONE} -- Implementation		

	append_info_to (n: READABLE_STRING_8; v: detachable READABLE_STRING_GENERAL; e: CMS_EXECUTION; t: STRING)
		do
			t.append ("<li>")
			t.append ("<strong>" + n + "</strong>: ")
			if v /= Void then
				t.append (e.html_encoded (v))
			end
			t.append ("</li>")
		end

	html_encoded (s: detachable READABLE_STRING_GENERAL): STRING_8
		do
			if s /= Void then
				Result := html_encoder.general_encoded_string (s)
			else
				create Result.make_empty
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
