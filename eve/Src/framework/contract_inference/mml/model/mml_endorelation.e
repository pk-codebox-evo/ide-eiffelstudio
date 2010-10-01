note
	description: "Relation on a set."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MML_ENDORELATION [G->ANY]

inherit
	MML_RELATION [G, G]


feature -- Status report
	reflexive: BOOLEAN
			-- Is relation reflexive?
		deferred
		end

	irreflexive: BOOLEAN
			-- Is relation irreflexive?
		deferred
		end

	symmetric: BOOLEAN
			-- Is relation symmetric?
		deferred
		end

	antisymmetric: BOOLEAN
			-- Is relation antisymmetric?
		deferred
		end

	transitive: BOOLEAN
			-- Is relation transitive?
		deferred
		end

	total: BOOLEAN
			-- Is relation total?
		deferred
		end
end
