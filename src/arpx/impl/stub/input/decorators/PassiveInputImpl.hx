package arpx.impl.stub.input.decorators;

#if arp_input_backend_stub

import arpx.impl.ArpObjectImplBase;
import arpx.input.decorators.PassiveInput;

class PassiveInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:PassiveInput;

	public function new(input:PassiveInput) {
		super();
		this.input = input;
	}

	public function listen():Void return;
	public function purge():Void return;

	public function tick(timeslice:Float):Bool return true;

}

#end
