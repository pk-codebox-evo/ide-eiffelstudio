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
  

//************
// added by ramack
axiom (forall s:set :: (forall x:any :: !set.is_member(s, x)) ==> set.is_empty(s)); 
axiom (forall s:set :: (exists x:any :: set.is_member(s, x)) ==> !set.is_empty(s));


// The following solves the simple part of the problem discussed via icq
// commenting in will trigger the "same" problem with a set with carinality 2
// we have to find a general solution here
axiom (forall s:set, x:any :: set.cardinality(s) == 1 && set.is_member(s, x) ==>
        (forall y:any :: (y != x) ==> !set.is_member(s, y)));

// This seems to solve these problems in general...
// Maybe this can be simplified
//axiom (forall s:set, x:any :: set.is_member(s, x)
//        ==> set.is_subset(s, set.extended(set.make_empty, x)));

//axiom (forall s:set, x:any :: 
//        set.is_member(s, x) <==>
//        set.is_subset(s, set.extended(set.make_empty, x))
//      );

//axiom (forall s1:set, s2:set ::
//        set.cardinality(s1) == set.cardinality(s2) && set.is_subset(s1, s2)
//         ==> ! set.is_member(s1, set.any_element(s2)));

// class MMLED_SET[INTEGER]

const MMLED_SET_INTEGER: name;

var $set_models: [ref, name]set; // storage for the set models, could be done similar to Heap

procedure MMLED_SET_INTEGER.make_empty($current: ref);
  modifies $set_models;
  requires $current != null;
  ensures FUN_MMLED_SET_INTEGER.is_empty($set_models, $current);
  ensures (forall s:ref, n:name :: (s!= $current || n != MMLED_SET_INTEGER) // frame condition
                ==> $set_models[s, n] == old($set_models[s, n]));

implementation MMLED_SET_INTEGER.make_empty($current: ref)
{
entry:
        $set_models[$current, MMLED_SET_INTEGER] := set.make_empty;
        return;
}

procedure MMLED_SET_INTEGER.is_empty($current: ref) returns ($result: bool);
  requires $current != null;
  ensures set.is_empty($set_models[$current, MMLED_SET_INTEGER]) == $result; // valid:
  ensures $set_models[$current, MMLED_SET_INTEGER]                           // model_inv:
          == old($set_models[$current, MMLED_SET_INTEGER]);


function FUN_MMLED_SET_INTEGER.is_empty([ref, name]set, ref) returns (bool);
axiom (forall $models:[ref, name]set, $current:ref ::
        FUN_MMLED_SET_INTEGER.is_empty($models, $current)
        <==> set.is_empty($models[$current, MMLED_SET_INTEGER])
);

procedure MMLED_SET_INTEGER.has($current: ref, $item: int) returns ($result: bool);
  ensures set.is_member($set_models[$current, MMLED_SET_INTEGER], $item) == $result;
                                                                        // correct:
  ensures $set_models[$current, MMLED_SET_INTEGER]                      // model_inv:
          == old($set_models[$current, MMLED_SET_INTEGER]);

function FUN_MMLED_SET_INTEGER.has([ref, name]set, ref, int) returns (bool);
axiom (forall $models:[ref, name]set, $set:ref, $element:int ::
        FUN_MMLED_SET_INTEGER.has($models, $set, $element)
        <==> set.is_member($models[$set, MMLED_SET_INTEGER], $element)
       );

procedure MMLED_SET_INTEGER.cardinality($current: ref) returns ($result: int);
  ensures set.cardinality($set_models[$current, MMLED_SET_INTEGER]) == $result;
  ensures $set_models[$current, MMLED_SET_INTEGER]                      // model_inv:
          == old($set_models[$current, MMLED_SET_INTEGER]);

function FUN_MMLED_SET_INTEGER.cardinality([ref, name]set, ref) returns (int);
axiom (forall $models:[ref, name]set, $set:ref ::
        FUN_MMLED_SET_INTEGER.cardinality($models, $set)
        == set.cardinality($models[$set, MMLED_SET_INTEGER])
      );

procedure MMLED_SET_INTEGER.extend($current: ref, $item: int);
  modifies $set_models; 
  requires $current != null;
//TODO: remove
//  ensures (set.is_subset(old($set_models[$current, MMLED_SET_INTEGER]),
//        $set_models[$current, MMLED_SET_INTEGER]));
  ensures (forall s:ref, n:name :: (s!= $current || n != MMLED_SET_INTEGER) // frame condition
                ==> $set_models[s, n] == old($set_models[s, n]));
  ensures set.extended(old($set_models[$current, MMLED_SET_INTEGER]), $item) == $set_models[$current, MMLED_SET_INTEGER];

procedure MMLED_SET_INTEGER.prune($current: ref, $item: int);
  modifies $set_models;
  requires $current != null;
  ensures $set_models[$current, MMLED_SET_INTEGER]
          == set.pruned(old($set_models[$current, MMLED_SET_INTEGER]), $item);

  ensures (forall s:ref, n:name :: (s!= $current || n != MMLED_SET_INTEGER) // frame condition
                ==> $set_models[s, n] == old($set_models[s, n]));


