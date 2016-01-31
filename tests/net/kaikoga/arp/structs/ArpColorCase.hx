package net.kaikoga.arp.structs;

import haxe.io.BytesInput;
import haxe.io.BytesOutput;
import net.kaikoga.arp.persistable.TaggedPersistOutput;
import net.kaikoga.arp.io.OutputWrapper;
import net.kaikoga.arp.persistable.TaggedPersistInput;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.domain.seed.ArpSeed;

import org.hamcrest.Matchers;
import picotest.PicoAssert.*;

class ArpColorCase {

	public function testInitWithSeed():Void {
		var color:ArpColor = new ArpColor();
		color.initWithSeed(ArpSeed.fromXmlString('<color value="#112233@44" />'));
		assertEquals(0x44112233, color.value32);
		color.initWithSeed(ArpSeed.fromXmlString('<color hoge="#556677@88" />').iterator().next());
		assertEquals(0x88556677, color.value32);
	}

	public function testClone():Void {
		var color:ArpColor = new ArpColor(0xccddeeff);
		var color2:ArpColor = color.clone();
		assertEquals(color.value32, color2.value32);
	}

	public function testCopyFrom():Void {
		var color:ArpColor = new ArpColor(0xccddeeff);
		var color2:ArpColor = new ArpColor().copyFrom(color);
		assertEquals(color.value32, color2.value32);
	}

	public function testPersist():Void {
		var color:ArpColor = new ArpColor(0xccddeeff);
		var color2:ArpColor = new ArpColor();
		var bytesOutput:BytesOutput = new BytesOutput();
		color.writeSelf(new TaggedPersistOutput(new OutputWrapper(bytesOutput)));
		color2.readSelf(new TaggedPersistInput(new InputWrapper(new BytesInput(bytesOutput.getBytes()))));
		assertEquals(color.value32, color2.value32);
	}

}
