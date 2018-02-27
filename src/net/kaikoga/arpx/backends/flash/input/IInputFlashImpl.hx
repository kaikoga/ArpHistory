package net.kaikoga.arpx.backends.flash.input;

#if (arp_backend_flash || arp_backend_openfl)

import flash.events.IEventDispatcher;
import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arp.task.ITickable;

interface IInputFlashImpl extends IArpObjectImpl extends ITickable {

	function listen(target:IEventDispatcher):Void;

	function purge():Void;

	function tick(timeslice:Float):Bool;
}

#end
