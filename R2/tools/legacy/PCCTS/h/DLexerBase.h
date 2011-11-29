/* DLGLexerBase.h
 *
 * SOFTWARE RIGHTS
 *
 * We reserve no LEGAL rights to the Purdue Compiler Construction Tool
 * Set (PCCTS) -- PCCTS is in the public domain.  An individual or
 * company may do whatever they wish with source code distributed with
 * PCCTS or the code generated by PCCTS, including the incorporation of
 * PCCTS, or its output, into commerical software.
 * 
 * We encourage users to develop software with PCCTS.  However, we do ask
 * that credit is given to us for developing PCCTS.  By "credit",
 * we mean that if you incorporate our source code into one of your
 * programs (commercial product, research project, or otherwise) that you
 * acknowledge this fact somewhere in the documentation, research report,
 * etc...  If you like PCCTS and have developed a nice tool with the
 * output, please mention that you developed it using PCCTS.  In
 * addition, we ask that this header remain intact in our source code.
 * As long as these guidelines are kept, we expect to continue enhancing
 * this system and expect to make other tools available as they are
 * completed.
 *
 * ANTLR 1.33
 * Terence Parr
 * Parr Research Corporation
 * with Purdue University and AHPCRC, University of Minnesota
 * 1989-1995
 */

#ifndef DLGX_H
#define DLGX_H

#include <stdio.h>
#include "config.h"
#include ATOKEN_H
#include ATOKENSTREAM_H

/* must define what a char looks like; can make this a class too */
typedef char DLGChar;

/*  Can have it as a class too: (ack this looks weird; is it right?)
class DLGChar {
private:
	int c;
public:
	DLGChar(int ch) { c = ch; }
	int atom() { return c; }
};
*/

/* user must subclass this */
class DLGInputStream {
public:
	virtual int nextChar() = 0;
};

/* Predefined char stream: Input from FILE */
class DLGFileInput : public DLGInputStream {
private:
	int found_eof;
	FILE *input;
public:
	DLGFileInput(FILE *f) { input = f; found_eof = 0; }
	int nextChar() {
			int c;
			if ( found_eof ) return EOF;
			else {
				c=getc(input);
				if ( c==EOF ) found_eof = 1;
				return c;
			}
		}
};

/* Predefined char stream: Input from string */
class DLGStringInput : public DLGInputStream {
private:
	DLGChar *input;
	DLGChar *p;
public:
	DLGStringInput(DLGChar *s) { input = s; p = &input[0];}
	int nextChar()
		{
			if (*p) return (int) *p++;
			else return EOF;
		}
};

class DLGState {
public:
	DLGInputStream *input;
	int interactive;
	int track_columns;
	int auto_num;
	int add_erase;
	int lookc;
	int char_full;
	int begcol, endcol;
	int line;
	DLGChar *lextext, *begexpr, *endexpr;
	int bufsize;
	int bufovf;
	DLGChar *nextpos;
	int	class_num;
};

/* user must subclass this */
class DLGLexerBase : public ANTLRTokenStream {
public:
	virtual ANTLRTokenType erraction();

protected:
	DLGInputStream *input;
	int interactive;
	int track_columns;
	DLGChar	*_lextext;	/* text of most recently matched token */
	DLGChar	*_begexpr;	/* beginning of last reg expr recogn. */
	DLGChar	*_endexpr;	/* beginning of last reg expr recogn. */
	int	_bufsize;		/* number of characters in lextext */
	int	_begcol;		/* column that first character of token is in*/
	int	_endcol;		/* column that last character of token is in */
	int	_line;			/* line current token is on */
	int	ch;				/* character to determine next state */
	int	bufovf;			/* indicates that buffer too small for text */
	int	charfull;
	DLGChar	*nextpos;	/* points to next available position in lextext*/
	int	cl;
	int automaton;
	int	add_erase;
	DLGChar ebuf[70];
	_ANTLRTokenPtr token_to_fill;

	virtual _ANTLRTokenPtr getToken();

public:
	virtual void advance(void) = 0;
	void	skip(void);		/* erase lextext, look for antoher token */
	void	more(void);		/* keep lextext, look for another token */
	void	mode(int k);	/* switch to automaton 'k' */
	void	saveState(DLGState *);
	void	restoreState(DLGState *);
	virtual ANTLRTokenType nextTokenType(void)=0;/* get next token */
	void	replchar(DLGChar c);	/* replace last recognized reg. expr. with
									 a character */
	void	replstr(DLGChar *s);	/* replace last recognized reg. expr. with
									 a string */
	int		err_in();
	void	errstd(char *);

	int		line()		{ return _line; }
	virtual void newline()	{ _line++; }
	DLGChar	*lextext()	{ return _lextext; }

	int		begcol()	{ return _begcol; }
	int		endcol()	{ return _endcol; }
	void	set_begcol(int a)	{ _begcol=a; }
	void	set_endcol(int a)	{ _endcol=a; }
	DLGChar	*begexpr()	{ return _begexpr; }
	DLGChar	*endexpr()	{ return _endexpr; }
	int		bufsize()	{ return _bufsize; }

	void	setToken(ANTLRAbstractToken *t)	{ token_to_fill = t; }

	void	setInputStream(DLGInputStream *);
	DLGLexerBase(DLGInputStream *in,
				 unsigned bufsize=2000,
				 int interactive=0,
				 int track_columns=0);
	virtual ~DLGLexerBase() { delete [] _lextext; }
	void	panic(char *msg);

	void	trackColumns() {
				track_columns = 1;
				this->_begcol = 0;
				this->_endcol = 0;
			}
};

#endif
