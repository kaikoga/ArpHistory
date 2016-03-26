package net.kaikoga.arp.domain.seed;

import net.kaikoga.arp.domain.seed.ArpSeed;

import picotest.PicoAssert.*;

class ArpSeedCase {

	private function toHash(seed:ArpSeed) return {
		typeName: Std.string(seed.typeName()),
		template: seed.template(),
		name: seed.name(),
		ref: seed.ref(),
		key: seed.key(12345678),
		value: seed.value()
	};

	public function testEmptyXmlSeed():Void {
		var xml:Xml = Xml.parse('<root />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertTrue(seed.isSimple());
		assertMatch({typeName: "root", template: null, name: null, ref: null, key: "$12345678", value: null}, toHash(seed));
		var iterator = seed.iterator();
		assertFalse(iterator.hasNext());
	}

	public function testSimpleXmlSeed():Void {
		var xml:Xml = Xml.parse('<data name="name6" ref="ref8" template="template14" key="key28" value="value42" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertTrue(seed.isSimple());
		assertMatch({typeName: "data", template: "template14", name: "name6", ref: "ref8", key:"key28", value: "value42"}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "value", template: null, name: null, ref: null, key: "$12345678", value: "value42"}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testXmlSeedWithValue():Void {
		var xml:Xml = Xml.parse('<data>value128</data>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertTrue(seed.isSimple());
		assertMatch({typeName: "data", template: null, name: null, ref: null, key: "$12345678", value: "value128"}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "value", template: null, name: null, ref: null, key: "$12345678", value: "value128"}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testXmlSeedWithAttrValue():Void {
		var xml:Xml = Xml.parse('<data name="name6" ref="ref8" template="template14" valueKey="value42" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertFalse(seed.isSimple());
		assertMatch({typeName: "data", template: "template14", name: "name6", ref: "ref8", key: "$12345678", value: null}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "valueKey", template: null, name: null, ref: "value42", key: "$12345678", value: "value42"}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testXmlSeedWithComplexValue():Void {
		var xml:Xml = Xml.parse('<data>value16<a />value32<b>valueb</b>value64</data>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertFalse(seed.isSimple());
		assertMatch({typeName: "data", template: null, name: null, ref: null, key: "$12345678", value: "value16value32value64"}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "a", template: null, name: null, ref: null, key: "$12345678", value: null}, toHash(iterator.next()));
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "b", template: null, name: null, ref: null, key: "$12345678", value: "valueb"}, toHash(iterator.next()));
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "value", template: null, name: null, ref: null, key: "$12345678", value: "value16value32value64"}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

}
