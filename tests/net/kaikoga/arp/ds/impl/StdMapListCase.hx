package net.kaikoga.arp.ds.impl;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class StdMapListCase {

	private var me:StdMapList<String, Int>;

	private function values():Array<Int> return [for (v in me) v];

	public function setup():Void {
		me = new StdMapList<String, Int>();
	}

	public function testEmpty():Void {
		assertTrue(me.isEmpty());
		assertFalse(me.hasKey("1"));
		assertFalse(me.hasKey("2"));
		assertFalse(me.hasValue(1));
		assertFalse(me.hasValue(2));
	}

	public function testEmptyRemove():Void {
		me.removeKey("1");
		assertTrue(me.isEmpty());
		assertFalse(me.hasKey("1"));
		assertFalse(me.hasValue(1));
		me.remove(1);
		assertTrue(me.isEmpty());
		assertFalse(me.hasKey("1"));
		assertFalse(me.hasValue(1));
		me.clear();
		assertTrue(me.isEmpty());
		assertFalse(me.hasKey("1"));
		assertFalse(me.hasValue(1));
	}

	public function testAddUniquePair():Void {
		me.addPair("1", 1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey("1"));
		assertFalse(me.hasKey("2"));
		assertFalse(me.hasKey("3"));
		assertTrue(me.hasValue(1));
		assertFalse(me.hasValue(2));
		assertFalse(me.hasValue(3));
		me.addPair("2", 2);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey("1"));
		assertTrue(me.hasKey("2"));
		assertFalse(me.hasKey("3"));
		assertTrue(me.hasValue(1));
		assertTrue(me.hasValue(2));
		assertFalse(me.hasValue(3));
		me.addPair("3", 3);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey("1"));
		assertTrue(me.hasKey("2"));
		assertTrue(me.hasKey("3"));
		assertTrue(me.hasValue(1));
		assertTrue(me.hasValue(2));
		assertTrue(me.hasValue(3));
		me.removeKey("1");
		assertFalse(me.isEmpty());
		assertFalse(me.hasKey("1"));
		assertTrue(me.hasKey("2"));
		assertTrue(me.hasKey("3"));
		assertFalse(me.hasValue(1));
		assertTrue(me.hasValue(2));
		assertTrue(me.hasValue(3));
		me.remove(2);
		assertFalse(me.isEmpty());
		assertFalse(me.hasKey("1"));
		assertFalse(me.hasKey("2"));
		assertTrue(me.hasKey("3"));
		assertFalse(me.hasValue(1));
		assertFalse(me.hasValue(2));
		assertTrue(me.hasValue(3));
		me.clear();
		assertTrue(me.isEmpty());
		assertFalse(me.hasKey("1"));
		assertFalse(me.hasKey("2"));
		assertFalse(me.hasKey("3"));
		assertFalse(me.hasValue(1));
		assertFalse(me.hasValue(2));
		assertFalse(me.hasValue(3));
	}

	public function testAddNoDuplicateKey():Void {
		me.addPair("1", 1);
		me.addPair("1", 2);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey("1"));
		assertFalse(me.hasValue(1));
		assertTrue(me.hasValue(2));
		me.remove(1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey("1"));
		assertFalse(me.hasValue(1));
		assertTrue(me.hasValue(2));
		assertEquals(1, me.length);
		me.remove(2);
		assertTrue(me.isEmpty());
		assertFalse(me.hasKey("1"));
		assertFalse(me.hasValue(1));
		assertFalse(me.hasValue(2));
		assertEquals(0, me.length);
	}

	public function testAddDuplicateValue():Void {
		me.addPair("1", 1);
		me.addPair("2", 1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey("1"));
		assertTrue(me.hasKey("2"));
		assertTrue(me.hasValue(1));
		me.removeKey("1");
		assertFalse(me.isEmpty());
		assertFalse(me.hasKey("1"));
		assertTrue(me.hasKey("2"));
		assertTrue(me.hasValue(1));
		me.removeKey("2");
		assertTrue(me.isEmpty());
		assertFalse(me.hasKey("1"));
		assertFalse(me.hasKey("2"));
		assertFalse(me.hasValue(1));
	}

	public function testEmptyKeys():Void {
		var it:Iterator<String> = me.keys();
		assertNotEquals(null, it);
		assertFalse(it.hasNext());
	}

	public function testEmptyIterator():Void {
		var it:Iterator<Int> = me.iterator();
		assertNotEquals(null, it);
		assertFalse(it.hasNext());
	}

	public function testOrderedKeys():Void {
		me.addPair("1", 1);
		assertMatch(["1"], [for (v in me.keys()) v]);
		me.addPair("2", 2);
		assertMatch(["1", "2"], [for (v in me.keys()) v]);
		me.addPair("3", 3);
		assertMatch(["1", "2", "3"], [for (v in me.keys()) v]);
		me.addPair("4", 4);
		assertMatch(["1", "2", "3", "4"], [for (v in me.keys()) v]);
		me.insertPairAt(0, "5", 5);
		assertMatch(["5", "1", "2", "3", "4"], [for (v in me.keys()) v]);
		me.removeKey("2");
		assertMatch(["5", "1", "3", "4"], [for (v in me.keys()) v]);
		me.remove(4);
		assertMatch(["5", "1", "3"], [for (v in me.keys()) v]);
		me.removeAt(1);
		assertMatch(["5", "3"], [for (v in me.keys()) v]);

		var it:Iterator<String> = me.keys();
		var a:Array<String> = [];
		assertNotEquals(null, it);
		assertTrue(it.hasNext());
		a.push(it.next());
		assertTrue(it.hasNext());
		a.push(it.next());
		assertFalse(it.hasNext());
		assertMatch(["5", "3"], a);
	}

	public function testOrderedIterator():Void {
		me.addPair("1", 1);
		assertMatch([1], [for (v in me) v]);
		me.addPair("2", 2);
		assertMatch([1, 2], [for (v in me) v]);
		me.addPair("3", 3);
		assertMatch([1, 2, 3], [for (v in me) v]);
		me.addPair("4", 4);
		assertMatch([1, 2, 3, 4], [for (v in me) v]);
		me.insertPairAt(0, "5", 5);
		assertMatch([5, 1, 2, 3, 4], [for (v in me) v]);
		me.removeKey("2");
		assertMatch([5, 1, 3, 4], [for (v in me) v]);
		me.remove(4);
		assertMatch([5, 1, 3], [for (v in me) v]);
		me.removeAt(1);
		assertMatch([5, 3], [for (v in me) v]);

		var it:Iterator<Int> = me.iterator();
		var a:Array<Int> = [];
		assertNotEquals(null, it);
		assertTrue(it.hasNext());
		a.push(it.next());
		assertTrue(it.hasNext());
		a.push(it.next());
		assertFalse(it.hasNext());
		assertMatch([5, 3], a);
	}

	public function testIndexOf():Void {
		me.addPair("1", 1);
		me.addPair("2", 2);
		assertMatch(0, me.indexOf(1));
		assertMatch(1, me.indexOf(2));
		assertMatch(-1, me.indexOf(3));
	}

	public function testResolveKeyIndex():Void {
		me.addPair("1", 1);
		me.addPair("2", 2);
		assertMatch(0, me.resolveKeyIndex("1"));
		assertMatch(1, me.resolveKeyIndex("2"));
		assertMatch(-1, me.resolveKeyIndex("3"));

	}

	public function testResolveName():Void {
		me.addPair("1", 1);
		me.addPair("2", 2);
		assertMatch("1", me.resolveName(1));
		assertMatch("2", me.resolveName(2));
		assertMatch(null, me.resolveName(3));
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
		assertEquals("{3 => 3, 5 => 5}", me.toString());
	}
}
