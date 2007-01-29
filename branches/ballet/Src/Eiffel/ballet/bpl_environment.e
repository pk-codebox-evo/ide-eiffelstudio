indexing
	description: "An evironment for the Ballet generation"
	author: "Bernd Schoeller and others"
	date: "$Date$"
	revision: "$Revision$"

class

	BPL_ENVIRONMENT

inherit

	KL_SHARED_STANDARD_FILES
		export
			{NONE} all
		end

create

	make

feature{NONE} -- Initialization

	make is
			-- Generate a BPL environment, generating code to `a_stream'.
		do
			create error_log.make
			out_stream := std.output
		ensure
			stream_set: out_stream = std.output
			error_log_generated: error_log /= Void
			error_log_empty: not error_log.has_error
		end

feature -- Access

	error_log: BPL_ERROR_LOG
		-- Error log to report errors to

	out_stream: KI_TEXT_OUTPUT_STREAM
		-- Output stream for the generation of BoogiePL code

	class_under_verification: CLASS_AS
		-- Class ballet is verifying

feature -- Settors

	set_out_stream (a_stream: KI_TEXT_OUTPUT_STREAM) is
			-- Set the output stream to `a_stream'.
		require
			a_stream_not_void: a_stream /= Void
		do
			out_stream := a_stream
		ensure
			stream_set: out_stream = a_stream
		end

feature {BPL_GENERATOR}

	set_verification_class(a_cls: CLASS_AS) is
			-- Set the class currently verified.
		do
			class_under_verification := a_cls
		ensure
			class_set: class_under_verification = a_cls
		end

invariant
	error_log_not_void: error_log /= Void
	out_not_void: out_stream /= Void
end
