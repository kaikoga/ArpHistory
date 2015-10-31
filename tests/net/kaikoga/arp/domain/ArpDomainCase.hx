package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.gen.ArpDynamicGenerator;
import net.kaikoga.arp.domain.mocks.MockArpObject;
import net.kaikoga.arp.domain.seed.ArpSeed;
import net.kaikoga.arp.domain.core.ArpType;

import picotest.PicoAssert.*;

class ArpDomainCase {

	private var domain:ArpDomain;
	private var xml:Xml;
	private var seed:ArpSeed;

	public function setup():Void {
		domain = new ArpDomain();
		domain.addGenerator(new ArpDynamicGenerator(new ArpType("TestArpObject"), MockArpObject));
		xml = Xml.parse('
		<data name="name1" intField="42" floatField="3.14" boolField="true" stringField="stringValue" refField="/name1" />
		').firstElement();
		seed = ArpSeed.fromXml(xml);
		domain.loadSeed(seed, new ArpType("TestArpObject"));
	}

	public function testDumpEntries():Void {
		var DUMP:String = "? <slots> [1] {
?    [1]
?   /name1:TestArpObject [1]
   }
";
		var DUMP_BY_NAME:String = "?  [1] {
?   name1: /name1 [1] {
?     <TestArpObject>: /name1:TestArpObject [1]
     }
   }
";
		assertEquals(DUMP, domain.dumpEntries());
		assertEquals(DUMP_BY_NAME, domain.dumpEntriesByName());
		fail();
	}

}
