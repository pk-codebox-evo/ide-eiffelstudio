indexing
	description: "Change the horizontal resizement policy."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class TEXT_READ_CMD 

inherit
	CONTEXT_CMD
		redefine
			context, undo
		end

feature {NONE} -- Implementation

	associated_form: INTEGER is
		do
			if context.is_field then
				Result := Context_const.text_field_att_form_nbr
			else
				Result := Context_const.text_att_form_nbr
			end
		end

	name: STRING is
		do
			Result := Command_names.cont_text_read_cmd_name
		end

	context: TEXT_COMPONENT_C

	old_is_editable: BOOLEAN

	work is
		do
			old_is_editable := context.is_editable
		end

	undo is
		local
			new_is_editable: BOOLEAN
		do
			new_is_editable := context.is_editable
			context.set_editable (old_is_editable)
			old_is_editable := new_is_editable
			{CONTEXT_CMD} Precursor
		end

end -- class TEXT_READ_CMD

