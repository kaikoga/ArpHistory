package net.kaikoga.arp.hit.fields;

import net.kaikoga.arp.hit.strategies.HitWithSphere;
import net.kaikoga.arp.hit.structs.HitSphere;

import picotest.PicoAssert.*;

class HitFieldSphereCase {

	private var me:HitField<String, HitSphere>;

	public function setup() {
		me = new HitField<String, HitSphere>(new HitWithSphere());
		me.add("a").setSphere(2, 1, 1, 1);
		me.add("b").setSphere(1, 3, 1, 1);
		me.add("c").setSphere(1, 5, 1, 1);
		me.add("d").setSphere(9, 3, 3, 3);
		me.add("e").setSphere(0, 0, 0, -200);
	}

	public function testCollides() {
		var map:Array<Array<String>> = [];
		me.hitTest(function(a:String, b:String):Bool { map.push([a, b]); return false; } );
		assertMatch([["a", "b"], ["a", "d"], ["b", "d"], ["c", "d"]], map);
	}

}
