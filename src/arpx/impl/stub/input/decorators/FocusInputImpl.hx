package arpx.impl.stub.input.decorators;

#if arp_input_backend_stub

import arpx.impl.ArpObjectImplBase;
import arpx.input.decorators.FocusInput;

class FocusInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:FocusInput;

	public function new(input:FocusInput) {
		super();
		this.input = input;
	}

	public function listen():Void return;
	public function purge():Void return;

	public function tick(timeslice:Float):Bool return true;
}

#end