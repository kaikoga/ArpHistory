package net.kaikoga.arp.ds.proxy;

import net.kaikoga.arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class MapProxyCase {

	private var me:IMap<Int, String>;
	private var provider:IDsImplProvider<IMap<String, Int>>;

	private function length():Int return [for (v in me) v].length;

	private function source():IMap<String, Int> {
		var a:IMap<String, Int> = provider.create();
		a.set("[1]", 4900);
		a.set("[3]", 5000);
		a.set("[5]", 5100);
		a.set("[7]", 5200);
		return a;
	}

	@Parameter
	public function setup(provider:IDsImplProvider<IMap<String, Int>>):Void {
		this.provider = provider;
		me = new MapProxy(source(), ProxyCaseUtil.proxyString, ProxyCaseUtil.unproxyString, ProxyCaseUtil.proxyInt, ProxyCaseUtil.unproxyInt);
	}

	public function testProxy():Void {
		assertEquals(4, length());
		assertEquals("1", me.get(1));
		assertEquals("2", me.get(3));
		assertEquals("3", me.get(5));
		assertEquals("4", me.get(7));
		assertEquals(1, me.resolveName("1"));
		assertEquals(3, me.resolveName("2"));
		assertEquals(5, me.resolveName("3"));
		assertEquals(7, me.resolveName("4"));
	}

}
