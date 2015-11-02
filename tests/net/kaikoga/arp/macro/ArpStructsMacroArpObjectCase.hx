package net.kaikoga.arp.macro;

import net.kaikoga.arp.macro.mocks.MockStructMacroArpObject;
import net.kaikoga.arp.domain.IArpObject;
import haxe.io.BytesInput;
import net.kaikoga.arp.io.OutputWrapper;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.persistable.TaggedPersistInput;
import net.kaikoga.arp.persistable.TaggedPersistOutput;
import haxe.io.BytesOutput;
import net.kaikoga.arp.domain.gen.ArpDynamicGenerator;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpSlot;

import picotest.PicoAssert.*;

class ArpStructsMacroArpObjectCase {

	private var domain:ArpDomain;
	private var slot:ArpSlot<MockStructMacroArpObject>;
	private var arpObj:MockStructMacroArpObject;
	private var xml:Xml;
	private var seed:ArpSeed;

	public function setup():Void {
		domain = new ArpDomain();
		domain.addGenerator(new ArpDynamicGenerator(new ArpType("MockMacroArpObject"), MockStructMacroArpObject));
		xml = Xml.parse('
<mock name="name1">
<arpArea2dField>1,2,3,4,5,6</arpArea2dField>
<arpColorField>#ff00ff@7f</arpColorField>
<arpDirectionField>southeast</arpDirectionField>
<arpHitAreaField>2,2,4,4,6,6</arpHitAreaField>
<arpPositionField>2,4,6,8</arpPositionField>
<arpRangeField>7..9</arpRangeField>
</mock>
		').firstElement();		seed = ArpSeed.fromXml(xml);
	}

	public function testCreateEmpty():Void {
		arpObj = domain.allocObject(MockStructMacroArpObject);

		assertEquals(domain, arpObj.arpDomain());
		assertEquals(new ArpType("MockMacroArpObject"), arpObj.arpType());
	}

	public function testLoadSeed():Void {
		slot = domain.loadSeed(seed, new ArpType("MockMacroArpObject"));
		arpObj = slot.value;

		assertEquals(domain, arpObj.arpDomain());
		assertEquals(new ArpType("MockMacroArpObject"), arpObj.arpType());
		assertEquals(slot, arpObj.arpSlot());
	}

	private function roundTrip<T:IArpObject>(inObject:T, klass:Class<T>):T {
		var bytesOutput:BytesOutput = new BytesOutput();
		inObject.writeSelf(new TaggedPersistOutput(new OutputWrapper(bytesOutput)));
		var outObject:T = domain.allocObject(klass);
		outObject.readSelf(new TaggedPersistInput(new InputWrapper(new BytesInput(bytesOutput.getBytes()))));
		return outObject;
	}

	public function testPersistable():Void {
		slot = domain.loadSeed(seed, new ArpType("MockMacroArpObject"));
		arpObj = slot.value;

		var arpObj2:MockStructMacroArpObject = roundTrip(arpObj, MockStructMacroArpObject);

		assertEquals(arpObj.arpDomain(), arpObj2.arpDomain());
		assertEquals(arpObj.arpType(), arpObj2.arpType());
		assertNotEquals(arpObj.arpSlot(), arpObj2.arpSlot());
	}
}
