indexing
	description: "Objects that ..."
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST

inherit

	SHARED_DEBUGGED_OBJECT_MANAGER

	export
		{NONE} all
	end

create
	make

feature {NONE} -- Initialization

	make (addr: STRING; cse: EIFFEL_CALL_STACK_ELEMENT debug_window: EV_WINDOW) is
			-- Initialize `Current'.
		local
			info: STRING
			cd: EV_INFORMATION_DIALOG
			dom: DEBUGGED_OBJECT_MANAGER
			alist: LIST [ABSTRACT_DEBUG_VALUE]
			vlist: DS_LIST [ABSTRACT_DEBUG_VALUE]
			dv: DUMP_VALUE
		do
			create info.make_empty
			dom := debugged_object_manager
			vlist := dom.attributes_at_address (addr, 0, 0)
			info.append ("CLASS: ")
			info.append (cse.class_name)
			info.append ("%N")
			info.append ("FEATURE: ")
			info.append (cse.routine.name)
			info.append ("%N")
			info.append ("ARGUMENTS%N")
			alist := cse.arguments
			from alist.start until alist.after loop
				info.append ("   ")
				info.append (alist.item.name)
				info.append (": ")
				info.append (alist.item.dynamic_class.name)
				dv := alist.item.dump_value
				if dv.has_formatted_output then
					info.append (" (" + dv.formatted_output + ")")
				end
				info.append_character ('%N')
				alist.forth
			end
			info.append ("OBJECT ATTRIBUTES%N")
			vlist := dom.attributes_at_address (addr, 0, 0)
			from vlist.start until vlist.after loop
				info.append ("   ")
				info.append (vlist.item_for_iteration.name)
				info.append (": ")
				info.append (vlist.item_for_iteration.dynamic_class.name)
				dv := vlist.item_for_iteration.dump_value
				if dv.has_formatted_output then
					info.append (" (" + dv.formatted_output + ")")
				end
				info.append_character ('%N')
				vlist.forth
			end
			create cd.make_with_text (info)
			cd.set_title ("Postcondition Violation")
			cd.show_modal_to_window (debug_window)
--	if application.status.exception_occurred then
--					info := "Exception code: " + application.status.exception_code.out + "%N"
--					status ?= application.status
--					info.append ("Class: " + status.dynamic_class.name + "%N")
--					info.append ("Object Addr: " + status.object_address)
					--kdump := application.dump_value_at_address_with_class (status.dynamic_class, status.object_address)
--					if cse /= Void then
--						info := "Exception code: " + application.status.exception_code.out
--						dslist := application.debug_value_at_address_with_class (cse.object_address, cse.dynamic_class).children
--						from
--							dslist.start
--						until
--							dslist.after
--						loop
--							info.append (dslist.item_for_iteration.name)
--							dslist.forth
--						end
--					else
--						info := "cse void..."
--					end
		end

end
