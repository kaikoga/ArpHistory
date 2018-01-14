﻿package net.kaikoga.arpx.text;

import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.seed.ArpSeed;
import net.kaikoga.arp.structs.ArpParams;

import picotest.PicoAssert.*;

class TextDataCase {

	private var domain:ArpDomain;
	private var me:FixedTextData;

	public function setup() {
		var xml:Xml = Xml.parse('<data>
		<text class="text" name="name1" value="{foo}{bar}" />
		</data>
		').firstElement();
		var seed:ArpSeed = ArpSeed.fromXml(xml);
		domain = new ArpDomain();
		domain.addTemplate(FixedTextData);
		domain.addTemplate(ParametrizedTextData);
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
		var params:ArpParams = new ArpParams();
		params.set("foo", "hoge");
		params.set("bar", "fuga");
		assertEquals("{foo}{bar}", me.publish(params));
	}
}
