class BIN_AND_AS

inherit

	BINARY_AS
		redefine
			bit_balanced, byte_anchor
		end

feature

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		once
			Result := "_infix_and";
		end;

	bit_balanced: BOOLEAN is
			-- Is the current binary operation subject to the
			-- balancing rule proper to bit types ?
		do
			Result := True;
		end;

	byte_anchor: BIN_AND_B is
            -- Byte code type
        do
            !!Result;
        end;

end
