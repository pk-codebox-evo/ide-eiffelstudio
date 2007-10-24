type real;

type elements;

type struct;

var $Heap: [ref,name]any where IsHeap($Heap);

function IsHeap(h: [ref,name]any) returns (bool);

const $allocated: name;

const $elements: name;

const $inv: name;

const $sharingMode: name;

const $SharingMode_Unshared: name;

const $SharingMode_LockProtected: name;

const $ownerRef: name;

const $ownerFrame: name;

const $PeerGroupPlaceholder: name;

function ClassRepr(class: name) returns (ref);

axiom (forall c0: name, c1: name :: c0 != c1 ==> ClassRepr(c0) != ClassRepr(c1));

axiom (forall T: name :: !($typeof(ClassRepr(T)) <: System.Object));

axiom (forall T: name :: ClassRepr(T) != null);

axiom (forall T: name, h: [ref,name]any :: { h[ClassRepr(T), $ownerFrame] } IsHeap(h) ==> cast(h[ClassRepr(T), $ownerFrame],name) == $PeerGroupPlaceholder);

function IsDirectlyModifiableField(f: name) returns (bool);

axiom !IsDirectlyModifiableField($allocated);

axiom IsDirectlyModifiableField($elements);

axiom !IsDirectlyModifiableField($inv);

axiom !IsDirectlyModifiableField($ownerRef);

axiom !IsDirectlyModifiableField($ownerFrame);

function IsStaticField(f: name) returns (bool);

axiom !IsStaticField($allocated);

axiom !IsStaticField($elements);

axiom !IsStaticField($inv);

function ValueArrayGet(elements, int) returns (any);

function ValueArraySet(elements, int, any) returns (elements);

function RefArrayGet(elements, int) returns (ref);

function RefArraySet(elements, int, ref) returns (elements);

axiom (forall A: elements, i: int, x: any :: ValueArrayGet(ValueArraySet(A, i, x), i) == x);

axiom (forall A: elements, i: int, j: int, x: any :: i != j ==> ValueArrayGet(ValueArraySet(A, i, x), j) == ValueArrayGet(A, j));

axiom (forall A: elements, i: int, x: ref :: RefArrayGet(RefArraySet(A, i, x), i) == x);

axiom (forall A: elements, i: int, j: int, x: ref :: i != j ==> RefArrayGet(RefArraySet(A, i, x), j) == RefArrayGet(A, j));

function ArrayIndex(arr: ref, dim: int, indexAtDim: int, remainingIndexContribution: int) returns (int);

axiom (forall a: ref, d: int, x: int, y: int, x': int, y': int :: ArrayIndex(a, d, x, y) == ArrayIndex(a, d, x', y') ==> x == x' && y == y');

axiom (forall a: ref, T: name, i: int, r: int, heap: [ref,name]any :: $typeof(a) <: RefArray(T, r) ==> $Is(RefArrayGet(cast(heap[a, $elements],elements), i), T));

function $Rank(ref) returns (int);

axiom (forall a: ref :: 1 <= $Rank(a));

axiom (forall a: ref, T: name, r: int :: { $Is(a, ValueArray(T, r)) } $Is(a, ValueArray(T, r)) ==> $Rank(a) == r);

axiom (forall a: ref, T: name, r: int :: { $Is(a, RefArray(T, r)) } $Is(a, RefArray(T, r)) ==> $Rank(a) == r);

function $Length(ref) returns (int);

axiom (forall a: ref :: { $Length(a) } 0 <= $Length(a));

function $DimLength(ref, int) returns (int);

axiom (forall a: ref, i: int :: 0 <= $DimLength(a, i));

axiom (forall a: ref :: $Rank(a) == 1 ==> $DimLength(a, 0) == $Length(a));

function $LBound(ref, int) returns (int);

function $UBound(ref, int) returns (int);

axiom (forall a: ref, i: int :: { $LBound(a, i) } $LBound(a, i) == 0);

axiom (forall a: ref, i: int :: { $UBound(a, i) } $UBound(a, i) == $DimLength(a, i) - 1);

const System.Array: name;

axiom System.Array <: System.Object;

function $ElementType(name) returns (name);

function ValueArray(elementType: name, rank: int) returns (name);

axiom (forall T: name, r: int :: { ValueArray(T, r) } ValueArray(T, r) <: System.Array);

function RefArray(elementType: name, rank: int) returns (name);

axiom (forall T: name, r: int :: { RefArray(T, r) } RefArray(T, r) <: System.Array);

axiom (forall T: name, U: name, r: int :: U <: T ==> RefArray(U, r) <: RefArray(T, r));

axiom (forall A: name, r: int :: $ElementType(ValueArray(A, r)) == A);

axiom (forall A: name, r: int :: $ElementType(RefArray(A, r)) == A);

axiom (forall A: name, r: int, T: name :: { T <: RefArray(A, r) } T <: RefArray(A, r) ==> T == RefArray($ElementType(T), r) && $ElementType(T) <: A);

axiom (forall A: name, r: int, T: name :: { T <: ValueArray(A, r) } T <: ValueArray(A, r) ==> T == ValueArray(A, r));

axiom (forall A: name, r: int, T: name :: RefArray(A, r) <: T ==> System.Array <: T || (T == RefArray($ElementType(T), r) && A <: $ElementType(T)));

axiom (forall A: name, r: int, T: name :: ValueArray(A, r) <: T ==> System.Array <: T || T == ValueArray(A, r));

function $ArrayPtr(elementType: name) returns (name);

function $StructGet(struct, name) returns (any);

function $StructSet(struct, name, any) returns (struct);

axiom (forall s: struct, f: name, x: any :: $StructGet($StructSet(s, f, x), f) == x);

axiom (forall s: struct, f: name, f': name, x: any :: f != f' ==> $StructGet($StructSet(s, f, x), f') == $StructGet(s, f'));

function ZeroInit(s: struct, typ: name) returns (bool);

function $typeof(ref) returns (name);

