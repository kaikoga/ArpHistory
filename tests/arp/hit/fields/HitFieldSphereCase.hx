package arp.hit.fields;

import arp.hit.strategies.HitWithSphere;
import arp.hit.structs.HitSphere;

import picotest.PicoAssert.*;

class HitFieldSphereCase {

	private var me:HitField<HitSphere, String>;
	private var a:String;
	private var b:String;
	private var c:String;
	private var d:String;
	private var e:String;

	public function setup() {
		me = new HitField<HitSphere, String>(new HitWithSphere());
		a = "a";
		b = "b";
		c = "c";
		d = "d";
		e = "e";
		me.addEternal(a).setSphere(2, 1, 1, 1);
		me.addEternal(b).setSphere(1, 3, 1, 1);
		me.addEternal(c).setSphere(1, 5, 1, 1);
		me.add(d).setSphere(9, 3, 3, 3);
		me.add(e).setSphere(0, 0, 0, -200);
	}

	public function testCollides() {
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
		var hitA = new HitSphere().setSphere(2, 1, 1, 1);
		me.hitRaw(hitA, function(other:String):Bool { list.push(other); return false; } );
		assertMatch(["a", "b", "d"], list);
		list = [];
		var hitB = new HitSphere().setSphere(1, 3, 1, 1);
		me.hitRaw(hitB, function(other:String):Bool { list.push(other); return false; } );
		assertMatch(["a", "b", "d"], list);
		list = [];
		var hitD = new HitSphere().setSphere(9, 3, 3, 3);
		me.hitRaw(hitD, function(other:String):Bool { list.push(other); return false; } );
		assertMatch(["a", "b", "c", "d"], list);
	}
}
