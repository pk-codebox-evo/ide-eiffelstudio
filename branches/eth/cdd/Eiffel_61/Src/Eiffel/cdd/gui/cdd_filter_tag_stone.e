indexing
	description: "Objects that represent a stone containing a filter tag"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

class
	CDD_FILTER_TAG_STONE

inherit
	STONE
		rename
			stone_signature as tag,
			header as tag,
			history_name as tag
		end

	EB_SHARED_PIXMAPS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_tag: like tag) is
			-- Initialize `Current' with `a_tag'.
		require
			a_tag_not_void: a_tag /= Void
		do
			tag := a_tag
		ensure
			tag_set: tag = a_tag
		end

feature -- Access

	tag: STRING
		-- Filter tag represented by `Current'

	stone_cursor: EV_POINTER_STYLE is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone.
			-- Default is Void, meaning no cursor is associated with `Current'.
		once
			create Result.make_with_pixmap (pixmaps.icon_pixmaps.cdd_test_icon, 0, 0)
		end

	x_stone_cursor: EV_POINTER_STYLE is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
			-- Default is Void, meaning no cursor is associated with `Current'.
		once
			create Result.make_with_pixmap (pixmaps.icon_pixmaps.cdd_test_icon, 0, 0)
		end

end
