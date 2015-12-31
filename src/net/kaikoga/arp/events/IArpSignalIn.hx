package net.kaikoga.arp.events;

interface IArpSignalIn<T> {

	function willTrigger():Bool;
	function dispatch(event:T):Void;

}
