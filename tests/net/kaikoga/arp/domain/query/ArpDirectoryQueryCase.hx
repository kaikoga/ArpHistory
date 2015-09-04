package net.kaikoga.arp.domain.query;

import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.mocks.MockArpObject;

import picotest.PicoAssert.*;

class ArpDirectoryQueryCase {

	private var domain:ArpDomain;
	private var child:ArpDirectory;
	private var dir:ArpDirectory;
	private var arpObject:IArpObject;
	private var arpType:ArpType;
	
	public function setup():Void {
		domain = new ArpDomain();
		child = domain.root.trueChild("path");
		dir = child.trueChild("to").trueChild("dir");
		arpObject = new MockArpObject();
		arpType = arpObject.arpType();
		dir.addArpObject(arpObject);
	}

	public function testAbsoluteDirectoryFromRoot():Void {
		var query:ArpDirectoryQuery = new ArpDirectoryQuery(domain.root, "/path/to/dir");
		var actual:ArpDirectory = query.directory();
		assertEquals(dir, actual);
	}

	public function testRelativeDirectoryFromRoot():Void {
		var query:ArpDirectoryQuery = new ArpDirectoryQuery(domain.root, "path/to/dir");
		var actual:ArpDirectory = query.directory();
		assertEquals(dir, actual);
	}

	public function testAbsoluteDirectory():Void {
		var query:ArpDirectoryQuery = new ArpDirectoryQuery(child, "/path/to/dir");
		var actual:ArpDirectory = query.directory();
		assertEquals(dir, actual);
	}

	public function testRelativeDirectory():Void {
		var query:ArpDirectoryQuery = new ArpDirectoryQuery(child, "to/dir");
		var actual:ArpDirectory = query.directory();
		assertEquals(dir, actual);
	}

}
