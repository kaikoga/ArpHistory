package net.kaikoga.arp.ds.lambda;

import net.kaikoga.arp.ds.impl.ArraySet;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class SetOpCase {

	private var me:ISet<Int>;

	public function setup():Void {
		me = new ArraySet<Int>();
	}

	public function testToArray():Void {
		assertTrue(SetOp.toArray(me) != null);
	}

}
