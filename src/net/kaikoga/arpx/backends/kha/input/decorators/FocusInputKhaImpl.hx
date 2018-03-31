package net.kaikoga.arpx.backends.kha.input.decorators;

#if arp_backend_kha

import kha.input.Keyboard;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.input.decorators.FocusInput;

class FocusInputKhaImpl extends ArpObjectImplBase implements IInputKhaImpl {

	private var input:FocusInput;

	public function new(input:FocusInput) {
		super();
		this.input = input;
	}

	public function listen(target:Keyboard):Void return;
	public function purge():Void return;

	public function tick(timeslice:Float):Bool {
		return true;
	}
}

#end
