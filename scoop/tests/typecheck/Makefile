EC=${EIFFEL_SRC}/Eiffel/Ace/EIFGENs/batch/W_code/ecb

EC_STABLE=ec

EC_OPTS=-config scoop_test.ecf -target scoop_test -c_compile -stop

all:
	touch x.e && touch application.e && ${EC} ${EC_OPTS}

regular:
	${EC_STABLE} ${EC_OPTS}
