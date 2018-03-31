package net.kaikoga.arpx.backends.kha.input;

#if arp_backend_kha

import kha.input.KeyCode;
import kha.input.Keyboard;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.input.KeyInput;

class KeyInputKhaImpl extends ArpObjectImplBase implements IInputKhaImpl {

	private var input:KeyInput;

	private var target:Keyboard;

	private var keyStates:Map<Int, Bool>;

	public function new(input:KeyInput) {
		super();
		this.input = input;
		this.keyStates = new Map<Int, Bool>();
	}

	public function listen(target:Keyboard):Void {
		this.target = target;
		this.target.notify(this.onKeyDown, this.onKeyUp, null);
	}

	public function purge():Void {
		this.target.remove(this.onKeyDown, this.onKeyUp, null);
		this.target = null;
	}

	private function onKeyDown(keyCode:KeyCode):Void {
		keyStates.set(cast keyCode, true);
	}

	private function onKeyUp(keyCode:KeyCode):Void {
		keyStates.set(cast keyCode, false);
	}

	public function tick(timeslice:Float):Bool {
		for (binding in this.input.keyBindings) {
			if (!this.keyStates.get(binding.keyCode)) continue;
			this.input.axis(binding.axis).nextValue += binding.factor;
		}
		for (axis in input.inputAxes) axis.tick(timeslice);
		return true;
	}

}

#end
