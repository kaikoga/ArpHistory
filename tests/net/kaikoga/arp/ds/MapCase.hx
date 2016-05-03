package net.kaikoga.arp.ds;

import net.kaikoga.arp.testFixtures.ArpSupportFixtures.IArpSupportFixture;
import net.kaikoga.arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class MapCase {

	private var me:IMap<String, Int>;

	@Parameter
	public function setup(provider:IDsImplProvider<IMap<String, Int>>, keyFixture:IArpSupportFixture<String>, valueFixture:IArpSupportFixture<Int>):Void {
		me = provider.create();
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
		me.set("1", 1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey("1"));
		assertFalse(me.hasKey("2"));
		assertFalse(me.hasKey("3"));
		assertTrue(me.hasValue(1));
		assertFalse(me.hasValue(2));
		assertFalse(me.hasValue(3));
		me.set("2", 2);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey("1"));
		assertTrue(me.hasKey("2"));
		assertFalse(me.hasKey("3"));
		assertTrue(me.hasValue(1));
		assertTrue(me.hasValue(2));
		assertFalse(me.hasValue(3));
		me.set("3", 3);
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
		me.set("1", 1);
		me.set("1", 2);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey("1"));
		assertFalse(me.hasValue(1));
		assertTrue(me.hasValue(2));
		me.remove(1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey("1"));
		assertFalse(me.hasValue(1));
		assertTrue(me.hasValue(2));
		me.remove(2);
		assertTrue(me.isEmpty());
		assertFalse(me.hasKey("1"));
		assertFalse(me.hasValue(1));
		assertFalse(me.hasValue(2));
	}

	public function testAddDuplicateValue():Void {
		me.set("1", 1);
		me.set("2", 1);
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

	public function testUnorderedKeys():Void {
		me.set("1", 1);
		me.set("2", 2);
		me.set("3", 3);
		me.set("4", 4);
		me.set("5", 5);
		me.removeKey("2");
		me.remove(4);
		var it:Iterator<String> = me.keys();
		var a:Array<String> = [];
		assertNotEquals(null, it);
		assertTrue(it.hasNext());
		a.push(it.next());
		assertTrue(it.hasNext());
		a.push(it.next());
		assertTrue(it.hasNext());
		a.push(it.next());
		assertFalse(it.hasNext());
		assertMatch(containsInAnyOrder("1", "3", "5"), a);
	}

	public function testUnorderedIterator():Void {
		me.set("1", 1);
		me.set("2", 2);
		me.set("3", 3);
		me.set("4", 4);
		me.set("5", 5);
		me.removeKey("2");
		me.remove(4);
		var it:Iterator<Int> = me.iterator();
		var a:Array<Int> = [];
		assertNotEquals(null, it);
		assertTrue(it.hasNext());
		a.push(it.next());
		assertTrue(it.hasNext());
		a.push(it.next());
		assertTrue(it.hasNext());
		a.push(it.next());
		assertFalse(it.hasNext());
		assertMatch(containsInAnyOrder(1, 3, 5), a);
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
		var string:String = me.toString();
		string = string.substr(1, string.length - 2);
		assertMatch(containsInAnyOrder("1 => 1", "3 => 3", "5 => 5"), string.split(", "));
	}
}
