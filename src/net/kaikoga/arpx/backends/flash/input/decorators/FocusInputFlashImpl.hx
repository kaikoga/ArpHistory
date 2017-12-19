package net.kaikoga.arpx.backends.flash.input.decorators;

import flash.events.IEventDispatcher;
import net.kaikoga.arpx.backends.ArpObjectImplBase;
import net.kaikoga.arpx.input.decorators.FocusInput;

class FocusInputFlashImpl extends ArpObjectImplBase implements IInputFlashImpl {

	private var input:FocusInput;

	public function new(input:FocusInput) {
		super();
		this.input = input;
	}

	public function listen(target:IEventDispatcher):Void return;
	public function purge():Void return;

	public function tick(timeslice:Float):Bool {
		return true;
	}
}
