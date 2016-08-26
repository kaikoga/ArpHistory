package net.kaikoga.arp.hit.fields;

import net.kaikoga.arp.hit.strategies.HitWithCuboid;
import net.kaikoga.arp.hit.structs.HitGeneric;

import picotest.PicoAssert.*;

class HitObjectFieldCuboidCase {

	private var me:HitObjectField<HitGeneric, TestHitObject<HitGeneric>>;

	public function setup() {
		me = new HitObjectField<HitGeneric, TestHitObject<HitGeneric>>(new HitWithCuboid());
		me.add(new TestHitObject<HitGeneric>("a"), 3).setCuboid(1, 1, 1, 2, 2, 2);
		me.add(new TestHitObject<HitGeneric>("b"), 3).setCuboid(3, 1, 1, 1, 1, 1);
		me.add(new TestHitObject<HitGeneric>("c"), 3).setCuboid(5, 1, 1, 1, 1, 1);
		me.add(new TestHitObject<HitGeneric>("d")).setCuboid(3, 3, 3, 9, 9, 9);
		me.add(new TestHitObject<HitGeneric>("e")).setCuboid(-200, -200, -200, 0, 0, 0);
	}

	public function testHitTest() {
		var map:Array<Array<String>> = [];
		map = [];
		me.hitTest(function(a:TestHitObject<HitGeneric>, b:TestHitObject<HitGeneric>):Bool { map.push([a.name, b.name]); return false; } );
		assertMatch([["a", "b"], ["a", "d"], ["b", "d"], ["c", "d"]], map);
		me.tick();
		map = [];
		me.hitTest(function(a:TestHitObject<HitGeneric>, b:TestHitObject<HitGeneric>):Bool { map.push([a.name, b.name]); return false; } );
		assertMatch([["a", "b"]], map);
		me.tick();
		map = [];
		me.hitTest(function(a:TestHitObject<HitGeneric>, b:TestHitObject<HitGeneric>):Bool { map.push([a.name, b.name]); return false; } );
		assertMatch([["a", "b"]], map);
		me.tick();
		map = [];
		me.hitTest(function(a:TestHitObject<HitGeneric>, b:TestHitObject<HitGeneric>):Bool { map.push([a.name, b.name]); return false; } );
		assertMatch([], map);
	}
}
