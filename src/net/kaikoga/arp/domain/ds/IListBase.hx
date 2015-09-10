package net.kaikoga.arp.domain.ds;

interface IListBase<T> extends ICollection<T> {

	var length(default,null):Int;
	function first():Null<T>;
	function last():Null<T>;
	function remove( v : T ) : Bool;
	function join(sep : String):String;

	function concat( a : Array<T> ) : Array<T>;
	function join( sep : String ) : String;
	function pop() : Null<T>;
	function push(x : T) : Int;
	function reverse() : Void;
	function shift() : Null<T>;
	function slice( pos : Int, ?end : Int ) : Array<T>;
	function sort( f : T -> T -> Int ) : Void;
	function splice( pos : Int, len : Int ) : Array<T>;
	function unshift( x : T ) : Void;
	function insert( pos : Int, x : T ) : Void;
	function remove( x : T ) : Bool;
	function indexOf( x : T, ?fromIndex:Int ) : Int;
	function lastIndexOf( x : T, ?fromIndex:Int ) : Int;

	function copy():IListBase<T>;
	function map<S>( f : T -> S ) : IListBase<S>;
	function filter( f : T -> Bool ) : IListBase<T>;
}
