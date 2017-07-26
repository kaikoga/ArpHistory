package net.kaikoga.arp.ds;

import net.kaikoga.arp.testFixtures.ArpSupportFixtures;
import net.kaikoga.arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class IntSetCase extends SetCase<Int> {
	@Parameter
	override public function setup(provider:IDsImplProvider<ISet<Int>>, valueFixture:IArpSupportFixture<Int>):Void {
		super.setup(provider, valueFixture);
	}
}

class SetCase<V> {

	private var me:ISet<V>;
	private var v:IArpSupportFixture<V>;

	@Parameter
	public function setup(provider:IDsImplProvider<ISet<V>>, valueFixture:IArpSupportFixture<V>):Void {
		me = provider.create();
		v = valueFixture.create();
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
		me.add(v.a1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasValue(v.a1));
		assertFalse(me.hasValue(v.a2));
		me.add(v.a2);
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
		me.add(v.a1);
		me.add(v.a1);
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

	public function testUnorderedIterator():Void {
		me.add(v.a1);
		me.add(v.a2);
		me.add(v.a3);
		me.add(v.a4);
		me.add(v.a5);
		me.remove(v.a3);
		var it:Iterator<V> = me.iterator();
		var a:Array<V> = [];
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
		var vm:ArpSupportFixtureMatchers<V> = v;
		assertMatch(containsInAnyOrder(vm.a1, vm.a2, vm.a4, vm.a5), a);
	}

	public function testKnit():Void {
		me.add(v.a1);
		assertMatch([v.a1], [for (p in me.knit()) p.value()]);
		for (p in me.knit()) p.insert(v.a2);
		assertMatch(containsInAnyOrder(true, false), [for (p in me.knit()) (p.value() == v.a1) && p.remove()]);
		assertMatch([v.a2], [for (p in me.knit()) p.value()]);
	}

	public function testEmptyToString():Void {
		assertEquals("[]", me.toString());
	}

	public function testToString():Void {
		me.add(v.a1);
		me.add(v.a2);
		me.add(v.a3);
		me.add(v.a4);
		me.add(v.a5);
		me.remove(v.a3);
		var string:String = me.toString();
		string = string.substr(1, string.length - 2);
		assertMatch(containsInAnyOrder('${v.a1}', '${v.a2}', '${v.a4}', '${v.a5}'), string.split(", "));
	}

}
