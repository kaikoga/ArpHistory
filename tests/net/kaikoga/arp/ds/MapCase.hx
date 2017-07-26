package net.kaikoga.arp.ds;

import net.kaikoga.arp.testFixtures.ArpSupportFixtures;
import net.kaikoga.arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class StringIntMapCase extends MapCase<String, Int> {
	@Parameter
	override public function setup(provider:IDsImplProvider<IMap<String, Int>>, keyFixture:IArpSupportFixture<String>, valueFixture:IArpSupportFixture<Int>):Void {
		super.setup(provider, keyFixture, valueFixture);
	}
}

class MapCase<K, V> {

	private var me:IMap<K, V>;
	private var k:IArpSupportFixture<K>;
	private var v:IArpSupportFixture<V>;

	@Parameter
	public function setup(provider:IDsImplProvider<IMap<K, V>>, keyFixture:IArpSupportFixture<K>, valueFixture:IArpSupportFixture<V>):Void {
		me = provider.create();
		k = keyFixture.create();
		v = valueFixture.create();
	}

	public function testEmpty():Void {
		assertTrue(me.isEmpty());
		assertFalse(me.hasKey(k.a1));
		assertFalse(me.hasKey(k.a2));
		assertFalse(me.hasValue(v.a1));
		assertFalse(me.hasValue(v.a2));
	}

	public function testEmptyRemove():Void {
		me.removeKey(k.a1);
		assertTrue(me.isEmpty());
		assertFalse(me.hasKey(k.a1));
		assertFalse(me.hasValue(v.a1));
		me.remove(v.a1);
		assertTrue(me.isEmpty());
		assertFalse(me.hasKey(k.a1));
		assertFalse(me.hasValue(v.a1));
		me.clear();
		assertTrue(me.isEmpty());
		assertFalse(me.hasKey(k.a1));
		assertFalse(me.hasValue(v.a1));
	}

