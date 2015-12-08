package net.kaikoga.arp.ds.lambda;

import net.kaikoga.arp.ds.impl.ArrayList;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class ListOpCase<Int> {

	private var me:IList<Int>;

	@Parameter
	public function setup(createImpl:Void->IList<Int>):Void {
		me = createImpl();
	}

	public function testToArray():Void {
		assertTrue(ListOp.toArray(me) != null);
	}

}
