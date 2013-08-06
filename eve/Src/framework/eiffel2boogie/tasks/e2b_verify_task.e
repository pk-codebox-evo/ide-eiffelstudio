note
	description: "Composite task of verifying Eiffel using the Boogie verifier."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_VERIFY_TASK

inherit

	ROTA_TIMED_TASK_I
		export
			{ANY} cancel
		end

	ROTA_SERIAL_TASK_I
		redefine
			remove_task
		end

	E2B_SHARED_CONTEXT

create
	make

feature {NONE} -- Implementation

	make (a_translator_input: E2B_TRANSLATOR_INPUT)
			-- Initialize task.
		do
			create boogie_universe.make
			create verifier.make

			create remaining_tasks.make
			remaining_tasks.extend (create {E2B_TRANSLATE_CHUNK_TASK}.make (a_translator_input, boogie_universe))
			remaining_tasks.extend (create {E2B_GENERATE_BOOGIE_TASK}.make (boogie_universe, verifier))
			remaining_tasks.extend (create {E2B_EXECUTE_BOOGIE_TASK}.make (verifier))
			remaining_tasks.extend (create {E2B_EVALUATE_BOOGIE_OUTPUT_TASK}.make (verifier))
			if options.is_reverification_with_inlining_enabled then
				remaining_tasks.extend (create {E2B_VERIFY_WITH_INLINING_TASK}.make (verifier, remaining_tasks))
			end
			if options.is_postcondition_mutation_enabled then
				remaining_tasks.extend (create {E2B_POSTCONDITION_MUTATION_TASK}.make (boogie_universe, verifier))
			end
		end

feature -- Access

	sleep_time: NATURAL = 100
			-- <Precursor>

	sub_task: detachable ROTA_TASK_I
			-- <Precursor>
		do
			if not remaining_tasks.is_empty then
				Result := remaining_tasks.first
			end
		end

	verifier_result: detachable E2B_RESULT
			-- Result of verification.
		do
			Result := verifier.last_result
		end

feature -- Status report

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

feature -- Element change

	append_task (a_task: ROTA_TASK_I)
			-- Append a task to do after other tasks finished.
		do
			remaining_tasks.extend (a_task)
		end

feature {NONE} -- Implementation

	remove_task (a_task: attached like sub_task; a_cancel: BOOLEAN)
			-- <Precursor>
		do
			if a_cancel then
				remaining_tasks.wipe_out
			else
				remaining_tasks.start
				remaining_tasks.remove
			end
		end

	remaining_tasks: LINKED_LIST [ROTA_TASK_I]
			-- Tasks to work on.

	verifier: E2B_VERIFIER
			-- Boogie verifier.

	boogie_universe: IV_UNIVERSE
			-- Boogie universe.

end
