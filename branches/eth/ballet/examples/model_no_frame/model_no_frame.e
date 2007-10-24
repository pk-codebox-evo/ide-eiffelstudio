class MODEL_NO_FRAME

create

	make

feature -- Main

	token_user: TOKEN_USER

	make is
			-- Main routine, called when the program is executed.
		do
			create token_user.make
			token_user.prove_me
		end

end
