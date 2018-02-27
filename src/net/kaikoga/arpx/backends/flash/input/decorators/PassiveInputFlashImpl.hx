package net.kaikoga.arpx.backends.flash.input.decorators;

#if (arp_backend_flash || arp_backend_openfl)

import flash.events.IEventDispatcher;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.input.decorators.PassiveInput;

class PassiveInputFlashImpl extends ArpObjectImplBase implements IInputFlashImpl {

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
