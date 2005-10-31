indexing
	description: "[
		A thread-safe action queue to process actions from a queue in a syncronious manner.
		
		Note: Implementation is a queue and all items are removed once they have been
		      executed.
	]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_REPORT_QUEUED_ACTION_TIMER
	
inherit
	DISPOSABLE

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create an initialize a new idle action timer
		do
			create mutex_guard
			create action_queue.make (5)
			create action_timer
			action_timer.actions.extend (agent on_tick)
			resume
		end

feature -- Disposing
	
	dispose is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
			-- Effect it in descendants to perform specific dispose
			-- actions. Those actions should only take care of freeing
			-- external resources; they should not perform remote calls
			-- on other objects since these may also be dead and reclaimed.
		do
			if not is_disposed and then action_timer /= Void then
				action_timer.actions.wipe_out
			end
			is_disposed := True
		ensure then
			is_disposed: is_disposed
		end
		
	is_disposed: BOOLEAN
			-- Has instance been disposed of?
	
feature -- Extending

	extend (a_action: PROCEDURE [ANY, TUPLE]) is
			-- Extend action queue with `a_action'
		require
			a_action_attached: a_action /= Void
			not_is_disposed: not is_disposed
		do
			lock_access
			action_queue.extend (a_action)
			unlock_access
		ensure
			a_action_added: action_queue.has (a_action)
		end
		
feature {NONE} -- Basic Operations
	
	suspend is
			-- Suspend timer actions
		require
			action_timer_resumed: action_timer.interval = interval
			not_is_disposed: not is_disposed
		do
			lock_access
			action_timer.set_interval (0)
			unlock_access
		ensure
			action_timer_paused: action_timer.interval = 0
		end
		
	resume is
			-- Resume timer actions
		require
			action_timer_paused: action_timer.interval = 0
			not_is_disposed: not is_disposed
		do
			lock_access
			action_timer.set_interval (interval)
			unlock_access
		ensure
			action_timer_resumed: action_timer.interval = interval
		end	
		
feature {NONE} -- Action Processing

	on_tick is
			-- Called when timer ticks
		do
			lock_access
			suspend
				
			from
			until
				action_queue.is_empty
			loop
				action_queue.item.call ([])
				action_queue.remove
			end
				
			resume
			unlock_access
		end
		
feature {NONE} -- Implementation

	lock_access is
			-- Locks access
		do
			mutex_guard.lock
		end
		
	unlock_access is
			-- Unlocks access
		do
			mutex_guard.unlock
		end

	action_queue: ARRAYED_QUEUE [PROCEDURE [ANY, TUPLE]]
			-- Queue of all actions to process.
			
	action_timer: EV_TIMEOUT
			-- Idle action timer.
			
	interval: INTEGER is 100
			-- Timer interval.
			
	mutex_guard: MUTEX
			-- Mutex used to syncronize access
	
invariant
	action_queue_attached: action_queue /= Void
	action_timer_attached: action_timer /= Void
	mutex_guard_attached: mutex_guard /= Void

end -- class EC_REPORT_IDLE_TIMER
