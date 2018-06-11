package arp.hit.fields;

import arp.hit.strategies.HitWithCuboid;
import arp.hit.structs.HitGeneric;

import picotest.PicoAssert.*;

class HitFieldCuboidCase {

	private var me:HitField<HitGeneric, String>;
	private var a:String;
	private var b:String;
	private var c:String;
	private var d:String;
	private var e:String;

	public function setup() {
		me = new HitField<HitGeneric, String>(new HitWithCuboid());
		a = "a";
		b = "b";
		c = "c";
		d = "d";
		e = "e";
		me.addEternal(a).setCuboid(1, 1, 1, 2, 2, 2);
		me.addEternal(b).setCuboid(3, 1, 1, 1, 1, 1);
		me.addEternal(c).setCuboid(5, 1, 1, 1, 1, 1);
		me.add(d).setCuboid(3, 3, 3, 9, 9, 9);
		me.add(e).setCuboid(-200, -200, -200, 0, 0, 0);
	}

	public function testHitTest() {
		var map:Array<Array<String>>;
		map = [];
		me.hitTest(function(a:String, b:String):Bool { map.push([a, b]); return false; } );
		assertMatch([["a", "b"], ["a", "d"], ["b", "d"], ["c", "d"]], map);
		me.tick();
		map = [];
		me.hitTest(function(a:String, b:String):Bool { map.push([a, b]); return false; } );
		assertMatch([["a", "b"], ["a", "d"], ["b", "d"], ["c", "d"]], map);
		me.tick();
		map = [];
		me.hitTest(function(a:String, b:String):Bool { map.push([a, b]); return false; } );
		assertMatch([["a", "b"]], map);
	}

	public function testHitRawTest() {
		var list:Array<String>;
		list = [];
		var hitA = new HitGeneric().setCuboid(1, 1, 1, 2, 2, 2);
		me.hitRaw(hitA, function(other:String):Bool { list.push(other); return false; } );
		assertMatch(["a", "b", "d"], list);
		list = [];
		var hitB = new HitGeneric().setCuboid(3, 1, 1, 1, 1, 1);
		me.hitRaw(hitB, function(other:String):Bool { list.push(other); return false; } );
		assertMatch(["a", "b", "d"], list);
		list = [];
		var hitD = new HitGeneric().setCuboid(3, 3, 3, 9, 9, 9);
		me.hitRaw(hitD, function(other:String):Bool { list.push(other); return false; } );
		assertMatch(["a", "b", "c", "d"], list);
	}
}
