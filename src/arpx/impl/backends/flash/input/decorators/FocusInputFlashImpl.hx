package arpx.impl.backends.flash.input.decorators;

#if (arp_backend_flash || arp_backend_openfl)

import flash.events.IEventDispatcher;
import arpx.impl.ArpObjectImplBase;
import arpx.input.decorators.FocusInput;

class FocusInputFlashImpl extends ArpObjectImplBase implements IInputFlashImpl {

	private var input:FocusInput;

	public function new(input:FocusInput) {
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
