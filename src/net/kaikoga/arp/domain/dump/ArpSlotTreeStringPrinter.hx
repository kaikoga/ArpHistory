package net.kaikoga.arp.domain.dump;

import net.kaikoga.arp.ds.Tree;
import net.kaikoga.arp.ds.tree.ITreePrinter;

class ArpSlotTreeStringPrinter implements ITreePrinter<ArpSlotDump, String> {

	public function new() {
	}

	public function format(tree:Tree<ArpSlotDump>, depth:Int = -1, level:Int = 0):String {
		var item:ArpSlotDump = tree.value;
		var indent:String = StringTools.lpad("", " ", level * 2);
		var result = "";
		var entry:String = item.status + " " + indent;
		if (item.hashKey != null) {
			entry += item.hashKey + ": ";
		}
		entry += item.id + " [" + item.refCount + "]";
		if (depth != 0 && tree.hasChildren) {
			result += entry + " {\n";
			for (item in tree.children) {
				result += format(item, depth - 1, level + 1);
			}
			result += indent + "  }\n";
		} else {
			result += entry + "\n";
		}
		return result;
	}
}
