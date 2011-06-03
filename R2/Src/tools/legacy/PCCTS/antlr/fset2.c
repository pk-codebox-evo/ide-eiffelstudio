/*
 * fset2.c
 *
 * $Id$
 * $Revision$
 *
 * Compute FIRST sets for full LL(k)
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
#include <stdio.h>
#ifdef __cplusplus
#ifndef __STDC__
#define __STDC__
#endif
#endif
#ifdef __STDC__
#include <stdarg.h>
#else
#include <varargs.h>
#endif
#include "set.h"
#include "syn.h"
#include "hash.h"
#include "generic.h"
#include "dlgdef.h"

extern char tokens[];

extern char *PRED_AND_LIST;
extern char *PRED_OR_LIST;

/* ick! globals.  Used by permute() to track which elements of a set have been used */
static int *findex;
static set *fset;
static unsigned **ftbl;
static set *constrain; /* pts into fset. constrains tToken() to 'constrain' */
int ConstrainSearch;
static int maxk; /* set to initial k upon tree construction request */
static Tree *FreeList = NULL;

#ifdef __STDC__
static int tmember_of_context(Tree *, Predicate *);
#else
static int tmember_of_context();
#endif

/* Do root
 * Then each sibling
 */
void
#ifdef __STDC__
preorder( Tree *tree )
#else
preorder( tree )
Tree *tree;
#endif
{
	if ( tree == NULL ) return;
	if ( tree->down != NULL ) fprintf(stderr, " (");
	if ( tree->token == ALT ) fprintf(stderr, " J");
	else fprintf(stderr, " %s", TerminalString(tree->token));
	if ( tree->token==EpToken ) fprintf(stderr, "(%d)", tree->v.rk);
	preorder(tree->down);
	if ( tree->down != NULL ) fprintf(stderr, " )");
	preorder(tree->right);
}

/* check the depth of each primary sibling to see that it is exactly
 * k deep. e.g.;
 *
 *	ALT
 *   |
 *   A ------- B
 *   |         |
 *   C -- D    E
 *
 * Remove all branches <= k deep.
 *
 * Added by TJP 9-23-92 to make the LL(k) constraint mechanism to work.
 */
Tree *
#ifdef __STDC__
prune( Tree *t, int k )
#else
prune( t, k )
Tree *t;
int k;
#endif
{
    if ( t == NULL ) return NULL;
    if ( t->token == ALT ) fatal_internal("prune: ALT node in FIRST tree");
    if ( t->right!=NULL ) t->right = prune(t->right, k);
    if ( k>1 )
	{
		if ( t->down!=NULL ) t->down = prune(t->down, k-1);
		if ( t->down == NULL )
		{
			Tree *r = t->right;
			t->right = NULL;
			Tfree(t);
			return r;
		}
	}
    return t;
}

/* build a tree (root child1 child2 ... NULL) */
#ifdef __STDC__
Tree *tmake(Tree *root, ...)
#else
Tree *tmake(va_alist)
va_dcl
#endif
{
	Tree *w;
	va_list ap;
	Tree *child, *sibling=NULL, *tail;
#ifndef __STDC__
	Tree *root;
#endif

#ifdef __STDC__
	va_start(ap, root);
#else
	va_start(ap);
	root = va_arg(ap, Tree *);
#endif
	child = va_arg(ap, Tree *);
	while ( child != NULL )
	{
#ifdef DUM
		/* added "find end of child" thing TJP March 1994 */
		for (w=child; w->right!=NULL; w=w->right) {;} /* find end of child */
#else
		w = child;
#endif

		if ( sibling == NULL ) {sibling = child; tail = w;}
		else {tail->right = child; tail = w;}
		child = va_arg(ap, Tree *);
	}

	/* was "root->down = sibling;" */
	if ( root==NULL ) root = sibling;
	else root->down = sibling;

	va_end(ap);
	return root;
}

