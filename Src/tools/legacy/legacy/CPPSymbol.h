/*
 * PUBLIC DOMAIN PCCTS-BASED C++ GRAMMAR (cplusplus.g, stat.g, expr.g)
 *
 * Authors: Sumana Srinivasan, NeXT Inc.;            sumana_srinivasan@next.com
 *          Terence Parr, Parr Research Corporation; parrt@parr-research.com
 *          Russell Quong, Purdue University;        quong@ecn.purdue.edu
 *
 * SOFTWARE RIGHTS
 *
 * This file is a part of the ANTLR-based C++ grammar and is free
 * software.  We do not reserve any LEGAL rights to its use or
 * distribution, but you may NOT claim ownership or authorship of this
 * grammar or support code.  An individual or company may otherwise do
 * whatever they wish with the grammar distributed herewith including the
 * incorporation of the grammar or the output generated by ANTLR into
 * commerical software.  You may redistribute in source or binary form
 * without payment of royalties to us as long as this header remains
 * in all source distributions.
 *
 * We encourage users to develop parsers/tools using this grammar.
 * In return, we ask that credit is given to us for developing this
 * grammar.  By "credit", we mean that if you incorporate our grammar or
 * the generated code into one of your programs (commercial product,
 * research project, or otherwise) that you acknowledge this fact in the
 * documentation, research report, etc....  In addition, you should say nice
 * things about us at every opportunity.
 *
 * As long as these guidelines are kept, we expect to continue enhancing
 * this grammar.  Feel free to send us enhancements, fixes, bug reports,
 * suggestions, or general words of encouragement at parrt@parr-research.com.
 * 
 * NeXT Computer Inc.
 * 900 Chesapeake Dr.
 * Redwood City, CA 94555
 * 12/02/1994
 * 
 * Restructured for public consumption by Terence Parr late February, 1995.
 *
 * Requires PCCTS 1.32b4 or higher to get past ANTLR. 
 * 
 * DISCLAIMER: we make no guarantees that this grammar works, makes sense,
 *             or can be used to do anything useful.
 */
#ifndef CPPSymbol_h
#define CPPSymbol_h

#include "DictEntry.h"

class CPPSymbol : public DictEntry {
public:
	enum ObjectType {
		otInvalid=0, otFunction=1, otVariable, otTypedef,
		otStruct, otUnion, otEnum, otClass, otEnumElement , otNameSpace //###
	};

protected:
	ObjectType type;

public:
	CPPSymbol() {;}
	CPPSymbol(char *k, ObjectType st=otInvalid) : DictEntry(k) { type = st; }
	void setType(ObjectType t)	{ type = t; }
	ObjectType getType()		{ return type; }
};

#endif
