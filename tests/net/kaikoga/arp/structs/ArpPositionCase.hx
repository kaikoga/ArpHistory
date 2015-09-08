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

class ArpPositionCase {

	public function testInitWithSeed():Void {
		var ERR:Float = 0.01;
		var pos:ArpPosition = new ArpPosition();
		pos.initWithSeed(ArpSeed.fromXmlString('<pos x="1" y="2" z="3" dir="4" />'));
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(0, pos.gridSize);
		assertMatch(Matchers.closeTo(4, ERR), pos.dir.valueDegree);
		pos.initWithSeed(ArpSeed.fromXmlString('<pos gridX="1" gridY="2" gridZ="3" dir="4" />'));
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(1, pos.gridSize);
		assertMatch(Matchers.closeTo(4, ERR), pos.dir.valueDegree);
		pos.initWithSeed(ArpSeed.fromXmlString('<pos hoge="5,6,7,8" />').children()[0]);
		assertMatch(5, pos.x);
		assertMatch(6, pos.y);
		assertMatch(7, pos.z);
		assertMatch(0, pos.gridSize);
		assertMatch(Matchers.closeTo(8, ERR), pos.dir.valueDegree);
		pos.initWithSeed(ArpSeed.fromXmlString('<pos hoge="g5,6,7,8" />').children()[0]);
		assertMatch(5, pos.x);
		assertMatch(6, pos.y);
		assertMatch(7, pos.z);
		assertMatch(1, pos.gridSize);
		assertMatch(Matchers.closeTo(8, ERR), pos.dir.valueDegree);
		pos.initWithSeed(ArpSeed.fromXmlString('<pos hoge="" />').children()[0]);
		assertMatch(0, pos.x);
		assertMatch(0, pos.y);
		assertMatch(0, pos.z);
		assertMatch(0, pos.gridSize);
		assertMatch(Matchers.closeTo(0, ERR), pos.dir.valueDegree);
	}

	public function testGridSize():Void {
		var pos:ArpPosition = new ArpPosition(2, 4, 6, 0, 2);
		assertMatch(2, pos.x);
		assertMatch(4, pos.y);
		assertMatch(6, pos.z);
		assertMatch(1, pos.gridX);
		assertMatch(2, pos.gridY);
		assertMatch(3, pos.gridZ);
		assertMatch(2, pos.gridSize);
		pos.gridSize = 1;
		assertMatch(2, pos.x);
		assertMatch(4, pos.y);
		assertMatch(6, pos.z);
		assertMatch(2, pos.gridX);
		assertMatch(4, pos.gridY);
		assertMatch(6, pos.gridZ);
		assertMatch(1, pos.gridSize);
		pos = new ArpPosition(2, 4, 6, 0, 0);
		assertMatch(2, pos.x);
		assertMatch(4, pos.y);
		assertMatch(6, pos.z);
		assertMatch(2, pos.gridX);
		assertMatch(4, pos.gridY);
		assertMatch(6, pos.gridZ);
		assertMatch(0, pos.gridSize);
		pos.gridSize = 2;
		assertMatch(2, pos.x);
		assertMatch(4, pos.y);
		assertMatch(6, pos.z);
		assertMatch(1, pos.gridX);
		assertMatch(2, pos.gridY);
		assertMatch(3, pos.gridZ);
		assertMatch(2, pos.gridSize);
	}

	public function testGridScale():Void {
		var pos:ArpPosition = new ArpPosition(2, 4, 6, 0, 2);
		assertMatch(2, pos.x);
		assertMatch(4, pos.y);
		assertMatch(6, pos.z);
		assertMatch(1, pos.gridX);
		assertMatch(2, pos.gridY);
		assertMatch(3, pos.gridZ);
		assertMatch(2, pos.gridScale);
		pos.gridScale = 3;
		assertMatch(3, pos.x);
		assertMatch(6, pos.y);
		assertMatch(9, pos.z);
		assertMatch(1, pos.gridX);
		assertMatch(2, pos.gridY);
		assertMatch(3, pos.gridZ);
		assertMatch(3, pos.gridScale);
		pos = new ArpPosition(2, 4, 6, 0, 0);
		assertMatch(2, pos.x);
		assertMatch(4, pos.y);
		assertMatch(6, pos.z);
		assertMatch(2, pos.gridX);
		assertMatch(4, pos.gridY);
		assertMatch(6, pos.gridZ);
		assertMatch(0, pos.gridScale);
		pos.gridScale = 2;
		assertMatch(2, pos.x);
		assertMatch(4, pos.y);
		assertMatch(6, pos.z);
		assertMatch(1, pos.gridX);
		assertMatch(2, pos.gridY);
		assertMatch(3, pos.gridZ);
		assertMatch(2, pos.gridScale);
	}