function AsDirectSubClass(sub: name, base: name) returns (sub': name);

function OneClassDown(sub: name, base: name) returns (directSub: name);

axiom (forall A: name, B: name, C: name :: { C <: AsDirectSubClass(B, A) } C <: AsDirectSubClass(B, A) ==> OneClassDown(C, A) == B);

function $IsValueType(name) returns (bool);

axiom (forall T: name :: $IsValueType(T) ==> (forall U: name :: T <: U ==> T == U) && (forall U: name :: U <: T ==> T == U));

const System.Object: name;

function $IsTokenForType(struct, name) returns (bool);

function TypeObject(name) returns (ref);

const System.Type: name;

axiom System.Type <: System.Object;

axiom (forall T: name :: { TypeObject(T) } $IsNotNull(TypeObject(T), System.Type));

function TypeName(ref) returns (name);

axiom (forall T: name :: { TypeObject(T) } TypeName(TypeObject(T)) == T);

function $Is(ref, name) returns (bool);

axiom (forall o: ref, T: name :: { $Is(o, T) } $Is(o, T) <==> o == null || $typeof(o) <: T);

function $IsNotNull(ref, name) returns (bool);

axiom (forall o: ref, T: name :: { $IsNotNull(o, T) } $IsNotNull(o, T) <==> o != null && $Is(o, T));

function $As(ref, name) returns (ref);

axiom (forall o: ref, T: name :: $Is(o, T) ==> $As(o, T) == o);

axiom (forall o: ref, T: name :: !$Is(o, T) ==> $As(o, T) == null);

axiom (forall heap: [ref,name]any, o: ref, A: name, r: int :: $Is(o, RefArray(A, r)) ==> heap[o, $inv] == $typeof(o));

axiom (forall heap: [ref,name]any, o: ref, A: name, r: int :: $Is(o, ValueArray(A, r)) ==> heap[o, $inv] == $typeof(o));

function IsAllocated(h: [ref,name]any, o: any) returns (bool);

axiom (forall h: [ref,name]any, o: ref, f: name :: { IsAllocated(h, h[o, f]) } IsHeap(h) && cast(h[o, $allocated],bool) ==> IsAllocated(h, h[o, f]));

axiom (forall h: [ref,name]any, s: struct, f: name :: { IsAllocated(h, $StructGet(s, f)) } IsAllocated(h, s) ==> IsAllocated(h, $StructGet(s, f)));

axiom (forall h: [ref,name]any, e: elements, i: int :: { IsAllocated(h, RefArrayGet(e, i)) } IsAllocated(h, e) ==> IsAllocated(h, RefArrayGet(e, i)));

axiom (forall h: [ref,name]any, o: ref :: { h[o, $allocated] } IsAllocated(h, o) ==> cast(h[o, $allocated],bool));

axiom (forall h: [ref,name]any, c: name :: { h[ClassRepr(c), $allocated] } IsHeap(h) ==> cast(h[ClassRepr(c), $allocated],bool));

function DeclType(field: name) returns (class: name);

function AsNonNullRefField(field: name, T: name) returns (f: name);

function AsRefField(field: name, T: name) returns (f: name);

function AsRangeField(field: name, T: name) returns (f: name);

axiom (forall f: name, T: name :: { AsNonNullRefField(f, T) } AsNonNullRefField(f, T) == f ==> AsRefField(f, T) == f);

axiom (forall h: [ref,name]any, o: ref, f: name, T: name :: { h[o, AsRefField(f, T)] } IsHeap(h) ==> $Is(cast(h[o, AsRefField(f, T)],ref), T));

axiom (forall h: [ref,name]any, o: ref, f: name, T: name :: { h[o, AsNonNullRefField(f, T)] } IsHeap(h) ==> cast(h[o, AsNonNullRefField(f, T)],ref) != null);

axiom (forall h: [ref,name]any, o: ref, f: name, T: name :: { h[o, AsRangeField(f, T)] } IsHeap(h) ==> InRange(cast(h[o, AsRangeField(f, T)],int), T));

const System.String: name;

function AsStringOwner(string: ref, owner: ref) returns (theString: ref);

axiom (forall h: [ref,name]any, s: ref :: IsHeap(h) && $typeof(s) == System.String ==> h[s, $inv] == $typeof(s) && cast(h[s, $ownerFrame],name) == $PeerGroupPlaceholder && AsStringOwner(s, cast(h[s, $ownerRef],ref)) == s && (forall t: ref :: { AsStringOwner(s, cast(h[t, $ownerRef],ref)) } AsStringOwner(s, cast(h[t, $ownerRef],ref)) == s ==> t == s));

function AsRepField(f: name, declaringType: name) returns (theField: name);

axiom (forall h: [ref,name]any, o: ref, f: name, T: name :: { h[o, AsRepField(f, T)] } IsHeap(h) && cast(h[o, AsRepField(f, T)],ref) != null ==> cast(h[cast(h[o, AsRepField(f, T)],ref), $ownerRef],ref) == o && cast(h[cast(h[o, AsRepField(f, T)],ref), $ownerFrame],name) == T);

function AsPeerField(f: name) returns (theField: name);

axiom (forall h: [ref,name]any, o: ref, f: name :: { h[o, AsPeerField(f)] } IsHeap(h) && cast(h[o, AsPeerField(f)],ref) != null ==> h[cast(h[o, AsPeerField(f)],ref), $ownerRef] == h[o, $ownerRef] && h[cast(h[o, AsPeerField(f)],ref), $ownerFrame] == h[o, $ownerFrame]);

axiom (forall h: [ref,name]any, o: ref :: { cast(h[cast(h[o, $ownerRef],ref), $inv],name) <: cast(h[o, $ownerFrame],name) } IsHeap(h) && cast(h[o, $ownerFrame],name) != $PeerGroupPlaceholder && cast(h[cast(h[o, $ownerRef],ref), $inv],name) <: cast(h[o, $ownerFrame],name) ==> cast(h[o, $inv],name) == $typeof(o));

procedure $SetOwner(o: ref, ow: ref, fr: name);
  modifies $Heap;
  ensures (forall p: ref, F: name :: (F != $ownerRef && F != $ownerFrame) || old($Heap[p, $ownerRef] != $Heap[o, $ownerRef]) || old($Heap[p, $ownerFrame] != $Heap[o, $ownerFrame]) ==> old($Heap[p, F]) == $Heap[p, F]);
  ensures (forall p: ref :: old($Heap[p, $ownerRef] == $Heap[o, $ownerRef]) && old($Heap[p, $ownerFrame] == $Heap[o, $ownerFrame]) ==> cast($Heap[p, $ownerRef],ref) == ow && cast($Heap[p, $ownerFrame],name) == fr);



procedure $UpdateOwnersForRep(o: ref, T: name, e: ref);
  modifies $Heap;
  ensures (forall p: ref, F: name :: (F != $ownerRef && F != $ownerFrame) || old($Heap[p, $ownerRef] != $Heap[e, $ownerRef]) || old($Heap[p, $ownerFrame] != $Heap[e, $ownerFrame]) ==> old($Heap[p, F]) == $Heap[p, F]);
  ensures e == null ==> $Heap == old($Heap);
  ensures e != null ==> (forall p: ref :: old($Heap[p, $ownerRef] == $Heap[e, $ownerRef]) && old($Heap[p, $ownerFrame] == $Heap[e, $ownerFrame]) ==> cast($Heap[p, $ownerRef],ref) == o && cast($Heap[p, $ownerFrame],name) == T);



procedure $UpdateOwnersForPeer(c: ref, d: ref);
  modifies $Heap;
  ensures (forall p: ref, F: name :: (F != $ownerRef && F != $ownerFrame) || old(($Heap[p, $ownerRef] != $Heap[c, $ownerRef] || $Heap[p, $ownerFrame] != $Heap[c, $ownerFrame]) && ($Heap[p, $ownerRef] != $Heap[d, $ownerRef] || $Heap[p, $ownerFrame] != $Heap[d, $ownerFrame])) ==> old($Heap[p, F]) == $Heap[p, F]);
  ensures d == null ==> $Heap == old($Heap);
  ensures d != null ==> (forall p: ref :: (old($Heap[p, $ownerRef] == $Heap[c, $ownerRef]) && old($Heap[p, $ownerFrame] == $Heap[c, $ownerFrame])) || (old($Heap[p, $ownerRef] == $Heap[d, $ownerRef]) && old($Heap[p, $ownerFrame] == $Heap[d, $ownerFrame])) ==> (old($Heap)[d, $ownerFrame] == $PeerGroupPlaceholder && $Heap[p, $ownerRef] == old($Heap)[c, $ownerRef] && $Heap[p, $ownerFrame] == old($Heap)[c, $ownerFrame]) || (old($Heap)[d, $ownerFrame] != $PeerGroupPlaceholder && $Heap[p, $ownerRef] == old($Heap)[d, $ownerRef] && $Heap[p, $ownerFrame] == old($Heap)[d, $ownerFrame]));



function Box(any, ref) returns (ref);

function Unbox(ref) returns (any);

axiom (forall x: any, p: ref :: { Unbox(Box(x, p)) } Unbox(Box(x, p)) == x);

axiom (forall heap: [ref,name]any, x: any, p: ref :: { heap[Box(x, p), $inv] } IsHeap(heap) ==> heap[Box(x, p), $inv] == $typeof(Box(x, p)));

function UnboxedType(ref) returns (name);

function BoxTester(p: ref, typ: name) returns (ref);

axiom (forall p: ref, typ: name :: { BoxTester(p, typ) } UnboxedType(p) == typ <==> BoxTester(p, typ) != null);

const System.Int16: name;

axiom $IsValueType(System.Int16);

const System.Int32: name;

axiom $IsValueType(System.Int32);

const System.Int64: name;

axiom $IsValueType(System.Int64);

const System.Byte: name;

axiom $IsValueType(System.Byte);

const System.Int16.MinValue: int;

const System.Int16.MaxValue: int;

const System.Int32.MinValue: int;

const System.Int32.MaxValue: int;

const System.Int64.MinValue: int;

const System.Int64.MaxValue: int;

axiom System.Int64.MinValue < System.Int32.MinValue;

axiom System.Int32.MinValue < System.Int16.MinValue;

axiom System.Int16.MinValue < System.Int16.MaxValue;

axiom System.Int16.MaxValue < System.Int32.MaxValue;

axiom System.Int32.MaxValue < System.Int64.MaxValue;

function InRange(i: int, T: name) returns (bool);

axiom (forall i: int :: InRange(i, System.Int16) <==> System.Int16.MinValue <= i && i <= System.Int16.MaxValue);

axiom (forall i: int :: InRange(i, System.Int32) <==> System.Int32.MinValue <= i && i <= System.Int32.MaxValue);

axiom (forall i: int :: InRange(i, System.Int64) <==> System.Int64.MinValue <= i && i <= System.Int64.MaxValue);

axiom (forall i: int :: { InRange(i, System.Byte) } InRange(i, System.Byte) <==> 0 <= i && i < 256);

function $RealToInt(real) returns (int);

function $IntToReal(int) returns (real);

function $SizeIs(name, int) returns (bool);

function $IfThenElse(bool, any, any) returns (any);

axiom (forall b: bool, x: any, y: any :: { $IfThenElse(b, x, y) } b ==> $IfThenElse(b, x, y) == x);

axiom (forall b: bool, x: any, y: any :: { $IfThenElse(b, x, y) } !b ==> $IfThenElse(b, x, y) == y);

function #neg(int) returns (int);

function #rneg(real) returns (real);

function #rdiv(real, real) returns (real);

function #and(int, int) returns (int);

function #or(int, int) returns (int);

function #xor(int, int) returns (int);

function #shl(int, int) returns (int);

function #shr(int, int) returns (int);

axiom (forall x: int, y: int :: { x % y } { x / y } x % y == x - x / y * y);

axiom (forall x: int, y: int :: { x % y } 0 <= x && 0 < y ==> 0 <= x % y && x % y < y);

axiom (forall x: int, y: int :: { x % y } 0 <= x && y < 0 ==> 0 <= x % y && x % y < 0 - y);

axiom (forall x: int, y: int :: { x % y } x <= 0 && 0 < y ==> 0 - y < x % y && x % y <= 0);

axiom (forall x: int, y: int :: { x % y } x <= 0 && y < 0 ==> y < x % y && x % y <= 0);

axiom (forall x: int, y: int :: { (x + y) % y } 0 <= x && 0 <= y ==> (x + y) % y == x % y);

axiom (forall x: int, y: int :: { (y + x) % y } 0 <= x && 0 <= y ==> (y + x) % y == x % y);

axiom (forall x: int, y: int :: { (x - y) % y } 0 <= x - y && 0 <= y ==> (x - y) % y == x % y);

axiom (forall a: int, b: int, d: int :: { a % d,b % d } 2 <= d && a % d == b % d && a < b ==> a + d <= b);

axiom (forall i: int :: { #shl(i, 0) } #shl(i, 0) == i);

axiom (forall i: int, j: int :: 0 <= j ==> #shl(i, j + 1) == #shl(i, j) * 2);

axiom (forall i: int :: { #shr(i, 0) } #shr(i, 0) == i);

axiom (forall i: int, j: int :: 0 <= j ==> #shr(i, j + 1) == #shr(i, j) / 2);

const $UnknownRef: ref;

const BankAccount.balance: name;

const BankAccount: name;

const Microsoft.Contracts.GuardException: name;

const Microsoft.Contracts.ICheckedException: name;

const System.Runtime.InteropServices._Exception: name;

const System.Runtime.Serialization.ISerializable: name;

const System.Boolean: name;

const Microsoft.Contracts.ObjectInvariantException: name;

const System.Exception: name;

axiom !IsStaticField(BankAccount.balance);

axiom IsDirectlyModifiableField(BankAccount.balance);

axiom DeclType(BankAccount.balance) == BankAccount;

axiom AsRangeField(BankAccount.balance, System.Int32) == BankAccount.balance;

axiom BankAccount <: BankAccount;

axiom BankAccount <: System.Object && AsDirectSubClass(BankAccount, System.Object) == BankAccount;

axiom (forall $oi: ref, $h: [ref,name]any :: { cast($h[$oi, $inv],name) <: BankAccount } IsHeap($h) && cast($h[$oi, $inv],name) <: BankAccount ==> cast($h[$oi, BankAccount.balance],int) >= 0);

procedure BankAccount.SpecSharp.CheckInvariant$System.Boolean(this: ref, throwException$in: bool) returns ($result: bool);
  requires (forall $pc: ref :: $pc != null && $Heap[$pc, $allocated] == true && cast($Heap[$pc, $ownerRef],ref) == cast($Heap[this, $ownerRef],ref) && cast($Heap[$pc, $ownerFrame],name) == cast($Heap[this, $ownerFrame],name) ==> (cast($Heap[$pc, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[$pc, $ownerRef],ref), $inv],name) <: cast($Heap[$pc, $ownerFrame],name))) && cast($Heap[$pc, $inv],name) == $typeof($pc));
  modifies $Heap;
  free ensures IsAllocated($Heap, $result);
  free ensures (forall $o: ref, $f: name :: $f != $inv && $o != null && cast(old($Heap)[$o, $allocated],bool) == true && (cast(old($Heap)[$o, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast(old($Heap)[cast(old($Heap)[$o, $ownerRef],ref), $inv],name) <: cast(old($Heap)[$o, $ownerFrame],name))) && (!IsStaticField($f) || !IsDirectlyModifiableField($f)) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures (forall $o: ref :: old($Heap)[$o, $inv] == $Heap[$o, $inv] || cast(old($Heap)[$o, $allocated],bool) != true);
  free ensures (forall $o: ref :: cast(old($Heap)[$o, $allocated],bool) ==> cast($Heap[$o, $allocated],bool));
  free ensures (forall $o: ref :: old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);
  free ensures (forall $o: ref :: $o != null && !cast(old($Heap)[$o, $allocated],bool) && cast($Heap[$o, $allocated],bool) ==> cast($Heap[$o, $inv],name) == $typeof($o));
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true && old($Heap)[cast($Heap[$o, $ownerRef],ref), $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));



implementation BankAccount.SpecSharp.CheckInvariant$System.Boolean(this: ref, throwException$in: bool) returns ($result: bool)
{
  var throwException: bool, stack0i: int, stack1i: int, stack0b: bool, local0: bool, stack50000o: ref, stack0o: ref, local1: bool;

  entry:
    assume $IsNotNull(this, BankAccount);
    assume $Heap[this, $allocated] == true;
    throwException := throwException$in;
    assume true;
    assume IsAllocated($Heap, throwException$in);
    goto block1479;

  block1479:
    goto block1496;

  block1496:
    // ----- load field
    assert this != null;
    stack0i := cast($Heap[this, BankAccount.balance],int);
    // ----- load constant 0
    stack1i := 0;
    // ----- binary operator
    stack0b := stack0i >= stack1i;
    // ----- branch
    goto true1496to1598, false1496to1513;

  true1496to1598:
    assume stack0b == true;
    goto block1598;

  false1496to1513:
    assume stack0b == false;
    goto block1513;

  block1598:
    // ----- load constant 1
    local0 := true;
    // ----- branch
    goto block1615;

  block1513:
    // ----- copy
    stack0b := throwException;
    // ----- unary operator
    stack0b := !stack0b;
    // ----- branch
    goto true1513to1564, false1513to1530;

  true1513to1564:
    assume stack0b == true;
    goto block1564;

  false1513to1530:
    assume stack0b == false;
    goto block1530;

  block1564:
    // ----- load constant 0
    local0 := false;
    // ----- branch
    goto block1615;

  block1530:
    assume false;
    // ----- new object
    havoc stack50000o;
    assume cast($Heap[stack50000o, $allocated],bool) == false && stack50000o != null && $typeof(stack50000o) == Microsoft.Contracts.ObjectInvariantException;
    assume cast($Heap[stack50000o, $ownerRef],ref) == stack50000o && cast($Heap[stack50000o, $ownerFrame],name) == $PeerGroupPlaceholder;
    $Heap[stack50000o, $allocated] := true;
    // ----- call
    assert stack50000o != null;
    call Microsoft.Contracts.ObjectInvariantException..ctor(stack50000o);
    // ----- copy
    stack0o := stack50000o;
    // ----- throw
    assert stack0o != null;
    assume false;
    return;

  block1615:
    // ----- copy
    local1 := local0;
    // ----- copy
    stack0b := local0;
    // ----- return
    $result := stack0b;
    return;

}



axiom (forall $U: name :: { $U <: System.Boolean } $U <: System.Boolean ==> $U == System.Boolean);

axiom Microsoft.Contracts.ObjectInvariantException <: Microsoft.Contracts.ObjectInvariantException;

axiom Microsoft.Contracts.GuardException <: Microsoft.Contracts.GuardException;

axiom System.Exception <: System.Exception;

axiom System.Exception <: System.Object && AsDirectSubClass(System.Exception, System.Object) == System.Exception;

axiom System.Runtime.Serialization.ISerializable <: System.Object;

axiom System.Exception <: System.Runtime.Serialization.ISerializable;

axiom System.Runtime.InteropServices._Exception <: System.Object;

axiom System.Exception <: System.Runtime.InteropServices._Exception;

axiom Microsoft.Contracts.GuardException <: System.Exception && AsDirectSubClass(Microsoft.Contracts.GuardException, System.Exception) == Microsoft.Contracts.GuardException;

axiom Microsoft.Contracts.ObjectInvariantException <: Microsoft.Contracts.GuardException && AsDirectSubClass(Microsoft.Contracts.ObjectInvariantException, Microsoft.Contracts.GuardException) == Microsoft.Contracts.ObjectInvariantException;

procedure Microsoft.Contracts.ObjectInvariantException..ctor(this: ref);
  free requires (forall $o: ref :: cast($Heap[$o, $ownerRef],ref) != this || cast($Heap[$o, $ownerFrame],name) != Microsoft.Contracts.ObjectInvariantException);
  free requires cast($Heap[this, $ownerRef],ref) == this && cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder;
  free requires (forall $o: ref :: cast($Heap[$o, $ownerRef],ref) == cast($Heap[this, $ownerRef],ref) && cast($Heap[$o, $ownerFrame],name) == cast($Heap[this, $ownerFrame],name) ==> $o == this);
  modifies $Heap;
  free ensures (forall $o: ref, $f: name :: $f != $inv && $o != null && cast(old($Heap)[$o, $allocated],bool) == true && (cast(old($Heap)[$o, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast(old($Heap)[cast(old($Heap)[$o, $ownerRef],ref), $inv],name) <: cast(old($Heap)[$o, $ownerFrame],name))) && (!IsStaticField($f) || !IsDirectlyModifiableField($f)) && ($o != this || !(Microsoft.Contracts.ObjectInvariantException <: DeclType($f))) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures (forall $o: ref :: $o == this || old($Heap)[$o, $inv] == $Heap[$o, $inv] || cast(old($Heap)[$o, $allocated],bool) != true);
  free ensures (forall $o: ref :: cast(old($Heap)[$o, $allocated],bool) ==> cast($Heap[$o, $allocated],bool));
  free ensures (forall $o: ref :: $o == this || old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);
  ensures (cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[this, $ownerRef],ref), $inv],name) <: cast($Heap[this, $ownerFrame],name))) && cast($Heap[this, $inv],name) == Microsoft.Contracts.ObjectInvariantException;
  ensures (forall $pc: ref :: $pc != null && $Heap[$pc, $allocated] == true && $pc != this && cast($Heap[$pc, $ownerRef],ref) == cast($Heap[this, $ownerRef],ref) && cast($Heap[$pc, $ownerFrame],name) == cast($Heap[this, $ownerFrame],name) ==> old($Heap)[$pc, $allocated] != true && cast($Heap[$pc, $inv],name) == $typeof($pc));
  ensures $Heap[this, $ownerRef] == old($Heap)[this, $ownerRef] && $Heap[this, $ownerFrame] == old($Heap)[this, $ownerFrame];
  ensures $Heap[this, $sharingMode] == $SharingMode_Unshared;
  free ensures (forall $o: ref :: $o != null && !cast(old($Heap)[$o, $allocated],bool) && cast($Heap[$o, $allocated],bool) ==> cast($Heap[$o, $inv],name) == $typeof($o));
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true && old($Heap)[cast($Heap[$o, $ownerRef],ref), $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));



procedure BankAccount..ctor(this: ref);
  free requires (forall $o: ref :: cast($Heap[$o, $ownerRef],ref) != this || cast($Heap[$o, $ownerFrame],name) != BankAccount);
  free requires cast($Heap[this, $ownerRef],ref) == this && cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder;
  free requires (forall $o: ref :: cast($Heap[$o, $ownerRef],ref) == cast($Heap[this, $ownerRef],ref) && cast($Heap[$o, $ownerFrame],name) == cast($Heap[this, $ownerFrame],name) ==> $o == this);
  modifies $Heap;
  ensures cast($Heap[this, BankAccount.balance],int) == 0;
  free ensures (forall $o: ref, $f: name :: $f != $inv && $o != null && cast(old($Heap)[$o, $allocated],bool) == true && (cast(old($Heap)[$o, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast(old($Heap)[cast(old($Heap)[$o, $ownerRef],ref), $inv],name) <: cast(old($Heap)[$o, $ownerFrame],name))) && (!IsStaticField($f) || !IsDirectlyModifiableField($f)) && ($o != this || !(BankAccount <: DeclType($f))) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures (forall $o: ref :: $o == this || old($Heap)[$o, $inv] == $Heap[$o, $inv] || cast(old($Heap)[$o, $allocated],bool) != true);
  free ensures (forall $o: ref :: cast(old($Heap)[$o, $allocated],bool) ==> cast($Heap[$o, $allocated],bool));
  free ensures (forall $o: ref :: $o == this || old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);
  ensures (cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[this, $ownerRef],ref), $inv],name) <: cast($Heap[this, $ownerFrame],name))) && cast($Heap[this, $inv],name) == BankAccount;
  ensures (forall $pc: ref :: $pc != null && $Heap[$pc, $allocated] == true && $pc != this && cast($Heap[$pc, $ownerRef],ref) == cast($Heap[this, $ownerRef],ref) && cast($Heap[$pc, $ownerFrame],name) == cast($Heap[this, $ownerFrame],name) ==> old($Heap)[$pc, $allocated] != true && cast($Heap[$pc, $inv],name) == $typeof($pc));
  ensures $Heap[this, $ownerRef] == old($Heap)[this, $ownerRef] && $Heap[this, $ownerFrame] == old($Heap)[this, $ownerFrame];
  ensures $Heap[this, $sharingMode] == $SharingMode_Unshared;
  free ensures (forall $o: ref :: $o != null && !cast(old($Heap)[$o, $allocated],bool) && cast($Heap[$o, $allocated],bool) ==> cast($Heap[$o, $inv],name) == $typeof($o));
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true && old($Heap)[cast($Heap[$o, $ownerRef],ref), $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));



