package arpx.impl.sys.input;

#if arp_input_backend_sys

import arpx.impl.ArpObjectImplBase;
import arpx.input.KeyInput;

class KeyInputImpl extends ArpObjectImplBase implements IInputImpl {

	private var input:KeyInput;

	public function new(input:KeyInput) {
		super();
		this.input = input;
	}

	public function listen():Void return;
	public function purge():Void return;
	public function tick(timeslice:Float):Bool return true;

}

#end
