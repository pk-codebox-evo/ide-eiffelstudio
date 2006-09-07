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
			-- Initialize new test case for testing 'a_feature' of class 'a_target_class' where
			-- 'a_test_class' is the classed used for testing
		require
			valid_target_class: a_target_class /= Void
			feature_not_empty: a_feature /= Void and then not a_feature.is_empty
			valid_test_class: a_test_class /= Void
			a_tag_not_empty: a_tag /= Void and then not a_tag.is_empty
			an_id_not_empty: an_id /= Void and then not an_id.is_empty
		do
			target_class := a_target_class
			feature_name := a_feature
			test_class := a_test_class
			exception_tag := a_tag
			id := an_id
			create on_start_testing.make (5)
			create on_finish_testing.make (5)
		ensure
			target_class_set: target_class = a_target_class
			e_feature_set: feature_name = a_feature
			test_class_set: test_class = a_test_class
		end


feature -- Access

	target_cluster: CLUSTER_I is
			-- cluster which class being tested belongs to
		do
			Result := target_class.cluster
		ensure
			correct_result: Result = target_class.cluster
		end

	target_class: EIFFEL_CLASS_I
			-- class under tested

	feature_name: STRING
			-- name of feature under tested

	test_class: CLASS_I
			-- class used for testing

	exception_tag: STRING
			-- name of postcondition which is violated

	id: STRING
			-- identifier for state which is reproduced at test case execution

	is_testing: BOOLEAN
			-- is test case beeing executed?

	passes: BOOLEAN
			-- does test case pass?

feature -- Status seeting

	start_testing is
			-- Set 'is_testing' to true an notify agents
		require
			not_testing: not is_testing
		do
			from
				is_testing := True
				on_start_testing.start
			until
				on_start_testing.after
			loop
				on_start_testing.item.call ([Current])
				on_start_testing.forth
			end
		ensure
			started_testing: is_testing
		end

	set_passes (a_result: BOOLEAN) is
			-- Set 'passes' to 'a_result' and notify agents
		do
			from
				is_testing := False
				passes := a_result
				on_finish_testing.start
			until
				on_finish_testing.after
			loop
				on_finish_testing.item.call ([Current, a_result])
				on_finish_testing.forth
			end
		ensure
			testing_stopped: not is_testing
			passed_set: passes = a_result
		end



feature -- Event handling

	on_start_testing: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [CDD_TEST_CASE]]]
			-- agents called when test case is beeing executed

	on_finish_testing: ARRAYED_LIST [PROCEDURE [ANY, TUPLE [CDD_TEST_CASE, BOOLEAN]]]
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
	e_feature_not_empty: feature_name /= Void and then not feature_name.is_empty
	test_class_not_void: test_class /= Void
	on_start_testing_not_void: on_start_testing /= Void
	on_finish_testing_not_void: on_finish_testing /= Void

end