implementation BankAccount..ctor(this: ref)
{
  var stack0i: int, temp0: ref;

  entry:
    assume $IsNotNull(this, BankAccount);
    assume $Heap[this, $allocated] == true;
    assume (cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[this, $ownerRef],ref), $inv],name) <: cast($Heap[this, $ownerFrame],name))) && cast($Heap[this, $inv],name) == System.Object;
    assume cast($Heap[this, BankAccount.balance],int) == 0;
    goto block2992;

  block2992:
    goto block3009;

  block3009:
    // ----- call
    assert this != null;
    call System.Object..ctor(this);
    goto block3026;

  block3026:
    goto block3077;

  block3077:
    // ----- load constant 0
    stack0i := 0;
    // ----- store field
    assert this != null;
    assert !(cast($Heap[this, $inv],name) <: BankAccount);
    $Heap[this, BankAccount.balance] := stack0i;
    temp0 := this;
    // ----- pack
    assert temp0 != null;
    assert cast($Heap[temp0, $inv],name) == System.Object;
    assert cast($Heap[temp0, BankAccount.balance],int) >= 0;
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] == true && cast($Heap[$p, $ownerRef],ref) == temp0 && cast($Heap[$p, $ownerFrame],name) == BankAccount ==> cast($Heap[$p, $inv],name) == $typeof($p));
    $Heap[temp0, $inv] := BankAccount;
    goto block3094;

  block3094:
    goto block3111, block3128;

  block3111:
    goto block3230;

  block3128:
    goto block3213;

  block3230:
    goto block3264;

  block3213:
    assume false;
    return;

  block3264:
    // ----- nop
    // ----- return
    return;

}



