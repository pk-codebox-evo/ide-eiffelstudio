indexing
	description: "Objects that represent test cases"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_TEST_CASE

inherit

	COMPARABLE

create
	make

feature {NONE} -- Initialization

	make (a_target_class: like class_under_test; a_feature: like feature_under_test; a_test_class: like tester_class) is
			-- Initialize new test case for testing `a_feature' of class `a_target_class' where
			-- `a_test_class' is the classed used for testing.
		require
			valid_target_class: a_target_class /= Void
			feature_not_empty: a_feature /= Void
			valid_test_class: a_test_class /= Void
		do
			class_under_test := a_target_class
			feature_under_test := a_feature
			tester_class := a_test_class
			create update_status_actions
		ensure
			target_class_set: class_under_test = a_target_class
			e_feature_set: feature_under_test = a_feature
			test_class_set: tester_class = a_test_class
		end


feature -- Access

	cluster_under_test: CLUSTER_I is
			-- Cluster of `class_under_test'
		do
			Result := class_under_test.cluster
		ensure
			correct_result: Result = class_under_test.cluster
		end

	class_under_test: EIFFEL_CLASS_I
			-- Class under tested

	feature_under_test: E_FEATURE
			-- Name of feature under tested

	tester_class: CLASS_I
			-- Class used for testing

	last_exception_tag: STRING
			-- Name of the last violation thrown by the test case

	status: INTEGER
			-- Status of `Current'

	pass_code, fail_code,
	invalid_code, not_verified_code: INTEGER is unique
			-- Test case status codes

	correct_status (a_status: INTEGER): BOOLEAN is
			-- Is `a_status' a correct status
		do
			Result := a_status = fail_code or a_status = pass_code or a_status = invalid_code or a_status = not_verified_code
		end

feature -- Status setting

	is_verified: BOOLEAN is
			-- Has `Current' been verified yet?
		do
			Result := status /= not_verified_code
		end

	passes: BOOLEAN is
			-- Did `Current' pass last test execution?
		do
			Result := status = pass_code
		end

	set_status (a_status: like status; an_exception_tag: like last_exception_tag) is
			-- Set `status' to `a_status' and `last_exception_tag' to `an_exception' and notify agents.
		require
			correct_status: correct_status (a_status)
		do
			last_exception_tag := an_exception_tag
			status := a_status
			update_status_actions.call ([])
		ensure
			last_exception_tag_set: last_exception_tag = an_exception_tag
			status_set: status = a_status
		end

feature -- Actions

	update_status_actions: ACTION_SEQUENCE [TUPLE]
			-- Agents called when execution of test case is over

feature -- Compare

	infix "<" (other: like Current): BOOLEAN is
			-- is 'Current' less than 'other'?
		require else
			other_not_void: other /= Void
		do
			if cluster_under_test < other.cluster_under_test then
				Result := True
			elseif cluster_under_test = other.cluster_under_test then
				if class_under_test < other.class_under_test then
					Result := True
				elseif class_under_test = other.class_under_test then
					if feature_under_test < other.feature_under_test then
						Result := True
					elseif feature_under_test.is_equal (other.feature_under_test) then
						if tester_class < other.tester_class then
							Result := True
						end
					end
				end
			end
		end


invariant
	target_cluster_not_void: class_under_test /= Void
	target_class_not_void: class_under_test /= Void
	e_feature_not_void: feature_under_test /= Void
	test_class_not_void: tester_class /= Void
	update_status_actions_not_void: update_status_actions /= Void

end
