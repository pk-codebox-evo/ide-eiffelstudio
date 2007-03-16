

//======================================================================
// Background theory starts here

// ----------------------------------------------------------------------
// STATE

// Some things are heaps
function IsHeap(h: [ref,name]any) returns (bool);

// Given an heap, some things are allocated
const $allocated:name;

function IsAllocated(h: [ref,name]any, o: any) returns (bool);

axiom (forall h: [ref,name]any, o: ref :: 
	{ IsAllocated(h,o) } 
	IsAllocated(h,o) <==> cast(h[o,$allocated],bool));

// On a heap, the target of any fields is allocated
axiom (forall h: [ref,name]any, o: ref, f: name :: 
	{ IsAllocated(h, h[o, f]) } 
	IsHeap(h) ==> IsAllocated(h, h[o, f]));

// Integers are always allocated
axiom (forall h: [ref,name]any, i: int :: 
	{ IsAllocated(h,i) } 
	IsAllocated(h,i));

// Booleans are always allocated
axiom (forall h: [ref,name]any, b: bool :: 
	{ IsAllocated(h,b) } 
	IsAllocated(h,b));

// Void are always allocated
axiom (forall h: [ref,name]any :: 
	{ IsAllocated(h,null) } 
	IsAllocated(h,null));

// The global heap is a heap
var Heap: [ref,name]any where IsHeap(Heap);

// ----------------------------------------------------------------------
// ANY functions

function fun.ANY.conforms_to([ref,name]any,any,any) returns (bool);
axiom (forall h:[ref,name]any,a:ref,b:ref :: { fun.ANY.conforms_to(h,a,b) }
	fun.ANY.conforms_to(h,a,b) == true);

// ----------------------------------------------------------------------
// INTEGER_32 functions

// abs
function fun.INTEGER_32.abs([ref,name]any,int) returns (int);
axiom (forall h:[ref,name]any,c:int :: { fun.INTEGER_32.abs(h,c) }
	(c >= 0) ==> (fun.INTEGER_32.abs(h,c) == c));
axiom (forall h:[ref,name]any,c:int :: { fun.INTEGER_32.abs(h,c) }
	(c < 0) ==> (fun.INTEGER_32.abs(h,c) == -c));

// out
function fun.INTEGER_32.out([ref,name]any,int) returns (ref);
axiom (forall h:[ref,name]any,c:int :: { fun.INTEGER_32.out(h,c) }
	(fun.INTEGER_32.out(h,c) != null));

// ----------------------------------------------------------------------
// BOOLEAN functions

// out
function fun.BOOLEAN.out([ref,name]any,int) returns (ref);
axiom (forall h:[ref,name]any,c:int :: { fun.BOOLEAN.out(h,c) }
	(fun.BOOLEAN.out(h,c) != null));

// ----------------------------------------------------------------------
// STRING functions

// String Constants
function any_string (int) returns (ref);

// Background theory ends here
// ======================================================================