procedure MMLED_SET_INTEGER.is_subset($current: ref, $other: ref) returns($result: bool);
  requires $current != null;
  requires $other != null;                                              // valid_other:
  ensures $set_models[$current, MMLED_SET_INTEGER]                      // model_inv:
          == old($set_models[$current, MMLED_SET_INTEGER]);
  ensures $set_models[$other, MMLED_SET_INTEGER]                        // model_inv2:
          == old($set_models[$other, MMLED_SET_INTEGER]);
  ensures $result == set.is_subset($set_models[$current, MMLED_SET_INTEGER],
                        old($set_models[$current, MMLED_SET_INTEGER])); // model_definition:

function FUN_MMLED_SET_INTEGER.is_subset([ref, name]set, ref, ref) returns (bool);
axiom (forall $models:[ref, name]set, $a:ref, $b:ref ::
        (FUN_MMLED_SET_INTEGER.is_subset($models, $a, $b)
        <==> set.is_subset($models[$a, MMLED_SET_INTEGER],
                        $models[$b, MMLED_SET_INTEGER])));

// derived from invariant is_empty = (cardinality = 0)
axiom (forall $s:ref,$models:[ref, name]set :: (
        FUN_MMLED_SET_INTEGER.is_empty($models, $s)
       <==>
        (FUN_MMLED_SET_INTEGER.cardinality($models, $s)  == 0)
       )
      );

// class MAIN
  
procedure make($current:ref);
  modifies $set_models;
  requires $current != null;

implementation make($current:ref)
{
  var s:ref;

  entry:
        havoc s;     // TODO: allocate on the heap
        assume(s != null);
        call MMLED_SET_INTEGER.make_empty(s);  // call creation procedure

        call MAIN.use1($current, s);
        
//        assert(FUN_MMLED_SET_INTEGER.cardinality($set_models, s) == 1);
//        assert(FUN_MMLED_SET_INTEGER.has($set_models, s, 1));

//        assert(!FUN_MMLED_SET_INTEGER.has($set_models, s, 2));

        call MAIN.use2($current, s);

        call MAIN.use22($current, s);

        call MAIN.use3($current, s, 3);
        
        call MAIN.use4($current, s, 2);

	return;
}

procedure MAIN.use1($current: ref, $set: ref);
  modifies $set_models;
  requires ($set != null);                                              // set_not_void:
  requires FUN_MMLED_SET_INTEGER.is_empty($set_models, $set);           // empty_set:
  ensures FUN_MMLED_SET_INTEGER.cardinality($set_models, $set) == 1;    // card_set:
  ensures FUN_MMLED_SET_INTEGER.has($set_models, $set, 1);              // added:

  ensures (forall s:ref, n:name :: (s!= $set || n != MMLED_SET_INTEGER) // frame condition
                ==> $set_models[s, n] == old($set_models[s, n]));

implementation MAIN.use1($current:ref, $set: ref)
{
  entry:
        call MMLED_SET_INTEGER.extend($set, 1);
// use this to test
//        call MMLED_SET_INTEGER.extend($set, 2);
        return;
}

procedure MAIN.use2($current: ref, $set: ref);
  modifies $set_models;
  requires ($set != null);                                              // set_not_void:

//*****************************
//TODO: remove
  requires FUN_MMLED_SET_INTEGER.has($set_models, $set, 1); //TODO: remove
  requires FUN_MMLED_SET_INTEGER.cardinality($set_models, $set) == 1;

  requires set.is_subset($set_models[$set, MMLED_SET_INTEGER], set.extended(set.make_empty, 1));


// *****************************
  requires ! FUN_MMLED_SET_INTEGER.has($set_models, $set, 2);           // has_no2:
  ensures FUN_MMLED_SET_INTEGER.cardinality($set_models, $set) ==       // card:
          old (FUN_MMLED_SET_INTEGER.cardinality($set_models, $set)) + 1;
  ensures FUN_MMLED_SET_INTEGER.has($set_models, $set, 2);          // added:

  ensures (set.is_subset($set_models[$set, MMLED_SET_INTEGER],
                        old($set_models[$set, MMLED_SET_INTEGER])));

  ensures set.is_subset($set_models[$set, MMLED_SET_INTEGER],
                old($set_models[$set, MMLED_SET_INTEGER]));
  ensures (forall s:ref, n:name :: (s!= $set || n != MMLED_SET_INTEGER) // frame condition
                ==> $set_models[s, n] == old($set_models[s, n]));


implementation MAIN.use2($current: ref, $set: ref)
{
  entry:
        call MMLED_SET_INTEGER.extend($set, 2);
        return;
}

