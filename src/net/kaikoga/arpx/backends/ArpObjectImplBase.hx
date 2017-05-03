package net.kaikoga.arpx.backends;

import net.kaikoga.arp.backends.IArpObjectImpl;

class ArpObjectImplBase implements IArpObjectImpl {
	public function new() return;
	public function arpHeatUp():Bool return true;
	public function arpHeatDown():Bool return true;
	public function arpDispose():Void return;
}


