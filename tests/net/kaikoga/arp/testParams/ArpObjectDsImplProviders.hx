package net.kaikoga.arp.testParams;

import net.kaikoga.arp.domain.ArpDomain;
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
		var domain1:ArpDomain = new ArpDsTestDomain(false);
		var domain2:ArpDomain = new ArpDsTestDomain(true);
		return [
			[new ArpObjectSetProvider<MockArpObject>(domain1), domain1],
			[new ArpObjectSetProvider<MockArpObject>(domain2), domain2]
		];
	}

	public static function arpObjectListProvider():Iterable<Array<Dynamic>> {
		var domain1:ArpDomain = new ArpDsTestDomain(false);
		var domain2:ArpDomain = new ArpDsTestDomain(true);
		return [
			[new ArpObjectListProvider<MockArpObject>(domain1), domain1],
			[new ArpObjectListProvider<MockArpObject>(domain2), domain2]
		];
	}

	public static function arpObjectMapProvider():Iterable<Array<Dynamic>> {
		var domain1:ArpDomain = new ArpDsTestDomain(false);
		var domain2:ArpDomain = new ArpDsTestDomain(true);
		return [
			[new ArpObjectMapProvider<String, MockArpObject>(domain1), new DsStringFixture(), domain1],
			[new ArpObjectMapProvider<String, MockArpObject>(domain2), new DsStringFixture(), domain2]
		];
	}

	public static function arpObjectOmapProvider():Iterable<Array<Dynamic>> {
		var domain1:ArpDomain = new ArpDsTestDomain(false);
		var domain2:ArpDomain = new ArpDsTestDomain(true);
		return [
			[new ArpObjectOmapProvider<String, MockArpObject>(domain1), new DsStringFixture(), domain2],
			[new ArpObjectOmapProvider<String, MockArpObject>(domain2), new DsStringFixture(), domain2]
		];
	}
}

typedef IArpObjectDsImplProvider<T> = {
	function create():T;
}

@:generic @:remove
class ArpObjectSetProvider<V:IArpObject> {
	private var domain:ArpDomain;
	public function new(domain:ArpDomain) this.domain = domain;
	public function create():ISet<V> return new ArpObjectSet<V>(this.domain);
}

@:generic @:remove
class ArpObjectListProvider<V:IArpObject> {
	private var domain:ArpDomain;
	public function new(domain:ArpDomain) this.domain = domain;
	public function create():IList<V> return new ArpObjectList<V>(this.domain);
}

@:generic @:remove
class ArpObjectMapProvider<K, V:IArpObject> {
	private var domain:ArpDomain;
	public function new(domain:ArpDomain) this.domain = domain;
	public function create():IMap<K, V> return new ArpObjectMap<K, V>(this.domain);
}

@:generic @:remove
class ArpObjectOmapProvider<K, V:IArpObject> {
	private var domain:ArpDomain;
	public function new(domain:ArpDomain) this.domain = domain;
	public function create():IOmap<K, V> return new ArpObjectOmap<K, V>(this.domain);
}
