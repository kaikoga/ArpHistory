package arpx.impl.backends.flash.input.decorators;

#if (arp_input_backend_flash || arp_input_backend_openfl)

import flash.events.IEventDispatcher;
import arpx.impl.ArpObjectImplBase;
import arpx.input.decorators.PassiveInput;

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
