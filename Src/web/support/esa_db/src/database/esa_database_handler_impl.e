note
	description: "Database handler Implementation"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_DATABASE_HANDLER_IMPL

inherit
	ESA_DATABASE_HANDLER

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_connection: ESA_DATABASE_CONNECTION)
			-- Create a database handler with connnection `connection'
		do
			connection := a_connection
			create last_query.make_now
			create error_handler
		ensure
			connection_not_void: connection /= Void
			last_query_not_void: last_query /= Void
		end

feature -- Error Handling

	error_handler: ESA_ERROR_HANDLER

feature -- Functionality

	execute_reader
			-- Execute stored procedure that returns data
		local
			l_db_selection: DB_SELECTION
		do
			reset_error
			if not keep_connection then
				connect
			end

			if attached store as l_store then
				create l_db_selection.make
				db_selection := l_db_selection
				items := l_store.execute_reader (l_db_selection)
				handle_error
			end

			if not keep_connection then
				disconnect
			end
		end

	execute_writer
			-- Execute stored procedure that update/add data
		local
			l_db_change: DB_CHANGE
		do
			reset_error
			if not keep_connection and not is_connected then
				connect
			end

			if attached store as l_store then
				create l_db_change.make
				db_update := l_db_change
				l_store.execute_writer (l_db_change)
				to_implement ("Handling Error")
				if not l_store.has_error then
					db_control.commit
				end
				handle_error
			end
			if not keep_connection then
				disconnect
			end
		end

feature -- SQL Queries

	execute_query
			-- Execute query
		local
			l_db_selection: DB_SELECTION
		do
			reset_error
			if not keep_connection then
				connect
			end

			if attached query as l_query then
				create l_db_selection.make
				db_selection := l_db_selection
				items := l_query.execute_reader (l_db_selection)
				handle_error
			end

			if not keep_connection then
				disconnect
			end
		end

feature -- Iteration

	start
			-- Set the cursor on first element
		do
			if attached db_selection as l_db_selection and then l_db_selection.container /= Void then
				l_db_selection.start
			end
		end

	forth
			-- Move cursor to next element
		do
			if attached db_selection as l_db_selection then
				l_db_selection.forth
			else
				check False end
			end
		end

	after: BOOLEAN
			-- True for the last element
		do
			if attached db_selection as l_db_selection and then l_db_selection.container /= Void then
				Result := l_db_selection.after or else l_db_selection.cursor = Void
			else
				Result := True
			end
		end

	item: DB_TUPLE
			-- Current element
		do
			if attached db_selection as l_db_selection and then attached l_db_selection.cursor as l_cursor then
				create {DB_TUPLE} Result.copy (l_cursor)
			else
				check False then end
			end
		end

feature -- Error Handling

	handle_error
				-- Check if the last operation is_ok.
		note
			EIS: "name=EiffelStore Error Handling", "src=http://docs.eiffel.com/book/solutions/database-control", "protocol=uri"
		do
			if not db_control.is_ok then
			   error_handler.set_error_code (db_control.error_code)
			   error_handler.set_error_message (db_control.error_message_32)
			   error_handler.set_has_error
			end
		end

	reset_error
				-- Rest the last error
		do
			error_handler.reset
		end

feature {NONE} -- Implementation

	connection: ESA_DATABASE_CONNECTION
		-- Database connection

	db_control: DB_CONTROL
		-- Database control
		do
			Result := connection.db_control
		end

	db_result: detachable DB_RESULT
		-- Database query result

	db_selection: detachable DB_SELECTION
		-- Database selection

	db_update: detachable DB_CHANGE
		-- Database modification	

	last_query: DATE_TIME
		-- Last time when a query was executed
	keep_connection: BOOLEAN
		-- Keep connection alive?

	connect
			-- Connect to the database
		require else
			db_control_not_void: db_control /= Void
		do
			if not is_connected then
				db_control.connect
			end
		end

	disconnect
			-- Disconnect from the database
		require else
			db_control_not_void: db_control /= Void
		do
			db_control.disconnect
		end

	is_connected: BOOLEAN
			-- True if connected to the database
		require else
			db_control_not_void: db_control /= Void
		do
			Result := db_control.is_connected
		end

	affected_row_count: INTEGER
			--  The number of rows changed, deleted, or inserted by the last statement
		do
			if attached db_update as l_update then
				Result := l_update.affected_row_count
			end
		end

feature -- Result

	items : detachable LIST[DB_RESULT]
		-- Query result

end
