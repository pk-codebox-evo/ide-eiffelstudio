note
	description:	"Priority constants and helper features"
	legal:			"See note at the end of this class"
	status:			"See notice at the end of this class"
	date:			"$Date$"
	revision:		"$Revision$"

class LOG_PRIORITY_CONSTANTS

feature {NONE} -- Constants

	Log_emergency: INTEGER
			-- System is unusable
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_EMERGENCY"
		end

	Log_alert: INTEGER
			-- Action must be taken immediately
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_ALERT"
		end

	Log_critical: INTEGER
			-- Critical conditions
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_CRITICAL"
		end

	Log_error: INTEGER
			-- Error conditions
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_ERROR"
		end

	Log_warning: INTEGER
			-- Warning conditions
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_WARNING"
		end

	Log_notice: INTEGER
			-- Normal but significant condition
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_NOTICE"
		end

	Log_information: INTEGER
			-- Informational
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_INFORMATION"
		end

	Log_debug: INTEGER
			-- Debug-level messages
		external
			"C [macro %"eif_logging.h%"]"
		alias
			"EIF_LOGGING_DEBUG"
		end

feature {NONE} -- Implementation

	priority_tag (priority: INTEGER): STRING
			-- The human-readable priority tag for `priority'
		do
			Result := once "UNKNO"
			if priority = Log_emergency then
				Result := once "EMERG"
			elseif priority = Log_alert then
				Result := once "ALERT"
			elseif priority = Log_critical then
				Result := once "CRIT "
			elseif priority = Log_error then
				Result := once "ERROR"
			elseif priority = Log_warning then
				Result := once "WARN "
			elseif priority = Log_notice then
				Result := once "NOTIC"
			elseif priority = Log_information then
				Result := once "INFO "
			elseif priority = Log_debug then
				Result := once "DEBUG"
			end
		end

note
	copyright:	"Copyright (C) 2010 by ITPassion Ltd, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (See http://www.eiffel.com/licensing/forum.txt)"
	source:		"[
					ITPassion Ltd.
					5 Anstice Close, Chiswick, Middlesex, W4 2RJ, United Kingdom
					Telephone 0044-208-742-3422 Fax 0044-208-742-3468
					Website http://www.itpassion.com
					Customer Support http://powerdesk.itpassion.com
				]"

end
