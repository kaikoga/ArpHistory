package net.kaikoga.arp.backends;

interface IArpObjectImpl {
	function arpHeatUp():Bool;
	function arpHeatDown():Bool;
	function arpDispose():Void;
}
