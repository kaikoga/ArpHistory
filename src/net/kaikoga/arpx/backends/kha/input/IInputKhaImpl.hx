package net.kaikoga.arpx.backends.kha.input;

#if arp_backend_kha

import kha.input.Keyboard;

import net.kaikoga.arp.backends.IArpObjectImpl;
import net.kaikoga.arp.task.ITickable;

interface IInputKhaImpl extends IArpObjectImpl extends ITickable {

	function listen(target:Keyboard):Void;

	function purge():Void;

	function tick(timeslice:Float):Bool;
}

#end
