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
using Lambda;
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
	<intStdList value="112" />
	<intStdList value="134" />
	<floatStdList value="2.23" />
	<floatStdList value="2.45" />
	<boolStdList value="true" />
	<boolStdList value="true" />
	<stringStdList value="stdFoo" />
	<stringStdList value="stdBar" />
	<intStdMap key="key1" value="312" />
	<intStdMap key="key2" value="334" />
	<floatStdMap key="key3" value="4.23" />
	<floatStdMap key="key4" value="4.45" />
	<boolStdMap key="key5" value="true" />
	<boolStdMap key="key6" value="false" />
	<stringStdMap key="key7" value="stdMapFoo" />
	<stringStdMap key="key8" value="stdMapBar" />
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
		assertMatch([112, 134], arpObj.intStdList.array());
		assertMatch([2.23, 2.45], arpObj.floatStdList.array());
		assertMatch([true, true], arpObj.boolStdList.array());
		assertMatch(["stdFoo", "stdBar"], arpObj.stringStdList.array());
		assertEquals(312, arpObj.intStdMap.get("key1"));
		assertEquals(334, arpObj.intStdMap.get("key2"));
		assertEquals(4.23, arpObj.floatStdMap.get("key3"));
		assertEquals(4.45, arpObj.floatStdMap.get("key4"));
		assertEquals(true, arpObj.boolStdMap.get("key5"));
		assertEquals(false, arpObj.boolStdMap.get("key6"));
		assertEquals("stdMapFoo", arpObj.stringStdMap.get("key7"));
		assertEquals("stdMapBar", arpObj.stringStdMap.get("key8"));
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
		assertMatch(arpObj.intStdList.array(), arpObj2.intStdList.array());
		assertMatch(arpObj.floatStdList.array(), arpObj2.floatStdList.array());
		assertMatch(arpObj.boolStdList.array(), arpObj2.boolStdList.array());
		assertMatch(arpObj.stringStdList.array(), arpObj2.stringStdList.array());
		assertEquals(arpObj.intStdMap.get("key1"), arpObj2.intStdMap.get("key1"));
		assertEquals(arpObj.intStdMap.get("key2"), arpObj2.intStdMap.get("key2"));
		assertEquals(arpObj.floatStdMap.get("key3"), arpObj2.floatStdMap.get("key3"));
		assertEquals(arpObj.floatStdMap.get("key4"), arpObj2.floatStdMap.get("key4"));
		assertEquals(arpObj.boolStdMap.get("key5"), arpObj2.boolStdMap.get("key5"));
		assertEquals(arpObj.boolStdMap.get("key6"), arpObj2.boolStdMap.get("key6"));
		assertEquals(arpObj.stringStdMap.get("key7"), arpObj2.stringStdMap.get("key7"));
		assertEquals(arpObj.stringStdMap.get("key8"), arpObj2.stringStdMap.get("key8"));
	}
}
