package net.kaikoga.arp.hit.fields;

import net.kaikoga.arp.hit.strategies.HitWithSphere;
import net.kaikoga.arp.hit.structs.HitSphere;

import picotest.PicoAssert.*;

class HitObjectFieldSphereCase {

	private var me:HitObjectField<HitSphere, TestHitObject<HitSphere>>;

	public function setup() {
		me = new HitObjectField<HitSphere, TestHitObject<HitSphere>>(new HitWithSphere());
		me.add(new TestHitObject<HitSphere>("a"), 3).setSphere(2, 1, 1, 1);
		me.add(new TestHitObject<HitSphere>("b"), 3).setSphere(1, 3, 1, 1);
		me.add(new TestHitObject<HitSphere>("c"), 3).setSphere(1, 5, 1, 1);
		me.add(new TestHitObject<HitSphere>("d")).setSphere(9, 3, 3, 3);
		me.add(new TestHitObject<HitSphere>("e")).setSphere(0, 0, 0, -200);
	}

	public function testCollides() {
		var map:Array<Array<String>>;
		map = [];
		me.hitTest(function(a:TestHitObject<HitSphere>, b:TestHitObject<HitSphere>):Bool { map.push([a.name, b.name]); return false; } );
		assertMatch([["a", "b"], ["a", "d"], ["b", "d"], ["c", "d"]], map);
		me.tick();
		map = [];
		me.hitTest(function(a:TestHitObject<HitSphere>, b:TestHitObject<HitSphere>):Bool { map.push([a.name, b.name]); return false; } );
		assertMatch([["a", "b"]], map);
		me.tick();
		map = [];
		me.hitTest(function(a:TestHitObject<HitSphere>, b:TestHitObject<HitSphere>):Bool { map.push([a.name, b.name]); return false; } );
		assertMatch([["a", "b"]], map);
		me.tick();
		map = [];
		me.hitTest(function(a:TestHitObject<HitSphere>, b:TestHitObject<HitSphere>):Bool { map.push([a.name, b.name]); return false; } );
		assertMatch([], map);
	}

}
