package net.kaikoga.arp.ds.impl;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class StdOmapCase {

	private var me:StdOmap<String, Int>;

	public function setup():Void {
		me = new StdOmap<String, Int>();
	}

	public function testEmptyToString():Void {
		assertEquals("{}", me.toString());
	}

	public function testToString():Void {
		me.addPair("1", 1);
		me.addPair("2", 2);
		me.addPair("3", 3);
		me.addPair("4", 4);
		me.insertPairAt(0, "5", 5);
		me.removeKey("2");
		me.remove(4);
		me.removeAt(1);
		assertEquals("{5 => 5; 3 => 3}", me.toString());
	}
}