Tree *
#ifdef __STDC__
tnode( int tok )
#else
tnode( tok )
int tok;
#endif
{
	Tree *p, *newblk;
	static int n=0;
	
	if ( FreeList == NULL )
	{
		/*fprintf(stderr, "tnode: %d more nodes\n", TreeBlockAllocSize);*/
		if ( TreeResourceLimit > 0 )
		{
			if ( (n+TreeBlockAllocSize) >= TreeResourceLimit )
			{
				fprintf(stderr, ErrHdr, FileStr[CurAmbigfile], CurAmbigline);
				fprintf(stderr, " hit analysis resource limit while analyzing alts %d and %d %s\n",
								CurAmbigAlt1,
								CurAmbigAlt2,
								CurAmbigbtype);
				exit(PCCTS_EXIT_FAILURE);
			}
		}
		newblk = (Tree *)calloc(TreeBlockAllocSize, sizeof(Tree));
		if ( newblk == NULL )
		{
			fprintf(stderr, ErrHdr, FileStr[CurAmbigfile], CurAmbigline);
			fprintf(stderr, " out of memory while analyzing alts %d and %d %s\n",
							CurAmbigAlt1,
							CurAmbigAlt2,
							CurAmbigbtype);
			exit(PCCTS_EXIT_FAILURE);
		}
		n += TreeBlockAllocSize;
		for (p=newblk; p<&(newblk[TreeBlockAllocSize]); p++)
		{
			p->right = FreeList;	/* add all new Tree nodes to Free List */
			FreeList = p;
		}
	}
	p = FreeList;
	FreeList = FreeList->right;		/* remove a tree node */
	p->right = NULL;				/* zero out ptrs */
	p->down = NULL;
	p->token = tok;
#ifdef TREE_DEBUG
	require(!p->in_use, "tnode: node in use!");
	p->in_use = 1;
#endif
	return p;
}

static Tree *
#ifdef __STDC__
eofnode( int k )
#else
eofnode( k )
int k;
#endif
{
	Tree *t=NULL;
	int i;

	for (i=1; i<=k; i++)
	{
		t = tmake(tnode((TokenInd!=NULL?TokenInd[EofToken]:EofToken)), t, NULL);
	}
	return t;
}



void
#ifdef __STDC__
_Tfree( Tree *t )
#else
_Tfree( t )
Tree *t;
#endif
{
	if ( t!=NULL )
	{
#ifdef TREE_DEBUG
		require(t->in_use, "_Tfree: node not in use!");
		t->in_use = 0;
#endif
		t->right = FreeList;
		FreeList = t;
	}
}

/* tree duplicate */
Tree *
#ifdef __STDC__
tdup( Tree *t )
#else
tdup( t )
Tree *t;
#endif
{
	Tree *u;
	
	if ( t == NULL ) return NULL;
	u = tnode(t->token);
	u->v.rk = t->v.rk;
	u->right = tdup(t->right);
	u->down = tdup(t->down);
	return u;
}

/* tree duplicate (assume tree is a chain downwards) */
Tree *
#ifdef __STDC__
tdup_chain( Tree *t )
#else
tdup_chain( t )
Tree *t;
#endif
{
	Tree *u;
	
	if ( t == NULL ) return NULL;
	u = tnode(t->token);
	u->v.rk = t->v.rk;
	u->down = tdup(t->down);
	return u;
}

Tree *
#ifdef __STDC__
tappend( Tree *t, Tree *u )
#else
tappend( t, u )
Tree *t;
Tree *u;
#endif
{
	Tree *w;

	/*fprintf(stderr, "tappend(");
	preorder(t); fprintf(stderr, ",");
	preorder(u); fprintf(stderr, " )\n");*/
	if ( t == NULL ) return u;
	if ( t->token == ALT && t->right == NULL ) return tappend(t->down, u);
	for (w=t; w->right!=NULL; w=w->right) {;}
	w->right = u;
	return t;
}

/* dealloc all nodes in a tree */
void
#ifdef __STDC__
Tfree( Tree *t )
#else
Tfree( t )
Tree *t;
#endif
{
	if ( t == NULL ) return;
	Tfree( t->down );
	Tfree( t->right );
	_Tfree( t );
}

/* find all children (alts) of t that require remaining_k nodes to be LL_k
 * tokens long.
 *
 * t-->o
 *     |
 *     a1--a2--...--an		<-- LL(1) tokens
 *     |   |        |
 *     b1  b2  ...  bn		<-- LL(2) tokens
 *     |   |        |
 *     .   .        .
 *     .   .        .
 *     z1  z2  ...  zn		<-- LL(LL_k) tokens
 *
 * We look for all [Ep] needing remaining_k nodes and replace with u.
 * u is not destroyed or actually used by the tree (a copy is made).
 */
