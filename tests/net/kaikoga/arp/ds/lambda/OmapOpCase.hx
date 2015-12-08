package net.kaikoga.arp.ds.lambda;

import net.kaikoga.arp.ds.impl.StdOmap;
import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class OmapOpCase {

	private var me:IOmap<String, Int>;

	public function setup():Void {
		me = new StdOmap<String, Int>();
	}

	public function testToArray():Void {
		assertTrue(OmapOp.toArray(me) != null);
	}

}
