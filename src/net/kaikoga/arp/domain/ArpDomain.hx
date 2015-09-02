package net.kaikoga.arp.domain;

import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
import net.kaikoga.arp.domain.query.ArpDirectoryQuery;
import net.kaikoga.arp.domain.core.ArpType;
import net.kaikoga.arp.domain.query.ArpObjectQuery;
import net.kaikoga.arp.domain.core.ArpSid;
import net.kaikoga.arp.domain.core.ArpDid;

class ArpDomain {

	public var root(default, null):ArpDirectory;
	private var slots:Map<String, ArpUntypedSlot>;

	private var _sid:Int = 0;
	private var _did:Int = 0;

	public function new() {
		this.root = this.allocDir("");
		this.slots = new Map();
	}

	private function allocSlot(name:String = null):ArpUntypedSlot {
		if (name == null) name = '@s${Std.string(_sid++)}';
		var sid:ArpSid = new ArpSid(name);
		var slot:ArpUntypedSlot = new ArpUntypedSlot(this, sid);
		this.slots.set(cast sid, slot);
		return slot;
	}

	private function allocDir(name:String = null):ArpDirectory {
		if (name == null) name = '@${Std.string(_did++)}';
		var did:ArpDid = new ArpDid(name);
		return new ArpDirectory(this, did);
	}

	private function slot<T:IArpObject>(sid:ArpSid):ArpSlot<T> {
		return this.slots.get(cast sid);
	}

	inline public function dir(path:String = null):ArpDirectory {
		return new ArpDirectoryQuery(this.root, path).directory();
	}

	inline public function query<T:IArpObject>(path:String = null, type:ArpType = null):ArpObjectQuery<T> {
		return new ArpObjectQuery(this.root, path, type);
	}

}
