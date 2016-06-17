package net.kaikoga.arp.domain.dump;

import net.kaikoga.arp.ds.Tree;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;

class ArpDump {

	public var slot:ArpUntypedSlot;
	public var dir:ArpDirectory;
	public var id:String;
	public var hashKey:String;
	public var refCount:Int = 0;
	public var status:String;

	public var isDir(get, never):Bool;
	private function get_isDir():Bool return status == null;

	@:access(net.kaikoga.arp.domain.ArpUntypedSlot._refCount)
	private function new(dir:ArpDirectory = null, slot:ArpUntypedSlot = null, hashKey:String = null) {
		this.hashKey = hashKey;
		this.id = "<slots>";
		if (slot != null) {
			this.slot = slot;
			this.refCount = slot._refCount;
			this.id = slot.sid.toString();
			this.status = (slot.value == null) ? "." : slot.heat.toChar();
		} else if (dir != null) {
			this.dir = dir;
			this.id = dir.did.toString();
			this.status = null;
		} else {
			throw "slot or dir is required.";
		}
	}

	public static function ofDir(dir:ArpDirectory = null, hashKey:String = null):Tree<ArpDump> {
		return new Tree(new ArpDump(dir, null, hashKey));
	}

	public static function ofSlot(slot:ArpUntypedSlot = null, hashKey:String = null):Tree<ArpDump> {
		return new Tree(new ArpDump(null, slot, hashKey));
	}

	public static function compareTreeId(a:Tree<ArpDump>, b:Tree<ArpDump>):Int {
		var ai:String = a.value.id;
		var bi:String = b.value.id;
		if (ai > bi) return 1;
		if (ai < bi) return -1;
		return 0;
	}
}
