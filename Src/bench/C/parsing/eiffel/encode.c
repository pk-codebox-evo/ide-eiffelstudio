/*

 ######  #    #   ####    ####   #####   ######           ####
 #       ##   #  #    #  #    #  #    #  #               #    #
 #####   # #  #  #       #    #  #    #  #####           #
 #       #  # #  #       #    #  #    #  #        ###    #
 #       #   ##  #    #  #    #  #    #  #        ###    #    #
 ######  #    #   ####    ####   #####   ######   ###     ####

	Encoding of C generated functions.
*/

#include "macros.h" 				/* Access to Eiffel objects. */

#define BASE sizeof(encode_tbl)
#define ENCODE_LENGTH 7

#define FEAT_NAME_FLAG		0
#define PRECOND_FLAG		((1<<29))
#define POSTCOND_FLAG		((1<<30))
#define ROUT_TABLE_FLAG		((1<<30)+ (1<<29))
#define ROUT_ACCESS_FLAG	((1<<31))
#define TYPE_TABLE_FLAG		((1<<31) + (1<<29))
#define TYPE_ACCESS_FLAG	((1<<31) + (1<<30))

/*
 * Function declarations.
 */

void 	eif000(),
		eif001(),
		eif010(),
		eif011(),
		eif100(),
		eif101(),
		eif110();
/*
 * Static declarations.
 */

static void encode();				/* Encoder function */
static char encode_tbl[] = {		/* Corespondance table */
	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
	'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
	'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
	'_', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
};


/*
 * Function definitions.
 */

void eif000(eiffel_string, i, j)
char *eiffel_string;
long i, j;
{
	/*
	 * Initialize the Eiffel string `eiffel_string' with an internal name
	 * for Eiffel features: the Eiffel string is supposed to be created
	 * with a size of ENCODE_LENGTH.
	 */

	char *s;


	/*
	 * 's' is a reference on the special object of the Eiffel string
	 */
	s = *(char **) eiffel_string;

	encode(s, ((uint32) i) + ((uint32) j << 15) + FEAT_NAME_FLAG);
}

void eif001(eiffel_string, i, j)
char *eiffel_string;
long i, j;
{
	/*
	 * Intialize the Eiffel string `eiffel_string' wirh an internal name
	 * for Eiffel preconditions functions: the Eiffel string is supposed to
	 * be created with a size of ENCODE_LENGTH.
	 */

	char *s;


    /*
     * 's' is a reference on the special object of the Eiffel string
     */
    s = *(char **) eiffel_string;

    encode(s, ((uint32) i) + ((uint32) j << 15) + PRECOND_FLAG);
}

void eif010(eiffel_string, i, j)
char *eiffel_string;
long i, j;
{
    /*
     * Intialize the Eiffel string `eiffel_string' wirh an internal name
     * for Eiffel postconditions functions: the Eiffel string is supposed to
     * be created with a size of ENCODE_LENGTH.
     */

    char *s;


    /*
     * 's' is a reference on the special object of the Eiffel string
     */
    s = *(char **) eiffel_string;

    encode(s, ((uint32) i) + ((uint32) j << 15) + POSTCOND_FLAG);
}

void eif011(eiffel_string, i)
char *eiffel_string;
long i;
{
	char *s;

	/*
	 * 's' is a reference on the special object of the Eiffel string
	 */

	s = *(char **) eiffel_string;

	/*
	 * ROUT_TABLE_FLAG is the characteristic of routine table entry or an
	 * attribute offset entry
	 */
	encode(s, ((uint32) i) + ROUT_TABLE_FLAG);
}

void eif100(eiffel_string, i)
char *eiffel_string;
long i;
{
	char *s;

	/*
	 * 's' is a reference on the special object of the Eiffel string
	 */

	s = *(char **) eiffel_string;

	/*
	 * ROUT_ACCESS_FLAG is the characteristic of a routine or attribute offset
	 * table access name
	 */

	encode(s, ((uint32) i) + ROUT_ACCESS_FLAG);
}

void eif101(eiffel_string, i)
char *eiffel_string;
long i;
{
	char *s;

	s = *(char **) eiffel_string;

	/*
	 * TYPE_TABLE_FLAG is the characteristic of the type table name
	 */

	encode(s, ((uint32) i) + TYPE_TABLE_FLAG);
}

void eif110(eiffel_string, i)
char *eiffel_string;
long i;
{
    char *s;

    s = *(char **) eiffel_string;

    /*
     *  TYPE_ACCESS_FLAG is the characteristic of the type table name
     */

    encode(s, ((uint32) i) + TYPE_ACCESS_FLAG);
}

/*
 * Encoding of a number into a six-character string
 */

static void encode(s, n)
char *s;
uint32 n;
{
	int t;

	/*
	 * Encode number n in base BASE in string s
	 */
	for (s += 6, t = 1; t < ENCODE_LENGTH; t++) {
		*s-- = encode_tbl[n % BASE];
		n /= BASE;
	}
}

#ifdef TEST

static uint32 decode(s)
char *s;
{
	/* Decode number 's' in base BASE from string 's' */

	uint32 n = 0;
	int i;
	int len = strlen(s);
	uint32 power = 1;

	for (i = 0; i < len; i++) {
		n += value(s[len - i - 1]) * power;
		power *= BASE;
	}

	return n;
}

static int value(c)
char c;
{
	/* Value of digit 'c' in base BASE */
	
	int i;

	for (i = 0; i < BASE; i++)
		if (encode_tbl[i] == c)
			return i;
	
	return i;
}

#include <stdio.h>

main()
{
	char l[100];
	uint32 value;

	char toto [1000];
	strcpy (toto, "E000000");

	encode(toto, ((uint32) 12) + ((uint32) 14 << 15) + FEAT_NAME_FLAG);
	printf ("Encoded name: %s\n", toto);
	while (gets(l)) {
		value = decode(l);
		printf("%s is %d, %d\n", l, value / 32768, value % 32768);
	}
	exit(0);
}

#endif
