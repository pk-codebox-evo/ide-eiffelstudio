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

	make (a_target_class: like target_class;
		a_feature: like feature_name;
		a_test_class: like test_class;
		a_tag: like exception_tag;
		an_id: like id) is
			-- Initialize new test case for testing `a_feature' of class `a_target_class' where
			-- `a_test_class' is the classed used for testing.
		require
			valid_target_class: a_target_class /= Void
			feature_not_empty: a_feature /= Void
			valid_test_class: a_test_class /= Void
			a_tag_not_empty: a_tag /= Void and then not a_tag.is_empty
			an_id_not_empty: an_id /= Void and then not an_id.is_empty
		do
			target_class := a_target_class
			feature_name := a_feature
			test_class := a_test_class
			exception_tag := a_tag
			id := an_id
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

	exception_tag: STRING
			-- Name of postcondition which is violated
			-- TODO: Does this really just store tags from postconditions?
			-- What about tags of preconditions, invariants, etc...

	id: STRING
			-- Identifier for state which is reproduced at test case execution

	was_tested: BOOLEAN
			-- Has this test case excuted yet?

	is_tested: BOOLEAN
			-- Is this test case currently being executed?

	passes: BOOLEAN
			-- Does test case pass?

feature -- Status seeting

	start_testing is
			-- Set `is_testing' to true an notify agents.
		require
			not_testing: not is_tested
		do
			is_tested := True
			update_status_actions.call ([])
		ensure
			started_testing: is_tested
		end

	set_passes (a_result: BOOLEAN) is
			-- Set 'passes' to 'a_result' and notify agents.
		do
			was_tested := True
			is_tested := False
			passes := a_result
			update_status_actions.call ([])
		ensure
			testing_stopped: not is_tested
			was_tested: was_tested
			passed_set: passes = a_result
		end



feature -- Actions

	update_status_actions: ACTION_SEQUENCE [TUPLE]
			-- agents called when execution of test case is over

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