	public function testToward():Void {
		var pos:ArpPosition = new ArpPosition(1, 2, 3, 0, 3);
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(0, pos.tx);
		assertMatch(0, pos.ty);
		assertMatch(0, pos.tz);
		assertMatch(0, pos.period);
		assertMatch(0, pos.dir.value);
		pos.toward(2, 2, 4, 6, false);
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(2, pos.tx);
		assertMatch(4, pos.ty);
		assertMatch(6, pos.tz);
		assertMatch(2, pos.period);
		assertTrue(0 != pos.dir.value);
		pos.toward(3, 1, 2, 3, true);
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(3, pos.tx);
		assertMatch(6, pos.ty);
		assertMatch(9, pos.tz);
		assertMatch(3, pos.period);
		assertTrue(0 != pos.dir.value);
		pos.towardD(1, 1, 1, 1, false);
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(2, pos.tx);
		assertMatch(3, pos.ty);
		assertMatch(4, pos.tz);
		assertMatch(1, pos.period);
		assertTrue(0 != pos.dir.value);
		pos.towardD(3, 1, 0, 1, true);
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(4, pos.tx);
		assertMatch(2, pos.ty);
		assertMatch(6, pos.tz);
		assertMatch(3, pos.period);
		assertMatch(0, pos.dir.value);
	}

	public function testRelocate():Void {
		var pos:ArpPosition = new ArpPosition(1, 2, 3, 0, 3);
		assertMatch(1, pos.x);
		assertMatch(2, pos.y);
		assertMatch(3, pos.z);
		assertMatch(0, pos.tx);
		assertMatch(0, pos.ty);
		assertMatch(0, pos.tz);
		assertMatch(0, pos.period);
		assertMatch(0, pos.dir.value);
		pos.relocate(2, 4, 6, false);
		assertMatch(2, pos.x);
		assertMatch(4, pos.y);
		assertMatch(6, pos.z);
		assertMatch(0, pos.tx);
		assertMatch(0, pos.ty);
		assertMatch(0, pos.tz);
		assertMatch(0, pos.period);
		assertMatch(0, pos.dir.value);
		pos.relocate(1, 2, 3, true);
		assertMatch(3, pos.x);
		assertMatch(6, pos.y);
		assertMatch(9, pos.z);
		assertMatch(0, pos.tx);
		assertMatch(0, pos.ty);
		assertMatch(0, pos.tz);
		assertMatch(0, pos.period);
		assertMatch(0, pos.dir.value);
		pos.relocateD(1, 1, 1, false);
		assertMatch(4, pos.x);
		assertMatch(7, pos.y);
		assertMatch(10, pos.z);
		assertMatch(0, pos.tx);
		assertMatch(0, pos.ty);
		assertMatch(0, pos.tz);
		assertMatch(0, pos.period);
		assertMatch(0, pos.dir.value);
		pos.relocateD(-1, -1, -1, false);
		pos.relocateD(1, 1, 1, true);
		assertMatch(6, pos.x);
		assertMatch(9, pos.y);
		assertMatch(12, pos.z);
		assertMatch(0, pos.tx);
		assertMatch(0, pos.ty);
		assertMatch(0, pos.tz);
		assertMatch(0, pos.period);
		assertMatch(0, pos.dir.value);
	}

	public function testFrameMove():Void {
		var pos:ArpPosition = new ArpPosition(0, 0, 0, 0, 3);
		pos.toward(4, 4, 4, 4, false);
		assertMatch(0, pos.x);
		pos.frameMove();
		assertMatch(1, pos.x);
		pos.frameMove();
		assertMatch(2, pos.x);
		pos.frameMove();
		assertMatch(3, pos.x);
		pos.frameMove();
		assertMatch(4, pos.x);
		pos.frameMove();
		assertMatch(4, pos.x);
	}

	public function testClone():Void {
		var pos:ArpPosition = new ArpPosition(1, 2, 3, 4, 5);
		var pos2:ArpPosition = pos.clone();
		assertMatch(pos.x, pos2.x);
		assertMatch(pos.y, pos2.y);
		assertMatch(pos.z, pos2.z);
		assertMatch(pos.dir.value, pos2.dir.value);
		assertMatch(pos.gridSize, pos2.gridSize);
	}

	public function testCopyFrom():Void {
		var pos:ArpPosition = new ArpPosition(1, 2, 3, 4, 5);
		var pos2:ArpPosition = new ArpPosition().copyFrom(pos);
		assertMatch(pos.x, pos2.x);
		assertMatch(pos.y, pos2.y);
		assertMatch(pos.z, pos2.z);
		assertMatch(pos.dir.value, pos2.dir.value);
		assertMatch(pos.gridSize, pos2.gridSize);
	}

	public function testPersist():Void {
		var pos:ArpPosition = new ArpPosition(1, 2, 3, 4, 5);
		var pos2:ArpPosition = new ArpPosition();
		var bytesOutput:BytesOutput = new BytesOutput();
		pos.writeSelf(new TaggedPersistOutput(new OutputWrapper(bytesOutput)));
		pos2.readSelf(new TaggedPersistInput(new InputWrapper(new BytesInput(bytesOutput.getBytes()))));
		assertMatch(pos.x, pos2.x);
		assertMatch(pos.y, pos2.y);
		assertMatch(pos.z, pos2.z);
		assertMatch(pos.dir.value, pos2.dir.value);
		assertMatch(pos.gridSize, pos2.gridSize);
	}
}
