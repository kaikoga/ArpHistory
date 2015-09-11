package net.kaikoga.arp.domain.dump;

import net.kaikoga.arp.ds.TreeItem;
import net.kaikoga.arp.ds.tree.ITreePrinter;

class ArpSlotDump extends TreeItem<ArpSlot> {

	public var hashKey:String;
	public var slotRefCount:Int = 1;

	public function ArpObjectSlotStatus(slot:ArpSlot, hashKey:String = null) {
		super(slot.sid.toString(), Std.string(slot));
		this.hashKey = hashKey;
	}
}

class ArpSlotTreeStringPrinter implements ITreePrinter<ArpSlotDump> {

	public function new() {
	}

	public function format(tree:Array<ArpSlotDump>, depth:Int = -1, level:Int = 0):Dynamic {
		var result:String = "";
		var indent:String = StringTools.lpad("", " ", level * 2);
		for (item in tree) {
			var entry:String = item.slotStatus + " " + indent;
			if (item.hashKey) {
				entry += item.hashKey + ": ";
			}
			entry += item.value + " [" + item.slotRefCount + "]";
			if (depth && item.hasChildren) {
				result += entry + " {\n";
				result += format(item.children, depth - 1, level + 1);
				result += indent + "   }\n";
			} else {
				result += entry + "\n";
			}
		}
		return result;

	}
}
