
-- Terminal window with kind of a clickable interface...

class TERM_WINDOW

inherit

	CLICK_WINDOW

feature

	put_string (s: STRING) is do io.error.putstring (s) end;

	put_clickable_string (a: ANY; s: STRING) is do io.error.putstring (s) end;

end