Tree *
#ifdef __STDC__
tlink( Tree *t, Tree *u, int remaining_k )
#else
tlink( t, u, remaining_k )
Tree *t;
Tree *u;
int remaining_k;
#endif
{
	Tree *p;
	require(remaining_k!=0, "tlink: bad tree");

	if ( t==NULL ) return NULL;
	/*fprintf(stderr, "tlink: u is:"); preorder(u); fprintf(stderr, "\n");*/
	if ( t->token == EpToken && t->v.rk == remaining_k )
	{
		require(t->down==NULL, "tlink: invalid tree");
		if ( u == NULL ) return t->right;
		p = tdup( u );
		p->right = t->right;
		_Tfree( t );
		return p;
	}
	t->down = tlink(t->down, u, remaining_k);
	t->right = tlink(t->right, u, remaining_k);
	return t;
}

/* remove as many ALT nodes as possible while still maintaining semantics */
Tree *
#ifdef __STDC__
tshrink( Tree *t )
#else
tshrink( t )
Tree *t;
#endif
{
	if ( t == NULL ) return NULL;
	t->down = tshrink( t->down );
	t->right = tshrink( t->right );
	if ( t->down == NULL )
	{
		if ( t->token == ALT )
		{
			Tree *u = t->right;
			_Tfree(t);
			return u;			/* remove useless alts */
		}
		return t;
	}

	/* (? (ALT (? ...)) s) ==> (? (? ...) s) where s = sibling, ? = match any */
	if ( t->token == ALT && t->down->right == NULL)
	{
		Tree *u = t->down;
		u->right = t->right;
		_Tfree( t );
		return u;
	}
	/* (? (A (ALT t)) s) ==> (? (A t) s) where A is a token; s,t siblings */
	if ( t->token != ALT && t->down->token == ALT && t->down->right == NULL )
	{
		Tree *u = t->down->down;
		_Tfree( t->down );
		t->down = u;
		return t;
	}
	return t;
}

Tree *
#ifdef __STDC__
tflatten( Tree *t )
#else
tflatten( t )
Tree *t;
#endif
{
	if ( t == NULL ) return NULL;
	t->down = tflatten( t->down );
	t->right = tflatten( t->right );
	if ( t->down == NULL ) return t;
	
	if ( t->token == ALT )
	{
		Tree *u;
		/* find tail of children */
		for (u=t->down; u->right!=NULL; u=u->right) {;}
		u->right = t->right;
		u = t->down;
		_Tfree( t );
		return u;
	}
	return t;
}

Tree *
#ifdef __STDC__
tJunc( Junction *p, int k, set *rk )
#else
tJunc( p, k, rk )
Junction *p;
int k;
set *rk;
#endif
{
	Tree *t=NULL, *u=NULL;
	Junction *alt;
	Tree *tail, *r;

#ifdef DBG_TRAV
	fprintf(stderr, "tJunc(%d): %s in rule %s\n", k,
			decodeJType[p->jtype], ((Junction *)p)->rname);
#endif
	if ( p->jtype==aLoopBlk || p->jtype==RuleBlk ||
		 p->jtype==aPlusBlk || p->jtype==aSubBlk || p->jtype==aOptBlk )
	{
		if ( p->jtype!=aSubBlk && p->jtype!=aOptBlk ) {
			require(p->lock!=NULL, "rJunc: lock array is NULL");
			if ( p->lock[k] ) return NULL;
			p->lock[k] = TRUE;
		}
		TRAV(p->p1, k, rk, tail);
		if ( p->jtype==RuleBlk ) {p->lock[k] = FALSE; return tail;}
		r = tmake(tnode(ALT), tail, NULL);
		for (alt=(Junction *)p->p2; alt!=NULL; alt = (Junction *)alt->p2)
		{
			/* if this is one of the added optional alts for (...)+ then break */
			if ( alt->ignore ) break;

			if ( tail==NULL ) {TRAV(alt->p1, k, rk, tail); r->down = tail;}
			else
			{
				TRAV(alt->p1, k, rk, tail->right);
				if ( tail->right != NULL ) tail = tail->right;
			}
		}
		if ( p->jtype!=aSubBlk && p->jtype!=aOptBlk ) p->lock[k] = FALSE;
#ifdef DBG_TREES
		fprintf(stderr, "blk(%s) returns:",((Junction *)p)->rname); preorder(r); fprintf(stderr, "\n");
#endif
		if ( r->down == NULL ) {_Tfree(r); return NULL;}
		return r;
	}

	if ( p->jtype==EndRule )
	{
		if ( p->halt )						/* don't want FOLLOW here? */
		{
/*			if ( ContextGuardTRAV ) return NULL;*/
			set_orel(k, rk);				/* indicate this k value needed */
			t = tnode(EpToken);
			t->v.rk = k;
			return t;
		}
		require(p->lock!=NULL, "rJunc: lock array is NULL");
		if ( p->lock[k] ) return NULL;
		/* if no FOLLOW assume k EOF's */
		if ( p->p1 == NULL ) return eofnode(k);
		p->lock[k] = TRUE;
	}

	if ( p->p2 == NULL )
	{
		TRAV(p->p1, k, rk,t);
		if ( p->jtype==EndRule ) p->lock[k]=FALSE;
		return t;
	}
	TRAV(p->p1, k, rk, t);
	if ( p->jtype!=RuleBlk ) TRAV(p->p2, k, rk, u);
	if ( p->jtype==EndRule ) p->lock[k] = FALSE;/* unlock node */

	if ( t==NULL ) return tmake(tnode(ALT), u, NULL);
	return tmake(tnode(ALT), t, u, NULL);
}

