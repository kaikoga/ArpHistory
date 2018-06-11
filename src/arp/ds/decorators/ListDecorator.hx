package arp.ds.decorators;

import arp.ds.lambda.CollectionTools;
import arp.ds.access.IListKnit.IListKnitPin;
import arp.ds.IList;

class ListDecorator<V> implements IList<V> {

	private var list:IList<V>;

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return this.list.isUniqueValue;

	public function new(list:IList<V>) this.list = list;

	//read
	public function isEmpty():Bool return this.list.isEmpty();
	public function hasValue(v:V):Bool return this.list.hasValue(v);
	public function iterator():Iterator<V> return this.list.iterator();
	public function toString():String return this.list.toString();
	public var length(get, null):Int;
	public function get_length():Int return this.list.length;
	public function first():Null<V> return this.list.first();
	public function last():Null<V> return this.list.last();
	public function getAt(index:Int):Null<V> return this.list.getAt(index);

	//resolve
	public function indexOf(v:V, ?fromIndex:Int):Int return this.list.indexOf(v, fromIndex);
	public function lastIndexOf(v:V, ?fromIndex:Int):Int return this.list.lastIndexOf(v, fromIndex);

	//write
	public function push(v:V):Int return this.list.push(v);
	public function unshift(v:V):Void this.list.unshift(v);
	public function insertAt(index:Int, v:V):Void this.list.insertAt(index, v);

	//remove
	public function pop():Null<V> return this.list.pop();
	public function shift():Null<V> return this.list.shift();
	public function remove(v:V):Bool return this.list.remove(v);
	public function removeAt(index:Int):Bool return this.list.removeAt(index);
	public function clear():Void this.list.clear();

	//knit
	public function knit():Iterator<IListKnitPin<V>> return CollectionTools.listKnitImpl(this);
}
