package net.kaikoga.arp.ds.impl;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class StdMapSetCase {

	private var me:StdMapSet<Int>;

	public function setup():Void {
		me = new StdMapSet<Int>();
	}

	public function testEmptyToString():Void {
		assertEquals("{}", me.toString());
	}

	public function testToString():Void {
		me.add(1);
		me.add(2);
		me.add(3);
		me.add(4);
		me.add(5);
		me.remove(3);
		assertEquals("{1 => true, 2 => true, 4 => true, 5 => true}", me.toString());
	}

}
