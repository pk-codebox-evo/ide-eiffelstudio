indexing
	description: "Change the maximum length of the text."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class TEXT_MAX_CMD

inherit
	CONTEXT_CMD
		redefine
			context, undo
		end

feature {NONE} -- Implementation

	associated_form: INTEGER is
		do
			Result := Context_const.text_field_att_form_nbr
		end

	name: STRING is
		do
			Result := Command_names.cont_text_max_cmd_name
		end

	context: TEXT_FIELD_C

	old_maximum_size: INTEGER

	work is
		do
--			old_maximum_size := context.maximum_text_length
		end

	undo is
		local
			new_maximum_size: INTEGER
		do
--			new_maximum_size := context.maximum_text_length
--			context.set_maximum_text_length (old_maximum_size)
			old_maximum_size := new_maximum_size
			{CONTEXT_CMD} Precursor
		end

end -- class TEXT_MAX_CMD

