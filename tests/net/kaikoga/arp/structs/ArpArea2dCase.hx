package net.kaikoga.arp.structs;

import haxe.io.BytesInput;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.io.OutputWrapper;
import net.kaikoga.arp.persistable.TaggedPersistInput;
import net.kaikoga.arp.persistable.TaggedPersistOutput;
import haxe.io.BytesOutput;

import org.hamcrest.Matchers;
import picotest.PicoAssert.*;

class ArpArea2dCase {

	public function testClone():Void {
		var area:ArpArea2d = new ArpArea2d();
		var area2:ArpArea2d = area.clone();
		assertMatch(area.x, area2.x);
	}

	public function testCopyFrom():Void {
		var area:ArpArea2d = new ArpArea2d();
		var area2:ArpArea2d = new ArpArea2d().copyFrom(area);
		assertMatch(area.x, area2.x);
	}

	public function testPersist():Void {
		var area:ArpArea2d = new ArpArea2d();
		var area2:ArpArea2d = new ArpArea2d();
		var bytesOutput:BytesOutput = new BytesOutput();
		area.writeSelf(new TaggedPersistOutput(new OutputWrapper(bytesOutput)));
		area2.readSelf(new TaggedPersistInput(new InputWrapper(new BytesInput(bytesOutput.getBytes()))));
		assertMatch(area.x, area2.x);
	}

}
