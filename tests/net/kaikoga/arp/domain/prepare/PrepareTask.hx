package net.kaikoga.arp.domain.prepare;

import net.kaikoga.arp.domain.prepare.PrepareTaskManager;

import net.kaikoga.arp.domain.ArpDomain;
import net.kaikoga.arp.domain.ArpObjectSlot;
import net.kaikoga.arp.domain.ArpTemperatures;

class PrepareTask implements IPrepareTask {
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

	private var _heatPropagated:Bool = false;

	public function new(manager:PrepareTaskManager, domain:ArpDomain, slot:ArpObjectSlot, heat:Int) {
		super();
		this.manager = manager;
		this.domain = domain;
		this._slot = slot;
		this._heat = heat;
	}

	public function run():Bool {
		if (!this._slot.value) {
			//check if this ref is ultimately unused
			if (this._slot.refCount <= 0) {
				return true;
			}
		}
		var status:String = this.manager.taskStatus + this._slot + " -> " + ArpTemperatures.nameByValue(this._heat);
		//postpone if this ref has dependencies not loaded yet
		if (this._slot.potentialTemperatureLate == ArpTemperatures.VOID) {
			this.domain.log("arp_debug_prepare", "PrepareTask.run(): waiting depending prepares(unloaded): " + status);
			return false;
		} //prepare if this ref can be prepared now  

		if (this._slot.heatTo(this._heat)) {
			this.domain.log("arp_debug_prepare", "PrepareTask.run(): prepared: " + status);
			return true;
		} //late prepare triggers heat propagation if not triggered yet  

		if (!this._heatPropagated) {
			for (obj/* AS3HX WARNING could not determine type for var: obj exp: ECall(EField(EField(EIdent(this),_slot),waitsFor),[EField(EIdent(this),_heat)]) type: null */ in this._slot.waitsFor(this._heat)) {
				if (obj) {
					this.domain.prepareLater(obj.arpSlot, this._heat);
				}
				else {
					this.domain.log("arp_debug_prepare", "PrepareTask.run(): invalid reference found from " + this._slot);
				}
			}
			this._heatPropagated = true;
		}
		this.domain.log("arp_debug_prepare", "PrepareTask.run(): waiting depending prepares: " + status);
		//this.manager.waitBySlot(this._slot);
		return false;
	}
}
