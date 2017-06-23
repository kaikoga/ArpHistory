package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.ds.ISet;
import net.kaikoga.arp.ds.impl.ArraySet;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.domain.IArpObject;

@:arpType("mock", "stdMacro")
class MockDsMacroArpObject implements IArpObject {

	@:arpField public var intSet:ISet<Int>;
	@:arpField public var intList:IList<Int>;
	@:arpField public var intMap:IMap<String, Int>;
	@:arpField public var intOmap:IOmap<String, Int>;

	@:arpField public var refSet:ISet<MockDsMacroArpObject>;
	@:arpField public var refList:IList<MockDsMacroArpObject>;
	@:arpField public var refMap:IMap<String, MockDsMacroArpObject>;
	@:arpField public var refOmap:IOmap<String, MockDsMacroArpObject>;

	@:arpField public var intISet:ISet<Int> = new ArraySet<Int>();
	@:arpField public var intArraySet:ArraySet<Int> = new ArraySet<Int>();
	// @:arpField public var intStdMapSet:StdMapSet<Int>;
	// @:arpField public var refISet:ISet<MockDsMacroArpObject> = new ArpObjectSet<MockDsMacroArpObject>();
	// @:arpField public var refArpObjectSet:ArpObjectSet<MockDsMacroArpObject>;

	public function new() {
	}
}
