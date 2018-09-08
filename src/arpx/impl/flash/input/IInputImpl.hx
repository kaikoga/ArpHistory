package arpx.impl.flash.input;

#if arp_input_backend_flash

import flash.events.IEventDispatcher;
import arp.impl.IArpObjectImpl;
import arp.task.ITickable;

interface IInputImpl extends IArpObjectImpl extends ITickable {
	function listen(target:IEventDispatcher):Void;
	function purge():Void;
	function tick(timeslice:Float):Bool;
}

#end
