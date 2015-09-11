package net.kaikoga.arp.domain.prepare;

import net.kaikoga.arp.domain.prepare.PrepareTaskManager;

import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.domain.ArpObjectSlot;
import net.kaikoga.arp.domain.ArpTemperatures;
import net.kaikoga.arp.domain.IArpBankEntryGenerator;

class PrepareChildTask implements IPrepareTask {
	public var slot(get, never):ArpObjectSlot;
	public var heat(get, never):Int;

	private var manager:PrepareTaskManager;
	private var domain:ArpDomain;

	private var _slot:ArpObjectSlot;

	private function get_Slot():ArpObjectSlot {
		return _slot;
	}

	private var _heat:Int;

	private function get_Heat():Int {
		return _heat;
	}

	private var parentSlot:ArpObjectSlot;
	private var key:String;

	public function new(manager:PrepareTaskManager, domain:ArpDomain, parentSlot:ArpObjectSlot, key:String, slot:ArpObjectSlot, heat:Int) {
		super();
		this.manager = manager;
		this.domain = domain;
		this.parentSlot = parentSlot;
		this.key = key;
		this._slot = slot;
		this._heat = heat;
	}

	public function run():Bool {
		if (!this._slot.value) {
			//check if this ref is ultimately unused
			if (this._slot.refCount <= 0) {
				return true;
			} //try to create child  

			var parentValue:IArpBankEntryGenerator = try cast(this.parentSlot.value, IArpBankEntryGenerator) catch (e:Dynamic) null;
			if (parentValue != null) {
				parentValue.createChild(this._slot, this.key, this._heat);
			}
		}
		var status:String = this.manager.taskStatus;
		if (this._slot) {
			if (this._slot.heatTo(this._heat)) {
				this.domain.log("arp_debug_prepare", "PrepareTask.run(): prepared: " + status + this._slot);
				return true;
			}
		}

		this.domain.log("arp_debug_prepare", "PrepareTask.run(): waiting parent prepare: " + status + this._slot);
		this.domain.prepareLater(this.parentSlot, ArpTemperatures.HOT);
		//this.manager.waitBySlot(this._slot);
		return false;
	}
}

