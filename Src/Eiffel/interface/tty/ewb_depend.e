indexing

	description: 
		"Display features's dependants in output_window."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_DEPEND 

inherit
	EWB_FEATURE

	SHARED_SERVER

create
	make, do_nothing

feature

	display (class_c: CLASS_C; f: FEATURE_I) is
		local
			dep: CLASS_DEPENDANCE;
			fdep: FEATURE_DEPENDANCE;
			supplier: CLASS_C;
			supp_f: FEATURE_I;
			class_id: INTEGER;
			fid: INTEGER;
			st: STRUCTURED_TEXT
		do
			dep := Depend_server.item (class_c.id);
			fdep := dep.item (f.feature_name);

			create st.make
			st.add_string ("Dependents:");
			st.add.put_new_line;
			from
				fdep.start
			until
				fdep.after
			loop
				class_id := fdep.item.id;
				fid := fdep.item.feature_id;

				supplier := System.class_of_id (class_id);
				supp_f := supplier.feature_table.feature_of_feature_id (fid);

				supplier.append_name (st);
				st.add_char ('.');
				supp_f.append_name (st, supplier);
				st.add.put_new_line;

				fdep.forth
			end;
			output_window.put_string (st.image);
			output_window.put_new_line
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EWB_DEPEND
