package net.kaikoga.arpx.logger;

import net.kaikoga.arpx.socketClient.SocketClient;
@:build(net.kaikoga.arp.macro.MacroArpObjectBuilder.build("logger", "socketClient"))
class SocketClientLogger extends Logger {

	@:arpField @:arpBarrier public var socketClient:SocketClient;

	public function new() {
		super();
	}

	override public function log(category:String, message:String):Void {
		if (!this.respondsTo(category)) return;
		try {
			this.socketClient.writeUtfBlob("[" + category + "]" + StringTools.replace(message, "\n", "\n ") + "\n");
		} catch (d:Dynamic) {
			// ignore
		}
	}
}


