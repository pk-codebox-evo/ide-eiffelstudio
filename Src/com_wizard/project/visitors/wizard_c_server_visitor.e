indexing
	description: "C server visitor"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_C_SERVER_VISITOR

inherit
	WIZARD_TYPE_INFO_VISITOR
		redefine
			process_alias,
			process_coclass,
			process_implemented_interface,
			process_interface,
			process_enum,
			process_record
		end		

feature -- Processing

	process_alias (a_descriptor: WIZARD_ALIAS_DESCRIPTOR) is
			-- process alias
			-- generate code for alias described in `alias_descriptor'
		local
			l_generator: WIZARD_ALIAS_C_SERVER_GENERATOR
		do
			Precursor (a_descriptor)
			create l_generator
			l_generator.generate (a_descriptor)
		end

	process_coclass (a_descriptor: WIZARD_COCLASS_DESCRIPTOR ) is
			-- process coclass
			-- generate code for coclass described in `coclass_descriptor'
			-- for every interface in `coclass_descriptor'
				-- call `process_interface'
				-- generate C calls for every function of interface
				-- add deferred interface class as parent
		local
			l_generator: WIZARD_COCLASS_C_SERVER_GENERATOR
		do
			Precursor (a_descriptor)
			create l_generator
			l_generator.generate (a_descriptor)
		end

	process_implemented_interface (a_descriptor: WIZARD_IMPLEMENTED_INTERFACE_DESCRIPTOR) is
			-- process interface
			-- generated class for interface
			-- `inteface_descriptor' must provide information on
			-- every function of interface
		local
			l_generator: WIZARD_IMPLEMENTED_INTERFACE_C_SERVER_GENERATOR
			l_interface: WIZARD_INTERFACE_DESCRIPTOR
		do
			Precursor (a_descriptor)
			l_interface := a_descriptor.interface_descriptor
			if not l_interface.is_well_known_interface then
				create l_generator
				l_generator.generate (a_descriptor)
			end
		end

	process_interface (a_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- process interface
			-- generated deffered class for interface
			-- `inteface_descriptor' must provide information on
			-- every functiom of interface
		local
			l_generator: WIZARD_INTERFACE_C_SERVER_GENERATOR
		do
			Precursor (a_descriptor)
			if not a_descriptor.is_well_known_interface then
				create l_generator
				l_generator.generate (a_descriptor)
			end
		end

	process_enum (a_descriptor: WIZARD_ENUM_DESCRIPTOR) is
			-- process enumeration
			-- generate code for enumeration described by `enum_descriptor'
			-- for every constant in `enum_descriptor'
			-- generate code for constant
		do
			Precursor (a_descriptor)
		end

	process_record (a_descriptor: WIZARD_RECORD_DESCRIPTOR) is
			-- process structure
			-- generate code for structure described by `record_descriptor'
			-- for every field in `record_descriptor'
				-- if field type is basic type then
					-- generate Eiffel set/get
					-- generate C macros
				-- if field type is record then
					-- generate set/get for structure item (Eiffel + C)
					-- call `process_record' if it was not processed
				-- if field type is enumeration then
					-- 
				-- if field type is union then
					--
		local
			l_generator: WIZARD_RECORD_C_SERVER_GENERATOR
		do
			Precursor (a_descriptor)
			create l_generator
			l_generator.generate (a_descriptor)
		end

feature {NONE} -- Implementation

	language: STRING is
			-- Lanuage currently generated
		once
			Result := C
		end

	Module_type: STRING is
			-- Module type currently generated
		once
			Result := Server
		end

end -- class WIZARD_C_SERVER_VISITOR

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

