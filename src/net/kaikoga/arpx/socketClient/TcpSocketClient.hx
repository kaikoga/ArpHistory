package net.kaikoga.arpx.socketClient;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.socketClient.TcpSocketClientFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.socketClient.TcpSocketClientHeapsImpl;
#end

@:arpType("socketClient", "tcp")
class TcpSocketClient extends SocketClient {

	@:arpField public var host:String;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:TcpSocketClientFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:TcpSocketClientHeapsImpl;
	#end

	public function new() super();
}


