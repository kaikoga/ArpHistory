package net.kaikoga.arpx.backends.flash.input;

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arp.task.ITickable;
import flash.events.IEventDispatcher;

interface IInputFlashImpl extends IArpObjectImpl extends ITickable {

	function listen(target:IEventDispatcher):Void;

	function purge():Void;

	function tick(timeslice:Float):Bool;
}
