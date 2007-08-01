indexing
	description:
		"[
			Information about covariant features. This datastructure allows to ask if a feature is
			covariantly redefined in any descendant starting from a class id.

			The data structure works as follows:
			  * The hashtable `data' holds a list of class id's per routine id.
			  * Only class ids which covariantly redefine the routine (identified by the routine id)
			    are in this list. Empty lists are not stored.
			That means:
			  * If a routine id has no associated list, then there are no covariant redefinitions for
			    this routine at all
			  * If a routine id has an associated list, then you can check if any of the class ids which
			    are in the list conform to the given class id:
			      * If yes, then this subclass covariantly redefines the feature
			      * If no, then no subclass covariantly redefine the feature
			
			Todo: The data structure for the list of class ids could be changed to a heap. It should have
			      better performance than an arrayed list
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_COVARIANCE_INDEX

inherit
	SHARED_WORKBENCH

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize empty index.
		do
			create data.make (300)
		end

feature -- Status report

	is_covariantly_redefined (a_routine_id: INTEGER; a_class: CLASS_C): BOOLEAN is
			-- Is the routine with id `a_routine_id' covariantly redefined in any
			-- descendant of class `a_class'?
		local
			l_class_list: ARRAYED_LIST [INTEGER]
		do
				-- Check if a class list exists
			data.search (a_routine_id)
			if data.found then
					-- If yes, loop through class ids
				l_class_list := data.found_item
				from
					l_class_list.start
				until
					l_class_list.after or Result
				loop
						-- Check for every class id if the class conforms to the class in question
						-- If yes,
					Result := system.class_of_id (l_class_list.item).conform_to (a_class)
					l_class_list.forth
				end
			end
		end

	is_covariantly_redefined_by_class_id (a_routine_id, a_class_id: INTEGER): BOOLEAN is
			-- Is the routine with id `a_routine_id' covariantly redefined in any
			-- descendant of class with `a_class_id'?
		do
			Result := is_covariantly_redefined (a_routine_id, system.class_of_id (a_class_id))
		end

feature -- Element change

	add_class (a_routine_id_set: ROUT_ID_SET; a_class: CLASS_C) is
			-- Insert class `a_class' for routine ids in `a_routine_id_set'.
		require
			a_routine_id_set_not_void: a_routine_id_set /= Void
			a_class_not_void: a_class /= Void
		do
			add_class_id (a_routine_id_set, a_class.class_id)
		ensure
			added: is_covariantly_redefined (a_routine_id_set.first, a_class)
		end

	add_class_id (a_routine_id_set: ROUT_ID_SET; a_class_id: INTEGER) is
			-- Insert class with id `a_class_id' for routine ids in `a_routine_id_set'.
		require
			a_routine_id_set_not_void: a_routine_id_set /= Void
		local
			i, l_count, l_routine_id: INTEGER
			l_class_list: ARRAYED_LIST [INTEGER]
		do
			from
				i := 1
				l_count := a_routine_id_set.count
			until
				i > l_count
			loop
				l_routine_id := a_routine_id_set.item (i)
				data.search (l_routine_id)
				if data.found then
					l_class_list := data.found_item
					if not l_class_list.has (a_class_id) then
						l_class_list.extend (a_class_id)
					end
				else
					create l_class_list.make (3)
					data.put (l_class_list, l_routine_id)
					l_class_list.extend (a_class_id)
				end
				i := i + 1
			end
		ensure
			added: is_covariantly_redefined_by_class_id (a_routine_id_set.first, a_class_id)
		end

	remove_class (a_routine_id_set: ROUT_ID_SET; a_class: CLASS_C) is
			-- Remove class `a_class' for routines ids in `a_routine_id_set'.
		require
			a_routine_id_set_not_void: a_routine_id_set /= Void
			a_class_not_void: a_class /= Void
		do
			remove_class_id (a_routine_id_set, a_class.class_id)
		ensure
			-- No guarantees can be made. A descendant can still covariantly redefine the feature
		end

	remove_class_id (a_routine_id_set: ROUT_ID_SET; a_class_id: INTEGER) is
			-- Remove class with id `a_class_id' for routines ids in `a_routine_id_set'.
		require
			a_routine_id_set_not_void: a_routine_id_set /= Void
		local
			i, l_count, l_routine_id: INTEGER
			l_class_list: ARRAYED_LIST [INTEGER]
		do
			from
				i := 1
				l_count := a_routine_id_set.count
			until
				i > l_count
			loop
				l_routine_id := a_routine_id_set.item (i)
				data.search (l_routine_id)
				if data.found then
					l_class_list := data.found_item
					if l_class_list.has (a_class_id) then
						l_class_list.start
						l_class_list.prune (a_class_id)
					end
					if l_class_list.is_empty then
						data.remove (l_routine_id)
					end
				end
				i := i + 1
			end
		ensure
			-- No guarantees can be made. A descendant can still covariantly redefine the feature
		end

feature {NONE} -- Implementation

	data: HASH_TABLE [ARRAYED_LIST [INTEGER], INTEGER]
			-- Data storage:
			--  The hashtable holds a list of class ids indexed by routine ids

end
