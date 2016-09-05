package net.kaikoga.arpx.backends.flash.input;

import flash.events.IEventDispatcher;

interface IInputFlashImpl {

	public function listen(target:IEventDispatcher):Void;

	public function purge():Void;

	public function tick(timeslice:Float):Void;

}
