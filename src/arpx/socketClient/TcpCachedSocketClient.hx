package arpx.socketClient;

#if (arp_socket_backend_flash || arp_socket_backend_openfl)
import arpx.impl.targets.flash.socketClient.TcpCachedSocketClientFlashImpl;
#end

@:arpType("socketClient", "tcpCached")
class TcpCachedSocketClient extends SocketClient {

	@:arpField public var host:String;

	#if (arp_socket_backend_flash || arp_socket_backend_openfl)
	@:arpImpl private var flashImpl:TcpCachedSocketClientFlashImpl;
	#end

	public function new() super();
}