	public function testAddUniquePair():Void {
		me.set(k.a1, v.a1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey(k.a1));
		assertFalse(me.hasKey(k.a2));
		assertFalse(me.hasKey(k.a3));
		assertTrue(me.hasValue(v.a1));
		assertFalse(me.hasValue(v.a2));
		assertFalse(me.hasValue(v.a3));
		me.set(k.a2, v.a2);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey(k.a1));
		assertTrue(me.hasKey(k.a2));
		assertFalse(me.hasKey(k.a3));
		assertTrue(me.hasValue(v.a1));
		assertTrue(me.hasValue(v.a2));
		assertFalse(me.hasValue(v.a3));
		me.set(k.a3, v.a3);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey(k.a1));
		assertTrue(me.hasKey(k.a2));
		assertTrue(me.hasKey(k.a3));
		assertTrue(me.hasValue(v.a1));
		assertTrue(me.hasValue(v.a2));
		assertTrue(me.hasValue(v.a3));
		me.removeKey(k.a1);
		assertFalse(me.isEmpty());
		assertFalse(me.hasKey(k.a1));
		assertTrue(me.hasKey(k.a2));
		assertTrue(me.hasKey(k.a3));
		assertFalse(me.hasValue(v.a1));
		assertTrue(me.hasValue(v.a2));
		assertTrue(me.hasValue(v.a3));
		me.remove(v.a2);
		assertFalse(me.isEmpty());
		assertFalse(me.hasKey(k.a1));
		assertFalse(me.hasKey(k.a2));
		assertTrue(me.hasKey(k.a3));
		assertFalse(me.hasValue(v.a1));
		assertFalse(me.hasValue(v.a2));
		assertTrue(me.hasValue(v.a3));
		me.clear();
		assertTrue(me.isEmpty());
		assertFalse(me.hasKey(k.a1));
		assertFalse(me.hasKey(k.a2));
		assertFalse(me.hasKey(k.a3));
		assertFalse(me.hasValue(v.a1));
		assertFalse(me.hasValue(v.a2));
		assertFalse(me.hasValue(v.a3));
	}

	public function testAddNoDuplicateKey():Void {
		me.set(k.a1, v.a1);
		me.set(k.a1, v.a2);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey(k.a1));
		assertFalse(me.hasValue(v.a1));
		assertTrue(me.hasValue(v.a2));
		me.remove(v.a1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey(k.a1));
		assertFalse(me.hasValue(v.a1));
		assertTrue(me.hasValue(v.a2));
		me.remove(v.a2);
		assertTrue(me.isEmpty());
		assertFalse(me.hasKey(k.a1));
		assertFalse(me.hasValue(v.a1));
		assertFalse(me.hasValue(v.a2));
	}

	public function testAddDuplicateValue():Void {
		me.set(k.a1, v.a1);
		me.set(k.a2, v.a1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey(k.a1));
		assertTrue(me.hasKey(k.a2));
		assertTrue(me.hasValue(v.a1));
		me.removeKey(k.a1);
		assertFalse(me.isEmpty());
		assertFalse(me.hasKey(k.a1));
		assertTrue(me.hasKey(k.a2));
		assertTrue(me.hasValue(v.a1));
		me.removeKey(k.a2);
		assertTrue(me.isEmpty());
		assertFalse(me.hasKey(k.a1));
		assertFalse(me.hasKey(k.a2));
		assertFalse(me.hasValue(v.a1));
	}

	public function testEmptyKeys():Void {
		var it:Iterator<K> = me.keys();
		assertNotEquals(null, it);
		assertFalse(it.hasNext());
	}

	public function testEmptyIterator():Void {
		var it:Iterator<V> = me.iterator();
		assertNotEquals(null, it);
		assertFalse(it.hasNext());
	}

	public function testUnorderedKeys():Void {
		me.set(k.a1, v.a1);
		me.set(k.a2, v.a2);
		me.set(k.a3, v.a3);
		me.set(k.a4, v.a4);
		me.set(k.a5, v.a5);
		me.removeKey(k.a2);
		me.remove(v.a4);
		var it:Iterator<K> = me.keys();
		var a:Array<K> = [];
		assertNotEquals(null, it);
		assertTrue(it.hasNext());
		a.push(it.next());
		assertTrue(it.hasNext());
		a.push(it.next());
		assertTrue(it.hasNext());
		a.push(it.next());
		assertFalse(it.hasNext());
		var km:ArpSupportFixtureMatchers<K> = k;
		assertMatch(containsInAnyOrder(km.a1, km.a3, km.a5), a);
	}

	public function testUnorderedIterator():Void {
		me.set(k.a1, v.a1);
		me.set(k.a2, v.a2);
		me.set(k.a3, v.a3);
		me.set(k.a4, v.a4);
		me.set(k.a5, v.a5);
		me.removeKey(k.a2);
		me.remove(v.a4);
		var it:Iterator<V> = me.iterator();
		var a:Array<V> = [];
		assertNotEquals(null, it);
		assertTrue(it.hasNext());
		a.push(it.next());
		assertTrue(it.hasNext());
		a.push(it.next());
		assertTrue(it.hasNext());
		a.push(it.next());
		assertFalse(it.hasNext());
		var vm:ArpSupportFixtureMatchers<V> = v;
		assertMatch(containsInAnyOrder(vm.a1, vm.a3, vm.a5), a);
	}

	public function testKnit():Void {
		me.set(k.a1, v.a1);
		assertMatch([k.a1], [for (p in me.knit()) p.key()]);
		assertMatch([v.a1], [for (p in me.knit()) p.value()]);
		for (p in me.knit()) p.insert(k.a2, v.a2);
		assertMatch(containsInAnyOrder(true, false), [for (p in me.knit()) (p.value() == v.a1) && p.remove()]);
		assertMatch([k.a2], [for (p in me.knit()) p.key()]);
		assertMatch([v.a2], [for (p in me.knit()) p.value()]);
	}

	public function testEmptyToString():Void {
		assertEquals("{}", me.toString());
	}

	public function testToString():Void {
		me.set(k.a1, v.a1);
		me.set(k.a2, v.a2);
		me.set(k.a3, v.a3);
		me.set(k.a4, v.a4);
		me.set(k.a5, v.a5);
		me.removeKey(k.a2);
		me.remove(v.a4);
		var string:String = me.toString();
		string = string.substr(1, string.length - 2);
		assertMatch(containsInAnyOrder('${k.a1} => ${v.a1}', '${k.a3} => ${v.a3}', '${k.a5} => ${v.a5}'), string.split(", "));
	}
}
