package net.kaikoga.arp.ds.lambda;

import net.kaikoga.arp.ds.impl.StdMap;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

@:generic
class MapOpCase<String, Int> {

	private var me:IMap<String, Int>;

	@Parameter
	public function setup(createImpl:Void->IMap<String, Int>):Void {
		me = createImpl();
	}

	public function testToArray():Void {
		assertTrue(MapOp.toArray(me) != null);
	}

}
