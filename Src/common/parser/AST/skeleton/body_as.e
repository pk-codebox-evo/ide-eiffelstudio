indexing

	description: "Abstract description of an Eiffel feature.";
	date: "$Date$";
	revision: "$Revision$"

class BODY_AS

inherit

	AST_EIFFEL
		redefine
			simple_format
		end;

feature -- Attributes

	arguments: EIFFEL_LIST [TYPE_DEC_AS];
			-- List (of list) of arguments

	type: TYPE;
			-- Type if any

	content: CONTENT_AS;
			-- Content of the body: constant or regular body

feature -- Initialization
	
	set is
			-- Yacc initialization
		do
			arguments ?= yacc_arg (0);
			type ?= yacc_arg (1);
			content ?= yacc_arg (2);
				-- Constant value or standard feature body
		ensure then
			(content /= Void) or else (type /= Void);
		end; -- set

	is_unique: BOOLEAN is
		do
			Result := content /= Void and then content.is_unique
		end;

	check_local_names is
			-- Check conflicts between local names and feature names
		do
			if content /= Void then
					-- i.e: if it not the content of an attribute
				content.check_local_names;
			end;
		end;

	is_body_equiv (other: like Current): BOOLEAN is
			-- Is the body of current feature equivalent to 
			-- body of `other' ?
		do
			Result := deep_equal (type, other.type) and then
					deep_equal (arguments, other.arguments);
debug
	io.error.putstring ("BODY_AS.is_body_equiv%N");
	if not Result then
		io.error.putstring ("Different signatures%N");
	end;
end;
			if Result then
				if (content = Void) and (other.content = Void) then
				elseif (content = Void) or else (other.content = Void) then
					Result := False
				elseif (content.is_constant = other.content.is_constant) then
						-- The two objects are of the same type.
						-- There is no global typing problem.
					Result := content.is_body_equiv (other.content)
debug
	if not Result then
		io.error.putstring ("Different bodies%N");
	end;
end
				else
					Result := False
				end;
			end;
		end;
 
	is_assertion_equiv (other: like Current): BOOLEAN is
			-- Is the assertion of Current feature equivalent to 
			-- assertion of `other' ?
			--|Note: This test is valid since assertions are generated
			--|along with the body code. The assertions will be re-generated
			--|whenever the body has changed. Therefore it is not necessary to
			--|consider the cases in which one of the contents is a ROUTINE_AS 
			--|and the other a CONSTANT_AS (The True value is actually returned
			--|but we don't care.
			--|Non-constant attributes have a Void content. In any case 
			--|involving at least on attribute, the True value is retuned:
			--|   . If they are both attributes, the assertions are equivalent
			--|   . If only on is an attribute, we don't care since the bodies will
			--|	 not be equivalent anyway.
			--|The best way to understand all this, is to draw a two-dimensional
			--|table, for all possible combinations of the values (CONSTANT_AS,
			--|ROUTINE_AS, Void) of content and other.content)
		local
			r1, r2: ROUTINE_AS
		do
			r1 ?= content; 
			r2 ?= other.content;
			if (r1 /= Void) and then (r2 /= Void) then
				Result := r1.is_assertion_equiv (r2)
			else
				Result := True
			end
		end;

feature -- Status report

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Does this body has instruction `i'?
		do
			if content /= Void then
				Result := content.has_instruction (i)
			else
				Result := False
			end
		end;

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this body.
			-- Result is `0' not found.
		do
			if content /= Void then
				Result := content.index_of_instruction (i)
			else
				Result := 0
			end
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			routine_as: ROUTINE_AS;
		do
			ctxt.begin;
			if arguments /= void and then not arguments.empty then
				ctxt.put_space;
				ctxt.put_text_item (ti_L_parenthesis);
				ctxt.set_separator (ti_Semi_colon);
				ctxt.space_between_tokens;
				arguments.simple_format (ctxt);
				ctxt.put_text_item (ti_R_parenthesis)
			end;

			if type /= void then
				ctxt.put_text_item (ti_Colon);
				ctxt.put_space;
				if type.has_like then
					ctxt.new_expression;
				end;
				type.simple_format (ctxt);
			end;

			if content /= void then
				content.simple_format (ctxt)
			end;

			ctxt.put_text_item (ti_Semi_colon);
			ctxt.commit;
		end;
				
feature {BODY_AS, FEATURE_AS, BODY_MERGER, USER_CMD, CMD} -- Replication

	set_arguments (a: like arguments) is
		do
			arguments := a
		end;

	set_type (t: like type) is
		do
			type := t
		end;

	set_content (c: like content) is
		do
			content := c
		end;

end -- class BODY_AS
