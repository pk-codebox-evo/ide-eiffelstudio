indexing

	description:
		"AST representation of a nested call `target.message' where %
		%the target is a parenthesized expression.";
	date: "$Date$";
	revision: "$Revision$"

class NESTED_EXPR_AS

inherit

	CALL_AS

feature {NONE} -- Initialization

	set is
			-- Yacc initilization
		do
			target ?= yacc_arg (0);
			message ?= yacc_arg (1);
		ensure then
			target_exists: target /= Void;
			message_exists: message /= Void;
		end;

feature -- Properties

	target: EXPR_AS;
			-- Target of the call

	message: CALL_AS;
			-- Message send to the target

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
		-- Reconstitute text.
		local
			paran_as: PARAN_AS
		do
			paran_as ?= target
			if paran_as = Void then
				ctxt.put_text_item (ti_L_parenthesis);
			end
			target.simple_format (ctxt);
			if paran_as = Void then
				ctxt.put_text_item_without_tabs (ti_R_parenthesis);
			end
			ctxt.need_dot;
			message.simple_format (ctxt);
		end;

feature {NESTED_EXPR_AS} -- Replication

	set_target (t: like target) is
		require
			valid_arg: t /= Void
		do
			target := t;
		end;

	set_message (m: like message) is
		require
			valid_arg: m /= Void
		do
			message := m;
		end;

end -- class NESTED_EXPR_AS
