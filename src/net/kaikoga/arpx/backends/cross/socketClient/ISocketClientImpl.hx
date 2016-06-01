package net.kaikoga.arpx.backends.cross.socketClient;

import net.kaikoga.arp.io.IOutput;
import net.kaikoga.arp.io.IInput;

interface ISocketClientImpl extends IInput extends IOutput {
	function heatUp():Bool;
	function heatDown():Bool;
}


