package net.kaikoga.arp.ds.adapters;

import net.kaikoga.arp.ds.access.IListKnit.IListKnitPin;
import net.kaikoga.arp.ds.lambda.CollectionTools;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arp.ds.IOmap;

class ListOfOmapKey<K, V> implements IList<K> {

	private var omap:IOmap<K, V>;
	private var autoValue:K->V;

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return true;

	public function new(omap:IOmap<K, V>, autoValue:K->V) {
		this.omap = omap;
		this.autoValue = autoValue;
	}

	public function isEmpty():Bool return this.omap.isEmpty();
	public function hasValue(v:K):Bool return this.omap.hasKey(v);
	public function iterator():Iterator<K> return this.omap.keys();
	public function toString():String return CollectionTools.listToStringImpl(this);
	public var length(get, null):Int;
	public function get_length():Int return this.omap.length;
	public function first():Null<K> return this.omap.resolveName(this.omap.first());
	public function last():Null<K> return this.omap.resolveName(this.omap.last());
	public function getAt(index:Int):Null<K> return this.omap.resolveName(this.omap.getAt(index));

	//resolve
	public function indexOf(v:K, ?fromIndex:Int):Int return this.omap.resolveKeyIndex(v);
	public function lastIndexOf(v:K, ?fromIndex:Int):Int return this.omap.resolveKeyIndex(v);

	//write
	public function push(v:K):Int {
		this.omap.addPair(v, this.autoValue(v));
		return this.omap.length;
	}
	public function unshift(v:K):Void this.omap.insertPairAt(0, v, this.autoValue(v));
	public function insertAt(index:Int, v:K):Void this.omap.insertPairAt(index, v, this.autoValue(v));

	//remove
	public function pop():Null<K> {
		var k:K = this.last();
		this.omap.pop();
		return k;
	}
	public function shift():Null<K> {
		var k:K = this.first();
		this.omap.shift();
		return k;
	}
	public function remove(v:K):Bool return this.omap.removeKey(v);
	public function removeAt(index:Int):Bool return this.omap.removeAt(index);
	public function clear():Void this.omap.clear();

	//knit
	public function knit():Iterator<IListKnitPin<K>> return CollectionTools.listKnitImpl(this);
}
