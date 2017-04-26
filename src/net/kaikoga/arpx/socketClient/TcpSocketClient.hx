package net.kaikoga.arpx.socketClient;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.socketClient.TcpSocketClientFlashImpl;
#end

@:build(net.kaikoga.arp.ArpDomainMacros.buildObject("socketClient", "tcp"))
class TcpSocketClient extends SocketClient {

	@:arpField public var host:String;

#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:TcpSocketClientFlashImpl;
#else
	@:arpWithoutBackend
#end
	public function new () {
		super();
	}

}


