package arpx.impl.backends.heaps.input;

#if arp_input_backend_heaps

import hxd.Event;
import hxd.Stage;
import arpx.impl.ArpObjectImplBase;
import arpx.input.KeyInput;

class KeyInputHeapsImpl extends ArpObjectImplBase implements IInputHeapsImpl {

	private var input:KeyInput;

	private var keyStates:Map<Int, Bool>;

	public function new(input:KeyInput) {
		super();
		this.input = input;
		this.keyStates = new Map<Int, Bool>();
	}

	public function listen():Void {
		Stage.getInstance().addEventTarget(onEvent);
	}

	public function purge():Void {
		Stage.getInstance().removeEventTarget(onEvent);
	}

	private function onEvent(e:Event):Void {
		switch( e.kind ) {
			case EKeyDown:
				keyStates.set(e.keyCode, true);
			case EKeyUp:
				keyStates.set(e.keyCode, false);
			case _:
		}
	}

	public function tick(timeslice:Float):Bool {
		for (binding in this.input.keyBindings) {
			if (!this.keyStates.get(binding.keyCode)) continue;
			@:privateAccess this.input.axis(binding.axis).nextValue += binding.factor;
		}
		for (axis in input.inputAxes) axis.tick(timeslice);
		return true;
	}

}

#end
