package net.kaikoga.arp.domain.query;

import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;
import net.kaikoga.arp.domain.core.ArpType;

class ArpObjectQuery<T:IArpObject> extends ArpDirectoryQuery {

	private var type:ArpType;

	inline public function new(root:ArpDirectory, path:String = null, type:ArpType = null) {
		super(root, path);
		this.type = type;
	}

	inline public function slot():ArpSlot<T> {
		var target:ArpDirectory = this.directory();
		return target.getOrCreateSlot(this.type);
	}

	inline public function setSlot(value:ArpSlot<T>):ArpSlot<T> {
		var target:ArpDirectory = this.directory();
		return target.setSlot(this.type, value);
	}

	inline public function value():T {
		return this.slot().value;
	}

}
