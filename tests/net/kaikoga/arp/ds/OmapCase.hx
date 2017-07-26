package net.kaikoga.arp.ds;

import net.kaikoga.arp.testFixtures.ArpSupportFixtures.IArpSupportFixture;
import net.kaikoga.arp.testParams.DsImplProviders.IDsImplProvider;

import org.hamcrest.Matchers.*;

import picotest.PicoAssert.*;

class StringIntOmapCase extends OmapCase<String, Int> {
	@Parameter
	override public function setup(provider:IDsImplProvider<IOmap<String, Int>>, keyFixture:IArpSupportFixture<String>, valueFixture:IArpSupportFixture<Int>):Void {
		super.setup(provider, keyFixture, valueFixture);
	}
}

class OmapCase<K, V> {

	private var me:IOmap<K, V>;
	private var k:IArpSupportFixture<K>;
	private var v:IArpSupportFixture<V>;

	@Parameter
	public function setup(provider:IDsImplProvider<IOmap<K, V>>, keyFixture:IArpSupportFixture<K>, valueFixture:IArpSupportFixture<V>):Void {
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
		me.addPair(k.a1, v.a1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey(k.a1));
		assertFalse(me.hasKey(k.a2));
		assertFalse(me.hasKey(k.a3));
		assertTrue(me.hasValue(v.a1));
		assertFalse(me.hasValue(v.a2));
		assertFalse(me.hasValue(v.a3));
		me.addPair(k.a2, v.a2);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey(k.a1));
		assertTrue(me.hasKey(k.a2));
		assertFalse(me.hasKey(k.a3));
		assertTrue(me.hasValue(v.a1));
		assertTrue(me.hasValue(v.a2));
		assertFalse(me.hasValue(v.a3));
		me.addPair(k.a3, v.a3);
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
		me.addPair(k.a1, v.a1);
		me.addPair(k.a1, v.a2);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey(k.a1));
		assertFalse(me.hasValue(v.a1));
		assertTrue(me.hasValue(v.a2));
		me.remove(v.a1);
		assertFalse(me.isEmpty());
		assertTrue(me.hasKey(k.a1));
		assertFalse(me.hasValue(v.a1));
		assertTrue(me.hasValue(v.a2));
		assertEquals(1, me.length);
		me.remove(v.a2);
		assertTrue(me.isEmpty());
		assertFalse(me.hasKey(k.a1));
		assertFalse(me.hasValue(v.a1));
		assertFalse(me.hasValue(v.a2));
		assertEquals(0, me.length);
	}

	public function testAddDuplicateValue():Void {
		me.addPair(k.a1, v.a1);
		me.addPair(k.a2, v.a1);
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

	public function testOrderedKeys():Void {
		me.addPair(k.a1, v.a1);
		assertMatch([k.a1], [for (v in me.keys()) v]);
		me.addPair(k.a2, v.a2);
		assertMatch([k.a1, k.a2], [for (v in me.keys()) v]);
		me.addPair(k.a3, v.a3);
		assertMatch([k.a1, k.a2, k.a3], [for (v in me.keys()) v]);
		me.addPair(k.a4, v.a4);
		assertMatch([k.a1, k.a2, k.a3, k.a4], [for (v in me.keys()) v]);
		me.insertPairAt(0, k.a5, v.a5);
		assertMatch([k.a5, k.a1, k.a2, k.a3, k.a4], [for (v in me.keys()) v]);
		me.removeKey(k.a2);
		assertMatch([k.a5, k.a1, k.a3, k.a4], [for (v in me.keys()) v]);
		me.remove(v.a4);
		assertMatch([k.a5, k.a1, k.a3], [for (v in me.keys()) v]);
		me.removeAt(1);
		assertMatch([k.a5, k.a3], [for (v in me.keys()) v]);

		var it:Iterator<K> = me.keys();
		var a:Array<K> = [];
		assertNotEquals(null, it);
		assertTrue(it.hasNext());
		a.push(it.next());
		assertTrue(it.hasNext());
		a.push(it.next());
		assertFalse(it.hasNext());
		assertMatch([k.a5, k.a3], a);
	}

	public function testOrderedIterator():Void {
		me.addPair(k.a1, v.a1);
		assertMatch([v.a1], [for (v in me) v]);
		me.addPair(k.a2, v.a2);
		assertMatch([v.a1, v.a2], [for (v in me) v]);
		me.addPair(k.a3, v.a3);
		assertMatch([v.a1, v.a2, v.a3], [for (v in me) v]);
		me.addPair(k.a4, v.a4);
		assertMatch([v.a1, v.a2, v.a3, v.a4], [for (v in me) v]);
		me.insertPairAt(0, k.a5, v.a5);
		assertMatch([v.a5, v.a1, v.a2, v.a3, v.a4], [for (v in me) v]);
		me.removeKey(k.a2);
		assertMatch([v.a5, v.a1, v.a3, v.a4], [for (v in me) v]);
		me.remove(v.a4);
		assertMatch([v.a5, v.a1, v.a3], [for (v in me) v]);
		me.removeAt(1);
		assertMatch([v.a5, v.a3], [for (v in me) v]);

		var it:Iterator<V> = me.iterator();
		var a:Array<V> = [];
		assertNotEquals(null, it);
		assertTrue(it.hasNext());
		a.push(it.next());
		assertTrue(it.hasNext());
		a.push(it.next());
		assertFalse(it.hasNext());
		assertMatch([v.a5, v.a3], a);
	}

	public function testIndexOf():Void {
		me.addPair(k.a1, v.a1);
		me.addPair(k.a2, v.a2);
		assertMatch(0, me.indexOf(v.a1));
		assertMatch(1, me.indexOf(v.a2));
		assertMatch(-1, me.indexOf(v.a3));
	}

	public function testFirstLast():Void {
		assertEquals(me.first(), null);
		assertEquals(me.last(), null);
		me.addPair(k.a1, v.a1);
		assertEquals(me.first(), v.a1);
		assertEquals(me.last(), v.a1);
		me.addPair(k.a2, v.a2);
		assertEquals(me.first(), v.a1);
		assertEquals(me.last(), v.a2);
		me.removeKey(k.a1);
		assertEquals(me.first(), v.a2);
		assertEquals(me.last(), v.a2);
	}

	public function testResolveKeyIndex():Void {
		me.addPair(k.a1, v.a1);
		me.addPair(k.a2, v.a2);
		assertMatch(0, me.resolveKeyIndex(k.a1));
		assertMatch(1, me.resolveKeyIndex(k.a2));
		assertMatch(-1, me.resolveKeyIndex(k.a3));
	}

	public function testResolveName():Void {
		me.addPair(k.a1, v.a1);
		me.addPair(k.a2, v.a2);
		assertMatch(k.a1, me.resolveName(v.a1));
		assertMatch(k.a2, me.resolveName(v.a2));
		assertMatch(null, me.resolveName(v.a3));
	}

	public function testKnit():Void {
		me.addPair(k.a1, v.a1);
		assertMatch([k.a1], [for (p in me.knit()) p.key()]);
		assertMatch([v.a1], [for (p in me.knit()) p.value()]);
		for (p in me.knit()) p.append(k.a2, v.a2);
		assertMatch([true, false], [for (p in me.knit()) (p.value() == v.a1) && p.remove()]);
		assertMatch([k.a2], [for (p in me.knit()) p.key()]);
		assertMatch([v.a2], [for (p in me.knit()) p.value()]);
		for (p in me.knit()) p.prepend(k.a3, v.a3);
		assertMatch([k.a3, k.a2], [for (p in me.knit()) p.key()]);
		assertMatch([v.a3, v.a2], [for (p in me.knit()) p.value()]);
	}

	public function testEmptyToString():Void {
		assertEquals("{}", me.toString());
	}

	public function testToString():Void {
		me.addPair(k.a1, v.a1);
		me.addPair(k.a2, v.a2);
		me.addPair(k.a3, v.a3);
		me.addPair(k.a4, v.a4);
		me.insertPairAt(0, k.a5, v.a5);
		me.removeKey(k.a2);
		me.remove(v.a4);
		me.removeAt(1);
		assertEquals('{${k.a5} => ${v.a5}; ${k.a3} => ${v.a3}}', me.toString());
	}
}
