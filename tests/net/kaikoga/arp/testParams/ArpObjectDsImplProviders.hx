package net.kaikoga.arp.testParams;

import net.kaikoga.arp.testFixtures.ArpSupportFixtures.DsStringFixture;
import net.kaikoga.arp.testFixtures.ArpDsTestDomain;
import net.kaikoga.arp.domain.mocks.MockArpObject;
import net.kaikoga.arp.domain.IArpObject;
import net.kaikoga.arp.domain.ds.ArpObjectSet;
import net.kaikoga.arp.domain.ds.ArpObjectList;
import net.kaikoga.arp.domain.ds.ArpObjectMap;
import net.kaikoga.arp.domain.ds.ArpObjectOmap;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.ds.ISet;

class ArpObjectDsImplProviders {

	public static function arpObjectSetProvider():Iterable<Array<Dynamic>> {
		return [
			[new ArpObjectSetProvider<MockArpObject>(), new ArpDsTestDomain()]
		];
	}

	public static function arpObjectListProvider():Iterable<Array<Dynamic>> {
		return [
			[new ArpObjectListProvider<MockArpObject>(), new ArpDsTestDomain()]
		];
	}

	public static function arpObjectMapProvider():Iterable<Array<Dynamic>> {
		return [
			[new ArpObjectMapProvider<String, MockArpObject>(), new DsStringFixture(), new ArpDsTestDomain()]
		];
	}

	public static function arpObjectOmapProvider():Iterable<Array<Dynamic>> {
		return [
			[new ArpObjectOmapProvider<String, MockArpObject>(), new DsStringFixture(), new ArpDsTestDomain()]
		];
	}
}

typedef IArpObjectDsImplProvider<T> = {
	function create():T;
}

@:generic @:remove
class ArpObjectSetProvider<V:IArpObject> {
	public function new() {}
	public function create():ISet<V> return new ArpObjectSet<V>();
}

@:generic @:remove
class ArpObjectListProvider<V:IArpObject> {
	public function new() {}
	public function create():IList<V> return new ArpObjectList<V>();
}

@:generic @:remove
class ArpObjectMapProvider<K, V:IArpObject> {
	public function new() {}
	public function create():IMap<K, V> return new ArpObjectMap<K, V>();
}

@:generic @:remove
class ArpObjectOmapProvider<K, V:IArpObject> {
	public function new() {}
	public function create():IOmap<K, V> return new ArpObjectOmap<K, V>();
}
