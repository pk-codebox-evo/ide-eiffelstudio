type bag;
type sequence;
type relation;

// ------------------------------------------------------------------------
// PAIR
type pair;

// Constructors
function pair.make (any,any) returns (pair);

// Selectors
function pair.first (pair) returns (any);
axiom (forall x:any,y:any :: pair.first(pair.make (x,y)) == x);
function pair.second (pair) returns (any);
axiom (forall x:any,y:any :: pair.second(pair.make (x,y)) == y);

// ------------------------------------------------------------------------
// SET
type set;

// Constructors
const set.make_empty: set;
function set.extended (set,any) returns (set);

// Content
function set.is_member (set,any) returns (bool);
axiom (forall s:set,x:any :: {set.is_member(set.extended(s,x),x)}
  set.is_member(set.extended(s,x),x));
axiom (forall s:set,x:any,y:any :: 
  x != y ==> set.is_member(set.extended(s,y),x) == set.is_member(s,x));
axiom (forall x:any :: !set.is_member (set.make_empty,x));

// Pruning
function set.pruned (set,any) returns (set);
axiom (forall x:any :: {set.pruned(set.make_empty,x)}
  set.pruned(set.make_empty,x) == set.make_empty);
axiom (forall s:set,x:any :: {set.pruned(set.extended(s,x),x)}
  set.pruned(set.extended(s,x),x) == set.pruned(s,x));
axiom (forall s:set,x:any,y:set :: {set.pruned(set.extended(s,x),y)}
  (x != y) ==> set.pruned(set.extended(s,x),y) == set.extended(set.pruned(s,y),x));

// Emptiness
function set.is_empty (set) returns (bool);
axiom (forall s:set,x:any :: !set.is_empty(set.extended(s,x)));
axiom (set.is_empty (set.make_empty));

// Cardinality
function set.cardinality (set) returns (int);
axiom (set.cardinality(set.make_empty) == 0);
axiom (forall s:set,x:any :: { set.cardinality(set.extended(s,x)) }
  !set.is_member(s,x) ==> 
    set.cardinality(set.extended(s,x)) == set.cardinality(s) + 1);
axiom (forall s:set,x:any :: { set.cardinality(set.extended(s,x)) }
  set.is_member(s,x) ==> 
    set.cardinality(set.extended(s,x)) == set.cardinality(s));

// Any element
function set.any_element (set) returns (any);
axiom (forall s:set,x:any :: set.any_element(set.extended(s,x)) == x);	

// Subset
function set.is_subset (set,set) returns (bool);
axiom (forall s:set :: set.is_subset (s,set.make_empty));
axiom (forall s1:set,s2:set,x:any :: 
  set.is_subset (s1,set.extended(s2,x)) == (set.is_subset (s1,s2) &&
    set.is_member (s1,x)));
	
// Equality
axiom (forall s1:set,s2:set :: (s1 == s2) == (set.is_subset(s1,s2) &&
  set.is_subset(s2,s1)));

// Union
function set.united (set,set) returns (set);
axiom (forall s:set :: {set.united (s,set.make_empty)}
  set.united (s,set.make_empty) == s);
axiom (forall s1:set,s2:set,x:any :: {set.united(s1,set.extended(s2,x))}
  set.united(s1,set.extended(s2,x)) == set.extended(set.united(s1,s2),x));

// Intersected
function set.intersected (set,set) returns (set);
axiom (forall s:set :: {set.intersected(s,set.make_empty)}
  set.intersected(s,set.make_empty) == set.make_empty);
axiom (forall s1:set,s2:set,x:any :: {set.intersected(s1, set.extended(s2, x))}
  set.is_member(s1,x) ==> (set.intersected(s1,set.extended(s2,x))  == 
    set.extended (set.intersected(s1,s2),x)));
axiom (forall s1:set,s2:set,x:any :: {set.intersected(s1, set.extended(s2, x))}
  !set.is_member(s1,x) ==> (set.intersected(s1,set.extended(s2,x))  == 
    set.intersected(s1,s2)));
  
