package arpx.impl.backends.heaps.input.decorators;

#if arp_input_backend_heaps

import arpx.impl.ArpObjectImplBase;
import arpx.input.decorators.PassiveInput;

class PassiveInputHeapsImpl extends ArpObjectImplBase implements IInputHeapsImpl {

	private var input:PassiveInput;

	public function new(input:PassiveInput) {
		super();
		this.input = input;
	}

	public function listen():Void return;
	public function purge():Void return;

	public function tick(timeslice:Float):Bool {
		return true;
	}

}

#end
