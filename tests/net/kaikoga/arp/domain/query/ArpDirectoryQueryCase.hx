package net.kaikoga.arp.domain.query;

import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.mocks.MockArpObject;

import picotest.PicoAssert.*;

class ArpDirectoryQueryCase {

	private var domain:ArpDomain;
	private var dir:ArpDirectory;
	private var arpObject:IArpObject;
	private var arpType:ArpType;
	
	public function setup():Void {
		domain = new ArpDomain();
		dir = domain.root.trueChild("path").trueChild("to").trueChild("dir");
		arpObject = new MockArpObject();
		arpType = arpObject.arpType();
		dir.addArpObject(arpObject);
	}

	public function testDirectory():Void {
		var query:ArpDirectoryQuery = new ArpDirectoryQuery(domain.root, "path/to/dir");
		var actual:ArpDirectory = query.directory();
		assertEquals(dir, actual);
	}

}
