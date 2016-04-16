package net.kaikoga.arpx.text;

import net.kaikoga.arp.domain.gen.ArpObjectGenerator;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.domain.core.ArpType;

import picotest.PicoAssert.*;

class ParametrizedTextDataCase {

	private var domain:ArpDomain;
	private var me:ParametrizedTextData;

	public function setup() {
		var xml:Xml = Xml.parse('<data>
		<text class="ptext" name="name1" value="{foo}{bar}" />
		</data>
		').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		domain = new ArpDomain();
		domain.addGenerator(new ArpObjectGenerator(FixedTextData));
		domain.addGenerator(new ArpObjectGenerator(ParametrizedTextData));
		domain.loadSeed(seed);
		me = domain.query("name1", new ArpType("text")).value();
	}

	public function testFields() {
		assertEquals("{foo}{bar}", me.value);
	}

	public function testPublish() {
		assertEquals("{foo}{bar}", me.publish(null));
	}

	public function testComplexPublish() {
		var map:Map<String, Dynamic> = new Map();
		map.set("foo", "hoge");
		map.set("bar", "fuga");
		assertEquals("hogefuga", me.publish(map));
	}

}