Tree *
#ifdef __STDC__
tRuleRef( RuleRefNode *p, int k, set *rk_out )
#else
tRuleRef( p, k, rk_out )
RuleRefNode *p;
int k;
set *rk_out;
#endif
{ 
	int k2;
	Tree *t, *u;
	Junction *r;
	set rk, rk2;
	int save_halt;
	RuleEntry *q = (RuleEntry *) hash_get(Rname, p->text);
	
#ifdef DBG_TRAV
	fprintf(stderr, "tRuleRef: %s\n", p->text);
#endif
	if ( q == NULL )
	{
		TRAV(p->next, k, rk_out, t);/* ignore undefined rules */
		return t;
	}
	rk = rk2 = empty;
	r = RulePtr[q->rulenum];
	if ( r->lock[k] ) return NULL;
	save_halt = r->end->halt;
	r->end->halt = TRUE;		/* don't let reach fall off end of rule here */
	TRAV(r, k, &rk, t);
	r->end->halt = save_halt;
#ifdef DBG_TREES
	fprintf(stderr, "after ruleref, t is:"); preorder(t); fprintf(stderr, "\n");
#endif
	t = tshrink( t );
	while ( !set_nil(rk) ) {	/* any k left to do? if so, link onto tree */
		k2 = set_int(rk);
		set_rm(k2, rk);
		TRAV(p->next, k2, &rk2, u);
		t = tlink(t, u, k2);	/* any alts missing k2 toks, add u onto end */
	}
	set_free(rk);				/* rk is empty, but free it's memory */
	set_orin(rk_out, rk2);		/* remember what we couldn't do */
	set_free(rk2);
	return t;
}

Tree *
#ifdef __STDC__
tToken( TokNode *p, int k, set *rk )
#else
tToken( p, k, rk )
TokNode *p;
int k;
set *rk;
#endif
{
	Tree *t, *tset=NULL, *u;

	if ( ConstrainSearch )
	{
		require(constrain>=fset&&constrain<=&(fset[LL_k]),"tToken: constrain is not a valid set");
		constrain = &fset[maxk-k+1];
	}

#ifdef DBG_TRAV
	fprintf(stderr, "tToken(%d): %s\n", k, TerminalString(p->token));
	if ( ConstrainSearch ) {
		fprintf(stderr, "constrain is:"); s_fprT(stderr, *constrain); fprintf(stderr, "\n");
	}
#endif
	/* is it a meta token (set of tokens)? */
	if ( !set_nil(p->tset) )
	{
		unsigned e=0;
		set a;
		Tree *n, *tail = NULL;

		if ( ConstrainSearch ) a = set_and(p->tset, *constrain);
		else a = set_dup(p->tset);
#ifdef DUM
		if ( ConstrainSearch ) a = set_dif(p->tset, *constrain);
		else a = set_dup(p->tset);
#endif
		for (; !set_nil(a); set_rm(e, a))
		{
			e = set_int(a);
			n = tnode(e);
			if ( tset==NULL ) { tset = n; tail = n; }
			else { tail->right = n; tail = n; }
		}
		set_free( a );
	}
	else if ( ConstrainSearch && !set_el(p->token, *constrain) )
    {
/*      fprintf(stderr, "ignoring token %s(%d)\n", TerminalString(p->token),
                k);*/
        return NULL;
    }
	else tset = tnode( p->token );

	if ( k == 1 ) return tset;

	TRAV(p->next, k-1, rk, t);
	/* here, we are positive that, at least, this tree will not contribute
	 * to the LL(2) tree since it will be too shallow, IF t==NULL.
	 * If doing a context guard walk, then don't prune.
	 */
	if ( t == NULL && !ContextGuardTRAV )	/* tree will be too shallow */
	{
		if ( tset!=NULL ) Tfree( tset );
		return NULL;
	}
#ifdef DBG_TREES
	fprintf(stderr, "tToken(%d)->next:",k); preorder(t); fprintf(stderr, "\n");
#endif

	/* if single token root, then just make new tree and return */
	if ( set_nil(p->tset) ) return tmake(tnode(p->token), t, NULL);

	/* here we must make a copy of t as a child of each element of the tset;
	 * e.g., "T1..T3 A" would yield ( nil ( T1 A ) ( T2 A ) ( T3 A ) )
	 */
	for (u=tset; u!=NULL; u=u->right)
	{
		/* make a copy of t and hook it onto bottom of u */
		u->down = tdup(t);
	}
	Tfree( t );
#ifdef DBG_TREES
	fprintf(stderr, "range is:"); preorder(tset); fprintf(stderr, "\n");
#endif
	return tset;
}

