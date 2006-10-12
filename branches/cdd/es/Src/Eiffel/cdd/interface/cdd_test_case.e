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

	make (a_target_class: like target_class; a_feature: like feature_name; a_test_class: like test_class) is
			-- Initialize new test case for testing `a_feature' of class `a_target_class' where
			-- `a_test_class' is the classed used for testing.
		require
			valid_target_class: a_target_class /= Void
			feature_not_empty: a_feature /= Void
			valid_test_class: a_test_class /= Void
		do
			target_class := a_target_class
			feature_name := a_feature
			test_class := a_test_class
			create update_status_actions
		ensure
			target_class_set: target_class = a_target_class
			e_feature_set: feature_name = a_feature
			test_class_set: test_class = a_test_class
		end


feature -- Access

	target_cluster: CLUSTER_I is
			-- Cluster which class being tested belongs to
		do
			Result := target_class.cluster
		ensure
			correct_result: Result = target_class.cluster
		end

	target_class: EIFFEL_CLASS_I
			-- Class under tested

	feature_name: E_FEATURE
			-- Name of feature under tested

	test_class: CLASS_I
			-- Class used for testing

	last_exception_tag: STRING
			-- Name of the last violation thrown by the test case

	was_tested: BOOLEAN
			-- Has this test case excuted yet?

	is_tested: BOOLEAN
			-- Is this test case currently being executed?

	passes: BOOLEAN
			-- Does test case pass?

feature -- Status setting

	start_testing is
			-- Set `is_testing' to true an notify agents.
		require
			not_testing: not is_tested
		do
			is_tested := True
			last_exception_tag := Void
			update_status_actions.call ([])
		ensure
			started_testing: is_tested
		end

	set_passes (a_result: BOOLEAN; an_exception_tag: STRING) is
			-- Set 'passes' to 'a_result' and notify agents.
		require
			correct_args: (not a_result) = (an_exception_tag /= Void and then not an_exception_tag.is_empty)
		do
			was_tested := True
			is_tested := False
			passes := a_result
			last_exception_tag := an_exception_tag
			update_status_actions.call ([])
		ensure
			testing_stopped: not is_tested
			was_tested: was_tested
			passed_set: passes = a_result
			last_exception_tag_set: last_exception_tag = an_exception_tag
		end

feature -- Element change

	set_last_exception_tag (a_tag: STRING) is
			-- Assign `a_tag' to `exception_tag'.
		do
			last_exception_tag := a_tag
		ensure
			exception_tag_set: last_exception_tag = a_tag
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
			if target_cluster < other.target_cluster then
				Result := True
			elseif target_cluster = other.target_cluster then
				if target_class < other.target_class then
					Result := True
				elseif target_class = other.target_class then
					if feature_name < other.feature_name then
						Result := True
					elseif feature_name.is_equal (other.feature_name) then
						if test_class < other.test_class then
							Result := True
						end
					end
				end
			end
		end


invariant
	target_cluster_not_void: target_class /= Void
	target_class_not_void: target_class /= Void
	e_feature_not_void: feature_name /= Void
	test_class_not_void: test_class /= Void
	update_status_actions_not_void: update_status_actions /= Void

end
