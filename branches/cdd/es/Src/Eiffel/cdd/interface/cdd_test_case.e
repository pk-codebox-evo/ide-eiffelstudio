indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_CASE

inherit
	COMPARABLE


create
	make

feature {NONE} -- Initialization

	make (a_target_class: like target_class; a_feature: like e_feature; a_test_class: like test_class) is
			--
		require
			valid_target_class: a_target_class /= Void
			valid_feature: a_feature /= Void and a_feature.associated_class = a_target_class
		do

		end


feature -- Access

	target_class: CLASS_C

	e_feature: E_FEATURE

	test_class: CLASS_I

feature -- Compare

	infix "<" (other: like Current): BOOLEAN is
			--
		do
			if target_class.name < other.target_class.name then
				Result := True
			elseif target_class = other.target_class then
				if e_feature.name < other.e_feature.name then
					Result := True
				elseif e_feature = other.e_feature then
					if test_class.name < other.test_class.name then
						Result := True
					end
				end
			end
		end


feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
