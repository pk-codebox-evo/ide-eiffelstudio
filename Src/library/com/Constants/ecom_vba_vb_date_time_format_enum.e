indexing
	description: "VB Date Format Constants."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	ECOM_VBA_VB_DATE_TIME_FORMAT_ENUM

creation

feature -- Access

	vb_general_date: INTEGER is 0
			-- Display a date and/or time. 
			-- For real numbers, display a data and time. 
			-- If there is no fractional part, 
			-- display only a date. If there is no 
			-- integer part, display time only. Date and 
			-- time display is determined by your system settings.
			-- vbGeneralDate

	vb_long_date: INTEGER is 1
			-- Display a date using the long date format specified 
			-- in your computer's regional settings.
			-- vbLongDate

	vb_short_date: INTEGER is 2
			-- Display a date using the short date format 
			-- specified in your computer's regional settings.
			-- vbShortDate

	vb_long_time: INTEGER is 3
			-- Display a time using the long time format 
			-- specified in your computer's regional settings.
			-- vbLongTime

	vb_short_time: INTEGER is 4
			-- Display a time using the short time format 
			-- specified in your computer's regional settings.
			-- vbShortTime

end -- ECOM_VBA_VB_DATE_TIME_FORMAT_ENUM

