note
	description: "Shared parts between read and write manager. Contains an array of OBJECT_DATA and some utility functions to manipulate the items."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PS_ABSTRACT_MANAGER [G -> PS_OBJECT_DATA]

inherit
	PS_ABEL_EXPORT

feature {NONE} -- Initialization

	initialize (meta_mgr: like metadata_factory; id_mgr: like id_manager; key_mapper: like primary_key_mapper)
			-- Initialization for `Current'
		do
			metadata_factory := meta_mgr
			id_manager := id_mgr
			primary_key_mapper := key_mapper
			create identity_type_handlers.make (tiny_size)
			create value_type_handlers.make_empty (tiny_size)
			create type_handler_cache.make (tiny_size)
		end

	tiny_size: INTEGER = 5
			-- A predefined size for tiny arrays.

	small_size: INTEGER = 20
			-- A predefined size for small arrays.

	default_size: INTEGER = 100
			-- A predefined size for normal arrays.

feature {PS_ABEL_EXPORT} -- Access

	count: INTEGER
			-- The number of objects known to this manager.
		do
			Result := object_storage.count
		ensure
			correct: object_storage.count = Result
		end

	item (index: INTEGER): G
			-- Get the object with index `index'
		require
			valid_index: 1 <= index and index <= count
		do
			Result := object_storage [index]
		ensure
			object_correct: object_storage [index] = Result
			index_set: Result.index = index
		end

feature {PS_ABEL_EXPORT} -- Access

	metadata_factory: PS_METADATA_FACTORY
			-- A factory for PS_TYPE_METADATA.

	id_manager: PS_OBJECT_IDENTIFICATION_MANAGER
			-- The ABEL identifier manager.

	primary_key_mapper: PS_KEY_POID_TABLE
			-- A table to map an ABEL identifier to a primary key.

	transaction: PS_INTERNAL_TRANSACTION
			-- The transaction in which the current operation is running.
		do
			check attached internal_transaction as attached_transaction then
				Result := attached_transaction
			end
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_transaction_initialized: BOOLEAN
			-- Is `transaction' initialized?
		do
			Result := attached internal_transaction
		end

feature {PS_ABEL_EXPORT} -- Element change

	add_handler (handler: PS_HANDLER)
			-- Add `handler' to the current manager.
		do
			if handler.is_mapping_to_value_type then
				if value_type_handlers.count = value_type_handlers.capacity then
					value_type_handlers := value_type_handlers.resized_area (2 * value_type_handlers.capacity + 1)
				end
				value_type_handlers.extend (handler)
			else
				identity_type_handlers.extend (handler)
			end
		end

feature {NONE} -- Utilities

	assign_handlers (set: INDEXABLE [INTEGER, INTEGER])
			-- Assign an appropriate handler for all objects with an index in `set'.
		local
			i: INTEGER
			object: PS_OBJECT_DATA
			found: BOOLEAN
			not_found_exception: PS_INTERNAL_ERROR
		do
			across
				set as idx_cursor
			loop
				object := item (idx_cursor.item)
				if
					attached type_handler_cache [object.type] as cached
					and then cached.can_handle (object)
				then
					object.set_handler (cached)
				else

					i := idx_cursor.item
					found := False
						-- First search for value types.
					across
						value_type_handlers as v_cursor
					until
						found
					loop
						if v_cursor.item.can_handle (item (i)) then
							item (i).set_handler (v_cursor.item)
							type_handler_cache.extend (v_cursor.item, item (i).type)
							found := True
						end
					end

					across
						identity_type_handlers as i_cursor
					until
						found
					loop
						if i_cursor.item.can_handle (item (i)) then
							item (i).set_handler (i_cursor.item)
							type_handler_cache.extend (i_cursor.item, item (i).type)
							found := True
						end
					end

					if not found then
						create not_found_exception
						not_found_exception.set_description (
							"Could not find a handler for type: " + item (i).type.type.name + "%N")
						not_found_exception.raise
					end

				end
			end
		end

	type_handler_cache: HASH_TABLE [PS_HANDLER, PS_TYPE_METADATA]
			-- A cache to quickly map a type to a handler.

	search_value_type_handler (type: PS_TYPE_METADATA): detachable PS_HANDLER
			-- Try to find a value type handler for `type'
		local
			i: INTEGER
			handler: PS_HANDLER
		do
			from
				i := value_type_handlers.count - 1
			until
				i < 0
			loop
				handler := value_type_handlers [i]
				if handler.can_handle_type (type) then
					Result := handler
				end
				i := i - 1
			variant
				i + 2
			end
		ensure
			correct: attached Result implies Result.can_handle_type (type)
		end

	do_all (operation: PROCEDURE [ANY, TUPLE [PS_HANDLER, G]])
			-- Apply `operation' on all items.
			-- Ignore items when {PS_OBJECT_DATA}.handler is void or {PS_OBJECT_DATA}.is_ignored is True.
		do
			do_all_in_set (operation, 1 |..| count)
		end

	do_all_in_set (operation: PROCEDURE [ANY, TUPLE [PS_HANDLER, G]]; set: INDEXABLE [INTEGER, INTEGER])
			-- Apply `operation' on all items with an index in `set'.
			-- Ignore items when {PS_OBJECT_DATA}.handler is void or {PS_OBJECT_DATA}.is_ignored is True.
			-- Do nothing if `from_index' > `to_index'
		local
			index: INTEGER
		do
			across
				set as idx_cursor
			loop
				index := idx_cursor.item
				if
					item (index).is_handler_initialized
					and not item (index).is_ignored
				then
					operation.call ([item (index).handler, item (index)])
				end
			end
		end

feature {NONE} -- Internal data structures

	identity_type_handlers: ARRAYED_LIST [PS_HANDLER]
			-- All identity type handlers.

	value_type_handlers: SPECIAL [PS_HANDLER]
			-- All value type handlers.


	object_storage: ARRAYED_LIST [G]
			-- An internal storage for objects.

	internal_transaction: detachable like transaction
			-- The detachable attribute for `transaction'
end