Tree *
#ifdef __STDC__
tAction( ActionNode *p, int k, set *rk )
#else
tAction( p, k, rk )
ActionNode *p;
int k;
set *rk;
#endif
{
	Tree *t;
	
	/*fprintf(stderr, "tAction\n");*/
	TRAV(p->next, k, rk, t);
	return t;
}

/* see if e exists in s as a possible input permutation (e is always a chain) */
int
#ifdef __STDC__
tmember( Tree *e, Tree *s )
#else
tmember( e, s )
Tree *e;
Tree *s;
#endif
{
	if ( e==NULL||s==NULL ) return 0;
	/*fprintf(stderr, "tmember(");
	preorder(e); fprintf(stderr, ",");
	preorder(s); fprintf(stderr, " )\n");*/
	if ( s->token == ALT && s->right == NULL ) return tmember(e, s->down);
	if ( e->token!=s->token )
	{
		if ( s->right==NULL ) return 0;
		return tmember(e, s->right);
	}
	if ( e->down==NULL && s->down == NULL ) return 1;
	if ( tmember(e->down, s->down) ) return 1;
	if ( s->right==NULL ) return 0;
	return tmember(e, s->right);
}

/* see if e exists in s as a possible input permutation (e is always a chain);
 * Only check s to the depth of e.  In other words, 'e' can be a shorter 
 * sequence than s.
 */
int
#ifdef __STDC__
tmember_constrained( Tree *e, Tree *s)
#else
tmember_constrained( e, s )
Tree *e;
Tree *s;
#endif
{
	if ( e==NULL||s==NULL ) return 0;
/*	fprintf(stderr, "tmember_constrained(");
	preorder(e); fprintf(stderr, ",");
	preorder(s); fprintf(stderr, " )\n");*/
	if ( s->token == ALT && s->right == NULL )
		return tmember_constrained(e, s->down);
	if ( e->token!=s->token )
	{
		if ( s->right==NULL ) return 0;
		return tmember_constrained(e, s->right);
	}
	if ( e->down == NULL ) return 1; /* if s is matched to depth of e return */
	if ( tmember_constrained(e->down, s->down) ) return 1;
	if ( s->right==NULL ) return 0;
	return tmember_constrained(e, s->right);
}

/* combine (? (A t) ... (A u) ...) into (? (A t u)) */
Tree *
#ifdef __STDC__
tleft_factor( Tree *t )
#else
tleft_factor( t )
Tree *t;
#endif
{
	Tree *u, *v, *trail, *w;

	/* left-factor what is at this level */
	if ( t == NULL ) return NULL;
	for (u=t; u!=NULL; u=u->right)
	{
		trail = u;
		v=u->right;
		while ( v!=NULL )
		{
			if ( u->token == v->token )
			{
				if ( u->down!=NULL )
				{
					for (w=u->down; w->right!=NULL; w=w->right) {;}
					w->right = v->down;	/* link children together */
				}
				else u->down = v->down;
				trail->right = v->right;		/* unlink factored node */
				_Tfree( v );
				v = trail->right;
			}
			else {trail = v; v=v->right;}
		}
	}
	/* left-factor what is below */
	for (u=t; u!=NULL; u=u->right) u->down = tleft_factor( u->down );
	return t;
}

