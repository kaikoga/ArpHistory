package net.kaikoga.arpx.impl.backends.heaps.input;

#if arp_backend_heaps

import net.kaikoga.arp.impl.IArpObjectImpl;
import net.kaikoga.arp.task.ITickable;

interface IInputHeapsImpl extends IArpObjectImpl extends ITickable {
	function listen():Void;
	function purge():Void;
	function tick(timeslice:Float):Bool;
}

#end
