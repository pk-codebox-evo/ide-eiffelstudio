note
	description: "[
		The ecosystem's default implementation for the {FILE_NOTIFIER_S} interface.
		
		The implementation performs simple cataloging of file records upon check requests and notifies listening clients of modifications.
		Modification events are passed a modification type argument, which corresponds to a value of {FILE_NOTIFIER_MODIFICATION_TYPES}.
	]"
	doc: "wiki://File Notifier Service"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	FILE_NOTIFIER

inherit
	FILE_NOTIFIER_S

	DISPOSABLE_SAFE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the file notification service
		do
			create file_records.make_default
			create file_modified_callbacks.make_default
			create file_modified_events
			auto_dispose (file_modified_events)

			file_modified_events.subscribe (agent on_file_modified)
		end

feature {NONE} -- Clean up

	safe_dispose (a_disposing: BOOLEAN)
			-- <Precursor>
		local
			l_callbacks: like file_modified_callbacks
		do
			if a_disposing then
				l_callbacks := file_modified_callbacks
				from l_callbacks.start until l_callbacks.after loop
						-- Clean up all events created
					l_callbacks.item_for_iteration.dispose
					l_callbacks.forth
				end
				file_modified_callbacks.wipe_out
				file_records.wipe_out
			end
		ensure then
			file_modified_callbacks_is_empty: a_disposing implies file_modified_callbacks.is_empty
			file_records_is_empty: a_disposing implies file_records.is_empty
		end

feature {NONE} -- Access

	file_records: DS_HASH_TABLE [FILE_NOTIFIER_RECORD, STRING_32]
			-- Table of monitored file last changed timestamps
			--
			-- Key: File name key as generated by `file_record_key'
			-- Value: Last known file changed timestamp and a monitor count

	file_modified_callbacks: DS_HASH_TABLE [EVENT_TYPE [TUPLE [modification_type: NATURAL_8]], STRING_32]
			-- Table of actions to be performed for individual file change notifications
			--
			-- Key: File name key as generated by `file_record_key'
			-- Value: The event to be fired when a modification occurs.

feature {NONE} -- Status report

	is_modification_self_published: BOOLEAN
			-- Indicates if the file modification event was published by Current.

feature -- Query

	is_monitoring (a_file_name: STRING_32): BOOLEAN
			-- <Precursor>
		do
			Result := file_records.has (file_name_key (a_file_name))
		ensure then
			file_records_has_a_file_name: Result implies file_records.has (file_name_key (a_file_name))
		end

feature -- Basic operation

	check_modifications (a_file_name: STRING_32)
			-- <Precursor>
		local
			l_key: like file_name_key
			l_records: like file_records
			l_record: FILE_NOTIFIER_RECORD
		do
			l_key := file_name_key (a_file_name)
			l_records := file_records
			if not l_records.has (l_key) then
					-- Create a new record and add it to the record table
				create l_record.make (a_file_name)
				l_records.put (l_record, l_key)
			else
				l_record := l_records.item (l_key)
			end

			check l_record_attached: l_record /= Void end
			l_record.increment_monitor_lock
		ensure then
			a_file_name_added: file_records.has (file_name_key (a_file_name))
			a_file_name_record_monitored: file_records.item (file_name_key (a_file_name)).is_monitoring
--			a_file_name_record_monitor_count_increased: old file_records.has (file_name_key (a_file_name)) implies
--				file_records.item (file_name_key (a_file_name)).monitor_count = old file_records.item (file_name_key (a_file_name)).monitor_count + 1
		end

	check_modifications_with_callback (a_file_name: STRING_32; a_callback: PROCEDURE [ANY, TUPLE [modification_type: NATURAL_8]])
			-- <Precursor>
		local
			l_key: like file_name_key
			l_callbacks: like file_modified_callbacks
			l_events: EVENT_TYPE [TUPLE [modification_type: NATURAL_8]]
		do
				-- Add the callback to the events object
			l_key := file_name_key (a_file_name)
			l_callbacks := file_modified_callbacks
			if l_callbacks.has (l_key) then
				l_events := l_callbacks.item (l_key)
			else
				create l_events
				l_callbacks.force (l_events, l_key)
			end
			l_events.subscribe (a_callback)

				-- Now perform the check, which will call the call back if a modification has taken place.
			check_modifications (a_file_name)
		ensure then
			a_file_name_added: file_records.has (file_name_key (a_file_name))
			a_file_name_record_monitored: file_records.item (file_name_key (a_file_name)).is_monitoring
