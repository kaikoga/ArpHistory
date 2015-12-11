package net.kaikoga.arp.ds;

import net.kaikoga.arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class ListCase {

	private var me:IList<Int>;

	@Parameter
	public function setup(provider:IDsImplProvider<IList<Int>>):Void {
		me = provider.create();
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
		me.push(1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasValue(1));
		assertFalse(me.hasValue(2));
		me.push(2);
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

	public function testAddDuplicateValue():Void {
		me.push(1);
		me.push(1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasValue(1));
		me.remove(1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasValue(1));
	}

	public function testEmptyIterator():Void {
		var it:Iterator<Int> = me.iterator();
		assertNotEquals(null, it);
		assertFalse(it.hasNext());
	}

	public function testOrderedIterator():Void {
		me.push(1);
		me.push(2);
		me.push(3);
		me.push(4);
		me.shift();
		me.unshift(5);
		me.remove(3);
		var it:Iterator<Int> = me.iterator();
		var a:Array<Int> = [];
		assertNotEquals(null, it);
		assertTrue(it.hasNext());
		assertEquals(5, it.next());
		assertTrue(it.hasNext());
		assertEquals(2, it.next());
		assertTrue(it.hasNext());
		assertEquals(4, it.next());
		assertFalse(it.hasNext());
	}

}
