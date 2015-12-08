package net.kaikoga.arp.ds.lambda;

import net.kaikoga.arp.ds.impl.ArraySet;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class SetOpCase {

	private var me:ISet<Int>;

	@Parameter
	public function setup(createImpl:Void->ISet<Int>):Void {
		me = createImpl();
	}

	public function testToArray():Void {
		assertTrue(SetOp.toArray(me) != null);
	}

}
