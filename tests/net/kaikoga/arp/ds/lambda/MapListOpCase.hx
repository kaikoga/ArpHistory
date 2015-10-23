package net.kaikoga.arp.ds.lambda;

import net.kaikoga.arp.ds.impl.StdMapList;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class MapListOpCase {

	private var me:IMapList<String, Int>;

	public function setup():Void {
		me = new StdMapList<String, Int>();
	}

	public function testToArray():Void {
		assertTrue(MapListOp.toArray(me) != null);
	}

}
