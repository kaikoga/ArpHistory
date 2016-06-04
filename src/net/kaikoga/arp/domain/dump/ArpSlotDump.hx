package net.kaikoga.arp.domain.dump;

import net.kaikoga.arp.ds.Tree;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;

class ArpSlotDump {

	public var slot:ArpUntypedSlot;
	public var dir:ArpDirectory;
	public var id:String;
	public var hashKey:String;
	public var refCount:Int = 0;
	public var status:String = "?";

	@:access(net.kaikoga.arp.domain.ArpUntypedSlot._refCount)
	private function new(dir:ArpDirectory = null, slot:ArpUntypedSlot = null, hashKey:String = null) {
		this.hashKey = hashKey;
		this.id = "<slots>";
		if (slot != null) {
			this.slot = slot;
			this.refCount = slot._refCount;
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
