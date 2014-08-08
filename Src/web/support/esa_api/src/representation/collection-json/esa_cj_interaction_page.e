note
	description: "Summary description for {ESA_CJ_INTERACTION_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CJ_INTERACTION_PAGE


inherit

	TEMPLATE_SHARED

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_INTERACTION_FORM_VIEW; a_user: detachable ANY;)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_interaction_form.tpl")
			set_template_folder (cj_path)
			set_template_file_name ("cj_interaction_form.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_form.categories, "categories")
			template.add_value (a_form.status, "status")
			template.add_value (a_form, "form")
			template.add_value (a_form.report, "report")
			template.add_value (a_form.temporary_files,"uploaded_files")

			if a_form.id > 0 then
				template.add_value (a_form.id, "id")
			end

			if attached a_user then
				template.add_value (a_user, "user")
			end

				-- Process current template
			process
		end
end
