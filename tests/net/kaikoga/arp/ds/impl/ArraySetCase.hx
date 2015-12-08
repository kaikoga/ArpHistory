package net.kaikoga.arp.ds.impl;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class ArraySetCase {

	private var me:ArraySet<Int>;

	public function setup():Void {
		me = new ArraySet<Int>();
	}

	public function testEmptyToString():Void {
		assertEquals("", me.toString());
	}

	public function testToString():Void {
		me.add(1);
		me.add(2);
		me.add(3);
		me.add(4);
		me.add(5);
		me.remove(3);
		assertEquals("1,2,4,5", me.toString());
	}

}
