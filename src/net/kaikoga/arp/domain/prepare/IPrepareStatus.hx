package net.kaikoga.arp.domain.prepare;

import net.kaikoga.arp.events.ArpProgressEvent;
import net.kaikoga.arp.events.IArpSignalOut;

interface IPrepareStatus {

	var isPending(get, never):Bool;
	var tasksProcessed(get, never):Int;
	var tasksTotal(get, never):Int;
	var tasksWaiting(get, never):Int;
	var taskStatus(get, never):String;

	public var onComplete(get, never):IArpSignalOut<Int>;
	public var onError(get, never):IArpSignalOut<Dynamic>;
	public var onProgress(get, never):IArpSignalOut<ArpProgressEvent>;
}
