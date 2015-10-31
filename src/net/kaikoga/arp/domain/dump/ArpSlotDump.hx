package net.kaikoga.arp.domain.dump;

import net.kaikoga.arp.ds.Tree;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
import net.kaikoga.arp.ds.tree.ITreePrinter;

class ArpSlotDump {

	public var slot:ArpUntypedSlot;
	public var dir:ArpDirectory;
	public var id:String;
	public var hashKey:String;
	public var refCount:Int = 1;
	public var status:String = "?";

	private function new(dir:ArpDirectory = null, slot:ArpUntypedSlot = null, hashKey:String = null) {
		this.hashKey = hashKey;
		this.id = "<slots>";
		if (slot != null) {
			this.slot = slot;
			this.id = slot.sid.toString();
		}
		if (dir != null) {
			this.dir = dir;
			this.id = dir.did.toString();
		}
	}

	public static function ofDir(dir:ArpDirectory = null, hashKey:String = null):Tree<ArpSlotDump> {
		return new Tree(new ArpSlotDump(dir, null, hashKey));
	}

	public static function ofSlot(slot:ArpUntypedSlot = null, hashKey:String = null):Tree<ArpSlotDump> {
		return new Tree(new ArpSlotDump(null, slot, hashKey));
	}

	public static function compareTreeId(a:Tree<ArpSlotDump>, b:Tree<ArpSlotDump>):Int {
		var ai:String = a.value.id;
		var bi:String = b.value.id;
		if (ai > bi) return 1;
		if (ai < bi) return -1;
		return 0;
	}
}

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
			result += indent + "   }\n";
		} else {
			result += entry + "\n";
		}
		return result;
	}
}
