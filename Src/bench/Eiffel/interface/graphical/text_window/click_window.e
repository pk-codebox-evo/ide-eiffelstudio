indexing

	description:	
		"Window with a scrollable text";
	date: "$Date$";
	revision: "$Revision$"

deferred class CLICK_WINDOW 

inherit

	TEXT_STRUCT;
	TEXT_AREA
		export
			{ANY} process_text
		undefine
			copy, setup, consistent, is_equal
		redefine
			process_after_class, process_address_text, process_error_text,
			process_feature_name_text, process_class_name_text,
			put_address, put_feature_name, put_feature,
			put_error, put_class, put_classi, put_cluster,
			put_class_syntax, put_ace_syntax, process_quoted_text,
			process_new_line, process_indentation, process_basic_text,
			process_cl_syntax, process_ace_syntax
		end

feature -- Properties

	focus_start, focus_end: INTEGER; 
			-- Bounds of focus in the structured text

feature -- Access

	focus: STONE is
			-- The stone where the focus currently is.
		do
			if position > 0 and then position <= clickable_count then
				Result := item (position).node
			end
		end;

feature -- Settings

	set_bounds (a, b: INTEGER) is
			-- Set the bounds of current focus.
		do
			focus_start := a;
			focus_end := b
		ensure
			focus_start = a;
			focus_end = b
		end;

feature -- Input

	put_string (s: STRING) is
			-- Add `s' to the text image, don't record it in internal structure.
		do
			image.append (s);
			text_position := text_position + s.count
		end;

	put_char (c: CHARACTER) is
			-- Add `c' to the text image, don't record it in internal structure.
		do
			image.extend (c);
			text_position := text_position + 1
		end;

	new_line is
		do
			image.extend ('%N');
			text_position := text_position + 1
		end;

	process_error_text (text: ERROR_TEXT) is
			-- Process the error `text'.
		do
			put_error (text.error, text.error_text)
		end;

	process_cl_syntax (text: CL_SYNTAX_ITEM) is
			-- Process the syntax error `text'.
		do
			put_class_syntax (text.syntax_error, text.e_class, text.error_text)
		end;

	process_ace_syntax (text: ACE_SYNTAX_ITEM) is
			-- Process the syntax error `text'.
		do
			put_ace_syntax (text.syntax_error, text.error_text)
		end;

	process_address_text (text: ADDRESS_TEXT) is
			-- Process the address `text'.
		do
			put_address (text.address, text.e_class)
		end;

	process_quoted_text (text: QUOTED_TEXT) is
			-- Process the quoted `text' within a comment.
		do
			put_string (text.image);
		end;

	put_stone (a_stone: STONE; stone_string: STRING) is
			-- Add `stone_string' to the text image and 
			-- record `a_stone' as clickable.
		local
			p: CLICK_STONE;
			length: INTEGER;
		do
			image.append (stone_string);
			length := stone_string.count;
			!!p.make (a_stone, text_position, text_position + length);
			add_click_stone (p);
			text_position := text_position + length;
		end;

	put_classi (e_class: CLASS_I; str: STRING) is
			-- Put `e_class' with string representation
			-- `str' at current position.
		local
			stone: CLASSI_STONE	
		do
			!! stone.make (e_class);
			put_stone (stone, str)
		end;

	put_cluster (e_cluster: CLUSTER_I; str: STRING) is
			-- Put `e_cluster' with string representation
			-- `str' at current position.
		do
			put_string (str)
		end;

	put_class (e_class: E_CLASS; str: STRING) is
			-- Put `e_class' with string representation
			-- `str' at current position.
		local
			stone: CLASSC_STONE	
		do
			!! stone.make (e_class);
			put_stone (stone, str)
		end;

	put_error (error: ERROR; str: STRING) is
			-- Put `error' with string representation
			-- `str' at current position.
		local
			stone: ERROR_STONE	
		do
			!! stone.make (error);
			put_stone (stone, str)
		end;

	put_feature (feat: E_FEATURE; e_class: E_CLASS; str: STRING) is
			-- Put feature `feat' defined in `e_class' with string
			-- representation `str' at current position.
		local
			stone: FEATURE_STONE	
		do
			!! stone.make (feat, e_class);
			put_stone (stone, str)
		end;

	put_feature_name (f_name: STRING; e_class: E_CLASS) is
			-- Put feature name `f_name' defined in `e_class'.
		local
			stone: FEATURE_NAME_STONE	
		do
			!! stone.make (f_name, e_class);
			put_stone (stone, f_name)
		end;

	put_address (address: STRING; e_class: E_CLASS) is
			-- Put `address' for `e_class'.
		local
			stone: OBJECT_STONE	
		do
			!! stone.make (address, e_class);
			put_stone (stone, address)
		end;

	put_class_syntax (syn: SYNTAX_ERROR; e_class: E_CLASS; str: STRING) is
			-- Put `address' for `e_class'.
		local
			stone: CL_SYNTAX_STONE	
		do
			!! stone.make (syn, e_class);
			put_stone (stone, str)
		end;

	put_ace_syntax (syn: SYNTAX_ERROR; str: STRING) is
			-- Put `address' for `e_class'.
		local
			stone: ACE_SYNTAX_STONE	
		do
			!! stone.make (syn);
			put_stone (stone, str)
		end;

feature {NONE} -- Implementation

	update_focus (i: INTEGER) is
			-- Select the stone corresponding to text position `i'.
		do
debug
io.putstring ("In update focus with: ");
io.putint (i);
io.putstring ("%N");
end;
			if clickable_count /= 0 then
				search_by_index (i);
				set_bounds (item (position).start_focus, item (position).end_focus)
			end
		end;

feature -- Output processing for text_struct

	image: STRING is
			-- Textual image generated by `build_image'
		once
			!!Result.make (10000)
		end; -- image

	text_position: INTEGER;
			-- Current position in the structured document text

	process_basic_text (t: BASIC_TEXT) is
			-- Puts normal, i.e. non clickable, text `t' in the
			-- text.
		do
			put_string (t.image);
		end;

	process_class_name_text (t: CLASS_NAME_TEXT) is
			-- Process clickable text `t'.
		local
			stone: STONE;
			e_class: E_CLASS;
		do
			e_class := t.class_i.compiled_eclass;
			if e_class /= Void then
				!CLASSC_STONE! stone.make (e_class)
			else
				!CLASSI_STONE! stone.make (t.class_i)
			end;
			put_stone (stone, t.image)
		end;

	process_feature_name_text (t: FEATURE_NAME_TEXT) is
			-- Process clickable text `t'.
		local
			st: FEATURE_STONE
		do
			!! st.make (t.e_feature, t.e_class);
			put_stone (st, t.image);	
		end;

	process_indentation (t: INDENT_TEXT) is
			-- Process non clickable text `t'.
		do
			put_string (t.image)
		end;

	process_new_line (t: NEW_LINE_ITEM) is
			-- Put a new line in the text.
		do
			new_line;
		end;

	process_after_class (t: AFTER_CLASS) is
			-- Put "-- class" followed by `t' in the text.
		local
			class_stone: CLASSC_STONE
		do
			put_string (" -- class ");
			!! class_stone.make (t.e_class);
			put_stone (class_stone, t.e_class.name_in_upper);
			new_line
		end;

end -- class CLICK_WINDOW