procedure System.Object..ctor(this: ref);
  free requires (forall $o: ref :: cast($Heap[$o, $ownerRef],ref) != this || cast($Heap[$o, $ownerFrame],name) != System.Object);
  free requires cast($Heap[this, $ownerRef],ref) == this && cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder;
  free requires (forall $o: ref :: cast($Heap[$o, $ownerRef],ref) == cast($Heap[this, $ownerRef],ref) && cast($Heap[$o, $ownerFrame],name) == cast($Heap[this, $ownerFrame],name) ==> $o == this);
  modifies $Heap;
  free ensures (forall $o: ref, $f: name :: $f != $inv && $o != null && cast(old($Heap)[$o, $allocated],bool) == true && (cast(old($Heap)[$o, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast(old($Heap)[cast(old($Heap)[$o, $ownerRef],ref), $inv],name) <: cast(old($Heap)[$o, $ownerFrame],name))) && (!IsStaticField($f) || !IsDirectlyModifiableField($f)) && ($o != this || !(System.Object <: DeclType($f))) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures (forall $o: ref :: $o == this || old($Heap)[$o, $inv] == $Heap[$o, $inv] || cast(old($Heap)[$o, $allocated],bool) != true);
  free ensures (forall $o: ref :: cast(old($Heap)[$o, $allocated],bool) ==> cast($Heap[$o, $allocated],bool));
  free ensures (forall $o: ref :: $o == this || old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);
  ensures (cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[this, $ownerRef],ref), $inv],name) <: cast($Heap[this, $ownerFrame],name))) && cast($Heap[this, $inv],name) == System.Object;
  ensures (forall $pc: ref :: $pc != null && $Heap[$pc, $allocated] == true && $pc != this && cast($Heap[$pc, $ownerRef],ref) == cast($Heap[this, $ownerRef],ref) && cast($Heap[$pc, $ownerFrame],name) == cast($Heap[this, $ownerFrame],name) ==> old($Heap)[$pc, $allocated] != true && cast($Heap[$pc, $inv],name) == $typeof($pc));
  ensures $Heap[this, $ownerRef] == old($Heap)[this, $ownerRef] && $Heap[this, $ownerFrame] == old($Heap)[this, $ownerFrame];
  ensures $Heap[this, $sharingMode] == $SharingMode_Unshared;
  free ensures (forall $o: ref :: $o != null && !cast(old($Heap)[$o, $allocated],bool) && cast($Heap[$o, $allocated],bool) ==> cast($Heap[$o, $inv],name) == $typeof($o));
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true && old($Heap)[cast($Heap[$o, $ownerRef],ref), $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));



