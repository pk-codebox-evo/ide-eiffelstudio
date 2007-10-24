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

axiom (forall a: ref :: { $DimLength(a, 0) } $Rank(a) == 1 ==> $DimLength(a, 0) == $Length(a));

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

function $StringLength(ref) returns (int);

axiom (forall s: ref :: { $StringLength(s) } 0 <= $StringLength(s));

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

function UnboxedType(ref) returns (name);

axiom (forall p: ref :: { $IsValueType(UnboxedType(p)) } $IsValueType(UnboxedType(p)) ==> (forall heap: [ref,name]any, x: any :: { heap[Box(x, p), $inv] } IsHeap(heap) ==> heap[Box(x, p), $inv] == $typeof(Box(x, p))));

axiom (forall x: any, p: ref :: { UnboxedType(Box(x, p)) <: System.Object } UnboxedType(Box(x, p)) <: System.Object && Box(x, p) == p ==> x == p);

function BoxTester(p: ref, typ: name) returns (ref);

axiom (forall p: ref, typ: name :: { BoxTester(p, typ) } UnboxedType(p) == typ <==> BoxTester(p, typ) != null);

const System.SByte: name;

axiom $IsValueType(System.SByte);

const System.Byte: name;

axiom $IsValueType(System.Byte);

const System.Int16: name;

axiom $IsValueType(System.Int16);

const System.UInt16: name;

axiom $IsValueType(System.UInt16);

const System.Int32: name;

axiom $IsValueType(System.Int32);

const System.UInt32: name;

axiom $IsValueType(System.UInt32);

const System.Int64: name;

axiom $IsValueType(System.Int64);

const System.UInt64: name;

axiom $IsValueType(System.UInt64);

const System.Char: name;

axiom $IsValueType(System.Char);

const int#m2147483648: int;

const int#2147483647: int;

const int#4294967295: int;

const int#m9223372036854775808: int;

const int#9223372036854775807: int;

const int#18446744073709551615: int;

axiom int#m9223372036854775808 < int#m2147483648;

axiom int#m2147483648 < 0 - 100000;

axiom 100000 < int#2147483647;

axiom int#2147483647 < int#4294967295;

axiom int#4294967295 < int#9223372036854775807;

axiom int#9223372036854775807 < int#18446744073709551615;

function InRange(i: int, T: name) returns (bool);

axiom (forall i: int :: InRange(i, System.SByte) <==> 0 - 128 <= i && i < 128);

axiom (forall i: int :: InRange(i, System.Byte) <==> 0 <= i && i < 256);

axiom (forall i: int :: InRange(i, System.Int16) <==> 0 - 32768 <= i && i < 32768);

axiom (forall i: int :: InRange(i, System.UInt16) <==> 0 <= i && i < 65536);

