package net.kaikoga.arp.domain.ds;

interface IList2<T> extends IListBase<T> {

	var length(default,null) : Int;
	function add( item : T );
	function push( item : T );
	function first() : Null<T>;
	function last() : Null<T>;
	function pop() : Null<T>;
	function isEmpty() : Bool;
	function clear() : Void;
	function remove( v : T ) : Bool;
	function iterator() : Iterator<T>;
	function toString():String;
	function join(sep : String):String;
	function filter( f : T -> Bool ):List<T>;
	function map<X>(f : T -> X) : List<X>;

	var length(default,null) : Int;
	function concat( a : Array<T> ) : Array<T>;
	function join( sep : String ) : String;
	function pop() : Null<T>;
	function push(x : T) : Int;
	function reverse() : Void;
	function shift() : Null<T>;
	function slice( pos : Int, ?end : Int ) : Array<T>;
	function sort( f : T -> T -> Int ) : Void;
	function splice( pos : Int, len : Int ) : Array<T>;
	function toString() : String;
	function unshift( x : T ) : Void;
	function insert( pos : Int, x : T ) : Void;
	function remove( x : T ) : Bool;
	function indexOf( x : T, ?fromIndex:Int ) : Int;
	function lastIndexOf( x : T, ?fromIndex:Int ) : Int;
	function copy() : Array<T>;
	function iterator() : Iterator<T>;
	function map<S>( f : T -> S ) : Array<S>;
	function filter( f : T -> Bool ) : Array<T>;
}
