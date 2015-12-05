package net.kaikoga.arp.domain.prepare;

import net.kaikoga.arp.task.TaskStatus;
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

	public function run():TaskStatus {
		if (this._slot.value == null) {
			if (this._slot.refCount <= 0) {
				this.domain.log("arp_debug_prepare", 'PrepareTask.run(): ultimate unused and prepare canceled: ${this._slot}');
				return TaskStatus.Complete;
			}
		}

		if (!this._preparePropagated) {
			this._slot.value.arpHeatLater();
			this._preparePropagated = true;
			return TaskStatus.Progress;
		}

		if (this._slot.value.arpHeatUp()) {
			this.domain.log("arp_debug_prepare", 'PrepareTask.run(): prepared: ${this._slot}');
			return TaskStatus.Complete;
		}

		this.domain.log("arp_debug_prepare", 'PrepareTask.run(): waiting depending prepares: ${this._slot}');
		return TaskStatus.Stalled;
	}
}