axiom (forall i: int :: InRange(i, System.Int32) <==> int#m2147483648 <= i && i <= int#2147483647);

axiom (forall i: int :: InRange(i, System.UInt32) <==> 0 <= i && i <= int#4294967295);

axiom (forall i: int :: InRange(i, System.Int64) <==> int#m9223372036854775808 <= i && i <= int#9223372036854775807);

axiom (forall i: int :: InRange(i, System.UInt64) <==> 0 <= i && i <= int#18446744073709551615);

axiom (forall i: int :: InRange(i, System.Char) <==> 0 <= i && i < 65536);

function $IntToInt(val: int, fromType: name, toType: name) returns (int);

function $IntToReal(int, fromType: name, toType: name) returns (real);

function $RealToInt(real, fromType: name, toType: name) returns (int);

function $RealToReal(val: real, fromType: name, toType: name) returns (real);

function $SizeIs(name, int) returns (bool);

function $IfThenElse(bool, any, any) returns (any);

axiom (forall b: bool, x: any, y: any :: { $IfThenElse(b, x, y) } b ==> $IfThenElse(b, x, y) == x);

axiom (forall b: bool, x: any, y: any :: { $IfThenElse(b, x, y) } !b ==> $IfThenElse(b, x, y) == y);

function #neg(int) returns (int);

function #and(int, int) returns (int);

function #or(int, int) returns (int);

function #xor(int, int) returns (int);

function #shl(int, int) returns (int);

function #shr(int, int) returns (int);

function #rneg(real) returns (real);

function #radd(real, real) returns (real);

function #rsub(real, real) returns (real);

function #rmul(real, real) returns (real);

function #rdiv(real, real) returns (real);

function #rmod(real, real) returns (real);

function #rLess(real, real) returns (bool);

function #rAtmost(real, real) returns (bool);

function #rEq(real, real) returns (bool);

function #rNeq(real, real) returns (bool);

function #rAtleast(real, real) returns (bool);

function #rGreater(real, real) returns (bool);

axiom (forall x: int, y: int :: { x % y } { x / y } x % y == x - x / y * y);

axiom (forall x: int, y: int :: { x % y } 0 <= x && 0 < y ==> 0 <= x % y && x % y < y);

axiom (forall x: int, y: int :: { x % y } 0 <= x && y < 0 ==> 0 <= x % y && x % y < 0 - y);

axiom (forall x: int, y: int :: { x % y } x <= 0 && 0 < y ==> 0 - y < x % y && x % y <= 0);

axiom (forall x: int, y: int :: { x % y } x <= 0 && y < 0 ==> y < x % y && x % y <= 0);

axiom (forall x: int, y: int :: { (x + y) % y } 0 <= x && 0 <= y ==> (x + y) % y == x % y);

axiom (forall x: int, y: int :: { (y + x) % y } 0 <= x && 0 <= y ==> (y + x) % y == x % y);

axiom (forall x: int, y: int :: { (x - y) % y } 0 <= x - y && 0 <= y ==> (x - y) % y == x % y);

axiom (forall a: int, b: int, d: int :: { a % d,b % d } 2 <= d && a % d == b % d && a < b ==> a + d <= b);

axiom (forall x: int, y: int :: { #and(x, y) } 0 <= x || 0 <= y ==> 0 <= #and(x, y));

axiom (forall x: int, y: int :: { #or(x, y) } 0 <= x && 0 <= y ==> 0 <= #or(x, y) && #or(x, y) <= x + y);

axiom (forall i: int :: { #shl(i, 0) } #shl(i, 0) == i);

axiom (forall i: int, j: int :: 0 <= j ==> #shl(i, j + 1) == #shl(i, j) * 2);

axiom (forall i: int :: { #shr(i, 0) } #shr(i, 0) == i);

axiom (forall i: int, j: int :: 0 <= j ==> #shr(i, j + 1) == #shr(i, j) / 2);

function #System.String.IsInterned$System.String$notnull(ref) returns (ref);

function #System.String.Equals$System.String(ref, ref) returns (bool);

function #System.String.Equals$System.String$System.String(ref, ref) returns (bool);

axiom (forall a: ref, b: ref :: { #System.String.Equals$System.String(a, b) } #System.String.Equals$System.String(a, b) == #System.String.Equals$System.String$System.String(a, b));

axiom (forall a: ref, b: ref :: { #System.String.Equals$System.String$System.String(a, b) } #System.String.Equals$System.String$System.String(a, b) == #System.String.Equals$System.String$System.String(b, a));

axiom (forall a: ref, b: ref :: { #System.String.Equals$System.String$System.String(a, b) } a != null && b != null && #System.String.Equals$System.String$System.String(a, b) ==> #System.String.IsInterned$System.String$notnull(a) == #System.String.IsInterned$System.String$notnull(b));

const $UnknownRef: ref;

const Program.b`36839: name;

const IntegerStore.v: name;

const Program.a`36856: name;

const IntegerStore.other: name;

const System.Collections.Generic.IEnumerable`1...System.String: name;

const System.ICloneable: name;

const System.IComparable: name;

const System.IEquatable`1...System.String: name;

const System.IComparable`1...System.String: name;

const System.IConvertible: name;

const IntegerStore`34969: name;

const System.Collections.IEnumerable: name;

const Program`34935: name;

axiom IsStaticField(Program.b`36839);

axiom IsDirectlyModifiableField(Program.b`36839);

axiom DeclType(Program.b`36839) == Program`34935;

axiom AsRefField(Program.b`36839, IntegerStore`34969) == Program.b`36839;

axiom IsStaticField(Program.a`36856);

axiom IsDirectlyModifiableField(Program.a`36856);

axiom DeclType(Program.a`36856) == Program`34935;

axiom AsRefField(Program.a`36856, IntegerStore`34969) == Program.a`36856;

function #IntegerStore`34969.value([ref,name]any, ref) returns (int);

axiom !IsStaticField(IntegerStore.v);

axiom IsDirectlyModifiableField(IntegerStore.v);

axiom DeclType(IntegerStore.v) == IntegerStore`34969;

axiom AsRangeField(IntegerStore.v, System.Int32) == IntegerStore.v;

axiom !IsStaticField(IntegerStore.other);

axiom IsDirectlyModifiableField(IntegerStore.other);

axiom DeclType(IntegerStore.other) == IntegerStore`34969;

axiom AsRefField(IntegerStore.other, IntegerStore`34969) == IntegerStore.other;

axiom Program`34935 <: Program`34935;

axiom Program`34935 <: System.Object && AsDirectSubClass(Program`34935, System.Object) == Program`34935;

axiom System.String <: System.String;

axiom System.String <: System.Object && AsDirectSubClass(System.String, System.Object) == System.String;

axiom System.IComparable <: System.Object;

axiom System.String <: System.IComparable;

axiom System.ICloneable <: System.Object;

axiom System.String <: System.ICloneable;

axiom System.IConvertible <: System.Object;

axiom System.String <: System.IConvertible;

axiom System.IComparable`1...System.String <: System.Object;

axiom System.String <: System.IComparable`1...System.String;

axiom System.Collections.Generic.IEnumerable`1...System.String <: System.Object;

axiom System.Collections.IEnumerable <: System.Object;

axiom System.Collections.Generic.IEnumerable`1...System.String <: System.Collections.IEnumerable;

axiom System.String <: System.Collections.Generic.IEnumerable`1...System.String;

axiom System.String <: System.Collections.IEnumerable;

axiom System.IEquatable`1...System.String <: System.Object;

axiom System.String <: System.IEquatable`1...System.String;

axiom (forall $U: name :: { $U <: System.String } $U <: System.String ==> $U == System.String);

procedure Program`34935.Main$System.String.array$notnull(args$in: ref where $IsNotNull(args$in, RefArray(System.String, 1)));
  free requires $Heap[args$in, $allocated] == true;
  // user-declared preconditions
  requires (forall ^s: ref :: true ==> ^s != null);
  requires (forall $pc: ref :: $pc != null && $Heap[$pc, $allocated] == true && cast($Heap[$pc, $ownerRef],ref) == cast($Heap[args$in, $ownerRef],ref) && cast($Heap[$pc, $ownerFrame],name) == cast($Heap[args$in, $ownerFrame],name) ==> (cast($Heap[$pc, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[$pc, $ownerRef],ref), $inv],name) <: cast($Heap[$pc, $ownerFrame],name))) && cast($Heap[$pc, $inv],name) == $typeof($pc));
  modifies $Heap;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] != true && $Heap[$o, $allocated] == true ==> cast($Heap[$o, $inv],name) == $typeof($o));
  // only captured parameters may change their owners
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));
  free ensures (forall $o: ref, $f: name :: $f != $inv && $o != null && old($Heap)[$o, $allocated] == true && (cast(old($Heap)[$o, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast(old($Heap)[cast(old($Heap)[$o, $ownerRef],ref), $inv],name) <: cast(old($Heap)[$o, $ownerFrame],name))) && (!IsStaticField($f) || !IsDirectlyModifiableField($f)) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures (forall $o: ref :: old($Heap)[$o, $inv] == $Heap[$o, $inv] || old($Heap)[$o, $allocated] != true);
  free ensures (forall $o: ref :: old($Heap)[$o, $allocated] == true ==> $Heap[$o, $allocated] == true) && (forall $ot: ref :: old($Heap)[$ot, $allocated] == true && cast(old($Heap)[$ot, $ownerFrame],name) != $PeerGroupPlaceholder ==> cast($Heap[$ot, $ownerRef],ref) == cast(old($Heap)[$ot, $ownerRef],ref) && cast($Heap[$ot, $ownerFrame],name) == cast(old($Heap)[$ot, $ownerFrame],name));
  free ensures (forall $o: ref :: old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation Program`34935.Main$System.String.array$notnull(args$in: ref)
{
  var args: ref where $IsNotNull(args, RefArray(System.String, 1)), stack0o: ref, stack50000o: ref, stack1o: ref, $Heap$block36108$LoopPreheader: [ref,name]any;

  entry:
    args := args$in;
    goto block36040;

  block36040:
    goto block36057;

  block36057:
    goto block36074;

  block36074:
    goto block36091, block36346;

  block36091:
    goto block36108$LoopPreheader;

  block36346:
    goto block36363;

  block36108:
    // ----- default loop invariant: allocation and ownership are stable
    assume (forall $o: ref :: $Heap$block36108$LoopPreheader[$o, $allocated] == true ==> $Heap[$o, $allocated] == true) && (forall $ot: ref :: $Heap$block36108$LoopPreheader[$ot, $allocated] == true && cast($Heap$block36108$LoopPreheader[$ot, $ownerFrame],name) != $PeerGroupPlaceholder ==> cast($Heap[$ot, $ownerRef],ref) == cast($Heap$block36108$LoopPreheader[$ot, $ownerRef],ref) && cast($Heap[$ot, $ownerFrame],name) == cast($Heap$block36108$LoopPreheader[$ot, $ownerFrame],name));
    // ----- default loop invariant: $inv field
    assume (forall $o: ref :: $Heap$block36108$LoopPreheader[$o, $inv] == $Heap[$o, $inv] || $Heap$block36108$LoopPreheader[$o, $allocated] != true);
    assume (forall $o: ref :: !cast($Heap$block36108$LoopPreheader[$o, $allocated],bool) && $Heap[$o, $allocated] == true ==> cast($Heap[$o, $inv],name) == $typeof($o));
    // ----- default loop invariant: $ownerRef and $ownerFrame fields
    assert (forall $o: ref :: $o != null && $Heap$block36108$LoopPreheader[$o, $allocated] == true ==> cast($Heap$block36108$LoopPreheader[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast($Heap$block36108$LoopPreheader[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));
    goto block36125;

  block36363:
    goto block36380;

  block36125:
    goto block36142, block36346;

  block36380:
    goto block36397, block36414;

  block36142:
    goto block36159;

  block36397:
    goto block36465;

  block36414:
    goto block36431;

  block36159:
    goto block36176, block36193;

  block36465:
    goto block36482;

  block36431:
    goto block36448;

  block36176:
    goto block36227;

  block36193:
    goto block36210;

  block36482:
    goto block36567;

  block36448:
    assume false;
    return;

  block36227:
    goto block36244;

  block36210:
    goto block36227;

  block36567:
    // ----- nop
    goto block36584;

  block36244:
    goto block36261;

  block36584:
    stack0o := null;
    // ----- new object  ----- Program.ssc(8,6)
    havoc stack50000o;
    assume cast($Heap[stack50000o, $allocated],bool) == false && stack50000o != null && $typeof(stack50000o) == IntegerStore`34969;
    assume cast($Heap[stack50000o, $ownerRef],ref) == stack50000o && cast($Heap[stack50000o, $ownerFrame],name) == $PeerGroupPlaceholder;
    $Heap[stack50000o, $allocated] := true;
    // ----- call  ----- Program.ssc(8,6)
    assert stack50000o != null;
    call IntegerStore`34969..ctor$IntegerStore`34969(stack50000o, stack0o);
    // ----- copy  ----- Program.ssc(8,2)
    stack0o := stack50000o;
    // ----- store field  ----- Program.ssc(8,2)
    $Heap[ClassRepr(Program`34935), Program.b`36839] := stack0o;
    // ----- load field  ----- Program.ssc(9,23)
    stack0o := cast($Heap[ClassRepr(Program`34935), Program.b`36839],ref);
    // ----- new object  ----- Program.ssc(9,6)
    havoc stack50000o;
    assume cast($Heap[stack50000o, $allocated],bool) == false && stack50000o != null && $typeof(stack50000o) == IntegerStore`34969;
    assume cast($Heap[stack50000o, $ownerRef],ref) == stack50000o && cast($Heap[stack50000o, $ownerFrame],name) == $PeerGroupPlaceholder;
    $Heap[stack50000o, $allocated] := true;
    // ----- call  ----- Program.ssc(9,6)
    assert stack50000o != null;
    call IntegerStore`34969..ctor$IntegerStore`34969(stack50000o, stack0o);
    // ----- copy  ----- Program.ssc(9,2)
    stack0o := stack50000o;
    // ----- store field  ----- Program.ssc(9,2)
    $Heap[ClassRepr(Program`34935), Program.a`36856] := stack0o;
    // ----- load field  ----- Program.ssc(10,22)
    stack0o := cast($Heap[ClassRepr(Program`34935), Program.a`36856],ref);
    // ----- load field  ----- Program.ssc(10,25)
    stack1o := cast($Heap[ClassRepr(Program`34935), Program.b`36839],ref);
    // ----- call  ----- Program.ssc(10,2)
    call Program`34935.integerStoresAssign$IntegerStore`34969$IntegerStore`34969(stack0o, stack1o);
    goto block36601;

  block36261:
    goto block36278, block36295;

  block36601:
    goto block36618;

  block36278:
    goto block36346;

  block36295:
    goto block36312;

  block36618:
    // ----- return
    return;

  block36312:
    goto block36329;

  block36329:
    goto block36108;

  block36108$LoopPreheader:
    $Heap$block36108$LoopPreheader := $Heap;
    goto block36108;

}



axiom IntegerStore`34969 <: IntegerStore`34969;

axiom IntegerStore`34969 <: System.Object && AsDirectSubClass(IntegerStore`34969, System.Object) == IntegerStore`34969;

procedure IntegerStore`34969..ctor$IntegerStore`34969(this: ref, an_other$in: ref where $Is(an_other$in, IntegerStore`34969));
  free requires $Heap[an_other$in, $allocated] == true;
  requires an_other$in == null || (forall $pc: ref :: $pc != null && $Heap[$pc, $allocated] == true && cast($Heap[$pc, $ownerRef],ref) == cast($Heap[an_other$in, $ownerRef],ref) && cast($Heap[$pc, $ownerFrame],name) == cast($Heap[an_other$in, $ownerFrame],name) ==> (cast($Heap[$pc, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[$pc, $ownerRef],ref), $inv],name) <: cast($Heap[$pc, $ownerFrame],name))) && cast($Heap[$pc, $inv],name) == $typeof($pc));
  // nothing is owned by [this,IntegerStore]
  free requires (forall $o: ref :: cast($Heap[$o, $ownerRef],ref) != this || cast($Heap[$o, $ownerFrame],name) != IntegerStore`34969);
  // 'this' is alone in its own peer group
  free requires cast($Heap[this, $ownerRef],ref) == this && cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder;
  free requires (forall $o: ref :: cast($Heap[$o, $ownerRef],ref) == cast($Heap[this, $ownerRef],ref) && cast($Heap[$o, $ownerFrame],name) == cast($Heap[this, $ownerFrame],name) ==> $o == this);
  modifies $Heap;
  ensures (cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[this, $ownerRef],ref), $inv],name) <: cast($Heap[this, $ownerFrame],name))) && cast($Heap[this, $inv],name) == IntegerStore`34969;
  ensures $Heap[this, $ownerRef] == old($Heap)[this, $ownerRef] && $Heap[this, $ownerFrame] == old($Heap)[this, $ownerFrame];
  ensures $Heap[this, $sharingMode] == $SharingMode_Unshared;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] != true && $Heap[$o, $allocated] == true ==> cast($Heap[$o, $inv],name) == $typeof($o));
  // only captured parameters may change their owners
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));
  free ensures (forall $o: ref, $f: name :: $f != $inv && $o != null && old($Heap)[$o, $allocated] == true && (cast(old($Heap)[$o, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast(old($Heap)[cast(old($Heap)[$o, $ownerRef],ref), $inv],name) <: cast(old($Heap)[$o, $ownerFrame],name))) && (!IsStaticField($f) || !IsDirectlyModifiableField($f)) && ($o != this || !(IntegerStore`34969 <: DeclType($f))) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures (forall $o: ref :: $o == this || old($Heap)[$o, $inv] == $Heap[$o, $inv] || old($Heap)[$o, $allocated] != true);
  free ensures (forall $o: ref :: old($Heap)[$o, $allocated] == true ==> $Heap[$o, $allocated] == true) && (forall $ot: ref :: old($Heap)[$ot, $allocated] == true && cast(old($Heap)[$ot, $ownerFrame],name) != $PeerGroupPlaceholder ==> cast($Heap[$ot, $ownerRef],ref) == cast(old($Heap)[$ot, $ownerRef],ref) && cast($Heap[$ot, $ownerFrame],name) == cast(old($Heap)[$ot, $ownerFrame],name));
  free ensures (forall $o: ref :: $o == this || old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



axiom (forall $Heap: [ref,name]any, this: ref :: { #IntegerStore`34969.value($Heap, this) } IsHeap($Heap) && (forall $pc: ref :: $pc != null && $Heap[$pc, $allocated] == true && cast($Heap[$pc, $ownerRef],ref) == cast($Heap[this, $ownerRef],ref) && cast($Heap[$pc, $ownerFrame],name) == cast($Heap[this, $ownerFrame],name) ==> (cast($Heap[$pc, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[$pc, $ownerRef],ref), $inv],name) <: cast($Heap[$pc, $ownerFrame],name))) && cast($Heap[$pc, $inv],name) == $typeof($pc)) ==> IsAllocated($Heap, #IntegerStore`34969.value($Heap, this)) && InRange(#IntegerStore`34969.value($Heap, this), System.Int32));

procedure Program`34935.integerStoresAssign$IntegerStore`34969$IntegerStore`34969(a$in: ref where $Is(a$in, IntegerStore`34969), b$in: ref where $Is(b$in, IntegerStore`34969));
  free requires $Heap[a$in, $allocated] == true;
  free requires $Heap[b$in, $allocated] == true;
  // user-declared preconditions
  requires a$in != null;
  requires b$in != null;
  requires a$in != b$in;
  requires a$in == null || (forall $pc: ref :: $pc != null && $Heap[$pc, $allocated] == true && cast($Heap[$pc, $ownerRef],ref) == cast($Heap[a$in, $ownerRef],ref) && cast($Heap[$pc, $ownerFrame],name) == cast($Heap[a$in, $ownerFrame],name) ==> (cast($Heap[$pc, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[$pc, $ownerRef],ref), $inv],name) <: cast($Heap[$pc, $ownerFrame],name))) && cast($Heap[$pc, $inv],name) == $typeof($pc));
  requires b$in == null || (forall $pc: ref :: $pc != null && $Heap[$pc, $allocated] == true && cast($Heap[$pc, $ownerRef],ref) == cast($Heap[b$in, $ownerRef],ref) && cast($Heap[$pc, $ownerFrame],name) == cast($Heap[b$in, $ownerFrame],name) ==> (cast($Heap[$pc, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[$pc, $ownerRef],ref), $inv],name) <: cast($Heap[$pc, $ownerFrame],name))) && cast($Heap[$pc, $inv],name) == $typeof($pc));
  modifies $Heap;
  // user-declared preconditions
  ensures #IntegerStore`34969.value($Heap, a$in) == 4;
  ensures false;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] != true && $Heap[$o, $allocated] == true ==> cast($Heap[$o, $inv],name) == $typeof($o));
  // only captured parameters may change their owners
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));
  free ensures (forall $o: ref, $f: name :: $f != $inv && $o != null && old($Heap)[$o, $allocated] == true && (cast(old($Heap)[$o, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast(old($Heap)[cast(old($Heap)[$o, $ownerRef],ref), $inv],name) <: cast(old($Heap)[$o, $ownerFrame],name))) && (!IsStaticField($f) || !IsDirectlyModifiableField($f)) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures (forall $o: ref :: old($Heap)[$o, $inv] == $Heap[$o, $inv] || old($Heap)[$o, $allocated] != true);
  free ensures (forall $o: ref :: old($Heap)[$o, $allocated] == true ==> $Heap[$o, $allocated] == true) && (forall $ot: ref :: old($Heap)[$ot, $allocated] == true && cast(old($Heap)[$ot, $ownerFrame],name) != $PeerGroupPlaceholder ==> cast($Heap[$ot, $ownerRef],ref) == cast(old($Heap)[$ot, $ownerRef],ref) && cast($Heap[$ot, $ownerFrame],name) == cast(old($Heap)[$ot, $ownerFrame],name));
  free ensures (forall $o: ref :: old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation Program`34935.integerStoresAssign$IntegerStore`34969$IntegerStore`34969(a$in: ref, b$in: ref)
{
  var a: ref where $Is(a, IntegerStore`34969), b: ref where $Is(b, IntegerStore`34969), stack0i: int;

  entry:
    a := a$in;
    b := b$in;
    goto block37689;

  block37689:
    goto block37706;

  block37706:
    goto block37723, block37740;

  block37723:
    goto block37791;

  block37740:
    goto block37757;

  block37791:
    goto block37808;

  block37757:
    goto block37774;

  block37808:
    goto block37825, block37842;

  block37774:
    assume false;
    return;

  block37825:
    goto block37893;

  block37842:
    goto block37859;

  block37893:
    goto block37910;

  block37859:
    goto block37876;

  block37910:
    goto block37927, block37944;

  block37876:
    assume false;
    return;

  block37927:
    goto block37995;

  block37944:
    goto block37961;

  block37995:
    goto block38012;

  block37961:
    goto block37978;

  block38012:
    goto block38097;

  block37978:
    assume false;
    return;

  block38097:
    // ----- nop
    goto block38114;

  block38114:
    // ----- load constant 4  ----- Program.ssc(20,14)
    stack0i := 4;
    // ----- call  ----- Program.ssc(20,2)
    assert a != null;
    call IntegerStore`34969.set_value$System.Int32(a, stack0i);
    // ----- load constant 5  ----- Program.ssc(21,14)
    stack0i := 5;
    // ----- call  ----- Program.ssc(21,2)
    assert b != null;
    call IntegerStore`34969.set_value$System.Int32(b, stack0i);
    goto block38131;

  block38131:
    goto block38148;

  block38148:
    goto block38165, block38182;

  block38165:
    goto block38233;

  block38182:
    goto block38199;

  block38233:
    goto block38250;

  block38199:
    goto block38216;

  block38250:
    goto block38284;

  block38216:
    assume false;
    return;

  block38284:
    goto block38301;

  block38301:
    goto block38318;

  block38318:
    assume false;
    return;

}



procedure IntegerStore`34969.set_value$System.Int32(this: ref, a_value$in: int where InRange(a_value$in, System.Int32));
  free requires IsAllocated($Heap, a_value$in);
  requires (forall $pc: ref :: $pc != null && $Heap[$pc, $allocated] == true && cast($Heap[$pc, $ownerRef],ref) == cast($Heap[this, $ownerRef],ref) && cast($Heap[$pc, $ownerFrame],name) == cast($Heap[this, $ownerFrame],name) ==> (cast($Heap[$pc, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[$pc, $ownerRef],ref), $inv],name) <: cast($Heap[$pc, $ownerFrame],name))) && cast($Heap[$pc, $inv],name) == $typeof($pc));
  modifies $Heap;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] != true && $Heap[$o, $allocated] == true ==> cast($Heap[$o, $inv],name) == $typeof($o));
  // only captured parameters may change their owners
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));
  free ensures (forall $o: ref, $f: name :: $f != $inv && $o != null && old($Heap)[$o, $allocated] == true && (cast(old($Heap)[$o, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast(old($Heap)[cast(old($Heap)[$o, $ownerRef],ref), $inv],name) <: cast(old($Heap)[$o, $ownerFrame],name))) && (!IsStaticField($f) || !IsDirectlyModifiableField($f)) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures (forall $o: ref :: old($Heap)[$o, $inv] == $Heap[$o, $inv] || old($Heap)[$o, $allocated] != true);
  free ensures (forall $o: ref :: old($Heap)[$o, $allocated] == true ==> $Heap[$o, $allocated] == true) && (forall $ot: ref :: old($Heap)[$ot, $allocated] == true && cast(old($Heap)[$ot, $ownerFrame],name) != $PeerGroupPlaceholder ==> cast($Heap[$ot, $ownerRef],ref) == cast(old($Heap)[$ot, $ownerRef],ref) && cast($Heap[$ot, $ownerFrame],name) == cast(old($Heap)[$ot, $ownerFrame],name));
  free ensures (forall $o: ref :: old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



procedure Program`34935..ctor(this: ref);
  // nothing is owned by [this,Program]
  free requires (forall $o: ref :: cast($Heap[$o, $ownerRef],ref) != this || cast($Heap[$o, $ownerFrame],name) != Program`34935);
  // 'this' is alone in its own peer group
  free requires cast($Heap[this, $ownerRef],ref) == this && cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder;
  free requires (forall $o: ref :: cast($Heap[$o, $ownerRef],ref) == cast($Heap[this, $ownerRef],ref) && cast($Heap[$o, $ownerFrame],name) == cast($Heap[this, $ownerFrame],name) ==> $o == this);
  modifies $Heap;
  ensures (cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[this, $ownerRef],ref), $inv],name) <: cast($Heap[this, $ownerFrame],name))) && cast($Heap[this, $inv],name) == Program`34935;
  ensures $Heap[this, $ownerRef] == old($Heap)[this, $ownerRef] && $Heap[this, $ownerFrame] == old($Heap)[this, $ownerFrame];
  ensures $Heap[this, $sharingMode] == $SharingMode_Unshared;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] != true && $Heap[$o, $allocated] == true ==> cast($Heap[$o, $inv],name) == $typeof($o));
  // only captured parameters may change their owners
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));
  free ensures (forall $o: ref, $f: name :: $f != $inv && $o != null && old($Heap)[$o, $allocated] == true && (cast(old($Heap)[$o, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast(old($Heap)[cast(old($Heap)[$o, $ownerRef],ref), $inv],name) <: cast(old($Heap)[$o, $ownerFrame],name))) && (!IsStaticField($f) || !IsDirectlyModifiableField($f)) && ($o != this || !(Program`34935 <: DeclType($f))) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures (forall $o: ref :: $o == this || old($Heap)[$o, $inv] == $Heap[$o, $inv] || old($Heap)[$o, $allocated] != true);
  free ensures (forall $o: ref :: old($Heap)[$o, $allocated] == true ==> $Heap[$o, $allocated] == true) && (forall $ot: ref :: old($Heap)[$ot, $allocated] == true && cast(old($Heap)[$ot, $ownerFrame],name) != $PeerGroupPlaceholder ==> cast($Heap[$ot, $ownerRef],ref) == cast(old($Heap)[$ot, $ownerRef],ref) && cast($Heap[$ot, $ownerFrame],name) == cast(old($Heap)[$ot, $ownerFrame],name));
  free ensures (forall $o: ref :: $o == this || old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation Program`34935..ctor(this: ref)
{

  entry:
    assume $IsNotNull(this, Program`34935);
    assume $Heap[this, $allocated] == true;
    assume (cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[this, $ownerRef],ref), $inv],name) <: cast($Heap[this, $ownerFrame],name))) && cast($Heap[this, $inv],name) == System.Object;
    goto block38692;

  block38692:
    goto block38709;

  block38709:
    goto block38726;

  block38726:
    // ----- call  ----- Program.ssc(3,14)
    assert this != null;
    call System.Object..ctor(this);
    goto block38743;

  block38743:
    goto block38760;

  block38760:
    // ----- return
    assert this != null;
    assert cast($Heap[this, $inv],name) == System.Object;
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] == true && cast($Heap[$p, $ownerRef],ref) == this && cast($Heap[$p, $ownerFrame],name) == Program`34935 ==> cast($Heap[$p, $inv],name) == $typeof($p));
    $Heap[this, $inv] := Program`34935;
    return;

}



