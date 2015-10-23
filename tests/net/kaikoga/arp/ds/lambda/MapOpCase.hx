package net.kaikoga.arp.ds.lambda;

import net.kaikoga.arp.ds.impl.StdMap;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class MapOpCase {

	private var me:IMap<String, Int>;

	public function setup():Void {
		me = new StdMap<String, Int>();
	}

	public function testToArray():Void {
		assertTrue(MapOp.toArray(me) != null);
	}

}