procedure BankAccount.deposit$System.Int32(this: ref, amount$in: int);
  requires amount$in >= 0;
  requires (cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[this, $ownerRef],ref), $inv],name) <: cast($Heap[this, $ownerFrame],name))) && cast($Heap[this, $inv],name) == BankAccount;
  modifies $Heap;
  ensures cast($Heap[this, BankAccount.balance],int) == old(cast($Heap[this, BankAccount.balance],int)) + amount$in;
  free ensures (forall $o: ref, $f: name :: $f != $inv && $o != null && cast(old($Heap)[$o, $allocated],bool) == true && (cast(old($Heap)[$o, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast(old($Heap)[cast(old($Heap)[$o, $ownerRef],ref), $inv],name) <: cast(old($Heap)[$o, $ownerFrame],name))) && (!IsStaticField($f) || !IsDirectlyModifiableField($f)) && ($o != this || $f != BankAccount.balance) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures (forall $o: ref :: old($Heap)[$o, $inv] == $Heap[$o, $inv] || cast(old($Heap)[$o, $allocated],bool) != true);
  free ensures (forall $o: ref :: cast(old($Heap)[$o, $allocated],bool) ==> cast($Heap[$o, $allocated],bool));
  free ensures (forall $o: ref :: old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);
  free ensures (forall $o: ref :: $o != null && !cast(old($Heap)[$o, $allocated],bool) && cast($Heap[$o, $allocated],bool) ==> cast($Heap[$o, $inv],name) == $typeof($o));
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true && old($Heap)[cast($Heap[$o, $ownerRef],ref), $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));



implementation BankAccount.deposit$System.Int32(this: ref, amount$in: int)
{
  var amount: int, temp0: ref, local7: ref, stack0i: int, stack0o: ref, stack0b: bool;

  entry:
    assume $IsNotNull(this, BankAccount);
    assume $Heap[this, $allocated] == true;
    amount := amount$in;
    assume InRange(amount, System.Int32);
    assume IsAllocated($Heap, amount$in);
    goto block6001;

  block6001:
    goto block6069;

  block6069:
    goto block6086, block6103;

  block6086:
    goto block6205;

  block6103:
    goto block6188;

  block6205:
    goto block6222;

  block6188:
    assume false;
    return;

  block6222:
    goto block6239, block6256;

  block6239:
    goto block6358;

  block6256:
    goto block6341;

  block6358:
    goto block6392;

  block6341:
    assume false;
    return;

  block6392:
    // ----- nop
    temp0 := this;
    // ----- unpack
    assert temp0 != null;
    assert (cast($Heap[temp0, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[temp0, $ownerRef],ref), $inv],name) <: cast($Heap[temp0, $ownerFrame],name))) && cast($Heap[temp0, $inv],name) == BankAccount;
    $Heap[temp0, $inv] := System.Object;
    local7 := null;
    goto block6409;

  block6409:
    // ----- load field
    assert this != null;
    stack0i := cast($Heap[this, BankAccount.balance],int);
    // ----- binary operator
    stack0i := stack0i + amount;
    // ----- store field
    assert this != null;
    assert !(cast($Heap[this, $inv],name) <: BankAccount);
    $Heap[this, BankAccount.balance] := stack0i;
    // ----- branch
    goto block6664;

  block6664:
    stack0o := null;
    // ----- binary operator
    stack0b := local7 == stack0o;
    // ----- branch
    goto true6664to6732, false6664to6681;

  true6664to6732:
    assume stack0b == true;
    goto block6732;

  false6664to6681:
    assume stack0b == false;
    goto block6681;

  block6732:
    // ----- pack
    assert temp0 != null;
    assert cast($Heap[temp0, $inv],name) == System.Object;
    assert cast($Heap[temp0, BankAccount.balance],int) >= 0;
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] == true && cast($Heap[$p, $ownerRef],ref) == temp0 && cast($Heap[$p, $ownerFrame],name) == BankAccount ==> cast($Heap[$p, $inv],name) == $typeof($p));
    $Heap[temp0, $inv] := BankAccount;
    goto block6715;

  block6681:
    // ----- is instance
    stack0o := $As(local7, Microsoft.Contracts.ICheckedException);
    // ----- branch
    goto true6681to6732, false6681to6698;

  true6681to6732:
    assume stack0o != null;
    goto block6732;

  false6681to6698:
    assume stack0o == null;
    goto block6698;

  block6698:
    // ----- branch
    goto block6715;

  block6715:
    // ----- nop
    // ----- branch
    goto block6460;

  block6460:
    goto block6477, block6494;

  block6477:
    goto block6596;

  block6494:
    goto block6579;

  block6596:
    goto block6630;

  block6579:
    assume false;
    return;

  block6630:
    // ----- nop
    // ----- return
    return;

}



