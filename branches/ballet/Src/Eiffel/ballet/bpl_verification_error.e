indexing
	description: "An error reported by the verifier."
	author: "Raphael Mack"
	date: "$Date$"
	revision: "$Revision$"

class
	BPL_VERIFICATION_ERROR

inherit
	BPL_ERROR
		redefine
			out, print_error_message
		end

	SHARED_WORKBENCH
		redefine
			out
		end

create
	make_verification

feature{NONE} -- Initialization

	make_verification (a_text: STRING; a_class_name: STRING; a_line_start, a_column_start,
							 a_line_end, a_column_end: INTEGER; a_tag: STRING) is
			-- Create an error message with `a_text' as message and
			-- which is originated in class a_class_name at position
			-- line, column
		require
			a_text_not_void: a_text /= Void
		do
			make(a_text)
			class_name := a_class_name
			line := a_line_start
			column := a_column_start
			line_end := a_line_end
			column_end := a_column_end
			tag := a_tag
			file_name := universe.class_named (a_class_name, universe.groups.first).file_name.string
		ensure
			text_set: message = a_text
			line_start: line = a_line_start
			col_start: column = a_column_start
			line_end: line_end = a_line_end
			col_end: column_end = a_column_end
			cls_name: class_name = a_class_name
			tag_set: tag = a_tag
		end

feature -- Access
	-- all line/column specifications are within the eiffel file
	line_end: INTEGER
	column_end: INTEGER
	class_name: STRING
	tag : STRING

feature -- Output

	out: STRING is
		do
			Result := message + " (" + line.out +
				"," + column.out + ") - (" + line_end.out + "," +
				column_end.out + ")"
			if tag /= Void then
				Result := Result + " at tag " + tag
			end
		end

	print_error_message (a_text_formatter: TEXT_FORMATTER) is
			-- Print the error message.
		do
			a_text_formatter.add (error_string)
			a_text_formatter.add (" code: ")
			a_text_formatter.add_error (Current, code)
			a_text_formatter.add_new_line
			a_text_formatter.add_class (universe.class_named (class_name, universe.groups.first))

			a_text_formatter.add (" (")
			a_text_formatter.add_int (line)
			a_text_formatter.add (",")
			a_text_formatter.add_int (column)
			a_text_formatter.add (")-(")
			a_text_formatter.add_int (line_end)
			a_text_formatter.add (",")
			a_text_formatter.add_int (column_end)
			a_text_formatter.add (")")
			a_text_formatter.add_new_line
			a_text_formatter.add (message)
			if tag /= Void then
				a_text_formatter.add (" (Tag: ")
				a_text_formatter.add (tag)
				a_text_formatter.add (")")
			end
			a_text_formatter.add_new_line
		end

end
