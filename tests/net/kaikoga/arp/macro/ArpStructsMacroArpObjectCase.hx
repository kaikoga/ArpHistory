package net.kaikoga.arp.macro;

import net.kaikoga.arp.tests.ArpDomainTestUtil;
import net.kaikoga.arp.domain.gen.ArpObjectGenerator;
import net.kaikoga.arp.persistable.DynamicPersistOutput;
import net.kaikoga.arp.persistable.IPersistable;
import net.kaikoga.arp.macro.mocks.MockStructMacroArpObject;
import net.kaikoga.arp.domain.IArpObject;
import haxe.io.BytesInput;
import net.kaikoga.arp.io.OutputWrapper;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.persistable.TaggedPersistInput;
import net.kaikoga.arp.persistable.TaggedPersistOutput;
import haxe.io.BytesOutput;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpSlot;

import picotest.PicoAssert.*;

using net.kaikoga.arp.macro.ArpStructsMacroArpObjectCase;

class ArpStructsMacroArpObjectCase {

	inline public static function toHash(persistable:IPersistable):Dynamic {
		var result:Dynamic = {};
		persistable.writeSelf(new DynamicPersistOutput(result));
		return result;
	}

	private var domain:ArpDomain;
	private var slot:ArpSlot<MockStructMacroArpObject>;
	private var arpObj:MockStructMacroArpObject;
	private var xml:Xml;
	private var seed:ArpSeed;

	public function setup():Void {
		domain = new ArpDomain();
		domain.addGenerator(new ArpObjectGenerator(MockStructMacroArpObject, true));
		xml = Xml.parse('
<mock name="name1">
<arpArea2dField>1,2,3,4,5,6</arpArea2dField>
<arpColorField>#ff00ff@7f</arpColorField>
<arpDirectionField>southeast</arpDirectionField>
<arpHitAreaField>1,2,3,4,5,6</arpHitAreaField>
<arpPositionField>2,4,6,0</arpPositionField>
<arpRangeField>7..9</arpRangeField>
</mock>
		').firstElement();
		seed = ArpSeed.fromXml(xml);
	}

	public function testCreateEmpty():Void {
		arpObj = domain.allocObject(MockStructMacroArpObject);

		assertEquals(domain, arpObj.arpDomain());
		assertEquals(new ArpType("mock"), arpObj.arpType());
	}

	public function testLoadSeed():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;

		assertEquals(domain, arpObj.arpDomain());
		assertEquals(new ArpType("mock"), arpObj.arpType());
		assertEquals(slot, arpObj.arpSlot());

		assertMatch({x:1, y:2, gridSize:1, areaLeft:3, areaTop:4, areaRight:5, areaBottom:6}, arpObj.arpArea2dField.toHash());
		assertMatch({color:0x7fff00ff}, arpObj.arpColorField.toHash());
		assertMatch({dir:0x20000000}, arpObj.arpDirectionField.toHash());
		assertMatch({areaLeft:1, areaRight:2, areaTop:3, areaBottom:4, areaHind:5, areaFore:6}, arpObj.arpHitAreaField.toHash());
		assertMatch({dir:0, x:2, y:4, z:6, gridSize:0, period:0, tx:0, ty:0, tz:0}, arpObj.arpPositionField.toHash());
		assertMatch({min:7, max:9}, arpObj.arpRangeField.toHash());
	}

	private function checkIsClone(original:MockStructMacroArpObject, clone:MockStructMacroArpObject):Void {
		assertEquals(original.arpDomain(), clone.arpDomain());
		assertEquals(original.arpType(), clone.arpType());
		assertNotEquals(original.arpSlot(), clone.arpSlot());

		assertMatch(original.arpArea2dField.toHash(), clone.arpArea2dField.toHash());
		assertMatch(original.arpColorField.toHash(), clone.arpColorField.toHash());
		assertMatch(original.arpDirectionField.toHash(), clone.arpDirectionField.toHash());
		assertMatch(original.arpHitAreaField.toHash(), clone.arpHitAreaField.toHash());
		assertMatch(original.arpPositionField.toHash(), clone.arpPositionField.toHash());
		assertMatch(original.arpRangeField.toHash(), clone.arpRangeField.toHash());
	}

	public function testPersistable():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;

		var clone:MockStructMacroArpObject = ArpDomainTestUtil.roundTrip(domain, arpObj, MockStructMacroArpObject);
		checkIsClone(arpObj, clone);
	}

	public function testArpClone():Void {
		slot = domain.loadSeed(seed, new ArpType("mock"));
		arpObj = slot.value;

		var clone:MockStructMacroArpObject = cast arpObj.arpClone();
		checkIsClone(arpObj, clone);
	}
}
