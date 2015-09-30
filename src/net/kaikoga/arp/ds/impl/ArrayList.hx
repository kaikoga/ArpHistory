package net.kaikoga.arp.ds.impl;

import net.kaikoga.arp.ds.IList;

class ArrayList<V> implements IList<V> {

	private var value:Array<V>;

	public function new() {
		this.value = [];
	}

	//read
	public function isEmpty():Bool return this.value.length == 0;
	public function hasValue(v:V):Bool return this.value.indexOf(v) >= 0;
	public function iterator():Iterator<V> return this.value.iterator();
	public function toString():String return this.value.toString();
	public var length(get, null):Int;
	public function get_length():Int return this.value.length;
	public function first():Null<V> return this.value[0];
	public function last():Null<V> return this.value[this.value.length - 1];
	public function getAt(index:Int):Null<V> return this.value[index];

	//resolve
	public function indexOf(v:V, ?fromIndex:Int):Int return this.value.indexOf(v, fromIndex);
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return this.value.lastIndexOf(v, fromIndex);

	//write
	public function pop():Null<V> return this.value.pop();
	public function push(v:V):Int return this.value.push(v);
	public function shift():Null<V> return this.value.shift();
	public function unshift(v:V):Void this.value.unshift(v);
	public function insertAt(index:Int, v:V):Void this.value.insert(index, v);
	public function removeAt(index:Int):Void this.value.splice(index, 1);
	public function clear():Void this.value = [];
}
