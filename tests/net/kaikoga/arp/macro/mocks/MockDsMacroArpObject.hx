package net.kaikoga.arp.macro.mocks;

import net.kaikoga.arp.ds.IList;
import net.kaikoga.arp.ds.IMap;
import net.kaikoga.arp.ds.IOmap;
import net.kaikoga.arp.ds.ISet;
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

	public function new() {
	}
}