procedure MAIN.use22($current: ref, $set: ref);
  modifies $set_models;
  requires ($set != null);                                              // set_not_void:

  requires FUN_MMLED_SET_INTEGER.cardinality($set_models, $set) == 2;   //TODO_remove
  requires FUN_MMLED_SET_INTEGER.has($set_models, $set, 1);
  requires FUN_MMLED_SET_INTEGER.has($set_models, $set, 2);

  requires set.is_member($set_models[$set, MMLED_SET_INTEGER], 1);
  requires set.is_member($set_models[$set, MMLED_SET_INTEGER], 2);
  requires set.cardinality($set_models[$set, MMLED_SET_INTEGER]) == 2;


  requires ! FUN_MMLED_SET_INTEGER.has($set_models, $set, 22);          // has_no22:
  ensures FUN_MMLED_SET_INTEGER.cardinality($set_models, $set) ==       // card:
          old (FUN_MMLED_SET_INTEGER.cardinality($set_models, $set)) + 1;
  ensures FUN_MMLED_SET_INTEGER.has($set_models, $set, 22);             // added:

  ensures (set.is_subset($set_models[$set, MMLED_SET_INTEGER],          // subset:
                        old($set_models[$set, MMLED_SET_INTEGER])));

  ensures (forall s:ref, n:name :: (s!= $set || n != MMLED_SET_INTEGER) // frame condition
                ==> $set_models[s, n] == old($set_models[s, n]));


implementation MAIN.use22($current: ref, $set: ref)
{
  entry:
        call MMLED_SET_INTEGER.extend($set, 22);
        return;
}

procedure MAIN.use3($current: ref, $set: ref, $item: int);
  modifies $set_models;
  requires ($set != null);                                              // set_not_void:

  ensures ! old (FUN_MMLED_SET_INTEGER.has($set_models, $set, $item)) ==> (
          FUN_MMLED_SET_INTEGER.cardinality($set_models, $set) ==       // increased:
          old (FUN_MMLED_SET_INTEGER.cardinality($set_models, $set)) + 1);

  ensures old (FUN_MMLED_SET_INTEGER.has($set_models, $set, $item)) ==> (
          FUN_MMLED_SET_INTEGER.cardinality($set_models, $set) ==       // unchanged:
          old (FUN_MMLED_SET_INTEGER.cardinality($set_models, $set)));

  ensures FUN_MMLED_SET_INTEGER.has($set_models, $set, $item);          // added:

  ensures (set.is_subset($set_models[$set, MMLED_SET_INTEGER],          // subset:
                        old($set_models[$set, MMLED_SET_INTEGER])));

  ensures (forall s:ref, n:name :: (s!= $set || n != MMLED_SET_INTEGER) // frame condition
                ==> $set_models[s, n] == old($set_models[s, n]));


implementation MAIN.use3($current: ref, $set: ref, $item: int)
{
  entry:
        call MMLED_SET_INTEGER.extend($set, $item);
        return;
}

procedure MAIN.use4($current: ref, $set: ref, $item: int);
  modifies $set_models;
  requires ($set != null);                                              // set_not_void:
  requires FUN_MMLED_SET_INTEGER.has($set_models, $set, $item);         // has_item:

  ensures !FUN_MMLED_SET_INTEGER.has($set_models, $set, $item);         // no_item:

  ensures FUN_MMLED_SET_INTEGER.cardinality($set_models, $set) ==       // decreased:
          old (FUN_MMLED_SET_INTEGER.cardinality($set_models, $set)) - 1;

  ensures (forall s:ref, n:name :: (s!= $set || n != MMLED_SET_INTEGER) // frame condition
                ==> $set_models[s, n] == old($set_models[s, n]));


implementation MAIN.use4($current: ref, $set: ref, $item: int)
{
  entry:
        call MMLED_SET_INTEGER.prune($set, $item);
        return;
}


// ob die Übersetung generisch (bezgl. GENERICS) geschehen kann ist (mir) unklar -> zu prüfen
// evtl. könnte man die postconditions der MMLED_SET-procedures mit free ensure specen
// wo wir die frame conditions her bekommen ist mir unklar...


// Achtung:
// kurz nach Zeile *******2********
// steht ein Beispiel für ein Problem in das ich oft gerannt bin: habe den
// mml-contract in die entsprechende FUN_XXX function übersetzt. In dem Beispiel
// wurde dann die abstraction zu spät gemacht: die Referenz hat sich ja nicht geändert
// sondern nur das set in der globalen Variablen ;-(

// ich habe oft die modifies-clause ausgelasen, wenn die postcondition
// model_inv: equal_values(model, old model)
// anzeigt, dass das feature pure ist; in dem Moment könnte/sollte dann auch 

//  ensures (forall s:ref, n:name :: (s!= $current || n != MMLED_SET_INTEGER) // frame condition
//                ==> $set_models[s, n] == old($set_models[s, n]));

// in der postcondition wegegelassen werden, da ziemlich sinnlos ohne modifies $set_models;


// is_eqaul und copy habe ich nicht übersetzt.




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

	assert (set.is_member(set.difference(w,x), 4));
	assert (set.is_member(set.difference(w,x), 2));
	assert (set.is_member(set.difference(w,x), 3));
	
	assert (set.cardinality(set.difference(w,x)) == 3);
	
	return;
}
procedure false_theory();
implementation false_theory()
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
	
	assert (!set.is_subset (u,s));
	assert (set.is_subset (s,u));

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
	
	assert (set.cardinality(set.difference(w,x)) == 3);
	
	return;
}
