package net.kaikoga.arp.testParams;

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