// Disjoint
function set.is_disjoint (set,set) returns (bool);
axiom (forall s:set :: {set.is_disjoint (s,set.make_empty)}
  set.is_disjoint (s,set.make_empty));
axiom (forall s1:set,s2:set,x:any :: set.is_disjoint(s1,set.extended(s2,x)) ==
  (!set.is_member(s1,x) && set.is_disjoint(s1,s2)));

// Superset
function set.is_superset (set,set) returns (bool);
axiom (forall s1:set,s2:set :: {set.is_superset(s1,s2)}
	set.is_superset(s1,s2) == set.is_subset(s2,s1));
	
// proper Subset
function set.is_proper_superset (set,set) returns (bool);
axiom (forall s1:set,s2:set :: {set.is_proper_superset(s1,s2)}
  set.is_proper_superset(s1,s2) == (set.is_subset(s2,s1) && (s1 != s2)));

// proper Superset
function set.is_proper_subset (set,set) returns (bool);
axiom (forall s1:set,s2:set :: {set.is_proper_subset(s1,s2)}
  set.is_proper_subset(s1,s2) == (set.is_subset(s1,s2) && (s1 != s2)));

// Substracted
function set.subtracted (set,set) returns (set);
axiom (forall s:set :: {set.subtracted(s,set.make_empty)}
  set.subtracted(s,set.make_empty) == s);
axiom (forall s1:set,s2:set,x:any :: {set.subtracted(s1,set.extended(s2,x))}
  set.subtracted(s1,set.extended(s2,x)) == set.pruned(set.subtracted(s1,s2),x));

// Difference
function set.difference (set,set) returns (set);
axiom (forall s1:set,s2:set :: {set.difference(s1,s2)}
  set.difference(s1,s2) == set.subtracted(set.united(s1,s2),set.intersected(s1,s2)));
  
procedure test_theory();
implementation test_theory()
{
  var i:int;
  
  var r:set;
  var s:set;
  var t:set;
  var u:set;
  var v:set;
  var w:set;
  var x:set;
  var y:set;

  foo:
	r := set.make_empty;  		// r = empty
	s := set.extended(r,1); 	// s = {1}
	t := set.extended(r,2);		// t = {2}
	u := set.extended(s,3);		// u = {1,3}
	v := set.extended(t,3);		// v = {2,3}
	w := set.extended(u,3);		// w = {1,3}
	x := set.pruned(set.extended(set.extended(set.extended(w,2),4),4),3);
								// x = {1,2,4}
	y := set.extended(v,4);     // y = {2,3,4}
								
	assert (set.is_member(s,1));
	assert (set.is_empty(r));
	assert (!set.is_empty(s));
	assert (!set.is_empty(t));
	
	assert (set.cardinality(r) == 0);
	assert (set.cardinality(s) == 1);
	assert (set.cardinality(t) == 1);
	assert (set.cardinality(u) == 2);
	assert (set.cardinality(v) == 2);
	assert (set.cardinality(w) == 2);

	assert (set.any_element(s) == 1);
	assert (set.any_element(u) == 1 || set.any_element(u) == 3);
	
	assert (set.is_subset (u,s));
	assert (!set.is_subset (s,u));
	assert (set.is_subset (u,w));
	assert (set.is_subset (w,u));
	
	assert (set.make_empty == set.make_empty);
	assert (u == w);
	assert (v != w);
	
	assert (set.cardinality (set.united (v,w)) == 3);
	assert (set.is_disjoint (s,t));
	assert (!set.is_disjoint (u,w));
	
	assert (set.is_proper_subset(u,s));
	assert (!set.is_proper_superset(u,w));
	
	assert (set.cardinality(set.intersected(v,w)) == 1);
	assert (set.is_member(set.intersected(v,w),3));
	
	assert (set.cardinality(x) == 3);
	
	assert (set.subtracted(v,u) == t);
	
// we have to assert (at least) one of the following to help the prover
// to find a prove for the cardinality assertion later

	assert (set.is_member(set.difference(w,x), 4));
//	assert (set.is_member(set.difference(w,x), 2));
//	assert (set.is_member(set.difference(w,x), 3));

	assert (set.cardinality(set.difference(w,x)) == 3);

	
	return;
}
