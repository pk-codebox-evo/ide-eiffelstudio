indexing
	description: "Objects that provide a tty command for changing cdd status"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_CDD_STATUS

inherit
	EWB_CDD_CMD

	CONF_ACCESS

	SHARED_EIFFEL_PROJECT

feature -- Access

	name: STRING is "Status"

	help_message: STRING is "Enable/disable and/or configure CDD."

	abbreviation: CHARACTER is 's'



feature -- Execution

	execute is
			--
		local
			l_conf: CONF_CDD
		do
			l_conf := eiffel_universe.target.cdd
			io.new_line
			if l_conf /= Void then
				io.put_string ("Enabled: " + l_conf.is_enabled.out)
				io.put_string ("%NExtracting: " + l_conf.is_extracting.out)
				io.put_string ("%NCluster name: ")
				if l_conf.cluster_name /= Void then
					io.put_string (l_conf.cluster_name)
				else
					io.put_string ("none")
				end
				io.put_string ("%NCapture/Replay: " + l_conf.is_capture_replay_activated.out)
			else
				io.put_string ("No cdd configuration...")
			end
			io.new_line
		end


feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
