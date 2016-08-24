package net.kaikoga.arp.hit.fields;

import net.kaikoga.arp.hit.strategies.HitWithSphere;
import net.kaikoga.arp.hit.structs.HitSphere;

import picotest.PicoAssert.*;

class HitFieldSphereCase {

	private var me:HitField<HitSphere, String>;

	public function setup() {
		me = new HitField<HitSphere, String>(new HitWithSphere());
		me.add("a", 3).setSphere(2, 1, 1, 1);
		me.add("b", 3).setSphere(1, 3, 1, 1);
		me.add("c", 3).setSphere(1, 5, 1, 1);
		me.add("d").setSphere(9, 3, 3, 3);
		me.add("e").setSphere(0, 0, 0, -200);
	}

	public function testCollides() {
		var map:Array<Array<String>>;
		map = [];
		me.hitTest(function(a:String, b:String):Bool { map.push([a, b]); return false; } );
		assertMatch([["a", "b"], ["a", "d"], ["b", "d"], ["c", "d"]], map);
		me.tick();
		map = [];
		me.hitTest(function(a:String, b:String):Bool { map.push([a, b]); return false; } );
		assertMatch([["a", "b"]], map);
		me.tick();
		map = [];
		me.hitTest(function(a:String, b:String):Bool { map.push([a, b]); return false; } );
		assertMatch([["a", "b"]], map);
		me.tick();
		map = [];
		me.hitTest(function(a:String, b:String):Bool { map.push([a, b]); return false; } );
		assertMatch([], map);
	}

}
