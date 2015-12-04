package net.kaikoga.arp.domain.prepare;

import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.domain.ArpSlot.ArpUntypedSlot;

class PrepareTask implements IPrepareTask {

	public var slot(get, never):ArpUntypedSlot;
	private var _slot:ArpUntypedSlot;
	private function get_slot():ArpUntypedSlot return _slot;

	private var domain:ArpDomain;

	private var _preparePropagated:Bool = false;

	public function new(domain:ArpDomain, slot:ArpUntypedSlot) {
		this.domain = domain;
		this._slot = slot;
	}

	public function run():Bool {
		//check if this ref is ultimately unused
		if (this._slot.value == null) {
			if (this._slot.refCount <= 0) return true;
		}

		if (!this._preparePropagated) {
			this._slot.value.arpHeatLater();
			this._preparePropagated = true;
			return false;
		}

		if (this._slot.value.arpHeatUp()) {
			this.domain.log("arp_debug_prepare", 'PrepareTask.run(): prepared: ${this._slot}');
			return true;
		}

		this.domain.log("arp_debug_prepare", 'PrepareTask.run(): waiting depending prepares: ${this._slot}');
		return false;
	}
}