procedure System.Object..ctor(this: ref);
  // nothing is owned by [this,Object]
  free requires (forall $o: ref :: cast($Heap[$o, $ownerRef],ref) != this || cast($Heap[$o, $ownerFrame],name) != System.Object);
  // 'this' is alone in its own peer group
  free requires cast($Heap[this, $ownerRef],ref) == this && cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder;
  free requires (forall $o: ref :: cast($Heap[$o, $ownerRef],ref) == cast($Heap[this, $ownerRef],ref) && cast($Heap[$o, $ownerFrame],name) == cast($Heap[this, $ownerFrame],name) ==> $o == this);
  modifies $Heap;
  ensures (cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[this, $ownerRef],ref), $inv],name) <: cast($Heap[this, $ownerFrame],name))) && cast($Heap[this, $inv],name) == System.Object;
  ensures $Heap[this, $ownerRef] == old($Heap)[this, $ownerRef] && $Heap[this, $ownerFrame] == old($Heap)[this, $ownerFrame];
  ensures $Heap[this, $sharingMode] == $SharingMode_Unshared;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] != true && $Heap[$o, $allocated] == true ==> cast($Heap[$o, $inv],name) == $typeof($o));
  // only captured parameters may change their owners
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));
  free ensures (forall $o: ref, $f: name :: $f != $inv && $o != null && old($Heap)[$o, $allocated] == true && (cast(old($Heap)[$o, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast(old($Heap)[cast(old($Heap)[$o, $ownerRef],ref), $inv],name) <: cast(old($Heap)[$o, $ownerFrame],name))) && (!IsStaticField($f) || !IsDirectlyModifiableField($f)) && ($o != this || !(System.Object <: DeclType($f))) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures (forall $o: ref :: $o == this || old($Heap)[$o, $inv] == $Heap[$o, $inv] || old($Heap)[$o, $allocated] != true);
  free ensures (forall $o: ref :: old($Heap)[$o, $allocated] == true ==> $Heap[$o, $allocated] == true) && (forall $ot: ref :: old($Heap)[$ot, $allocated] == true && cast(old($Heap)[$ot, $ownerFrame],name) != $PeerGroupPlaceholder ==> cast($Heap[$ot, $ownerRef],ref) == cast(old($Heap)[$ot, $ownerRef],ref) && cast($Heap[$ot, $ownerFrame],name) == cast(old($Heap)[$ot, $ownerFrame],name));
  free ensures (forall $o: ref :: $o == this || old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation IntegerStore`34969..ctor$IntegerStore`34969(this: ref, an_other$in: ref)
{
  var an_other: ref where $Is(an_other, IntegerStore`34969);

  entry:
    assume $IsNotNull(this, IntegerStore`34969);
    assume $Heap[this, $allocated] == true;
    assume (cast($Heap[this, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[this, $ownerRef],ref), $inv],name) <: cast($Heap[this, $ownerFrame],name))) && cast($Heap[this, $inv],name) == System.Object;
    an_other := an_other$in;
    assume cast($Heap[this, IntegerStore.v],int) == 0;
    assume cast($Heap[this, IntegerStore.other],ref) == null;
    goto block38964;

  block38964:
    goto block38981;

  block38981:
    goto block38998;

  block38998:
    goto block39015;

  block39015:
    // ----- call  ----- IntegerStore.ssc(5,44)
    assert this != null;
    call System.Object..ctor(this);
    goto block39032;

  block39032:
    // ----- store field  ----- IntegerStore.ssc(6,3)
    assert this != null;
    $Heap[this, IntegerStore.other] := an_other;
    goto block39049;

  block39049:
    goto block39066;

  block39066:
    // ----- return  ----- IntegerStore.ssc(7,2)
    assert this != null;
    assert cast($Heap[this, $inv],name) == System.Object;
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] == true && cast($Heap[$p, $ownerRef],ref) == this && cast($Heap[$p, $ownerFrame],name) == IntegerStore`34969 ==> cast($Heap[$p, $inv],name) == $typeof($p));
    $Heap[this, $inv] := IntegerStore`34969;
    return;

}



