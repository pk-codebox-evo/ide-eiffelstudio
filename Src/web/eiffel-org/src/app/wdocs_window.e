note
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	generator: "EiffelBuild"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			create_interface_objects, initialize, is_in_default_state
		end

	SHARED_EMBEDED_WEB_SERVICE_INFORMATION
		undefine
			default_create, copy
		end

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create, copy
		end

create
	make

feature {NONE} -- Initialization

	make (env: CMS_ENVIRONMENT)
			-- Creation method
		do
			environment := env
			default_create
		end

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_TITLED_WINDOW}

			set_title ("Wiki Docs App")

				-- Connect events.
				-- Close the application when an interface close
				-- request is received on `Current'. i.e. the cross is clicked.
			close_request_actions.extend (agent on_windows_closed)

				-- Call `user_initialization'.
			user_initialization
		end

	create_interface_objects
			-- Create objects
		do
			build_wdocs_manager
			create wdocs_browser.make ("http://localhost")
			create wdocs_control.make (wdocs_manager)
			wdocs_control.set_associated_window (Current)
		end

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			vb: EV_VERTICAL_BOX
			sp: EV_HORIZONTAL_SPLIT_AREA
			l_control_content: SD_CONTENT
			l_browser_content: SD_CONTENT
			l_docking_data_path: PATH
			ut: FILE_UTILITIES
			b: BOOLEAN
		do
			set_size (800, 600)

			create sd_manager.make (Current, Current)
			if attached sd_manager as l_sd_manager then
				l_control_content := wdocs_control.sd_content
				wdocs_control.initialize_edit_tool

				create l_browser_content.make_with_widget (wdocs_browser, "Browser")
				l_browser_content.set_long_title ("Browser")

				l_sd_manager.contents.extend (l_browser_content)
				l_sd_manager.contents.extend (l_control_content)
				if attached wdocs_control.edit_tool as l_edit_tool then
					l_sd_manager.contents.extend (l_edit_tool.sd_content)
				end

				l_sd_manager.close_editor_place_holder

				l_docking_data_path := sd_manager_config_path
				if not reset_layout_requested and then ut.file_path_exists (l_docking_data_path) then
					b := l_sd_manager.open_config_with_path (l_docking_data_path)
				end
				if not b then
					l_browser_content.set_top ({SD_ENUMERATION}.right)
					l_control_content.set_relative (l_browser_content, {SD_ENUMERATION}.left)
	--				l_browser_content.set_split_proportion (0.30)

					resize_actions.extend_kamikaze (agent (ix,iy,iw,ih: INTEGER; i_content: SD_CONTENT)
							do
								i_content.set_split_proportion (0.20)
							end(?,?,?,?,l_browser_content)
						)
				end
				l_control_content.update_mini_tool_bar_size
			else
				create vb
				extend (vb)
				vb.set_border_width (3)
				vb.set_padding_width (3)

				create sp
				vb.extend (sp)
				sp.set_first (wdocs_control)
				sp.set_second (wdocs_browser)
				sp.resize_actions.extend_kamikaze (agent (ix,iy,iw,ih: INTEGER; isp: EV_SPLIT_AREA)
						do
							isp.set_split_position ((180).max (isp.minimum_split_position))
						end(?,?,?,?,sp)
					)
			end

			wdocs_control.wiki_page_select_actions.extend (agent open_wiki_page)
			wdocs_control.url_requested_actions.extend (agent open_url)

			wdocs_control.refresh_now
		end

	is_in_default_state: BOOLEAN
		do
			Result := True
		end

feature -- Access: docking	

	environment: CMS_ENVIRONMENT
			-- Application environment layout.

	sd_manager: detachable SD_DOCKING_MANAGER

	sd_manager_config_path: PATH
		once
			create Result.make_from_string ("wdocs_layout.cfg")
			Result := Result.absolute_path
		end

	reset_layout_requested: BOOLEAN
		do
			Result := execution_environment.arguments.index_of_word_option ("-reset-layout") > 0
		end

feature -- Events

	on_windows_closed
		local
			b: BOOLEAN
		do
			if attached sd_manager as l_sd_manager then
				b := l_sd_manager.save_data_with_path (sd_manager_config_path)
			end
			destroy_and_exit_if_last;
			(create {EXCEPTIONS}).die (1)
		end

feature -- Basic operation

	open_wiki_page (wp: WIKI_PAGE)
		local
			lnk: WIKI_LINK
			l_url: READABLE_STRING_8
		do
			create lnk.make ("[[" + wp.title + "]]")
			if attached wdocs_control.wdocs_manager.link_to_wiki_url (lnk, wp) as u then
				l_url := u
			elseif attached {WIKI_BOOK_PAGE} wp as l_book_page then
				l_url := "/book/" + l_book_page.parent_key + "/" + l_book_page.key
			else
				l_url := "/book/" -- FIXME
			end
			if l_url.starts_with_general ("http:") or l_url.starts_with_general ("https:") then
				wdocs_browser.open (l_url)
			else
				wdocs_browser.open ("http://localhost:" + port_number.out + l_url)
			end
		end

	open_url (a_url: READABLE_STRING_8)
		do
			wdocs_browser.open (a_url)
		end

	on_web_service_ready
		do
			update_wdocs_manager
			check wdocs_control.wdocs_manager.server_url ~ wdocs_manager.server_url end
			wdocs_browser.set_home_url ("http://localhost:" + port_number.out)
			wdocs_browser.open_home
		end

feature {WDOCS_CONTROL} -- Element change		

	set_manager (man: like wdocs_manager)
		do
			wdocs_manager := man
		end

feature {NONE} -- Implementation

	wdocs_manager: WDOCS_EDIT_MANAGER

	build_wdocs_manager
		local
			cfg: WDOCS_DEFAULT_SETUP
			wdocs: like wdocs_manager
			dft: detachable READABLE_STRING_GENERAL
		do
			create cfg.make (environment.config_path.extended ("wdocs.ini"), "trunk")
			dft := cfg.documentation_default_version
			if dft = Void then
				dft := "trunk"
			end
			create wdocs.make (cfg.documentation_dir.extended (dft), dft, cfg.temp_dir)
			wdocs.set_server_url ("http://localhost:" + port_number.out)
			wdocs_manager := wdocs
		end

	update_wdocs_manager
		do
			wdocs_manager.set_server_url ("http://localhost:" + port_number.out)
		end

	wdocs_browser: WDOCS_BROWSER
	wdocs_control: WDOCS_CONTROL

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