/* remove the permutation p from t if present */
Tree *
#ifdef __STDC__
trm_perm( Tree *t, Tree *p )
#else
trm_perm( t, p )
Tree *t;
Tree *p;
#endif
{
	/*
	fprintf(stderr, "trm_perm(");
	preorder(t); fprintf(stderr, ",");
	preorder(p); fprintf(stderr, " )\n");
	*/
	if ( t == NULL || p == NULL ) return NULL;
	if ( t->token == ALT )
	{
		t->down = trm_perm(t->down, p);
		if ( t->down == NULL ) 				/* nothing left below, rm cur node */
		{
			Tree *u = t->right;
			_Tfree( t );
			return trm_perm(u, p);
		}
		t->right = trm_perm(t->right, p);	/* look for more instances of p */
		return t;
	}
	if ( p->token != t->token )				/* not found, try a sibling */
	{
		t->right = trm_perm(t->right, p);
		return t;
	}
	t->down = trm_perm(t->down, p->down);
	if ( t->down == NULL ) 					/* nothing left below, rm cur node */
	{
		Tree *u = t->right;
		_Tfree( t );
		return trm_perm(u, p);
	}
	t->right = trm_perm(t->right, p);		/* look for more instances of p */
	return t;
}

/* add the permutation 'perm' to the LL_k sets in 'fset' */
void
#ifdef __STDC__
tcvt( set *fset, Tree *perm )
#else
tcvt( fset, perm )
set *fset;
Tree *perm;
#endif
{
	if ( perm==NULL ) return;
	set_orel(perm->token, fset);
	tcvt(fset+1, perm->down);
}

/* for each element of ftbl[k], make it the root of a tree with permute(ftbl[k+1])
 * as a child.
 */
Tree *
#ifdef __STDC__
permute( int k, int max_k )
#else
permute( k, max_k )
int k, max_k;
#endif
{
	Tree *t, *u;
	
	if ( k>max_k ) return NULL;
	if ( ftbl[k][findex[k]] == nil ) return NULL;
	t = permute(k+1, max_k);
	if ( t==NULL&&k<max_k )		/* no permutation left below for k+1 tokens? */
	{
		findex[k+1] = 0;
		(findex[k])++;			/* try next token at this k */
		return permute(k, max_k);
	}
	
	u = tmake(tnode(ftbl[k][findex[k]]), t, NULL);
	if ( k == max_k ) (findex[k])++;
	return u;
}

/* Compute LL(k) trees for alts alt1 and alt2 of p.
 * function result is tree of ambiguous input permutations
 *
 * ALGORITHM may change to look for something other than LL_k size
 * trees ==> maxk will have to change.
 */
