package arp.hit.fields;

import arp.hit.strategies.HitWithSphere;
import arp.hit.structs.HitSphere;

import picotest.PicoAssert.*;

class HitObjectFieldSphereCase {

	private var me:HitObjectField<HitSphere, TestHitObject<HitSphere>>;
	private var a:TestHitObject<HitSphere>;
	private var b:TestHitObject<HitSphere>;
	private var c:TestHitObject<HitSphere>;
	private var d:TestHitObject<HitSphere>;
	private var e:TestHitObject<HitSphere>;

	public function setup() {
		me = new HitObjectField<HitSphere, TestHitObject<HitSphere>>(new HitWithSphere());
		a = new TestHitObject<HitSphere>("a");
		b = new TestHitObject<HitSphere>("b");
		c = new TestHitObject<HitSphere>("c");
		d = new TestHitObject<HitSphere>("d");
		e = new TestHitObject<HitSphere>("e");
		me.addEternal(a).setSphere(2, 1, 1, 1);
		me.addEternal(b).setSphere(1, 3, 1, 1);
		me.addEternal(c).setSphere(1, 5, 1, 1);
		me.add(d).setSphere(9, 3, 3, 3);
		me.add(e).setSphere(0, 0, 0, -200);
	}

	public function testCollides() {
		var map:Array<Array<String>>;
		map = [];
		me.hitTest(function(a:TestHitObject<HitSphere>, b:TestHitObject<HitSphere>):Bool { map.push([a.name, b.name]); return false; } );
		assertMatch([["a", "b"], ["a", "d"], ["b", "d"], ["c", "d"]], map);
		me.tick();
		map = [];
		me.hitTest(function(a:TestHitObject<HitSphere>, b:TestHitObject<HitSphere>):Bool { map.push([a.name, b.name]); return false; } );
		assertMatch([["a", "b"], ["a", "d"], ["b", "d"], ["c", "d"]], map);
		me.tick();
		map = [];
		me.hitTest(function(a:TestHitObject<HitSphere>, b:TestHitObject<HitSphere>):Bool { map.push([a.name, b.name]); return false; } );
		assertMatch([["a", "b"]], map);
	}

	public function testHitRawTest() {
		var list:Array<String>;
		list = [];
		var hitA = new HitSphere().setSphere(2, 1, 1, 1);
		me.hitRaw(hitA, function(other:TestHitObject<HitSphere>):Bool { list.push(other.name); return false; } );
		assertMatch(["a", "b", "d"], list);
		list = [];
		var hitB = new HitSphere().setSphere(1, 3, 1, 1);
		me.hitRaw(hitB, function(other:TestHitObject<HitSphere>):Bool { list.push(other.name); return false; } );
		assertMatch(["a", "b", "d"], list);
		list = [];
		var hitD = new HitSphere().setSphere(9, 3, 3, 3);
		me.hitRaw(hitD, function(other:TestHitObject<HitSphere>):Bool { list.push(other.name); return false; } );
		assertMatch(["a", "b", "c", "d"], list);
	}}
