indexing
	description: "[
		Base class for the EiffelBase library with complete contracts.
		Project-wide universal properties.
		This class is an ancestor to all developer-written classes.
		CC_ANY may be customized for individual projects or teams.
		]"
	author: "Marco Zietzling"
	library: "EiffelBase with complete contracts"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CC_ANY

inherit
	ANY
-- TODO kann man irgendwie any als automatischer ancester deaktivieren?

--redefine
	-- TODO alles redefinieren oder alles überschreiben ist vielleicht bessen

-- CC_ANY ist obsolete, wenn schon container globaler root ist.

end