--			a_file_name_record_monitor_count_increased: old file_records.has (file_name_key (a_file_name)) implies
--				file_records.item (file_name_key (a_file_name)).monitor_count = old file_records.item (file_name_key (a_file_name)).monitor_count + 1
		end

	uncheck_modifications (a_file_name: STRING_32)
			-- <Precursor>
		local
			l_key: like file_name_key
			l_records: like file_records
			l_record: FILE_NOTIFIER_RECORD
			l_callbacks: like file_modified_callbacks
		do
			l_key := file_name_key (a_file_name)
			l_records := file_records
			if l_records.has (l_key) then
				l_record := l_records.item (l_key)
				l_record.decrement_monitor_lock
				if not l_record.is_monitoring then
						-- The record is no longer being monitored, so remove it.
					l_records.remove (l_key)
					l_callbacks := file_modified_callbacks
					if l_callbacks.has (l_key) then
							-- Clean up and remove events object
						l_callbacks.item (l_key).dispose
						l_callbacks.remove (l_key)
					end
				end
			end
		ensure then
			a_file_name_removed: (old file_records.has (file_name_key (a_file_name))) and then not (old file_records.item (file_name_key (a_file_name))).is_monitoring implies not file_records.has (file_name_key (a_file_name))
			a_file_name_record_monitor_count_decreased: file_records.has (file_name_key (a_file_name)) implies file_records.item (file_name_key (a_file_name)).monitor_count = old file_records.item (file_name_key (a_file_name)).monitor_count - 1
		end

	uncheck_modifications_with_callback (a_file_name: STRING_32; a_callback: PROCEDURE [ANY, TUPLE [modification_type: NATURAL_8]])
			-- <Precursor>
		local
			l_key: like file_name_key
			l_callbacks: like file_modified_callbacks
			l_events: attached EVENT_TYPE [TUPLE [modification_type: NATURAL_8]]
		do
			l_key := file_name_key (a_file_name)
			l_callbacks := file_modified_callbacks
			if l_callbacks.has (l_key) then
					-- Unsubscribe the callback from the events object
				l_events := l_callbacks.item (l_key)
				check l_events.is_subscribed (a_callback) end
				if l_events.is_subscribed (a_callback) then
					l_events.unsubscribe (a_callback)
				end
			end

			uncheck_modifications (a_file_name)
		ensure then
			a_file_name_removed: (old file_records.has (file_name_key (a_file_name))) and then not (old file_records.item (file_name_key (a_file_name))).is_monitoring implies not file_records.has (file_name_key (a_file_name))
			a_file_name_record_monitor_count_decreased: file_records.has (file_name_key (a_file_name)) implies file_records.item (file_name_key (a_file_name)).monitor_count = old file_records.item (file_name_key (a_file_name)).monitor_count - 1
		end

	poll_modifications (a_file_name: STRING_32): NATURAL_8
			-- <Precursor>
		local
			l_key: like file_name_key
			l_records: like file_records
			l_record: FILE_NOTIFIER_RECORD
			l_events: like file_modified_events
			l_timestamp: INTEGER
		do
			l_key := file_name_key (a_file_name)
			l_records := file_records
			if l_records.has (l_key) then
				l_record := l_records.item (l_key)
				l_timestamp := l_record.time_stamp
				l_record.refresh
				if l_record.file_exists then
					if l_record.time_stamp /= l_timestamp then
							-- The file has been modified, as the timestamps have changed
						Result := {FILE_NOTIFIER_MODIFICATION_TYPES}.file_changed
					end
				else
						-- The file has been deleted since the last refresh
					Result := {FILE_NOTIFIER_MODIFICATION_TYPES}.file_deleted
				end

				l_events := file_modified_events
				if Result /= 0 and then not l_events.is_suspended then
						-- Only call the actions if they are not suspended.
					is_modification_self_published := True
					l_events.publish ([a_file_name, Result])
					is_modification_self_published := False
				end
			end
		end

feature {NONE} -- Formatting

	file_name_key (a_file_name: STRING_32): STRING_32
			-- Generates a string recored key, as used by `file_records', for a given file name.
			--
			-- `a_file_name': The name of the file to generate a record key for.
			-- `Result': The generated record key.
		require
			a_file_name_attached: attached a_file_name
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			if {PLATFORM}.is_windows then
				Result := a_file_name.as_lower.as_attached
			else
				Result := a_file_name
			end
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
			result_consistent: Result.hash_code = file_name_key (a_file_name).hash_code
		end

feature -- Events

	file_modified_events: EVENT_TYPE [TUPLE [file_name: STRING_32; modification_type: NATURAL_8]]
			-- <Precursor>

feature -- Event handlers

	on_file_modified (a_file_name: STRING_32; a_type: NATURAL_8)
			-- Called when a file has been modified.
			--
			-- `a_file_name': The name of the file modified.
			-- `a_type': The type of modification applied to the file. See {FILE_NOTIFIER_MODIFICATION_TYPES} for the respective flags
		require
			a_file_name_attached: attached a_file_name
			a_file_name_is_valid_file_name: is_valid_file_name (a_File_name)
		local
			l_key: like file_name_key
			l_records: like file_records
			l_record: FILE_NOTIFIER_RECORD
			l_callbacks: like file_modified_callbacks
		do
			l_key := file_name_key (a_file_name)

			if not is_modification_self_published then
					-- A client published a modification event explicitly so we need to be sure to refresh
					-- the file record
				l_records := file_records
				if l_records.has (l_key) then
					l_record := l_records.item (l_key)
					l_record.refresh
				end
			end

			l_callbacks := file_modified_callbacks
			if l_callbacks.has (l_key) then
				l_callbacks.item (l_key).publish ([a_type])
			end
		end

feature {NONE} -- Constants

	deleted_timestamp: INTEGER_32 = -1

invariant
	file_records_attached: attached file_records
	file_modified_callbacks: attached file_modified_callbacks
	file_records_contains_monitored_items: file_records.for_all (agent (a_record: FILE_NOTIFIER_RECORD): BOOLEAN
		do
			Result := a_record.is_monitoring
		end)

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