axiom Microsoft.Contracts.ICheckedException <: System.Object;

procedure BankAccount.withdraw$System.Int32(this: ref, amount$in: int);
  requires amount$in >= 0;
  requires amount$in <= cast($Heap[this, BankAccount.balance],int);
  requires (cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[this, $ownerRef],ref), $inv],name) <: cast($Heap[this, $ownerFrame],name))) && cast($Heap[this, $inv],name) == BankAccount;
  modifies $Heap;
  ensures cast($Heap[this, BankAccount.balance],int) == old(cast($Heap[this, BankAccount.balance],int)) - amount$in;
  free ensures (forall $o: ref, $f: name :: $f != $inv && $o != null && cast(old($Heap)[$o, $allocated],bool) == true && (cast(old($Heap)[$o, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast(old($Heap)[cast(old($Heap)[$o, $ownerRef],ref), $inv],name) <: cast(old($Heap)[$o, $ownerFrame],name))) && (!IsStaticField($f) || !IsDirectlyModifiableField($f)) && ($o != this || $f != BankAccount.balance) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures (forall $o: ref :: old($Heap)[$o, $inv] == $Heap[$o, $inv] || cast(old($Heap)[$o, $allocated],bool) != true);
  free ensures (forall $o: ref :: cast(old($Heap)[$o, $allocated],bool) ==> cast($Heap[$o, $allocated],bool));
  free ensures (forall $o: ref :: old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);
  free ensures (forall $o: ref :: $o != null && !cast(old($Heap)[$o, $allocated],bool) && cast($Heap[$o, $allocated],bool) ==> cast($Heap[$o, $inv],name) == $typeof($o));
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true && old($Heap)[cast($Heap[$o, $ownerRef],ref), $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));



implementation BankAccount.withdraw$System.Int32(this: ref, amount$in: int)
{
  var amount: int, temp0: ref, local9: ref, stack0i: int, stack0o: ref, stack0b: bool;

  entry:
    assume $IsNotNull(this, BankAccount);
    assume $Heap[this, $allocated] == true;
    amount := amount$in;
    assume InRange(amount, System.Int32);
    assume IsAllocated($Heap, amount$in);
    goto block10370;

  block10370:
    goto block10438;

  block10438:
    goto block10455, block10472;

  block10455:
    goto block10574;

  block10472:
    goto block10557;

  block10574:
    goto block10591;

  block10557:
    assume false;
    return;

  block10591:
    goto block10608, block10625;

  block10608:
    goto block10727;

  block10625:
    goto block10710;

  block10727:
    goto block10744;

  block10710:
    assume false;
    return;

  block10744:
    goto block10761, block10778;

  block10761:
    goto block10880;

  block10778:
    goto block10863;

  block10880:
    goto block10914;

  block10863:
    assume false;
    return;

  block10914:
    // ----- nop
    temp0 := this;
    // ----- unpack
    assert temp0 != null;
    assert (cast($Heap[temp0, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[temp0, $ownerRef],ref), $inv],name) <: cast($Heap[temp0, $ownerFrame],name))) && cast($Heap[temp0, $inv],name) == BankAccount;
    $Heap[temp0, $inv] := System.Object;
    local9 := null;
    goto block10931;

  block10931:
    // ----- load field
    assert this != null;
    stack0i := cast($Heap[this, BankAccount.balance],int);
    // ----- binary operator
    stack0i := stack0i - amount;
    // ----- store field
    assert this != null;
    assert !(cast($Heap[this, $inv],name) <: BankAccount);
    $Heap[this, BankAccount.balance] := stack0i;
    // ----- branch
    goto block11186;

  block11186:
    stack0o := null;
    // ----- binary operator
    stack0b := local9 == stack0o;
    // ----- branch
    goto true11186to11254, false11186to11203;

  true11186to11254:
    assume stack0b == true;
    goto block11254;

  false11186to11203:
    assume stack0b == false;
    goto block11203;

  block11254:
    // ----- pack
    assert temp0 != null;
    assert cast($Heap[temp0, $inv],name) == System.Object;
    assert cast($Heap[temp0, BankAccount.balance],int) >= 0;
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] == true && cast($Heap[$p, $ownerRef],ref) == temp0 && cast($Heap[$p, $ownerFrame],name) == BankAccount ==> cast($Heap[$p, $inv],name) == $typeof($p));
    $Heap[temp0, $inv] := BankAccount;
    goto block11237;

  block11203:
    // ----- is instance
    stack0o := $As(local9, Microsoft.Contracts.ICheckedException);
    // ----- branch
    goto true11203to11254, false11203to11220;

  true11203to11254:
    assume stack0o != null;
    goto block11254;

  false11203to11220:
    assume stack0o == null;
    goto block11220;

  block11220:
    // ----- branch
    goto block11237;

  block11237:
    // ----- nop
    // ----- branch
    goto block10982;

  block10982:
    goto block10999, block11016;

  block10999:
    goto block11118;

  block11016:
    goto block11101;

  block11118:
    goto block11152;

  block11101:
    assume false;
    return;

  block11152:
    // ----- nop
    // ----- return
    return;

}



