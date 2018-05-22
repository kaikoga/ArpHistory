package net.kaikoga.arp.tests;

import net.kaikoga.arp.tests.ArpDomainTestUtil;
import picotest.PicoAssert.*;

class ArpDomainTestUtilCase {

	public function testString() {
		assertEquals("bar", ArpDomainTestUtil.string("assets/test.txt", "foo"));
		assertEquals("fuga\npiyo", ArpDomainTestUtil.string("assets/test.txt", "hoge"));
		assertEquals("!!! section not found assets/test.txt spam !!!", ArpDomainTestUtil.string("assets/test.txt", "spam"));
		assertEquals("!!! file not found assets/foo.txt bar !!!", ArpDomainTestUtil.string("assets/foo.txt", "bar"));
	}
}
