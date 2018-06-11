package arp.hit.fields;

import arp.hit.strategies.HitWithCuboid;
import arp.hit.structs.HitGeneric;

import picotest.PicoAssert.*;

class HitObjectFieldCuboidCase {

	private var me:HitObjectField<HitGeneric, TestHitObject<HitGeneric>>;
	private var a:TestHitObject<HitGeneric>;
	private var b:TestHitObject<HitGeneric>;
	private var c:TestHitObject<HitGeneric>;
	private var d:TestHitObject<HitGeneric>;
	private var e:TestHitObject<HitGeneric>;

	public function setup() {
		me = new HitObjectField<HitGeneric, TestHitObject<HitGeneric>>(new HitWithCuboid());
		a = new TestHitObject<HitGeneric>("a");
		b = new TestHitObject<HitGeneric>("b");
		c = new TestHitObject<HitGeneric>("c");
		d = new TestHitObject<HitGeneric>("d");
		e = new TestHitObject<HitGeneric>("e");
		me.addEternal(a).setCuboid(1, 1, 1, 2, 2, 2);
		me.addEternal(b).setCuboid(3, 1, 1, 1, 1, 1);
		me.addEternal(c).setCuboid(5, 1, 1, 1, 1, 1);
		me.add(d).setCuboid(3, 3, 3, 9, 9, 9);
		me.add(e).setCuboid(-200, -200, -200, 0, 0, 0);
	}

	public function testHitTest() {
		var map:Array<Array<String>>;
		map = [];
		me.hitTest(function(a:TestHitObject<HitGeneric>, b:TestHitObject<HitGeneric>):Bool { map.push([a.name, b.name]); return false; } );
		assertMatch([["a", "b"], ["a", "d"], ["b", "d"], ["c", "d"]], map);
		me.tick();
		map = [];
		me.hitTest(function(a:TestHitObject<HitGeneric>, b:TestHitObject<HitGeneric>):Bool { map.push([a.name, b.name]); return false; } );
		assertMatch([["a", "b"], ["a", "d"], ["b", "d"], ["c", "d"]], map);
		me.tick();
		map = [];
		me.hitTest(function(a:TestHitObject<HitGeneric>, b:TestHitObject<HitGeneric>):Bool { map.push([a.name, b.name]); return false; } );
		assertMatch([["a", "b"]], map);
	}

	public function testHitRawTest() {
		var list:Array<String>;
		list = [];
		var hitA = new HitGeneric().setCuboid(1, 1, 1, 2, 2, 2);
		me.hitRaw(hitA, function(other:TestHitObject<HitGeneric>):Bool { list.push(other.name); return false; } );
		assertMatch(["a", "b", "d"], list);
		list = [];
		var hitB = new HitGeneric().setCuboid(3, 1, 1, 1, 1, 1);
		me.hitRaw(hitB, function(other:TestHitObject<HitGeneric>):Bool { list.push(other.name); return false; } );
		assertMatch(["a", "b", "d"], list);
		list = [];
		var hitD = new HitGeneric().setCuboid(3, 3, 3, 9, 9, 9);
		me.hitRaw(hitD, function(other:TestHitObject<HitGeneric>):Bool { list.push(other.name); return false; } );
		assertMatch(["a", "b", "c", "d"], list);
	}
}
