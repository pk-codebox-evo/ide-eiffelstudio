/*

 #####   ######   ####    ####   #####           #    #
 #    #  #       #       #    #  #    #          #    #
 #    #  #####    ####   #    #  #    #          ######
 #    #  #            #  #    #  #####    ###    #    #
 #    #  #       #    #  #    #  #        ###    #    #
 #####   ######   ####    ####   #        ###    #    #

	DES encryption/decryption routines used by authentication.
*/

#ifndef _desop_h_
#define _desop_h_

extern void des_decrypt(char *buf, int size);	/* Perform in-place DES decryption */
extern void des_encrypt(char *buf, int size);	/* Perform in-place DES encryption */

#endif
