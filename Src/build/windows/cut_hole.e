indexing
	description: "Hole for the wastebasket.";

class 
	CUT_HOLE 

inherit

	EB_BUTTON
	HOLE
		rename
			target as focus_source
		redefine
			process_any
		select
			init_toolkit
		end

creation

	make

feature {NONE}


	create_focus_label is 
		do
			set_focus_string (Focus_labels.wastebasket_label)
		end;
	
	make (a_parent: COMPOSITE) is
		require
			valid_a_parent: a_parent /= Void;
		do
			make_visible (a_parent);
			register
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.wastebasket_pixmap
		end;
	
feature {NONE}

	stone_type: INTEGER is 
		do 
			Result := Stone_types.any_type
		end;

	process_any (dropped: STONE) is
		local
			r: REMOVABLE;
			n: NAMABLE
		do
			r ?= dropped;
			if (r /= Void) then
				r.remove_yourself;
				n ?= r;
				if n /= Void and then namer_window.namable = n then
					namer_window.popdown
				end
			end;
		end;

end
