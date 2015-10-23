package net.kaikoga.arp.ds.impl;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class ArraySetCase {

	private var me:ArraySet<Int>;

	public function setup():Void {
		me = new ArraySet<Int>();
 	}

	public function testEmpty():Void {
		assertTrue(me.isEmpty());
		assertFalse(me.hasValue(1));
	}

	public function testEmptyRemove():Void {
		me.remove(1);
		assertTrue(me.isEmpty());
		assertFalse(me.hasValue(1));
		me.clear();
		assertTrue(me.isEmpty());
		assertFalse(me.hasValue(1));
	}

	public function testAddUniqueValue():Void {
		me.add(1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasValue(1));
		assertFalse(me.hasValue(2));
		me.add(2);
		assertFalse(me.isEmpty());
		assertTrue(me.hasValue(1));
		assertTrue(me.hasValue(2));
		me.remove(1);
		assertFalse(me.isEmpty());
		assertFalse(me.hasValue(1));
		assertTrue(me.hasValue(2));
		me.clear();
		assertTrue(me.isEmpty());
		assertFalse(me.hasValue(1));
		assertFalse(me.hasValue(2));
	}

	public function testAddNoDuplicateValue():Void {
		me.add(1);
		me.add(1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasValue(1));
		me.remove(1);
		assertTrue(me.isEmpty());
		assertFalse(me.hasValue(1));
	}

	public function testEmptyIterator():Void {
		var it:Iterator<Int> = me.iterator();
		assertNotEquals(null, it);
		assertFalse(it.hasNext());
	}

	public function testUnorderedIterator():Void {
		me.add(1);
		me.add(2);
		me.add(3);
		me.add(4);
		me.add(5);
		me.remove(3);
		var it:Iterator<Int> = me.iterator();
		var a:Array<Int> = [];
		assertNotEquals(null, it);
		assertTrue(it.hasNext());
		a.push(it.next());
		assertTrue(it.hasNext());
		a.push(it.next());
		assertTrue(it.hasNext());
		a.push(it.next());
		assertTrue(it.hasNext());
		a.push(it.next());
		assertFalse(it.hasNext());
		assertMatch([1, 2, 4, 5], a);
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
