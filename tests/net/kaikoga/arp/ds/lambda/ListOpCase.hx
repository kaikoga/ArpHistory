package net.kaikoga.arp.ds.lambda;

import net.kaikoga.arp.ds.impl.ArrayList;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class ListOpCase {

	private var me:IList<Int>;

	public function setup():Void {
		me = new ArrayList<Int>();
	}

	public function testToArray():Void {
		assertTrue(ListOp.toArray(me) != null);
	}

}
