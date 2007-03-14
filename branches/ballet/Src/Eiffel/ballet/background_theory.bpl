// ======================================================================
// Background theory starts here

// ----------------------------------------------------------------------
// FUNCTION AND CONSTANT DECLARATIONS

// Some things are heaps
function IsHeap(h: [ref,name]any) returns (bool);

// Given an heap, some things are allocated
function IsAllocated(h: [ref,name]any, o: any) returns (bool);

// ----------------------------------------------------------------------
// AXIOMS

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

// ----------------------------------------------------------------------
// GLOBAL VARIABLES

// The global heap is a heap
var Heap: [ref,name]any where IsHeap(Heap);

// Background theory ends here
// ======================================================================
