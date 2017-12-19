package net.kaikoga.arpx.backends.flash.input.decorators;

import flash.events.IEventDispatcher;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.input.decorators.PassiveInput;
import net.kaikoga.arpx.input.InputAxis;
import net.kaikoga.arpx.input.KeyInput;

class PassiveInputFlashImpl extends ArpObjectImplBase implements IInputFlashImpl {

	private var input:PassiveInput;

	public function new(input:PassiveInput) {
		super();
		this.input = input;
	}

	public function listen(target:IEventDispatcher):Void return;
	public function purge():Void return;

	public function tick(timeslice:Float):Bool {
		for (keyCode in this.keyStates.keys()) {
			if (!this.keyStates.get(keyCode)) continue;

			var binding:KeyInputBinding = this.input.keyBindings.get(keyCode);
			if (binding != null) {
				var axis:InputAxis = this.input.axis(binding.axis);
				axis.nextValue += binding.factor;
			}
		}
		for (axis in input.inputAxes) axis.tick(timeslice);
		return true;
	}

}
