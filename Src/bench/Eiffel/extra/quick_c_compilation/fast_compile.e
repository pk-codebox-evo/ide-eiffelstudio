indexing
	description: "Objects that ..."
	author: "Mark Howard, AxaRosenberg"
	date: "$Date$"
	revision: "$Revision$"

class
	FAST_COMPILE

creation
	make

feature 

	make (a_arguments: ARRAY[STRING]) is
		do
			if a_arguments.count > 1 then
				create top_directory.make(a_arguments.item(1))
				top_directory.convert
				print_termination
			else
				print_usage
			end
		end

	top_directory : EIFFEL_F_CODE_DIRECTORY

feature {NONE} -- Implementation

	print_usage is
			-- Print the usage of `quick_finalize'.
		do
			io.putstring ("Usage: quick_finalize path%N")
			io.putstring ("%Tpath: path to your F_code directory generated by EiffelBench%N")
		end

	print_termination is
			-- Print the termination message.
		do
			io.putstring ("Translation finished.%N")
		end

end
   
