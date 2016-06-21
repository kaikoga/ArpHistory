package net.kaikoga.arp.structs;

import net.kaikoga.arp.testParams.PersistIoProviders.IPersistIoProvider;
import haxe.io.BytesOutput;

import org.hamcrest.Matchers;
import picotest.PicoAssert.*;

using net.kaikoga.arp.tests.ArpDomainTestUtil;

class ArpArea2dCase {

	private var provider:IPersistIoProvider;

	@Parameter
	public function setup(provider:IPersistIoProvider):Void {
		this.provider = provider;
	}

	private function newArpArea2d():ArpArea2d {
		var area:ArpArea2d = new ArpArea2d();
		area.areaLeft = 1;
		area.areaTop = 2;
		area.areaRight = 3;
		area.areaBottom = 4;
		area.x = 5;
		area.y = 6;
		return area;
	}

	public function testBasic():Void {
		var area:ArpArea2d = newArpArea2d();
		assertMatch(5, area.x);
		assertMatch(6, area.y);
		assertMatch(3, area.width);
		assertMatch(7, area.height);
		assertMatch(1, area.areaLeft);
		assertMatch(2, area.areaTop);
		assertMatch(3, area.areaRight);
		assertMatch(4, area.areaBottom);
		assertMatch(5, area.gridX);
		assertMatch(6, area.gridY);
		assertMatch(3, area.gridWidth);
		assertMatch(7, area.gridHeight);
		assertMatch(1, area.gridAreaLeft);
		assertMatch(2, area.gridAreaTop);
		assertMatch(3, area.gridAreaRight);
		assertMatch(4, area.gridAreaBottom);
	}

	public function testGridSize():Void {
		var area:ArpArea2d = newArpArea2d();
		area.gridSize = 10;
		assertMatch(5, area.x);
		assertMatch(6, area.y);
		assertMatch(3, area.width);
		assertMatch(7, area.height);
		assertMatch(1, area.areaLeft);
		assertMatch(2, area.areaTop);
		assertMatch(3, area.areaRight);
		assertMatch(4, area.areaBottom);
		assertMatch(5, area.gridX);
		assertMatch(6, area.gridY);
		assertMatch(3, area.gridWidth);
		assertMatch(7, area.gridHeight);
		assertMatch(1, area.gridAreaLeft);
		assertMatch(2, area.gridAreaTop);
		assertMatch(3, area.gridAreaRight);
		assertMatch(4, area.gridAreaBottom);
	}

	public function testGridScale():Void {
		var area:ArpArea2d = newArpArea2d();
		area.gridScale = 10;
		assertMatch(50, area.x);
		assertMatch(60, area.y);
		assertMatch(30, area.width);
		assertMatch(70, area.height);
		assertMatch(10, area.areaLeft);
		assertMatch(20, area.areaTop);
		assertMatch(30, area.areaRight);
		assertMatch(40, area.areaBottom);
		assertMatch(5, area.gridX);
		assertMatch(6, area.gridY);
		assertMatch(3, area.gridWidth);
		assertMatch(7, area.gridHeight);
		assertMatch(1, area.gridAreaLeft);
		assertMatch(2, area.gridAreaTop);
		assertMatch(3, area.gridAreaRight);
		assertMatch(4, area.gridAreaBottom);
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
		area.writeSelf(provider.output);
		area2.readSelf(provider.input);
		assertMatch(area.toHash(), area2.toHash());
	}

}
