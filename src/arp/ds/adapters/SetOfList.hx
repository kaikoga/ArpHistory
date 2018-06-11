package arp.ds.adapters;

import arp.ds.access.ISetKnit.ISetKnitPin;
import arp.ds.lambda.CollectionTools;
import arp.ds.ISet;
import arp.ds.IList;

class SetOfList<V> implements ISet<V> {

	private var list:IList<V>;

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return true;

	public function new(list:IList<V>) {
		this.list = list;
	}

	public function isEmpty():Bool return this.list.isEmpty();
	public function hasValue(v:V):Bool return this.list.hasValue(v);
	public function iterator():Iterator<V> return this.list.iterator();
	public function toString():String return CollectionTools.setToStringImpl(this);

	public function add(v:V):Void if (!this.list.hasValue(v)) this.list.push(v);

	public function remove(v:V):Bool return this.list.remove(v);
	public function clear():Void this.list.clear();

	//knit
	public function knit():Iterator<ISetKnitPin<V>> return CollectionTools.setKnitImpl(this);
}
