package net.kaikoga.arp.structs;

import net.kaikoga.arp.domain.seed.ArpSeed;

import org.hamcrest.Matchers;
import picotest.PicoAssert.*;

class ArpDirectionCase {

	public function ArpDirectionTest() {
	}

	public function testInitWithSeed():Void {
		var ERR:Float = 0.01;
		var dir:ArpDirection = new ArpDirection();
		dir.initWithSeed(ArpSeed.fromXmlString('<dir value="10" />'));
		assertMatch(Matchers.closeTo(10, ERR), dir.valueDegree);
		dir.initWithSeed(ArpSeed.fromXmlString('<dir hoge="20" />').children()[0]);
		assertMatch(Matchers.closeTo(20, ERR), dir.valueDegree);
	}

	public function testClone():Void {
		var dir:ArpDirection = new ArpDirection(50);
		var dir2:ArpDirection = dir.clone();
		assertEquals(dir.value, dir2.value);
	}

	public function testCopyFrom():Void {
		var dir:ArpDirection = new ArpDirection(50);
		var dir2:ArpDirection = new ArpDirection().copyFrom(dir);
		assertEquals(dir.value, dir2.value);
	}

	/*
	public function testPersist():Void {
		var dir:ArpDirection = new ArpDirection(50);
		var dir2:ArpDirection = new ArpDirection();
		var bytes:ByteArray = new ByteArray();
		dir.writeSelf(new TaggedPersistOutput(bytes));
		bytes.position = 0;
		dir2.readSelf(new TaggedPersistInput(bytes));
		assertEquals(dir.value, dir2.value);
	}
	*/
}
