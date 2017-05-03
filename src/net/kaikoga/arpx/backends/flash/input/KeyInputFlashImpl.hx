package net.kaikoga.arpx.backends.flash.input;

import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.input.InputAxis;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.IEventDispatcher;

import net.kaikoga.arpx.input.KeyInput;

class KeyInputFlashImpl extends ArpObjectImplBase implements IInputFlashImpl {

	private var input:KeyInput;

	private var target:IEventDispatcher;
	private var keyStates:Map<Int, Bool>;

	public function new(input:KeyInput) {
		super();
		this.input = input;
		this.keyStates = new Map<Int, Bool>();
	}

	public function listen(target:IEventDispatcher):Void {
		this.target = target;
		this.target.addEventListener(Event.DEACTIVATE, this.onDeactivate);
		this.target.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
		this.target.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
	}

	public function purge():Void {
		this.target.removeEventListener(Event.DEACTIVATE, this.onDeactivate);
		this.target.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
		this.target.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
		this.target = null;
	}

	private function onDeactivate(event:Event):Void {
		this.input.clear();
	}

	private function onKeyDown(event:KeyboardEvent):Void {
		keyStates.set(event.keyCode, true);
	}

	private function onKeyUp(event:KeyboardEvent):Void {
		keyStates.set(event.keyCode, false);
	}

	public function tick(timeslice:Float):Void {
		input.clear();
		for (keyCode in this.keyStates.keys()) {
			if (!this.keyStates.get(keyCode)) continue;

			var binding:KeyInputBinding = this.input.keyBindings.get(keyCode);
			if (binding != null) {
				var axis:InputAxis = this.input.axis(binding.axis);
				axis.nextValue += binding.factor;
			}
		}
		for (axis in input.inputAxes) axis.tick(timeslice);
	}

}
