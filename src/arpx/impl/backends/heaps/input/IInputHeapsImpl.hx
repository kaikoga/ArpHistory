package arpx.impl.backends.heaps.input;

#if arp_input_backend_heaps

import arp.impl.IArpObjectImpl;
import arp.task.ITickable;

interface IInputHeapsImpl extends IArpObjectImpl extends ITickable {
	function listen():Void;
	function purge():Void;
	function tick(timeslice:Float):Bool;
}

#end
