package net.kaikoga.arpx.socketClient;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.socketClient.TcpSocketClientFlashImpl;
#end

#if arp_backend_kha
import net.kaikoga.arpx.backends.kha.socketClient.TcpSocketClientKhaImpl;
#end

@:arpType("socketClient", "tcp")
class TcpSocketClient extends SocketClient {

	@:arpField public var host:String;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:TcpSocketClientFlashImpl;
	#end

	#if arp_backend_kha
	@:arpImpl private var khaImpl:TcpSocketClientKhaImpl;
	#end

	public function new() super();
}


