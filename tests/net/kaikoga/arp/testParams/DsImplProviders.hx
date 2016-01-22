package net.kaikoga.arp.testParams;

import net.kaikoga.arp.ds.adapters.ListOfOmapValue;
import net.kaikoga.arp.ds.adapters.ListOfOmapKey;
import net.kaikoga.arp.ds.adapters.SetOfOmapValue;
import net.kaikoga.arp.ds.adapters.SetOfOmapKey;
import net.kaikoga.arp.ds.adapters.SetOfMapValue;
import net.kaikoga.arp.ds.adapters.SetOfMapKey;
import net.kaikoga.arp.ds.adapters.SetOfList;
import net.kaikoga.arp.ds.adapters.MapOfOmap;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.ds.ISet;
import net.kaikoga.arp.ds.impl.StdOmap;
import net.kaikoga.arp.ds.impl.StdMap;
import net.kaikoga.arp.ds.impl.ArrayList;
import net.kaikoga.arp.ds.impl.StdMapSet;
import net.kaikoga.arp.ds.impl.ArraySet;

class DsImplProviders {

	public static function setProvider():Iterable<Array<Dynamic>> {
		return [
			[new ArraySetProvider<Int>()],
			[new StdMapSetProvider<Int>()]
		];
	}

	public static function listProvider():Iterable<Array<Dynamic>> {
		return [
			[new ArrayListProvider<Int>()]
		];
	}

	public static function mapProvider():Iterable<Array<Dynamic>> {
		return [
			[new StdMapProvider<String, Int>()]
		];
	}

	public static function omapProvider():Iterable<Array<Dynamic>> {
		return [
			[new StdOmapProvider<String, Int>()]
		];
	}

	public static function adapterSetProvider():Iterable<Array<Dynamic>> {
		return [
			[new SetOfListProvider<Int>()],
			[new SetOfMapKeyProvider<Int, String>(intToString)],
			[new SetOfMapValueProvider<String, Int>(intToString)],
			[new SetOfOmapKeyProvider<Int, String>(intToString)],
			[new SetOfOmapValueProvider<String, Int>(intToString)]
		];
	}

	public static function adapterListProvider():Iterable<Array<Dynamic>> {
		return [
			[new ListOfOmapKeyProvider<Int, String>(intToString)],
			[new ListOfOmapValueProvider<String, Int>(intToString)]
		];
	}

	public static function adapterMapProvider():Iterable<Array<Dynamic>> {
		return [
			[new MapOfOmapProvider<String, Int>()]
		];
	}

	public static function adapterOmapProvider():Iterable<Array<Dynamic>> {
		return [
		];
	}

	private static function intToString(value:Int):String return Std.string(value);
}

typedef IDsImplProvider<T> = {
	function create():T;
}

class ArraySetProvider<V> {
	public function new() {}
	public function create():ISet<V> return new ArraySet<V>();
}

@:generic @:remove
class StdMapSetProvider<V> {
	public function new() {}
	public function create():ISet<V> return new StdMapSet<V>();
}

class ArrayListProvider<V> {
	public function new() {}
	public function create():IList<V> return new ArrayList<V>();
}

@:generic @:remove
class StdMapProvider<K, V> {
	public function new() {}
	public function create():IMap<K, V> return new StdMap<K, V>();
}

@:generic @:remove
class StdOmapProvider<K, V> {
	public function new() {}
	public function create():IOmap<K, V> return new StdOmap<K, V>();
}

class SetOfListProvider<V> {
	public function new() {}
	public function create():ISet<V> return new SetOfList(new ArrayList<V>());
}

@:generic @:remove
class SetOfMapKeyProvider<K, V> {
	private var valueFunc:K->V;
	public function new(valueFunc:K->V) { this.valueFunc = valueFunc; }
	public function create():ISet<K> return new SetOfMapKey(new StdMap<K, V>(), valueFunc);
}

@:generic @:remove
class SetOfMapValueProvider<K, V> {
	private var keyFunc:V->K;
	public function new(keyFunc:V->K) { this.keyFunc = keyFunc; }
	public function create():ISet<V> return new SetOfMapValue(new StdMap<K, V>(), keyFunc);
}

@:generic @:remove
class SetOfOmapKeyProvider<K, V> {
	private var valueFunc:K->V;
	public function new(valueFunc:K->V) { this.valueFunc = valueFunc; }
	public function create():ISet<K> return new SetOfOmapKey(new StdOmap<K, V>(), valueFunc);
}

@:generic @:remove
class SetOfOmapValueProvider<K, V> {
	private var keyFunc:V->K;
	public function new(keyFunc:V->K) { this.keyFunc = keyFunc; }
	public function create():ISet<V> return new SetOfOmapValue(new StdOmap<K, V>(), keyFunc);
}

@:generic @:remove
class ListOfOmapKeyProvider<K, V> {
	private var valueFunc:K->V;
	public function new(valueFunc:K->V) { this.valueFunc = valueFunc; }
	public function create():IList<K> return new ListOfOmapKey(new StdOmap<K, V>(), valueFunc);
}

@:generic @:remove
class ListOfOmapValueProvider<K, V> {
	private var keyFunc:V->K;
	public function new(keyFunc:V->K) { this.keyFunc = keyFunc; }
	public function create():IList<V> return new ListOfOmapValue(new StdOmap<K, V>(), keyFunc);
}

@:generic @:remove
class MapOfOmapProvider<K, V> {
	public function new() {}
	public function create():IMap<K, V> return new MapOfOmap(new StdOmap<K, V>());
}