procedure IntegerStore`34969.value(this: ref) returns ($result: int where InRange($result, System.Int32));
  requires (forall $pc: ref :: $pc != null && $Heap[$pc, $allocated] == true && cast($Heap[$pc, $ownerRef],ref) == cast($Heap[this, $ownerRef],ref) && cast($Heap[$pc, $ownerFrame],name) == cast($Heap[this, $ownerFrame],name) ==> (cast($Heap[$pc, $ownerFrame],name) == $PeerGroupPlaceholder || !(cast($Heap[cast($Heap[$pc, $ownerRef],ref), $inv],name) <: cast($Heap[$pc, $ownerFrame],name))) && cast($Heap[$pc, $inv],name) == $typeof($pc));
  modifies $Heap;
  free ensures IsAllocated($Heap, $result);
  free ensures InRange($result, System.Int32);
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] != true && $Heap[$o, $allocated] == true ==> cast($Heap[$o, $inv],name) == $typeof($o));
  // only captured parameters may change their owners
  ensures (forall $o: ref :: $o != null && old($Heap)[$o, $allocated] == true ==> cast(old($Heap)[$o, $ownerRef],ref) == cast($Heap[$o, $ownerRef],ref) && cast(old($Heap)[$o, $ownerFrame],name) == cast($Heap[$o, $ownerFrame],name));
  free ensures $Heap == old($Heap);
  free ensures $result == #IntegerStore`34969.value($Heap, this);



