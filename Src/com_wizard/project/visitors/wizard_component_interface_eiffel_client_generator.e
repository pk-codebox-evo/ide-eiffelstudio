indexing
	description: "Processing interface for Eiffel client component."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COMPONENT_INTERFACE_EIFFEL_CLIENT_GENERATOR

inherit
	WIZARD_COMPONENT_INTERFACE_EIFFEL_GENERATOR

create
	make

feature -- Basic operations

	process_property (a_property: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Process property.
		local
			l_generator: WIZARD_EIFFEL_CLIENT_PROPERTY_GENERATOR
		do
			create l_generator.generate (component, a_property)
			add_property_features_to_class (l_generator)
			add_property_rename (l_generator)
		end

	process_function (a_function: WIZARD_FUNCTION_DESCRIPTOR) is
			-- Process function.
		local
			l_generator: WIZARD_EIFFEL_CLIENT_FUNCTION_GENERATOR
		do
			create l_generator.generate (component, a_function)
			add_feature_rename (l_generator)
			if not a_function.is_renaming_clause then
				add_feature_to_class (l_generator.feature_writer)
				eiffel_writer.add_feature (l_generator.external_feature_writer, Externals)
			end
		end

end -- class WIZARD_COMPONENT_INTERFACE_EIFFEL_CLIENT_GENERATOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
