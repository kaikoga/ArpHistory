package net.kaikoga.arp.seed;

import net.kaikoga.arp.utils.ArpIdGenerator;
import picotest.PicoAssert.*;
import org.hamcrest.Matcher;
import org.hamcrest.Matchers;

class ArpSeedCase {

	private var autoKey(get, never):Matcher<Dynamic>;
	public function get_autoKey():Matcher<Dynamic> return Matchers.startsWith(ArpIdGenerator.AUTO_HEADER);

	private function toHash(seed:ArpSeed) return {
		typeName: Std.string(seed.typeName()),
		className: seed.className(),
		name: seed.name(),
		ref: seed.ref(),
		key: seed.key(),
		value: seed.value()
	};

	public function testEmptyXmlSeed():Void {
		var xml:Xml = Xml.parse('<root />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertTrue(seed.isSimple());
		assertMatch({typeName: "root", className: null, name: null, ref: null, key: autoKey, value: null}, toHash(seed));
		var iterator = seed.iterator();
		assertFalse(iterator.hasNext());
	}

	public function testSimpleXmlSeed():Void {
		var xml:Xml = Xml.parse('<data name="name6" ref="ref8" class="className14" key="key28" value="value42" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertTrue(seed.isSimple());
		assertMatch({typeName: "data", className: "className14", name: "name6", ref: "ref8", key:"key28", value: "value42"}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "value", className: null, name: null, ref: null, key: autoKey, value: "value42"}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testXmlSeedWithValue():Void {
		var xml:Xml = Xml.parse('<data>value128</data>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertTrue(seed.isSimple());
		assertMatch({typeName: "data", className: null, name: null, ref: null, key: autoKey, value: "value128"}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "value", className: null, name: null, ref: null, key: autoKey, value: "value128"}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testXmlSeedWithAttrValue():Void {
		var xml:Xml = Xml.parse('<data name="name6" ref="ref8" class="className14" valueKey="value42" />').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertFalse(seed.isSimple());
		assertMatch({typeName: "data", className: "className14", name: "name6", ref: "ref8", key: autoKey, value: null}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "valueKey", className: null, name: null, ref: "value42", key: autoKey, value: "value42"}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

	public function testXmlSeedWithComplexValue():Void {
		var xml:Xml = Xml.parse('<data>value16<a />value32<b>valueb</b>value64</data>').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		assertFalse(seed.isSimple());
		assertMatch({typeName: "data", className: null, name: null, ref: null, key: autoKey, value: "value16value32value64"}, toHash(seed));
		var iterator = seed.iterator();
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "a", className: null, name: null, ref: null, key: autoKey, value: null}, toHash(iterator.next()));
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "b", className: null, name: null, ref: null, key: autoKey, value: "valueb"}, toHash(iterator.next()));
		assertTrue(iterator.hasNext());
		assertMatch({typeName: "value", className: null, name: null, ref: null, key: autoKey, value: "value16value32value64"}, toHash(iterator.next()));
		assertFalse(iterator.hasNext());
	}

}
