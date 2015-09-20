package net.kaikoga.arp.domain.seed;

import net.kaikoga.arp.domain.seed.ArpSeed;

import picotest.PicoAssert.*;

class ArpSeedCase {

	private function toHash(seed:ArpSeed) return {typeName: Std.string(seed.typeName()), template: seed.template(), name: seed.name(), ref: seed.ref(), value: seed.value()};

	public function testEmptyXmlSeed():Void {
		var xml:Xml = Xml.parse('<root />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertMatch({typeName: "root", template: null, name: null, ref: null, value: null}, toHash(seed));
		var iterator = seed.iterator();
		assertFalse(iterator.hasNext());
	}

	public function testSimpleXmlSeed():Void {
		var xml:Xml = Xml.parse('<data name="name6" ref="ref8" template="template14" value="value42" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertMatch({typeName: "data", template: "template14", name: "name6", ref: "ref8", value: "value42"}, toHash(seed));
		var iterator = seed.iterator();
		assertFalse(iterator.hasNext());
	}

	public function testXmlSeedWithValue():Void {
		var xml:Xml = Xml.parse('<data>value128</data>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertMatch({typeName: "data", template: null, name: null, ref: null, value: "value128"}, toHash(seed));
		var iterator = seed.iterator();
		assertFalse(iterator.hasNext());
	}

	public function testXmlSeedWithAttrValue():Void {
		var xml:Xml = Xml.parse('<data name="name6" ref="ref8" template="template14" valueKey="value42" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertMatch({typeName: "data", template: "template14", name: "name6", ref: "ref8", value: null}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "valueKey", template: null, name: null, ref: "value42", value: "value42"}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testXmlSeedWithComplexValue():Void {
		var xml:Xml = Xml.parse('<data>value16<a />value32<b>valueb</b>value64</data>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertMatch({typeName: "data", template: null, name: null, ref: null, value: "value16value32value64"}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "a", template: null, name: null, ref: null, value: null}, toHash(iterator.next()));
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "b", template: null, name: null, ref: null, value: "valueb"}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

}
