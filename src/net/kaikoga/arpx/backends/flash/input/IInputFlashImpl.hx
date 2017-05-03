package net.kaikoga.arpx.backends.flash.input;

import net.kaikoga.arp.backends.IArpObjectImpl;
import flash.events.IEventDispatcher;

interface IInputFlashImpl extends IArpObjectImpl {

	public function listen(target:IEventDispatcher):Void;

	public function purge():Void;

	public function tick(timeslice:Float):Void;

}
