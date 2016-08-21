package net.kaikoga.arpx.logger;

import net.kaikoga.arp.domain.events.ArpLogEvent;
import net.kaikoga.arpx.socketClient.SocketClient;

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("logger", "socketClient"))
class SocketClientLogger extends Logger {

	@:arpField @:arpBarrier public var socketClient:SocketClient;

	public function new() {
		super();
	}

	override public function log(event:ArpLogEvent):Void {
		if (!this.respondsTo(event.category)) return;
		try {
			this.socketClient.writeUtfBlob("[" + event.category + "]" + StringTools.replace(event.message, "\n", "\n ") + "\n");
		} catch (d:Dynamic) {
			// ignore
		}
	}
}