procedure BankAccount.transfer$BankAccount$notnull$System.Int32(this: ref, target$in: ref, amount$in: int);
  requires amount$in >= 0;
  requires amount$in <= cast($Heap[this, BankAccount.balance],int);
  requires (forall $pc: ref :: $pc != null && $Heap[$pc, $allocated] == true && cast($Heap[$pc, $ownerRef],ref) == cast($Heap[this, $ownerRef],ref) && cast($Heap[$pc, $ownerFrame],name) == cast($Heap[this, $ownerFrame],name) ==> (cast($Heap[$pc, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[$pc, $ownerRef],ref), $inv],name) <: cast($Heap[$pc, $ownerFrame],name))) && cast($Heap[$pc, $inv],name) == $typeof($pc));
  requires (forall $pc: ref :: $pc != null && $Heap[$pc, $allocated] == true && cast($Heap[$pc, $ownerRef],ref) == cast($Heap[target$in, $ownerRef],ref) && cast($Heap[$pc, $ownerFrame],name) == cast($Heap[target$in, $ownerFrame],name) ==> (cast($Heap[$pc, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[$pc, $ownerRef],ref), $inv],name) <: cast($Heap[$pc, $ownerFrame],name))) && cast($Heap[$pc, $inv],name) == $typeof($pc));
  modifies $Heap;
  ensures cast($Heap[this, BankAccount.balance],int) == old(cast($Heap[this, BankAccount.balance],int)) - amount$in;
  ensures cast($Heap[target$in, BankAccount.balance],int) == old(cast($Heap[target$in, BankAccount.balance],int)) + amount$in;
  free ensures (forall $o: ref, $f: name :: $f != $inv && $o != null && cast(old($Heap)[$o, $allocated],bool) == true && (cast(old($Heap)[$o, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast(old($Heap)[cast(old($Heap)[$o, $ownerRef],ref), $inv],name) <: cast(old($Heap)[$o, $ownerFrame],name))) && (!IsStaticField($f) || !IsDirectlyModifiableField($f)) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures (forall $o: ref :: old($Heap)[$o, $inv] == $Heap[$o, $inv] || cast(old($Heap)[$o, $allocated],bool) != true);
  free ensures (forall $o: ref :: cast(old($Heap)[$o, $allocated],bool) ==> cast($Heap[$o, $allocated],bool));
  free ensures (forall $o: ref :: old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);
  free ensures (forall $o: ref :: $o != null && !cast(old($Heap)[$o, $allocated],bool) && cast($Heap[$o, $allocated],bool) ==> cast($Heap[$o, $inv],name) == $typeof($o));
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true && old($Heap)[cast($Heap[$o, $ownerRef],ref), $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));



implementation BankAccount.transfer$BankAccount$notnull$System.Int32(this: ref, target$in: ref, amount$in: int)
{
  var target: ref, amount: int, stack0i: int;

  entry:
    assume $IsNotNull(this, BankAccount);
    assume $Heap[this, $allocated] == true;
    target := target$in;
    assume $IsNotNull(target, BankAccount);
    assume $Heap[target$in, $allocated] == true;
    amount := amount$in;
    assume InRange(amount, System.Int32);
    assume IsAllocated($Heap, amount$in);
    goto block15385;

  block15385:
    goto block15402;

  block15402:
    goto block15419, block15436;

  block15419:
    goto block15538;

  block15436:
    goto block15521;

  block15538:
    goto block15555;

  block15521:
    assume false;
    return;

  block15555:
    goto block15572, block15589;

  block15572:
    goto block15691;

  block15589:
    goto block15674;

  block15691:
    goto block15708;

  block15674:
    assume false;
    return;

  block15708:
    goto block15725, block15742;

  block15725:
    goto block15844;

  block15742:
    goto block15827;

  block15844:
    goto block15861;

  block15827:
    assume false;
    return;

  block15861:
    goto block15878, block15895;

  block15878:
    goto block15997;

  block15895:
    goto block15980;

  block15997:
    goto block16031;

  block15980:
    assume false;
    return;

  block16031:
    // ----- nop
    // ----- copy
    stack0i := amount;
    // ----- call
    assert this != null;
    call BankAccount.withdraw$System.Int32$.Virtual.$(this, stack0i);
    // ----- copy
    stack0i := amount;
    // ----- call
    assert target != null;
    call BankAccount.deposit$System.Int32$.Virtual.$(target, stack0i);
    goto block16048;

  block16048:
    goto block16065, block16082;

  block16065:
    goto block16184;

  block16082:
    goto block16167;

  block16184:
    goto block16201;

  block16167:
    assume false;
    return;

  block16201:
    goto block16218, block16235;

  block16218:
    goto block16337;

  block16235:
    goto block16320;

  block16337:
    goto block16371;

  block16320:
    assume false;
    return;

  block16371:
    // ----- nop
    // ----- return
    return;

}



procedure BankAccount.withdraw$System.Int32$.Virtual.$(this: ref, amount$in: int);
  requires amount$in >= 0;
  requires amount$in <= cast($Heap[this, BankAccount.balance],int);
  requires (forall $pc: ref :: $pc != null && $Heap[$pc, $allocated] == true && cast($Heap[$pc, $ownerRef],ref) == cast($Heap[this, $ownerRef],ref) && cast($Heap[$pc, $ownerFrame],name) == cast($Heap[this, $ownerFrame],name) ==> (cast($Heap[$pc, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[$pc, $ownerRef],ref), $inv],name) <: cast($Heap[$pc, $ownerFrame],name))) && cast($Heap[$pc, $inv],name) == $typeof($pc));
  modifies $Heap;
  ensures cast($Heap[this, BankAccount.balance],int) == old(cast($Heap[this, BankAccount.balance],int)) - amount$in;
  free ensures (forall $o: ref, $f: name :: $f != $inv && $o != null && cast(old($Heap)[$o, $allocated],bool) == true && (cast(old($Heap)[$o, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast(old($Heap)[cast(old($Heap)[$o, $ownerRef],ref), $inv],name) <: cast(old($Heap)[$o, $ownerFrame],name))) && (!IsStaticField($f) || !IsDirectlyModifiableField($f)) && ($o != this || $f != BankAccount.balance) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures (forall $o: ref :: old($Heap)[$o, $inv] == $Heap[$o, $inv] || cast(old($Heap)[$o, $allocated],bool) != true);
  free ensures (forall $o: ref :: cast(old($Heap)[$o, $allocated],bool) ==> cast($Heap[$o, $allocated],bool));
  free ensures (forall $o: ref :: old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);
  free ensures (forall $o: ref :: $o != null && !cast(old($Heap)[$o, $allocated],bool) && cast($Heap[$o, $allocated],bool) ==> cast($Heap[$o, $inv],name) == $typeof($o));
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true && old($Heap)[cast($Heap[$o, $ownerRef],ref), $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));



procedure BankAccount.deposit$System.Int32$.Virtual.$(this: ref, amount$in: int);
  requires amount$in >= 0;
  requires (forall $pc: ref :: $pc != null && $Heap[$pc, $allocated] == true && cast($Heap[$pc, $ownerRef],ref) == cast($Heap[this, $ownerRef],ref) && cast($Heap[$pc, $ownerFrame],name) == cast($Heap[this, $ownerFrame],name) ==> (cast($Heap[$pc, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[$pc, $ownerRef],ref), $inv],name) <: cast($Heap[$pc, $ownerFrame],name))) && cast($Heap[$pc, $inv],name) == $typeof($pc));
  modifies $Heap;
  ensures cast($Heap[this, BankAccount.balance],int) == old(cast($Heap[this, BankAccount.balance],int)) + amount$in;
  free ensures (forall $o: ref, $f: name :: $f != $inv && $o != null && cast(old($Heap)[$o, $allocated],bool) == true && (cast(old($Heap)[$o, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast(old($Heap)[cast(old($Heap)[$o, $ownerRef],ref), $inv],name) <: cast(old($Heap)[$o, $ownerFrame],name))) && (!IsStaticField($f) || !IsDirectlyModifiableField($f)) && ($o != this || $f != BankAccount.balance) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures (forall $o: ref :: old($Heap)[$o, $inv] == $Heap[$o, $inv] || cast(old($Heap)[$o, $allocated],bool) != true);
  free ensures (forall $o: ref :: cast(old($Heap)[$o, $allocated],bool) ==> cast($Heap[$o, $allocated],bool));
  free ensures (forall $o: ref :: old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);
  free ensures (forall $o: ref :: $o != null && !cast(old($Heap)[$o, $allocated],bool) && cast($Heap[$o, $allocated],bool) ==> cast($Heap[$o, $inv],name) == $typeof($o));
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true && old($Heap)[cast($Heap[$o, $ownerRef],ref), $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));



procedure BankAccount..cctor();
  modifies $Heap;
  free ensures (forall $o: ref, $f: name :: $f != $inv && $o != null && cast(old($Heap)[$o, $allocated],bool) == true && (cast(old($Heap)[$o, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast(old($Heap)[cast(old($Heap)[$o, $ownerRef],ref), $inv],name) <: cast(old($Heap)[$o, $ownerFrame],name))) && (!IsStaticField($f) || !IsDirectlyModifiableField($f)) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures (forall $o: ref :: old($Heap)[$o, $inv] == $Heap[$o, $inv] || cast(old($Heap)[$o, $allocated],bool) != true);
  free ensures (forall $o: ref :: cast(old($Heap)[$o, $allocated],bool) ==> cast($Heap[$o, $allocated],bool));
  free ensures (forall $o: ref :: old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);
  free ensures (forall $o: ref :: $o != null && !cast(old($Heap)[$o, $allocated],bool) && cast($Heap[$o, $allocated],bool) ==> cast($Heap[$o, $inv],name) == $typeof($o));
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true && old($Heap)[cast($Heap[$o, $ownerRef],ref), $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));



implementation BankAccount..cctor()
{

  entry:
    goto block17391;

  block17391:
    goto block17408;

  block17408:
    goto block17442;

  block17442:
    // ----- nop
    // ----- return
    return;

}


