
-- Terminal window with kind of a clickable interface...

class TERM_WINDOW

inherit

	CLICK_WINDOW

feature

	put_string (s: STRING) is do io.putstring (s) end;

	put_clickable_string (a: ANY; s: STRING) is do io.putstring (s) end;

	new_line is do io.new_line end;

	put_char (c: CHARACTER) is do io.putchar (c) end;

end
