class
	FEATURE_FILTER

inherit
	XM_CALLBACKS_FILTER
		redefine
			on_start_tag,
			on_attribute,
			on_content,
			on_end_tag
		end

	TAG_FLAGS

creation
	make
	
feature -- Initialization

	make is
			-- Initialization.
		do
			create a_member.make
			create a_parameter.make
			create current_comment.make_empty
			create current_tag.make (10)
		ensure then
			non_void_a_member: a_member /= Void
			non_void_a_parameter: a_parameter /= Void
			non_void_current_comment: current_comment /= Void
			non_void_current_tag: current_tag /= Void
		end

feature -- Access

	a_member: MEMBER_INFORMATION
			-- Temporary attribute.

feature {NONE} -- Access
	
	a_parameter: PARAMETER_INFORMATION
			-- Temporary attribute.

	current_comment: STRING
			-- Current comment.

	current_tag: ARRAYED_LIST [STRING]
			-- Balises XML opened.

	paragraphe_tag: STRING is "<PARA>"

feature

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- called whenever the parser findes a start element
		local
			retried: BOOLEAN
		do
			if not retried then
				current_tag.extend (a_local_part)
			end
		rescue
			retried := True
			retry
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING) is
		local
			l_name: STRING
			retried: BOOLEAN
		do
			if not retried then
				if current_tag.last.is_equal (See_str) then
					check
						a_local_part.is_equal (Cref_str)
					end
					l_name := a_value
					l_name.keep_tail (l_name.count - 2)
					current_comment.append (l_name)
				elseif current_tag.last.is_equal (member_str) then
					a_member.reset
					check
						a_local_part.is_equal (Name_str)
					end
					l_name := a_value
					l_name.keep_tail (l_name.count - 2)
					a_member.set_name (l_name)
				elseif current_tag.last.is_equal (Param_str) then
					check
						a_local_part.is_equal (Name_str)
					end
					a_parameter.set_name (a_value)
				elseif current_tag.last.is_equal (Param_ref_str) then
					check
						a_local_part.is_equal (Name_str)
					end
					current_comment.append (a_value)
				elseif current_tag.last.is_equal (See_also_str) then
					check
						a_local_part.is_equal (Cref_str)
					end
					current_comment.append (a_value)
				elseif current_tag.last.is_equal (Exception_str) then
					check
						a_local_part.is_equal (Cref_str)
					end
					current_comment.append (a_value)
				elseif current_tag.last.is_equal (Permission_str) then
					check
						a_local_part.is_equal (Cref_str)
					end
					current_comment.append (a_value)
				elseif current_tag.last.is_equal (Include_str) then
					check
						a_local_part.is_equal (File_str) or a_local_part.is_equal (Path_str)
					end
					current_comment.append (a_value)
				elseif current_tag.last.is_equal (list_str) then
					check
						a_local_part.is_equal (type_str)
					end
					current_comment.append (a_value)
				else
					check
						Attribute_doesnot_belong_to_current_member: False
					end
				end
			end
		rescue
			retried := True
			retry
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- called whenever the parser findes an end element
		local
			l_str: STRING
			retried: BOOLEAN
		do
			if not retried then
				if current_tag.last.is_equal (Param_str) then
					l_str := format_comment (current_comment)
					a_parameter.set_description (l_str)
					a_member.add_parameter (deep_clone (a_parameter))
					current_comment.wipe_out
				elseif current_tag.last.is_equal (Summary_str) then
					l_str := format_comment (current_comment)
					a_member.set_summary (l_str)
					current_comment.wipe_out
				elseif current_tag.last.is_equal (Returns_str) then
					l_str := format_comment (current_comment)
					a_member.set_returns (l_str)
					current_comment.wipe_out
				elseif current_tag.last.is_equal (Para_str) then
					-- Do nothing
				else
					-- Do nothing
				end
				current_tag.go_i_th (current_tag.count - 1)
				current_tag.remove_right
			end
		rescue
			retried := True
			retry
		end

feature -- Content

	on_content (a_content: STRING) is
			-- called whenever the parser findes character data
		local
			retried: BOOLEAN
		do
			if not retried then
				if current_tag.last.is_equal (Para_str) then
					current_comment.append (a_content)
				elseif current_tag.last.is_equal (Returns_str) then
					current_comment.append (a_content)
				elseif current_tag.last.is_equal (Summary_str) then
					current_comment.append (a_content)
				elseif current_tag.last.is_equal (Param_str) then
					current_comment.append (a_content)
				elseif current_tag.last.is_equal (Member_str) then
					-- Not implemented
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Basic Operation

	format_comment (a_comment: STRING): STRING is
			-- format `a_comment'.
		require
			non_void_a_comment: a_comment /= Void
			not_empty_a_comment: not a_comment.is_empty
		do
			Result := clone (a_comment)
			Result.replace_substring_all ("%N", "")
			Result.prune_all_leading (' ')
			Result.prune_all_trailing (' ')
			Result.replace_substring_all ("   ", " ")
			Result.replace_substring_all ("   ", " ")
			Result.replace_substring_all ("  ", " ")
			Result.replace_substring_all (paragraphe_tag, "%N")
		end

invariant
	non_void_a_member: a_member /= Void
	non_void_a_parameter: a_parameter /= Void
	non_void_current_comment: current_comment /= Void
	non_void_current_tag: current_tag /= Void

end -- class FEATURE_FILTER
