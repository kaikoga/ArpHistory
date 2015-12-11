package net.kaikoga.arp.ds.lambda;

import net.kaikoga.arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class MapOpCase {

	private var me:IMap<String, Int>;

	@Parameter
	public function setup(provider:IDsImplProvider<IMap<String, Int>>):Void {
		me = provider.create();
	}

	public function testToArray():Void {
		assertTrue(MapOp.toArray(me) != null);
	}

}
