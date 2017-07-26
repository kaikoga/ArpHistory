package net.kaikoga.arp.ds.adapters;

import net.kaikoga.arp.ds.access.ISetKnit.ISetKnitPin;
import net.kaikoga.arp.ds.lambda.CollectionTools;
import net.kaikoga.arp.ds.ISet;
import net.kaikoga.arp.ds.IOmap;

class SetOfOmapValue<K, V> implements ISet<V> {

	private var omap:IOmap<K, V>;
	private var autoKey:V->K;

	public var isUniqueValue(get, never):Bool;
	public function get_isUniqueValue():Bool return true;

	public function new(omap:IOmap<K, V>, autoKey:V->K) {
		this.omap = omap;
		this.autoKey = autoKey;
	}

	// read
	public function isEmpty():Bool return this.omap.isEmpty();
	public function hasValue(v:V):Bool return this.omap.hasValue(v);
	public function iterator():Iterator<V> return this.omap.iterator();
	public function toString():String return CollectionTools.setToStringImpl(this);

	// write
	public function add(v:V):Void this.omap.addPair(autoKey(v), v);

	// remove
	public function remove(v:V):Bool return this.omap.remove(v);
	public function clear():Void this.omap.clear();

	//knit
	public function knit():Iterator<ISetKnitPin<V>> return CollectionTools.setKnitImpl(this);
}
