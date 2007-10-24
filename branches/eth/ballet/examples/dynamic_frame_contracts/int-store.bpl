// SET THEORY
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

axiom (forall s1:set,s2:set :: set.is_disjoint (s1,s2) == set.is_disjoint (s2,s1));

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

// END OF SET THEORY

// MEMORY MODEL 

var $Heap: [ref,name]any;

// END OF MEMORY MODEL

// SPECIFICATION OF INT STORE

function fun.INT_STORE.item ([ref,name]any,ref) returns (int);
function fun.INT_STORE.repr ([ref,name]any,ref) returns (set);

// axiom (forall ho:[ref,name]any,hn:[ref,name]any,c:ref :: (forall r:ref,n:name :: fun.INT_STORE.repr (ho, ho[r,n] == hn[r,n]) => 

procedure proc.INT_STORE.set_item (this:ref,a_value:int);
  requires this != null;
  modifies $Heap;
  ensures fun.INT_STORE.item ($Heap,this) == a_value;
  ensures fun.INT_STORE.repr ($Heap,this) == old (fun.INT_STORE.repr ($Heap,this));
  
// END OF SPECIFICATION OF INT STORE

// INT STORE USAGE

procedure initialize (a_store1:ref,a_store2:ref);
  requires a_store1 != null;
  requires a_store2 != null;
  requires set.is_disjoint (fun.INT_STORE.repr ($Heap,a_store1),fun.INT_STORE.repr ($Heap,a_store2));
  modifies $Heap;
  ensures fun.INT_STORE.item ($Heap,a_store1) == 4711;
  ensures fun.INT_STORE.item ($Heap,a_store2) == 1234;
implementation initialize (a_store1:ref,a_store2:ref) 
{
   var old_Heap: [ref,name]any;

  entry:
    old_Heap := $Heap;
    // Point 1
    call proc.INT_STORE.set_item (a_store1,4711);
    assume (forall o:ref :: set.is_disjoint (fun.INT_STORE.repr (old_Heap, o), fun.INT_STORE.repr (old_Heap, a_store1)) ==> (fun.INT_STORE.repr ($Heap,o) == fun.INT_STORE.repr (old_Heap, o)));
    assume (forall o:ref :: set.is_disjoint (fun.INT_STORE.repr (old_Heap, o), fun.INT_STORE.repr (old_Heap, a_store1)) ==> (fun.INT_STORE.item ($Heap,o) == fun.INT_STORE.item (old_Heap, o)));
    
    assert (set.is_disjoint (fun.INT_STORE.repr ($Heap,a_store1),fun.INT_STORE.repr ($Heap,a_store2)));
    
    old_Heap := $Heap;

    call proc.INT_STORE.set_item (a_store2,1234);
    assume (forall o:ref :: set.is_disjoint (fun.INT_STORE.repr (old_Heap, o), fun.INT_STORE.repr (old_Heap, a_store2)) ==> (fun.INT_STORE.repr ($Heap,o) == fun.INT_STORE.repr (old_Heap, o)));
    assume (forall o:ref :: set.is_disjoint (fun.INT_STORE.repr (old_Heap, o), fun.INT_STORE.repr (old_Heap, a_store2)) ==> (fun.INT_STORE.item ($Heap,o) == fun.INT_STORE.item (old_Heap, o)));
    
    return;
}

procedure copy (a_store1:ref,a_store2:ref);
  requires a_store1 != null;
  requires a_store2 != null;
  requires set.is_disjoint (fun.INT_STORE.repr ($Heap,a_store1),fun.INT_STORE.repr ($Heap,a_store2));
  modifies $Heap;
  ensures fun.INT_STORE.item ($Heap,a_store1) == fun.INT_STORE.item($Heap,a_store1);
implementation copy (a_store1:ref,a_store2:ref) 
{
  var old_repr1:set,old_repr2:set,old_item1:int,old_item2:int;

  entry:
    // Point 1
    old_repr1 := fun.INT_STORE.repr ($Heap,a_store1);
    old_repr2 := fun.INT_STORE.repr ($Heap,a_store2);
    old_item1 := fun.INT_STORE.item ($Heap,a_store1);
    old_item2 := fun.INT_STORE.item ($Heap,a_store2);
    call proc.INT_STORE.set_item (a_store1,fun.INT_STORE.item ($Heap,a_store2));
    assume (set.is_disjoint (old_repr1,old_repr1) ==> (fun.INT_STORE.repr ($Heap,a_store1) == old_repr1));
    assume (set.is_disjoint (old_repr2,old_repr1) ==> (fun.INT_STORE.repr ($Heap,a_store2) == old_repr2));
    assume (set.is_disjoint (old_repr1,old_repr1) ==> (fun.INT_STORE.item ($Heap,a_store1) == old_item1));
    assume (set.is_disjoint (old_repr2,old_repr1) ==> (fun.INT_STORE.item ($Heap,a_store2) == old_item2));

    return;
}

// END OF INT STORE USAGE