Tree *
#ifdef __STDC__
VerifyAmbig( Junction *alt1, Junction *alt2, unsigned **ft, set *fs, Tree **t, Tree **u, int *numAmbig )
#else
VerifyAmbig( alt1, alt2, ft, fs, t, u, numAmbig )
Junction *alt1;
Junction *alt2;
unsigned **ft;
set *fs;
Tree **t;
Tree **u;
int *numAmbig;
#endif
{
	set rk;
	Tree *perm, *ambig=NULL;
	Junction *p;
	int k;

	maxk = LL_k;				/* NOTE: for now, we look for LL_k */
	ftbl = ft;
	fset = fs;
	constrain = &(fset[1]);
	findex = (int *) calloc(LL_k+1, sizeof(int));
	if ( findex == NULL )
	{
		fprintf(stderr, ErrHdr, FileStr[CurAmbigfile], CurAmbigline);
		fprintf(stderr, " out of memory while analyzing alts %d and %d of %s\n",
						CurAmbigAlt1,
						CurAmbigAlt2,
						CurAmbigbtype);
		exit(PCCTS_EXIT_FAILURE);
	}
	for (k=1; k<=LL_k; k++) findex[k] = 0;

	rk = empty;
	ConstrainSearch = 1;	/* consider only tokens in ambig sets */

	p = analysis_point((Junction *)alt1->p1);
	TRAV(p, LL_k, &rk, *t);
	*t = tshrink( *t );
	*t = tflatten( *t );
	*t = prune(*t, LL_k);
	*t = tleft_factor( *t );
/*	fprintf(stderr, "after shrink&flatten&prune&left_factor:"); preorder(*t); fprintf(stderr, "\n");*/
	if ( *t == NULL )
	{
/*		fprintf(stderr, "TreeIncomplete --> no LL(%d) ambiguity\n", LL_k);*/
		Tfree( *t );	/* kill if impossible to have ambig */
		*t = NULL;
	}

	p = analysis_point((Junction *)alt2->p1);
	TRAV(p, LL_k, &rk, *u);
	*u = tshrink( *u );
	*u = tflatten( *u );
	*u = prune(*u, LL_k);
	*u = tleft_factor( *u );
/*	fprintf(stderr, "after shrink&flatten&prune&lfactor:"); preorder(*u); fprintf(stderr, "\n");*/
	if ( *u == NULL )
	{
/*		fprintf(stderr, "TreeIncomplete --> no LL(%d) ambiguity\n", LL_k);*/
		Tfree( *u );
		*u = NULL;
	}

	for (k=1; k<=LL_k; k++) set_clr( fs[k] );

	ambig = tnode(ALT);
	k = 0;
	if ( *t!=NULL && *u!=NULL )
	{
		while ( (perm=permute(1,LL_k))!=NULL )
		{
/*			fprintf(stderr, "chk perm:"); preorder(perm); fprintf(stderr, "\n");*/
			if ( tmember(perm, *t) && tmember(perm, *u) )
			{
/*				fprintf(stderr, "ambig upon"); preorder(perm); fprintf(stderr, "\n");*/
				k++;
				perm->right = ambig->down;
				ambig->down = perm;
				tcvt(&(fs[1]), perm);
			}
			else Tfree( perm );
		}
	}

	*numAmbig = k;
	if ( ambig->down == NULL ) {_Tfree(ambig); ambig = NULL;}
	free( (char *)findex );
/*	fprintf(stderr, "final ambig:"); preorder(ambig); fprintf(stderr, "\n");*/
	return ambig;
}

static Tree *
#ifdef __STDC__
bottom_of_chain( Tree *t )
#else
bottom_of_chain( t )
Tree *t;
#endif
{
    if ( t==NULL ) return NULL;
    for (; t->down != NULL; t=t->down) {;}
    return t;
}

/*
 * Make a tree from k sets where the degree of the first k-1 sets is 1.
 */
Tree *
#ifdef __STDC__
make_tree_from_sets( set *fset1, set *fset2 )
#else
make_tree_from_sets( fset1, fset2 )
set *fset1;
set *fset2;
#endif
{
	set inter;
	int i;
	Tree *t=NULL, *n, *u;
	unsigned *p,*q;
	require(LL_k>1, "make_tree_from_sets: LL_k must be > 1");

	/* do the degree 1 sets first */
	for (i=1; i<=LL_k-1; i++)
	{
		inter = set_and(fset1[i], fset2[i]);
		require(set_deg(inter)==1, "invalid set to tree conversion");
		n = tnode(set_int(inter));
		if (t==NULL) t=n; else tmake(t, n, NULL);
		set_free(inter);
	}

	/* now add the chain of tokens at depth k */
	u = bottom_of_chain(t);
	inter = set_and(fset1[LL_k], fset2[LL_k]);
	if ( (q=p=set_pdq(inter)) == NULL ) fatal_internal("Can't alloc space for set_pdq");
	/* first one is linked to bottom, then others are sibling linked */
	n = tnode(*p++);
	u->down = n;
	u = u->down;
	while ( *p != nil )
	{
		n = tnode(*p);
		u->right = n;
		u = u->right;
		p++;
	}
	free((char *)q);

	return t;
}

/* create and return the tree of lookahead k-sequences that are in t, but not
 * in the context of predicates in predicate list p.
 */