implementation IntegerStore`34969.value(this: ref) returns ($result: int)
{
  var stack0o: ref, stack1o: ref, stack0b: bool, return.value: int where InRange(return.value, System.Int32), stack0i: int, stack1i: int, SS$Display.Return.Local: int where InRange(SS$Display.Return.Local, System.Int32);

  entry:
    assume $IsNotNull(this, IntegerStore`34969);
    assume $Heap[this, $allocated] == true;
    goto block39338;

  block39338:
    goto block39355;

  block39355:
    // ----- load field  ----- IntegerStore.ssc(11,6)
    assert this != null;
    stack0o := cast($Heap[this, IntegerStore.other],ref);
    stack1o := null;
    // ----- binary operator  ----- IntegerStore.ssc(11,6)
    stack0b := stack0o != stack1o;
    // ----- branch  ----- IntegerStore.ssc(11,3)
    goto true39355to39406, false39355to39372;

  true39355to39406:
    assume stack0b == true;
    goto block39406;

  false39355to39372:
    assume stack0b == false;
    goto block39372;

  block39406:
    // ----- load field  ----- IntegerStore.ssc(14,11)
    assert this != null;
    stack0i := cast($Heap[this, IntegerStore.v],int);
    // ----- load field  ----- IntegerStore.ssc(14,15)
    assert this != null;
    stack1o := cast($Heap[this, IntegerStore.other],ref);
    // ----- call  ----- IntegerStore.ssc(14,15)
    assert stack1o != null;
    call stack1i := IntegerStore`34969.value(stack1o);
    // ----- binary operator  ----- IntegerStore.ssc(14,11)
    stack0i := stack0i + stack1i;
    // ----- copy  ----- IntegerStore.ssc(14,4)
    return.value := stack0i;
    // ----- branch
    goto block39457;

  block39372:
    // ----- load field  ----- IntegerStore.ssc(12,4)
    assert this != null;
    return.value := cast($Heap[this, IntegerStore.v],int);
    // ----- branch
    goto block39457;

  block39457:
    goto block39474;

  block39474:
    // ----- copy
    SS$Display.Return.Local := return.value;
    // ----- copy  ----- IntegerStore.ssc(16,2)
    stack0i := return.value;
    // ----- return  ----- IntegerStore.ssc(16,2)
    $result := stack0i;
    return;

}



implementation IntegerStore`34969.set_value$System.Int32(this: ref, a_value$in: int)
{
  var a_value: int where InRange(a_value, System.Int32), stack0o: ref, stack1o: ref, stack0b: bool, stack0i: int;

  entry:
    assume $IsNotNull(this, IntegerStore`34969);
    assume $Heap[this, $allocated] == true;
    a_value := a_value$in;
    goto block39729;

  block39729:
    goto block39746;

  block39746:
    // ----- load field  ----- IntegerStore.ssc(19,6)
    assert this != null;
    stack0o := cast($Heap[this, IntegerStore.other],ref);
    stack1o := null;
    // ----- binary operator  ----- IntegerStore.ssc(19,6)
    stack0b := stack0o != stack1o;
    // ----- branch  ----- IntegerStore.ssc(19,3)
    goto true39746to39797, false39746to39763;

  true39746to39797:
    assume stack0b == true;
    goto block39797;

  false39746to39763:
    assume stack0b == false;
    goto block39763;

  block39797:
    // ----- load field  ----- IntegerStore.ssc(22,18)
    assert this != null;
    stack0o := cast($Heap[this, IntegerStore.other],ref);
    // ----- call  ----- IntegerStore.ssc(22,18)
    assert stack0o != null;
    call stack0i := IntegerStore`34969.value(stack0o);
    // ----- binary operator  ----- IntegerStore.ssc(22,8)
    stack0i := a_value - stack0i;
    // ----- store field  ----- IntegerStore.ssc(22,4)
    assert this != null;
    $Heap[this, IntegerStore.v] := stack0i;
    // ----- nop  ----- IntegerStore.ssc(22,30)
    goto block39814;

  block39763:
    // ----- store field  ----- IntegerStore.ssc(20,4)
    assert this != null;
    $Heap[this, IntegerStore.v] := a_value;
    goto block39780;

  block39780:
    // ----- branch  ----- IntegerStore.ssc(21,3)
    goto block39814;

  block39814:
    goto block39831;

  block39831:
    goto block39848;

  block39848:
    // ----- return  ----- IntegerStore.ssc(23,2)
    return;

}


