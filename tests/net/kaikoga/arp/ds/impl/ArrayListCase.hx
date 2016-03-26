package net.kaikoga.arp.ds.impl;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class ArrayListCase {

	private var me:ArrayList<Int>;

	public function setup():Void {
		me = new ArrayList<Int>();
	}

	public function testEmptyToString():Void {
		assertEquals("[]", me.toString());
	}

	public function testToString():Void {
		me.push(1);
		me.push(2);
		me.push(3);
		me.push(4);
		me.shift();
		me.unshift(5);
		me.remove(3);
		assertEquals("[5; 2; 4]", me.toString());
	}
}
