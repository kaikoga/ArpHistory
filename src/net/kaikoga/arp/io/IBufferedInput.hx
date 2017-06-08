package net.kaikoga.arp.io;

interface IBufferedInput extends IInput {
	var bytesAvailable(get, never):Int;
	function drain():Void;
}

