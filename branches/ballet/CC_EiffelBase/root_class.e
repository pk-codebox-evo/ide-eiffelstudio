indexing
	description	: "System's root class aka Dump"
	author: "Marco Zietzling"
	copyright: "Copyright (c) 2007, Marco Zietzling"
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT_CLASS

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			-- test cc_linked_list from CC_EiffelBase

			-- test linked_list from EiffelBase
		end

feature -- DUMP

	foo is
			-- test bla
		use
			-- FRAME expr
		modify
			-- FRAME expr
		local
			gobo_linked_list: DS_LINKED_LIST [INTEGER]
			eiffelBase_linked_list: LINKED_LIST [INTEGER]

			repr: MML_SET [ANY]

			gobo_set: DS_SET [INTEGER]
			eiffelBase_set: SET[INTEGER]

			gobo_table: DS_TABLE [ANY, INTEGER]
			eiffelBase_table: TABLE [ANY, INTEGER]

			eiffelBase_bag: BAG [INTEGER]
			-- kein gobo bag

			-- DUMP
			eiffelBase_collection: COLLECTION [INTEGER]

			cc_set: CC_SET [INTEGER]
			cc_bag: CC_BAG [INTEGER]
			cc_table: CC_TABLE [INTEGER, INTEGER]

			cc_bilinear: CC_BILINEAR [INTEGER]

			cc_list: CC_LIST [INTEGER]

			cc_linked_list: CC_LINKED_LIST [INTEGER]

		do
			create gobo_linked_list.make
			create eiffelbase_linked_list.make

			-- create eiffelbase_collection.make
		ensure
			confined bla -- FRAME expr
		end


end -- class ROOT_CLASS
