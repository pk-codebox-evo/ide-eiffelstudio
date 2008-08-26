indexing
	description: "[
		Interface of an registrar for test processors
		
		Processors can be registrared or unregistered based on their type. Clients can then query for a
		certain processor providing a type.
		
		Add and remove events are observable so clients can be notified when a new item is available or
		beeing disposed.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_PROCESSOR_REGISTRAR_I [G]

inherit
	USABLE_I

feature -- Access

	processors: !DS_LINEAR [!G]
			-- Registered processors
		require
			usable: is_interface_usable
		deferred
		ensure
			result_consistent: Result = processors
		end

feature -- Status report

	is_registered (a_type: !TYPE [G]): BOOLEAN
			-- Is an item available for `a_type'?
			--
			-- `a_type': Type requested processor conforms to.
			-- `Result': True if processor of `a_type' is registered, False otherwise.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Query

	processor (a_type: !TYPE [G]): !G
			-- Processor registered for type.
			--
			-- `a_type': Type requested processor conforms to.
			-- `Result': Conforming processor registered under `a_type'.
		require
			is_interface_usable: is_interface_usable
			a_type_is_registered: is_registered (a_type)
		deferred
		ensure
			items_has_result: processors.has (Result)
			conforming_type: a_type.attempt (Result) /= Void
		end

	is_valid_processor (a_processor: !G): BOOLEAN
			-- Can processor be registered?
			--
			-- `a_processor': Processor to be registered.
			-- `Result': True if `a_processor' can be registered, False otherwise.
		require
			usable: is_interface_usable
		do
			Result := True
		end

feature -- Element change

	register (a_processor: !G; a_type: !TYPE [G]) is
			-- Register processor associated with type.
			--
			-- `a_processor': Processor to be registered.
			-- `a_type': Type under which processor shall be registered and conforms to.
		require
			is_interface_usable: is_interface_usable
			a_item_valid: is_valid_processor (a_processor)
			conforming_type: a_type.attempt (a_processor) /= Void
			not_is_registered: not is_registered (a_type)
		deferred
		ensure
			is_registered: is_registered (a_type)
			items_has_a_item: processors.has (a_processor)
		end

	unregister (a_type: !TYPE [G])
			-- Unregister processor associated with type.
			--
			-- `a_type': Type processor is registered with.
		require
			is_interface_usable: is_interface_usable
			is_registered: is_registered (a_type)
		deferred
		ensure
			not_is_registered: not is_registered (a_type)
		end

end
