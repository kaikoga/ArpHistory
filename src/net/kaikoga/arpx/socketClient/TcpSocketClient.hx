package net.kaikoga.arpx.socketClient;

import net.kaikoga.arp.events.ArpProgressEvent;
import net.kaikoga.arp.events.ArpSignal;
import net.kaikoga.arpx.backends.cross.socketClient.ISocketClientImpl;

#if flash
import net.kaikoga.arpx.backends.flash.socketClient.TcpSocketClientFlashImpl;
#end

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("socketClient", "tcp"))
class TcpSocketClient extends SocketClient {

	@:arpField public var host:String;

	#if arp_backend_flash

	override private function createImpl(onData:ArpSignal<ArpProgressEvent>):ISocketClientImpl return new TcpSocketClientFlashImpl(this, onData);

	public function new() {
		super();
	}

	#else

	@:arpWithoutBackend
	public function new () {
		super();
	}

	#end
}


