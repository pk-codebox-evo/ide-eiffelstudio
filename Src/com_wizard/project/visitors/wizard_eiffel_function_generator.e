indexing
	description: "Eiffel function generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_EIFFEL_FUNCTION_GENERATOR

inherit
	WIZARD_FUNCTION_GENERATOR

	ECOM_PARAM_FLAGS
		export
			{NONE} all
		end

	WIZARD_EIFFEL_ASSERTION_GENERATOR
		export
			{NONE} all
		end

feature -- Access

	feature_writer: WIZARD_WRITER_FEATURE
			-- Feature writer

	function_renamed: BOOLEAN
			-- Function is renamed?

	original_name: STRING
			-- Original name

	changed_name: STRING
			-- Changed name

feature {NONE} -- Implementation

	set_feature_result_type_and_arguments is
			-- Set arguments
		require
			non_void_feature_writer: feature_writer /= Void
		local
			arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			an_argument: STRING
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			arguments := func_desc.arguments

			from
				arguments.start
			until
				arguments.off
			loop
				visitor := arguments.item.type.visitor 

				if is_paramflag_fretval (arguments.item.flags) then
					pointed_descriptor ?= arguments.item.type

					if pointed_descriptor /= Void then
						visitor := pointed_descriptor.pointed_data_type_descriptor.visitor 
						add_enumeration_comments ("Result", pointed_descriptor.pointed_data_type_descriptor, visitor)
					else
						visitor := arguments.item.type.visitor 
						add_enumeration_comments ("Result", arguments.item.type, visitor)
					end
					feature_writer.set_result_type (visitor.eiffel_type)
					
				else
					create an_argument.make (100)
					an_argument.append (arguments.item.name)
					an_argument.append (Colon)
					an_argument.append (Space)
					an_argument.append (visitor.eiffel_type)
					feature_writer.add_argument (an_argument)
					add_enumeration_comments (arguments.item.name, arguments.item.type, visitor)
				end
				visitor := Void
				arguments.forth
			end

			visitor := func_desc.return_type.visitor 

			-- Eiffel will not have result type if the result type is "void" or "HRESULT"
			if not is_hresult (visitor.vt_type) and not is_error (visitor.vt_type) and not is_void (visitor.vt_type) then
				feature_writer.set_result_type (visitor.eiffel_type)
			end

		end

	add_enumeration_comments (a_name: STRING; a_type: WIZARD_DATA_TYPE_DESCRIPTOR;
				a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Add coments for enumeration types.
		local
			a_user_defined_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR
			an_index: INTEGER
			a_type_descriptor: WIZARD_TYPE_DESCRIPTOR
			a_comment: STRING
		do
			if a_visitor.is_enumeration then
				a_user_defined_descriptor ?= a_type
				if (a_user_defined_descriptor /= Void) then
					an_index := a_user_defined_descriptor.type_descriptor_index
					a_type_descriptor := a_user_defined_descriptor.library_descriptor.descriptors.item (an_index)
					if (feature_writer.comment = Void) then
						create a_comment.make (100)
					else
						a_comment := feature_writer.comment
					end
					if not a_comment.empty then
						a_comment.append ("%N%T%T%T-- ")
					end
					a_comment.append ("See ")
					a_comment.append (a_type_descriptor.eiffel_class_name)
					a_comment.append (" for possible ")
					a_comment.append (Back_quote)
					a_comment.append (a_name)
					a_comment.append (Single_quote)
					a_comment.append (" values.")
					feature_writer.set_comment (a_comment)
				end
			end
		end

	set_feature_assertions is
			-- Set precondition.
		local
			arguments: LINKED_LIST[WIZARD_PARAM_DESCRIPTOR]
			a_comment, comments: STRING
			pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
			a_type: WIZARD_DATA_TYPE_DESCRIPTOR
		do
			arguments := func_desc.arguments
			create comments.make (100)

			from
				arguments.start
			until 
				arguments.off
			loop

				if not is_paramflag_fretval (arguments.item.flags) then
					create a_comment.make (100)
					a_comment.append (Double_dash)
					a_comment.append (Space)

					a_comment.append (Back_quote)
					a_comment.append (arguments.item.name)
					a_comment.append (Single_quote)
					a_comment.append (Space)
					a_comment.append (Open_bracket)
					if is_paramflag_fin (arguments.item.flags) then
						if is_paramflag_fout (arguments.item.flags) then
							a_comment.append (Inout)
						else
							a_comment.append (In)
						end
					else
						a_comment.append (Out_keyword)
					end
					a_comment.append (Close_bracket)
					a_comment.append (Dot)
					a_comment.append (New_line_tab_tab_tab)

					comments.append (a_comment)

					generate_precondition (arguments.item.name, arguments.item.type, 
						is_paramflag_fin (arguments.item.flags),
						is_paramflag_fout (arguments.item.flags))
					if not assertions.empty then
						from 
							assertions.start
						until
							assertions.off
						loop
							feature_writer.add_precondition (assertions.item)
							assertions.forth
						end
					end
				end

				if not comments.empty then
					feature_writer.set_comment (comments)
				end

				if is_paramflag_fout (arguments.item.flags) then
					if is_paramflag_fretval  (arguments.item.flags) then
						pointed_descriptor ?= arguments.item.type
						if pointed_descriptor /= Void then
							a_type := pointed_descriptor.pointed_data_type_descriptor
						else
							a_type := arguments.item.type
						end

						generate_postcondition (feature_writer.name, a_type, 
							is_paramflag_fretval  (arguments.item.flags))
					else
						generate_postcondition (arguments.item.name, arguments.item.type, 
							is_paramflag_fretval  (arguments.item.flags))
					end
					if not assertions.empty then
						from 
							assertions.start
						until
							assertions.off
						loop
							feature_writer.add_postcondition (assertions.item)
							assertions.forth
						end
					end
				end

				arguments.forth
			end
		end

end -- class WIZARD_EIFFEL_FUNCTION_GENERATOR
--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
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
