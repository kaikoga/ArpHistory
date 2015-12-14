package net.kaikoga.arp.structs;

import haxe.io.BytesInput;
import haxe.io.BytesOutput;
import net.kaikoga.arp.persistable.TaggedPersistOutput;
import net.kaikoga.arp.io.OutputWrapper;
import net.kaikoga.arp.persistable.TaggedPersistInput;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.domain.seed.ArpSeed;
#if openfl
import openfl.geom.ColorTransform;
#elseif flash
import flash.geom.ColorTransform;
#end

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

	public function testToMultiplier():Void {
		var color:ArpColor = new ArpColor(0x336699);
		color.alpha = 0xcc;
		var ct:ColorTransform = color.toMultiplier();
		assertMatch(0.2, ct.redMultiplier);
		assertMatch(0.4, ct.greenMultiplier);
		assertMatch(0.6, ct.blueMultiplier);
		assertMatch(0.8, ct.alphaMultiplier);
		assertMatch(0, ct.redOffset);
		assertMatch(0, ct.greenOffset);
		assertMatch(0, ct.blueOffset);
		assertMatch(0, ct.alphaOffset);
	}

	public function testToOffset():Void {
		var color:ArpColor = new ArpColor(0x336699);
		color.alpha = 0xcc;
		var ct:ColorTransform = color.toOffset();
		assertMatch(0, ct.redMultiplier);
		assertMatch(0, ct.greenMultiplier);
		assertMatch(0, ct.blueMultiplier);
		assertMatch(0, ct.alphaMultiplier);
		assertMatch(0x33, ct.redOffset);
		assertMatch(0x66, ct.greenOffset);
		assertMatch(0x99, ct.blueOffset);
		assertMatch(0xcc, ct.alphaOffset);
	}

	public function testToColorize():Void {
		var ERR:Float = 0.01;
		var color:ArpColor = new ArpColor(0x336699);
		color.alpha = 0xcc;
		var ct:ColorTransform = color.toColorize();
		assertMatch(Matchers.closeTo(0x33 / 0xff, ERR), ct.redMultiplier);
		assertMatch(Matchers.closeTo(0x33 / 0xff, ERR), ct.greenMultiplier);
		assertMatch(Matchers.closeTo(0x33 / 0xff, ERR), ct.blueMultiplier);
		assertMatch(Matchers.closeTo(0xff / 0xff, ERR), ct.alphaMultiplier);
		assertMatch(Matchers.closeTo(0x33 * 0xcc / 0xff, ERR), ct.redOffset);
		assertMatch(Matchers.closeTo(0x66 * 0xcc / 0xff, ERR), ct.greenOffset);
		assertMatch(Matchers.closeTo(0x99 * 0xcc / 0xff, ERR), ct.blueOffset);
		assertMatch(0, ct.alphaOffset);
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
