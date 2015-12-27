package net.kaikoga.arp.structs;

import haxe.io.BytesInput;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.io.OutputWrapper;
import net.kaikoga.arp.persistable.TaggedPersistInput;
import net.kaikoga.arp.persistable.TaggedPersistOutput;
import haxe.io.BytesOutput;

import org.hamcrest.Matchers;
import picotest.PicoAssert.*;

using net.kaikoga.arp.tests.ArpDomainTestUtil;

class ArpArea2dCase {

	private function newArpArea2d():ArpArea2d {
		var area:ArpArea2d = new ArpArea2d();
		area.areaLeft = 1;
		area.areaRight = 2;
		area.areaTop = 3;
		area.areaBottom = 4;
		area.x = 5;
		area.y = 6;
		return area;
	}

	public function testBasic():Void {
		var area:ArpArea2d = newArpArea2d();
		assertEquals(5, area.x);
		assertEquals(6, area.y);
		assertEquals(3, area.width);
		assertEquals(7, area.height);
		assertEquals(1, area.areaLeft);
		assertEquals(2, area.areaTop);
		assertEquals(3, area.areaRight);
		assertEquals(4, area.areaBottom);
		assertEquals(5, area.gridX);
		assertEquals(6, area.gridY);
		assertEquals(3, area.gridWidth);
		assertEquals(7, area.gridHeight);
		assertEquals(1, area.gridAreaLeft);
		assertEquals(2, area.gridAreaTop);
		assertEquals(3, area.gridAreaRight);
		assertEquals(4, area.gridAreaBottom);
	}

	public function testGridSize():Void {
		var area:ArpArea2d = newArpArea2d();
		area.gridSize = 10;
		assertEquals(5, area.x);
		assertEquals(6, area.y);
		assertEquals(3, area.width);
		assertEquals(7, area.height);
		assertEquals(1, area.areaLeft);
		assertEquals(2, area.areaTop);
		assertEquals(3, area.areaRight);
		assertEquals(4, area.areaBottom);
		assertEquals(5, area.gridX);
		assertEquals(6, area.gridY);
		assertEquals(3, area.gridWidth);
		assertEquals(7, area.gridHeight);
		assertEquals(1, area.gridAreaLeft);
		assertEquals(2, area.gridAreaTop);
		assertEquals(3, area.gridAreaRight);
		assertEquals(4, area.gridAreaBottom);
	}

	public function testGridScale():Void {
		var area:ArpArea2d = newArpArea2d();
		area.gridScale = 10;
		assertEquals(50, area.x);
		assertEquals(60, area.y);
		assertEquals(30, area.width);
		assertEquals(70, area.height);
		assertEquals(10, area.areaLeft);
		assertEquals(20, area.areaTop);
		assertEquals(30, area.areaRight);
		assertEquals(40, area.areaBottom);
		assertEquals(5, area.gridX);
		assertEquals(6, area.gridY);
		assertEquals(3, area.gridWidth);
		assertEquals(7, area.gridHeight);
		assertEquals(1, area.gridAreaLeft);
		assertEquals(2, area.gridAreaTop);
		assertEquals(3, area.gridAreaRight);
		assertEquals(4, area.gridAreaBottom);
	}

	public function testClone():Void {
		var area:ArpArea2d = newArpArea2d();
		var area2:ArpArea2d = area.clone();
		assertMatch(area.toHash(), area2.toHash());
	}

	public function testCopyFrom():Void {
		var area:ArpArea2d = newArpArea2d();
		var area2:ArpArea2d = new ArpArea2d().copyFrom(area);
		assertMatch(area.toHash(), area2.toHash());
	}

	public function testPersist():Void {
		var area:ArpArea2d = newArpArea2d();
		var area2:ArpArea2d = new ArpArea2d();
		var bytesOutput:BytesOutput = new BytesOutput();
		area.writeSelf(new TaggedPersistOutput(new OutputWrapper(bytesOutput)));
		area2.readSelf(new TaggedPersistInput(new InputWrapper(new BytesInput(bytesOutput.getBytes()))));
		assertMatch(area.toHash(), area2.toHash());
	}

}
