package arpx.socketClient;

#if (arp_socket_backend_flash || arp_socket_backend_openfl)
import arpx.impl.targets.flash.socketClient.TcpSocketClientFlashImpl;
#end

@:arpType("socketClient", "tcp")
class TcpSocketClient extends SocketClient {

	@:arpField public var host:String;

	#if (arp_socket_backend_flash || arp_socket_backend_openfl)
	@:arpImpl private var flashImpl:TcpSocketClientFlashImpl;
	#end

	public function new() super();
}


