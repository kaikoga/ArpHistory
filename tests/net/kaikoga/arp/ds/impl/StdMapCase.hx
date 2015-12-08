package net.kaikoga.arp.ds.impl;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class StdMapCase {

	private var me:StdMap<String, Int>;

	public function setup():Void {
		me = new StdMap<String, Int>();
	}

	public function testEmptyToString():Void {
		assertEquals("{}", me.toString());
	}

	public function testToString():Void {
		me.set("1", 1);
		me.set("2", 2);
		me.set("3", 3);
		me.set("4", 4);
		me.set("5", 5);
		me.removeKey("2");
		me.remove(4);
		assertEquals("{1 => 1, 3 => 3, 5 => 5}", me.toString());
	}
}
