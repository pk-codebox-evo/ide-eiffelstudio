indexing
	description: "Container to hold attachments for forms";
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	ATTACHMENT_LIST_WINDOWS
 
inherit 
	LINKED_LIST [ATTACHMENT_WINDOWS]

creation
	make 

feature  -- Status setting

	find_widget (w: WIDGET_WINDOWS): ATTACHMENT_WINDOWS is
			-- Find the attachment that contains widget `w'
		require
			non_void: w /= Void
		local
			c: CURSOR
		do
			from
				c := cursor
				start
			variant
				count - index
			until
				after or item.widget = w
			loop
				forth
			end
			if not after then
				Result := item
			end
			go_to (c)
		end


feature -- Status setting

	attach_left (w,l : WIDGET_WINDOWS; pos: INTEGER;
			relative: BOOLEAN) is
			-- Attach the left of `w' to `l' separated by `pos' 
			-- which is `relative'
		local
			a : ATTACHMENT_WINDOWS
		do
			a := find_widget (w)
			if a = Void then 
				!!a.make (w)
				extend (a)
			end
			a.attach_left (l, pos, relative);
		end

	attach_right (w,r : WIDGET_WINDOWS; pos: INTEGER;
			relative: BOOLEAN) is
			-- Attach the right of `w' to `l' separated by `pos' 
			-- which is `relative'
		local
			a : ATTACHMENT_WINDOWS
		do
			a := find_widget (w)
			if a = Void then 
				!!a.make (w)
				extend (a)
			end
			a.attach_right (r, pos, relative);
		end

	attach_top (w,t : WIDGET_WINDOWS; pos: INTEGER;
			relative: BOOLEAN) is
			-- Attach the top of `w' to `l' separated by `pos' 
			-- which is `relative'
		local
			a : ATTACHMENT_WINDOWS
		do
			a := find_widget (w)
			if a = Void then 
				!!a.make (w)
				extend (a)
			end
			a.attach_top (t, pos, relative);
		end

	attach_bottom (w,b : WIDGET_WINDOWS; pos: INTEGER; relative: BOOLEAN) is
			-- Attach the bottom of `w' to `l' separated by `pos' 
			-- which is `relative'
		local
			a : ATTACHMENT_WINDOWS
		do
			a := find_widget (w)
			if a = Void then 
				!!a.make (w)
				extend (a)
			end
			a.attach_bottom (b, pos, relative);
		end

	clear_all is
			-- Set all processing flags to false
		local
			c: CURSOR
		do
			c := cursor
			from
				start
			variant
				count - index
			until
				after
			loop
				item.reset
				forth
			end
			go_to (c)
		end

	height (form: FORM_WINDOWS): INTEGER is
			-- Height of all the widgets in this
			-- list, includes sizing based on positioning
		local
			child_array: ARRAY [WIDGET_WINDOWS] 
			i: INTEGER
			c: CURSOR
		do
			if count > 0 then
				from
					c := cursor
					clear_all
					start
					Result := item.height (form)
					forth
				variant
					count - index
				until
					after
				loop
					Result := Result.max (item.height (form))
					forth
				end
				go_to (c)
			else
				child_array := form.children
				from
					i := child_array.lower
				until
					i > child_array.upper
				loop
					Result := (Result).max (child_array.item(i).y + child_array.item(i).height)
					i := i + 1
				end
			end
		end

	width (form: FORM_WINDOWS): INTEGER is
			-- Width of all the widgets in this
			-- list, includes sizing based on positioning
		local
			child_array: ARRAY [WIDGET_WINDOWS] 
			i: INTEGER
			c: CURSOR
		do
			if count > 0 then
				from
					c := cursor
					clear_all
					start
					Result := item.width (form)
					forth
				variant
					count - index
				until
					after
				loop
					Result := Result.max (item.width (form))
					forth
				end
				go_to (c)
			else
				child_array := form.children
				from
					i := child_array.lower
				until
					i > child_array.upper
				loop
					Result := (Result).max (child_array.item(i).x + child_array.item(i).width)
					i := i + 1
				end
			end
		end

	process (form: FORM_WINDOWS) is
			-- Position each widget in the list
			-- If more than 100 passes are required 
			-- we presume there is a circularity
		local
			i: INTEGER
			processing: BOOLEAN
			c : CURSOR
		do
			from
				c := cursor
				processing := true
			variant
				100 - i
			until
				i > 100 or not processing
			loop
				from
					start
					processing := false
				variant
					count - index
				until
					after
				loop
					if not item.processed then
						processing := true
						item.process (form)
					end
					forth
				end
				i := i + 1
			end
			if processing then
				io.error.putstring ("Unable to process all form attachments%N")
			end
			go_to (c)
		end

end -- class ATTACHMENT_LIST_WINDOWS
 
--|---------------------------------------------------------------- 
--| EiffelVision: library of reusable components for ISE Eiffel 3. 
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software 
--|   Engineering Inc. 
--| All rights reserved. Duplication and distribution prohibited. 
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA 
--| Telephone 805-685-1006 
--| Fax 805-685-6869 
--| Electronic mail <info@eiffel.com> 
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------

