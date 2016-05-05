package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.ds.ISet;
import net.kaikoga.arp.ds.impl.ArraySet;
import net.kaikoga.arp.ds.IList;
import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.domain.IArpObject;

@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("mock", "stdMacro"))
class MockDsMacroArpObject implements IArpObject {

	@:arpValue public var intSet:ISet<Int>;
	@:arpValue public var intList:IList<Int>;
	@:arpValue public var intMap:IMap<String, Int>;
	@:arpValue public var intOmap:IOmap<String, Int>;

	@:arpType("mock") public var refSet:ISet<MockDsMacroArpObject>;
	@:arpType("mock") public var refList:IList<MockDsMacroArpObject>;
	@:arpType("mock") public var refMap:IMap<String, MockDsMacroArpObject>;
	@:arpType("mock") public var refOmap:IOmap<String, MockDsMacroArpObject>;

	@:arpValue public var intISet:ISet<Int> = new ArraySet<Int>();
	@:arpValue public var intArraySet:ArraySet<Int> = new ArraySet<Int>();
	//@:arpValue public var intStdMapSet:StdMapSet<Int>;
	//@:arpType("mock") public var refISet:ISet<MockDsMacroArpObject> = new ArpObjectSet<MockDsMacroArpObject>();
	//@:arpType("mock") public var refArpObjectSet:ArpObjectSet<MockDsMacroArpObject>;

	public function new() {
	}
}
