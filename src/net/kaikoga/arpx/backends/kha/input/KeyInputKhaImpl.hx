package net.kaikoga.arpx.backends.kha.input;

#if arp_backend_kha

import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.KeyboardEvent;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.input.KeyInput;

class KeyInputKhaImpl extends ArpObjectImplBase implements IInputKhaImpl {

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
