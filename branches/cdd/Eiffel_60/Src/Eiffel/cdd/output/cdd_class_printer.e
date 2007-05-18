indexing
	description: "Objects that write class text to a file"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_CLASS_PRINTER

feature {NONE} -- Initialization

	initialize (a_file: like output_file) is
			-- Set `output_file' to `a_file'.
		require
			not_initialized: not is_initialized
			valid_file: a_file /= Void and then a_file.is_open_write
			file_empty: a_file.count = 0
		do
			output_file := a_file
		ensure
			initialized: is_initialized
		end

feature -- Access

	is_initialized: BOOLEAN is
			-- Are we currently writting to a file?
		do
			Result := output_file /= Void
		end

feature {NONE} -- Status change

	terminate is
			-- Close file and set `output_file' to Void.
		require
			initialized: is_initialized
		do
			output_file.close
			output_file := Void
		ensure
			not_initialized: not is_initialized
		end

feature {NONE} -- Basic class text output

	append_text (a_text: STRING) is
			-- Append `a_text' to `output_file'.
		require
			initialized: is_initialized
			a_text_not_empty: a_text /= Void and then not a_text.is_empty
		do
			output_file.put_string (a_text)
		ensure
			file_size_increased: output_file.count > old output_file.count
		end

	append_instruction (a_text: STRING) is
			-- Append `a_text' to `output_file' with correct indent.
		require
			initialized: is_initialized
			a_text_not_empty: a_text /= Void and then not a_text.is_empty
		do
			append_text (indent + a_text + "%N")
		ensure
			file_size_increased: output_file.count > old output_file.count
		end

	append_comment (a_text: STRING) is
			-- Append `a_text' to `output_file' as comment with correct indent.
		require
			initialized: is_initialized
			a_text_not_empty: a_text /= Void and then not a_text.is_empty
		do
			append_text (indent + "%T-- " + a_text + "%N")
		ensure
			file_size_increased: output_file.count > old output_file.count
		end

feature {NONE} -- Implementation

	indent: STRING is "%T%T%T"
			-- Indent for instruction text

	output_file: KL_OUTPUT_FILE
			-- File class text is written

invariant
	correct_output_file_status: is_initialized implies (output_file /= Void and then output_file.is_open_write)

end
