package net.kaikoga.arp.ds.lambda;

import net.kaikoga.arp.ds.impl.StdOmap;
import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class OmapOpCase<String, Int> {

	private var me:IOmap<String, Int>;

	@Parameter
	public function setup(createImpl:Void->IOmap<String, Int>):Void {
		me = createImpl();
	}

	public function testToArray():Void {
		assertTrue(OmapOp.toArray(me) != null);
	}

}
