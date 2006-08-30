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
			valid_feature: a_feature /= Void and then not a_feature.is_empty
			valid_test_class: a_test_class /= Void
		do
			target_class := a_target_class
			e_feature := a_feature
			test_class := a_test_class
			file_name := test_class.file_name
			create on_start_testing.make (5)
			create on_pass.make (5)
			create on_failure.make (5)
		end


feature -- Access

	target_cluster: CLUSTER_I is
			--
		do
			Result := target_class.cluster
		end


	target_class: EIFFEL_CLASS_I

	e_feature: STRING

	test_class: CLASS_I

	file_name: STRING

	is_testing: BOOLEAN
		-- is test case running?

	passes: BOOLEAN
		-- did test case pass last execution?

feature -- Status seeting

	set_start_testing is
			--
		require
			not_testing: not is_testing
		do
			from
				is_testing := True
				on_start_testing.start
			until
				on_start_testing.after
			loop
				on_start_testing.item.call ([])
				on_start_testing.forth
			end
		end

	set_test_result (a_result: BOOLEAN) is
			--
		do
			
		end



feature -- Event handling

	on_start_testing: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]

	on_pass: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]

	on_failure: ARRAYED_LIST [PROCEDURE [ANY, TUPLE]]


feature -- Compare

	infix "<" (other: like Current): BOOLEAN is
			--
		do
			if target_cluster < other.target_cluster then
				Result := True
			elseif target_cluster = other.target_cluster then
				if target_class < other.target_class then
					Result := True
				elseif target_class = other.target_class then
					if e_feature < other.e_feature then
						Result := True
					elseif e_feature = other.e_feature then
						if test_class < other.test_class then
							Result := True
						end
					end
				end
			end
		end


invariant
	invariant_clause: True -- Your invariant here

end
