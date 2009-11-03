EC=${EIFFEL_SRC}/Eiffel/Ace/EIFGENs/batch/W_code/ecb

EC_STABLE=ec

EC_OPTS=-config basic_compile.ecf -target basic_compile -c_compile -stop

all:
	touch application.e && ${EC} ${EC_OPTS}

regular:
	${EC_STABLE} ${EC_OPTS}
