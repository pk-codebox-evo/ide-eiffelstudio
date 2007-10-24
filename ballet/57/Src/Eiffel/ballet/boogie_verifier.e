indexing
	description	: "BPL verifier using boogie as backend"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	BOOGIE_VERIFIER

inherit
	BPL_VERIFIER

feature -- Process output

	handle_boogie_output (a_string: STRING) is
			-- Handle the output generated by boogie and create error items.
		local
			lines: LIST[STRING]
			regexp: RX_PCRE_REGULAR_EXPRESSION
			src_expr: RX_PCRE_REGULAR_EXPRESSION
			related_expr: RX_PCRE_REGULAR_EXPRESSION
			bpl_error_line, bpl_error_code, bpl_error_message: STRING
			bpl_lines: LIST[STRING]
			line_start: INTEGER
			tag: STRING
		do
			lines := a_string.split ('%N')
			-- TODO: improve performance. Splitting the lines is too
			-- expensive, find line faster.

			bpl_lines := bpl_code.split ('%N')

			create src_expr.make
			src_expr.compile ("^.*// eiffel:(.*);([0-9]*);(.*)$")

			create regexp.make
			regexp.compile ("^(.*)\(([0-9]*),([0-9]*)\): Error (.*): (.*)$")

			create related_expr.make
			related_expr.compile ("^(.*)\(([0-9]*),([0-9]*)\): Related location: (.*)$")

			from
				lines.start
			until
				lines.after
			loop
				lines.item.prune_all ('%R')
				-- Skip a 'related' message if not expecting it.
				related_expr.match (lines.item)
				if related_expr.match_count > 0 then
					lines.forth
					lines.item.prune_all ('%R')
				end

				if
					lines.item.count > 0 and then
					not (lines.item.substring_index ("Spec# Program Verifier", 1) = 1)
				then
					regexp.match (lines.item)

					if regexp.match_count < 5 then
						add_error (create {BPL_ERROR}.make("Cannot extract error information from ballet output '" +
																	  lines.item + "'"))
					else
						bpl_error_line := regexp.captured_substring(2)
						bpl_error_code := regexp.captured_substring(4)
						bpl_error_message := regexp.captured_substring(5)

						if bpl_error_code.is_equal("BP5003") then
							-- Postcondition violation.
							lines.forth
							related_expr.match (lines.item)

							if related_expr.match_count < 4 then
								add_error (create {BPL_ERROR}.make("Ballet Error BP5003 incomplete: no related location given."))
							else
								src_expr.match (bpl_lines.i_th (related_expr.captured_substring (2).to_integer))
								if src_expr.match_count > 2 then
									tag := src_expr.captured_substring (3)
								else
									tag := Void
								end

								line_start := src_expr.captured_substring (2).to_integer

								add_error (create {BPL_VERIFICATION_ERROR}.make_verification
											  ("Postcondition might not hold at end of feature",
												src_expr.captured_substring (1),
												line_start, tag))
							end
						elseif bpl_error_code.is_equal("BP5002") then
							-- Precondition violation.
							lines.forth
							related_expr.match (lines.item)

							if related_expr.match_count < 4 then
								add_error (create {BPL_ERROR}.make("Ballet Error BP5002 incomplete: no related location given."))
							else
								src_expr.match (bpl_lines.i_th (bpl_error_line.to_integer))
								if src_expr.match_count > 2 then
									tag := src_expr.captured_substring (3)
								else
									tag := Void
								end

								line_start := src_expr.captured_substring (2).to_integer

								add_error (create {BPL_VERIFICATION_ERROR}.make_verification
											  ("Precondition of call not met",
												src_expr.captured_substring (1),
												line_start, tag))
							end
						else
							src_expr.match (bpl_lines.i_th (bpl_error_line.to_integer))
							if src_expr.match_count >= 3 then
								line_start := src_expr.captured_substring (2).to_integer
								if src_expr.match_count > 2 then
									tag := src_expr.captured_substring (3)
								else
									tag := Void
								end
								add_error (create {BPL_VERIFICATION_ERROR}.make_verification
											  (bpl_error_message,
												src_expr.captured_substring (1),
												line_start, tag))
							else
								add_error (create {BPL_ERROR}.make("Cannot associate ballet output '" +
																			  lines.item + "' to a eiffel source."))
							end
						end
					end
				end
				lines.forth
			end

		end

feature -- Code generated through the verifier.

	bpl_code: STRING;

indexing
	copyright:	"Copyright (c) 2006, Raphael Mack"
	license:	"GPL version 2 or later"
	copying: "[

				 This program is free software; you can redistribute it and/or
				 modify it under the terms of the GNU General Public License as
				 published by the Free Software Foundation; either version 2 of
				 the License, or (at your option) any later version.
				
				 This program is distributed in the hope that it will be useful,
				 but WITHOUT ANY WARRANTY; without even the implied warranty of
				 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
				 GNU General Public License for more details.
				
				 You should have received a copy of the GNU General Public
				 License along with this program; if not, write to the Free Software
				 Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
				 MA 02110-1301  USA
				 ]"

end -- class BOOGIE_VERFIER
