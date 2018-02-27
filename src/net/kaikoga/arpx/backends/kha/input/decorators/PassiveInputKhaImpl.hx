package net.kaikoga.arpx.backends.kha.input.decorators;

#if arp_backend_kha

import flash.events.IEventDispatcher;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.input.decorators.PassiveInput;

class PassiveInputKhaImpl extends ArpObjectImplBase implements IInputKhaImpl {

	private var input:PassiveInput;

	public function new(input:PassiveInput) {
		super();
		this.input = input;
	}

	public function listen(target:IEventDispatcher):Void return;
	public function purge():Void return;

	public function tick(timeslice:Float):Bool {
		return true;
	}

}

#end
