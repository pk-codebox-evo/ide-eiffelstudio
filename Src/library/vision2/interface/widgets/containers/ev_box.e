indexing

	description: 
		"EiffelVision box. Invisible container that allows unlimited number of other widgets to be packed inside it. Box controls the location the children's location and size automatically."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 

	EV_BOX

inherit

	EV_INVISIBLE_CONTAINER
		redefine
			implementation
		end
	
feature -- Status report
	
	get_expand (box_child: EV_WIDGET): BOOLEAN is
			-- Is the box expanded to fill the area 
			-- allocated to 'box_child'
		do
--			Result := implementation.get_expand (box_child)
		end
	
	get_fill (box_child: EV_WIDGET): BOOLEAN is
			-- Is the extra space allocated to 'box_child'. Has 
			-- effect only if get_expand is True.
		do
--			Result := implementation.get_fill (box_child)
		end
	
	get_padding (box_child: EV_WIDGET): INTEGER is
			-- The extra space added on each side of 'box_child'
		do
		end
	
feature -- Element change (box specific)
	
	set_homogeneous (homogeneous: BOOLEAN) is
			-- Homogenous controls whether each object in
			-- the box has the same size. If homogenous =
			-- True, expand argument for each child is
			-- automatically True
		require
			exist: not destroyed
		do
			implementation.set_homogeneous (homogeneous)
		end
	
	set_spacing (spacing: INTEGER) is
			-- Spacing between the objects in the box
		require
			exist: not destroyed
		do
			implementation.set_spacing (spacing)
		end
		
feature -- Element change (specific for each child in the box)
	
	set_child_packing (box_child: EV_WIDGET; expand, fill: BOOLEAN; padding: INTEGER) is
			-- Set expand, fill and padding for 'box_child'
		
		do
		end
	
	set_children_packing (expand, fill: BOOLEAN; padding: INTEGER) is
			-- Set expand, fill and padding for each 
			-- child in the box
		
		do
		end	

feature {NONE} -- Implementation
	
	implementation: EV_BOX_I
			
end -- class EV_BOX
