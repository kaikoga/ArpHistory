package net.kaikoga.arp.ds;

import Map.IMap;
import net.kaikoga.collections.ConcurrentIntIterateContext;

/**
 * String->Object map.
 * @author kaikoga
 */
class IndexedMap<K, V> implements IIndexedMap<K, V> {

	private var _map:IMap<K, V>;

	private var _keys:Array<K>;

	public function keys():Iterator<K> {
		return this._keys.copy().iterator();
	}

	private var _iterators:ConcurrentIntIterateContext;

	public var length(get_length, never):Int;

	public function get_length():Int {
		return this._keys.length;
	}

	public function new() {
		this.clear();
	}

	public function clear():Void {
		this._map = new Map<K, V>();
		this._keys = [];
		this._iterators = new ConcurrentIntIterateContext();
	}

	public function get(key:K):V {
		return this._map.get(key);
	}

	public function set(key:K, value:V):Void {
		if (!this._map.exists(key)) {
			this._iterators.onInsert(this._keys.length, 1);
			this._keys.push(key);
		}
		this._map.set(key, value);
	}

	public function exists(key:K):Bool {
		return this._map.exists(key);
	}

	public function remove(key:K):Bool {
		if (!this._map.remove(key)) {
			return false;
		}
		var index = this._keys.indexOf(key);
		if (index >= 0) {
			this._keys.splice(index, 1);
		}
		this._iterators.onInsert(index, -1);
		return true;
	}

	public function iterator():Iterator<V> {
		return new IndexedMapIterator<K, V>(this, this._iterators);
	}

	public function toString():String {
		return "[IndexedMap ${this._map.toString()}]";
	}

	public function getAt(index:Int):V {
		return this._map.get(this.keyAt(index));
	}

	//TEST insert
	//TEST will head insert when index <= 0
	//TEST will append when index >= length
	//TEST will delete existing key before insert when duplicate
	/**
	 * Adds an entry to this map, with the position to insert.
	 * @param	index The index of the entry.
	 * @param	name The name of the entry.
	 * @param	value The entry value.
	 * @return	the index of the entry inserted.
	 */

	public function insert(index:Int, key:K, value:V):Int {
		if (this._map.exists(key)) {
			this.remove(key);
		}
		if (index >= this._keys.length) {
			this._keys.push(key);
		} else {
			this._keys.insert((index < 0) ? 0 : index, key);
		}
		this._map.set(key, value);
		this._iterators.onInsert(index, 1);
		return index;
	}

	public function keyAt(index:Int):K {
		return this._keys[index];
	}

}
