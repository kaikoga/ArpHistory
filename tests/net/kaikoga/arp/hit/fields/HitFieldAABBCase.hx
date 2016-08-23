package net.kaikoga.arp.hit.fields;

import net.kaikoga.arp.hit.strategies.HitWithAABB;
import net.kaikoga.arp.hit.structs.HitGeneric;

import picotest.PicoAssert.*;

class HitFieldAABBCase {

	private var me:HitField<String, HitGeneric>;

	public function setup() {
		me = new HitField<String, HitGeneric>(new HitWithAABB());
		me.add("a", new HitGeneric().setAABB(1, 1, 1, 2, 2, 2));
		me.add("b", new HitGeneric().setAABB(3, 1, 1, 1, 1, 1));
		me.add("c", new HitGeneric().setAABB(5, 1, 1, 1, 1, 1));
		me.add("d", new HitGeneric().setAABB(3, 3, 3, 9, 9, 9));
		me.add("e", new HitGeneric().setAABB(-200, -200, -200, 0, 0, 0));
	}

	public function testHitTest() {
		var map:Array<Array<String>> = [];
		me.hitTest(function(a:String, b:String):Bool { map.push([a, b]); return false; } );
		assertMatch([["a", "b"], ["a", "d"], ["b", "d"], ["c", "d"]], map);
	}

}
