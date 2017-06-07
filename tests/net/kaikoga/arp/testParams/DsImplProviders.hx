package net.kaikoga.arp.testParams;

import net.kaikoga.arp.ds.proxy.ProxyCaseUtil;
import net.kaikoga.arp.ds.proxy.OmapProxy;
import net.kaikoga.arp.ds.proxy.MapProxy;
import net.kaikoga.arp.ds.proxy.ListProxy;
import net.kaikoga.arp.ds.proxy.SetProxy;
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
import net.kaikoga.arp.testFixtures.ArpSupportFixtures.DsIntFixture;
import net.kaikoga.arp.testFixtures.ArpSupportFixtures.DsStringFixture;

class DsImplProviders {

	public static function setProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new ArraySetProvider<Int>(), new DsIntFixture()]);
		providers.push([new StdMapSetProvider<Int>(), new DsIntFixture()]);
		return providers;
	}

	public static function listProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new ArrayListProvider<Int>(), new DsIntFixture()]);
		return providers;
	}

	public static function mapProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new StdMapProvider<String, Int>(), new DsStringFixture(), new DsIntFixture()]);
		return providers;
	}

	public static function omapProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new StdOmapProvider<String, Int>(), new DsStringFixture(), new DsIntFixture()]);
		return providers;
	}

	public static function adapterSetProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new SetOfListProvider<Int>(), new DsIntFixture()]);
		providers.push([new SetOfMapKeyProvider<Int, String>(intToString), new DsIntFixture()]);
		providers.push([new SetOfMapValueProvider<String, Int>(intToString), new DsIntFixture()]);
		providers.push([new SetOfOmapKeyProvider<Int, String>(intToString), new DsIntFixture()]);
		providers.push([new SetOfOmapValueProvider<String, Int>(intToString), new DsIntFixture()]);
		return providers;
	}

	public static function adapterListProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new ListOfOmapKeyProvider<Int, String>(intToString), new DsIntFixture()]);
		providers.push([new ListOfOmapValueProvider<String, Int>(intToString), new DsIntFixture()]);
		return providers;
	}

	public static function adapterMapProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new MapOfOmapProvider<String, Int>(), new DsStringFixture(), new DsIntFixture()]);
		return providers;
	}

	public static function adapterOmapProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		return providers;
	}

	public static function proxySetProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new ProxySetProvider(), new DsIntFixture()]);
		providers.push([new SelfProxySetProvider(), new DsIntFixture()]);
		return providers;
	}

	public static function proxyListProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new ProxyListProvider(), new DsIntFixture()]);
		providers.push([new SelfProxyListProvider(), new DsIntFixture()]);
		return providers;
	}

	public static function proxyMapProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new ProxyMapProvider(), new DsStringFixture(), new DsIntFixture()]);
		providers.push([new SelfProxyMapProvider(), new DsStringFixture(), new DsIntFixture()]);
		return providers;
	}

	public static function proxyOmapProvider():Iterable<Array<Dynamic>> {
		var providers:Array<Array<Dynamic>> = [];
		providers.push([new ProxyOmapProvider(), new DsStringFixture(), new DsIntFixture()]);
		providers.push([new SelfProxyOmapProvider(), new DsStringFixture(), new DsIntFixture()]);
		return providers;
	}

	private static function intToString(value:Int):String return Std.string(value);
}

typedef IDsImplProvider<T> = {
	function create():T;
}

@:generic @:remove
class ArraySetProvider<V> {
	public function new() {}
	public function create():ISet<V> return new ArraySet<V>();
}

@:generic @:remove
class StdMapSetProvider<V> {
	public function new() {}
	public function create():ISet<V> return new StdMapSet<V>();
}

@:generic @:remove
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

@:generic @:remove
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

class ProxySetProvider {
	public function new() {}
	public function create():ISet<Int> {
		return new SetProxy(new ArraySet<String>(), ProxyCaseUtil.proxyString, ProxyCaseUtil.unproxyString);
	}
}

class ProxyListProvider {
	public function new() {}
	public function create():IList<Int> {
		return new ListProxy(new ArrayList<String>(), ProxyCaseUtil.proxyString, ProxyCaseUtil.unproxyString);
	}
}

class ProxyMapProvider {
	public function new() {}
	public function create():IMap<String, Int> {
		return new MapProxy(new StdMap<Int, String>(), ProxyCaseUtil.proxyInt, ProxyCaseUtil.unproxyInt, ProxyCaseUtil.proxyString, ProxyCaseUtil.unproxyString);
	}
}

class ProxyOmapProvider {
	public function new() {}
	public function create():IOmap<String, Int> {
		return new OmapProxy(new StdOmap<Int, String>(), ProxyCaseUtil.proxyInt, ProxyCaseUtil.unproxyInt, ProxyCaseUtil.proxyString, ProxyCaseUtil.unproxyString);
	}
}

class SelfProxySetProvider {
	public function new() {}
	public function create():ISet<Int> {
		return new SetProxy(new ArraySet<Int>(), ProxyCaseUtil.selfProxyInt, ProxyCaseUtil.selfUnproxyInt);
	}
}

class SelfProxyListProvider {
	public function new() {}
	public function create():IList<Int> {
		return new ListProxy(new ArrayList<Int>(), ProxyCaseUtil.selfProxyInt, ProxyCaseUtil.selfUnproxyInt);
	}
}

class SelfProxyMapProvider {
	public function new() {}
	public function create():IMap<String, Int> {
		return new MapProxy(new StdMap<String, Int>(), ProxyCaseUtil.selfProxyString, ProxyCaseUtil.selfUnproxyString, ProxyCaseUtil.selfProxyInt, ProxyCaseUtil.selfUnproxyInt);
	}
}

class SelfProxyOmapProvider {
	public function new() {}
	public function create():IOmap<String, Int> {
		return new OmapProxy(new StdOmap<String, Int>(), ProxyCaseUtil.selfProxyString, ProxyCaseUtil.selfUnproxyString, ProxyCaseUtil.selfProxyInt, ProxyCaseUtil.selfUnproxyInt);
	}
}
