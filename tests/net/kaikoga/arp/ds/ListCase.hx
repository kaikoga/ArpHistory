package net.kaikoga.arp.ds;

import net.kaikoga.arp.testFixtures.ArpSupportFixtures.IArpSupportFixture;
import net.kaikoga.arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class IntListCase extends ListCase<Int> {
	@Parameter
	override public function setup(provider:IDsImplProvider<IList<Int>>, valueFixture:IArpSupportFixture<Int>):Void {
		super.setup(provider, valueFixture);
	}
}

class ListCase<V> {

	private var me:IList<V>;
	private var v:IArpSupportFixture<V>;

	@Parameter
	public function setup(provider:IDsImplProvider<IList<V>>, valueFixture:IArpSupportFixture<V>):Void {
		me = provider.create();
		v = valueFixture;
	}

	public function testEmpty():Void {
		assertTrue(me.isEmpty());
		assertFalse(me.hasValue(v.a1));
	}

	public function testEmptyRemove():Void {
		me.remove(v.a1);
		assertTrue(me.isEmpty());
		assertFalse(me.hasValue(v.a1));
		me.clear();
		assertTrue(me.isEmpty());
		assertFalse(me.hasValue(v.a1));
	}

	public function testAddUniqueValue():Void {
		me.push(v.a1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasValue(v.a1));
		assertFalse(me.hasValue(v.a2));
		me.push(v.a2);
		assertFalse(me.isEmpty());
		assertTrue(me.hasValue(v.a1));
		assertTrue(me.hasValue(v.a2));
		me.remove(v.a1);
		assertFalse(me.isEmpty());
		assertFalse(me.hasValue(v.a1));
		assertTrue(me.hasValue(v.a2));
		me.clear();
		assertTrue(me.isEmpty());
		assertFalse(me.hasValue(v.a1));
		assertFalse(me.hasValue(v.a2));
	}

	public function testAddDuplicateValue():Void {
		me.push(v.a1);
		me.push(v.a1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasValue(v.a1));
		me.remove(v.a1);
		if (me.isUniqueValue) {
			assertTrue(me.isEmpty());
			assertFalse(me.hasValue(v.a1));
		} else {
			assertFalse(me.isEmpty());
			assertTrue(me.hasValue(v.a1));
		}
	}

	public function testEmptyIterator():Void {
		var it:Iterator<V> = me.iterator();
		assertNotEquals(null, it);
		assertFalse(it.hasNext());
	}

	public function testOrderedIterator():Void {
		me.push(v.a1);
		me.push(v.a2);
		me.push(v.a3);
		me.push(v.a4);
		me.shift();
		me.unshift(v.a5);
		me.remove(v.a3);
		var it:Iterator<V> = me.iterator();
		var a:Array<V> = [];
		assertNotEquals(null, it);
		assertTrue(it.hasNext());
		assertEquals(v.a5, it.next());
		assertTrue(it.hasNext());
		assertEquals(v.a2, it.next());
		assertTrue(it.hasNext());
		assertEquals(v.a4, it.next());
		assertFalse(it.hasNext());
	}

	public function testEmptyToString():Void {
		assertEquals("[]", me.toString());
	}

	public function testToString():Void {
		me.push(v.a1);
		me.push(v.a2);
		me.push(v.a3);
		me.push(v.a4);
		me.shift();
		me.unshift(v.a5);
		me.remove(v.a3);
		assertEquals('[${v.a5}; ${v.a2}; ${v.a4}]', me.toString());
	}
}
