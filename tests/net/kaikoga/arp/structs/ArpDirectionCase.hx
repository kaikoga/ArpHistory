package net.kaikoga.arp.structs;

import haxe.io.BytesOutput;
import net.kaikoga.arp.persistable.TaggedPersistOutput;
import net.kaikoga.arp.io.OutputWrapper;
import net.kaikoga.arp.persistable.TaggedPersistInput;
import net.kaikoga.arp.io.InputWrapper;
import haxe.io.BytesInput;
import net.kaikoga.arp.domain.seed.ArpSeed;

import org.hamcrest.Matchers;
import picotest.PicoAssert.*;

class ArpDirectionCase {

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

	public function testPersist():Void {
		var dir:ArpDirection = new ArpDirection(50);
		var dir2:ArpDirection = new ArpDirection();
		var bytesOutput:BytesOutput = new BytesOutput();
		dir.writeSelf(new TaggedPersistOutput(new OutputWrapper(bytesOutput)));
		dir2.readSelf(new TaggedPersistInput(new InputWrapper(new BytesInput(bytesOutput.getBytes()))));
		assertEquals(dir.value, dir2.value);
	}
}
