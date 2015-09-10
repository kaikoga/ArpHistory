package net.kaikoga.arp.collections;

import net.kaikoga.collections.ConcurrentIntIterateContext.ConcurrentIntIterator;

class IndexedMapIterator<K, V> {

	private var map:IIndexedMap<K, V>;
	private var iterator:ConcurrentIntIterator;

	public function new(map:IIndexedMap<K, V>, context:ConcurrentIntIterateContext) {
		this.map = map;
		this.iterator = context.newIterator();
	}

	public function hasNext():Bool {
		return this.iterator.hasNext();
	}

	public function next():V {
		return this.map.getAt(this.iterator.next());
	}
}
