package net.kaikoga.arp.hit.fields;

import net.kaikoga.arp.hit.strategies.HitWithCuboid;
import net.kaikoga.arp.hit.structs.HitGeneric;

import picotest.PicoAssert.*;

class HitFieldCuboidCase {

	private var me:HitField<HitGeneric, String>;

	public function setup() {
		me = new HitField<HitGeneric, String>(new HitWithCuboid());
		me.add("a", 3).setCuboid(1, 1, 1, 2, 2, 2);
		me.add("b", 3).setCuboid(3, 1, 1, 1, 1, 1);
		me.add("c", 3).setCuboid(5, 1, 1, 1, 1, 1);
		me.add("d").setCuboid(3, 3, 3, 9, 9, 9);
		me.add("e").setCuboid(-200, -200, -200, 0, 0, 0);
	}

	public function testHitTest() {
		var map:Array<Array<String>> = [];
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