Tree *
#ifdef __STDC__
tdif( Tree *ambig_tuples, Predicate *p, set *fset1, set *fset2 )
#else
tdif( ambig_tuples, p, fset1, fset2 )
Tree *ambig_tuples;
Predicate *p;
set *fset1;
set *fset2;
#endif
{
	unsigned **ft;
	Tree *dif=NULL;
	Tree *perm;
	set b;
	int i,k;

	if ( p == NULL ) return tdup(ambig_tuples);

	ft = (unsigned **) calloc(CLL_k+1, sizeof(unsigned *));
	require(ft!=NULL, "cannot allocate ft");
	for (i=1; i<=CLL_k; i++)
	{
		b = set_and(fset1[i], fset2[i]);
		ft[i] = set_pdq(b);
		set_free(b);
	}
	findex = (int *) calloc(LL_k+1, sizeof(int));
	if ( findex == NULL )
	{
		fatal_internal("out of memory in tdif while checking predicates");
	}
	for (k=1; k<=LL_k; k++) findex[k] = 0;

#ifdef DBG_TRAV
	fprintf(stderr, "tdif_%d[", p->k);
	preorder(ambig_tuples);
	fprintf(stderr, ",");
	preorder(p->tcontext);
	fprintf(stderr, "] =");
#endif

	ftbl = ft;
	while ( (perm=permute(1,p->k))!=NULL )
	{
#ifdef DBG_TRAV
		fprintf(stderr, "test perm:"); preorder(perm); fprintf(stderr, "\n");
#endif
		if ( tmember_constrained(perm, ambig_tuples) &&
			 !tmember_of_context(perm, p) )
		{
#ifdef DBG_TRAV
			fprintf(stderr, "satisfied upon"); preorder(perm); fprintf(stderr, "\n");
#endif
			k++;
			if ( dif==NULL ) dif = perm;
			else
			{
				perm->right = dif;
				dif = perm;
			}
		}
		else Tfree( perm );
	}

#ifdef DBG_TRAV
	preorder(dif);
	fprintf(stderr, "\n");
#endif

	for (i=1; i<=CLL_k; i++) free( (char *)ft[i] );
	free((char *)ft);
	free((char *)findex);

	return dif;
}

/* is lookahead sequence t a member of any context tree for any
 * predicate in p?
 */
static int
#ifdef __STDC__
tmember_of_context( Tree *t, Predicate *p )
#else
tmember_of_context( t, p )
Tree *t;
Predicate *p;
#endif
{
	for (; p!=NULL; p=p->right)
	{
		if ( p->expr==PRED_AND_LIST || p->expr==PRED_OR_LIST )
			return tmember_of_context(t, p->down);
		if ( tmember_constrained(t, p->tcontext) ) return 1;
		if ( tmember_of_context(t, p->down) ) return 1;
	}
	return 0;
}

int
#ifdef __STDC__
is_single_tuple( Tree *t )
#else
is_single_tuple( t )
Tree *t;
#endif
{
	if ( t == NULL ) return 0;
	if ( t->right != NULL ) return 0;
	if ( t->down == NULL ) return 1;
	return is_single_tuple(t->down);
}

/*
 * Look at a (...)? generalized-predicate context-guard and compute
 * either a lookahead set (k==1) or a lookahead tree for k>1.  The
 * k level is determined by the guard itself rather than the LL_k
 * variable.  For example, ( A B )? is an LL(2) guard and ( ID )?
 * is an LL(1) guard.  For the moment, you can only have a single
 * tuple in the guard.  Physically, the block must look like this
 *   --o-->TOKEN-->o-->o-->TOKEN-->o-- ... -->o-->TOKEN-->o--
 * An error is printed for any other type.
 */
Predicate *
#ifdef __STDC__
computePredicateFromContextGuard(Graph blk)
#else
computePredicateFromContextGuard(blk)
Graph blk;
#endif
{
    Junction *junc = (Junction *)blk.left, *p;
	Tree *t;
	Predicate *pred = NULL;
	set scontext, rk;
    require(junc!=NULL && junc->ntype == nJunction, "bad context guard");

	rk = empty;
	p = junc;
	pred = new_pred();
	pred->k = LL_k;
	if ( LL_k > 1 )
	{
		ConstrainSearch = 0;
		ContextGuardTRAV = 1;
		TRAV(p, LL_k, &rk, t);
		ContextGuardTRAV = 0;
		set_free(rk);
		t = tshrink( t );
		t = tflatten( t );
		t = tleft_factor( t );
/*
		fprintf(stderr, "ctx guard:");
		preorder(t);
		fprintf(stderr, "\n");
*/
		pred->tcontext = t;
	}
	else
	{
		REACH(p, 1, &rk, scontext);
		require(set_nil(rk), "rk != nil");
		set_free(rk);
/*
		fprintf(stderr, "LL(1) ctx guard is:");
		s_fprT(stderr, scontext);
		fprintf(stderr, "\n");
*/
		pred->scontext[1] = scontext;
	}

	return pred;
}
