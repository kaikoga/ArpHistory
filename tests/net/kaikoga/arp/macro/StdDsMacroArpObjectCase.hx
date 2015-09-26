package net.kaikoga.arp.macro;

import net.kaikoga.arp.macro.mocks.MockStdDsMacroArpObject;
import net.kaikoga.arp.domain.IArpObject;
import haxe.io.BytesInput;
import net.kaikoga.arp.io.OutputWrapper;
import net.kaikoga.arp.io.InputWrapper;
import net.kaikoga.arp.persistable.TaggedPersistInput;
import net.kaikoga.arp.persistable.TaggedPersistOutput;
import haxe.io.BytesOutput;
import net.kaikoga.arp.domain.gen.ArpDynamicGenerator;
import net.kaikoga.arp.macro.mocks.MockMacroArpObject;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpSlot;

import picotest.PicoAssert.*;

class StdDsMacroArpObjectCase {

	private var domain:ArpDomain;
	private var slot:ArpSlot<MockStdDsMacroArpObject>;
	private var arpObj:MockStdDsMacroArpObject;
	private var xml:Xml;
	private var seed:ArpSeed;

	public function setup():Void {
		domain = new ArpDomain();
		domain.addGenerator(new ArpDynamicGenerator(new ArpType("MockMacroArpObject"), MockMacroArpObject));
		domain.addGenerator(new ArpDynamicGenerator(new ArpType("MockStdDsMacroArpObject"), MockStdDsMacroArpObject));
		xml = Xml.parse('
<data name="name1">
	<intStdArray value="112" />
	<intStdArray value="134" />
	<floatStdArray value="2.23" />
	<floatStdArray value="2.45" />
	<boolStdArray value="true" />
	<boolStdArray value="true" />
	<stringStdArray value="stdFoo" />
	<stringStdArray value="stdBar" />
</data>
		').firstElement();
		seed = ArpSeed.fromXml(xml);
	}

	public function testCreateEmpty():Void {
		arpObj = domain.allocObject(MockStdDsMacroArpObject);

		assertEquals(domain, arpObj.arpDomain());
		assertEquals(new ArpType("MockStdDsMacroArpObject"), arpObj.arpType());
	}

	public function testLoadSeed():Void {
		slot = domain.loadSeed(seed, new ArpType("MockStdDsMacroArpObject"));
		arpObj = slot.value;

		assertEquals(domain, arpObj.arpDomain());
		assertEquals(new ArpType("MockStdDsMacroArpObject"), arpObj.arpType());
		assertEquals(slot, arpObj.arpSlot());

		assertMatch([112, 134], arpObj.intStdArray);
		assertMatch([2.23, 2.45], arpObj.floatStdArray);
		assertMatch([true, true], arpObj.boolStdArray);
		assertMatch(["stdFoo", "stdBar"], arpObj.stringStdArray);
	}

	private function roundTrip<T:IArpObject>(inObject:T, klass:Class<T>):T {
		var bytesOutput:BytesOutput = new BytesOutput();
		inObject.writeSelf(new TaggedPersistOutput(new OutputWrapper(bytesOutput)));
		var outObject:T = domain.allocObject(klass);
		outObject.readSelf(new TaggedPersistInput(new InputWrapper(new BytesInput(bytesOutput.getBytes()))));
		return outObject;
	}

	public function testPersistable():Void {
		slot = domain.loadSeed(seed, new ArpType("MockStdDsMacroArpObject"));
		arpObj = slot.value;

		var arpObj2:MockStdDsMacroArpObject = roundTrip(arpObj, MockStdDsMacroArpObject);

		assertEquals(arpObj.arpDomain(), arpObj2.arpDomain());
		assertEquals(arpObj.arpType(), arpObj2.arpType());
		assertNotEquals(arpObj.arpSlot(), arpObj2.arpSlot());

		assertMatch(arpObj.intStdArray, arpObj2.intStdArray);
		assertMatch(arpObj.floatStdArray, arpObj2.floatStdArray);
		assertMatch(arpObj.boolStdArray, arpObj2.boolStdArray);
		assertMatch(arpObj.stringStdArray, arpObj2.stringStdArray);
	}
}
