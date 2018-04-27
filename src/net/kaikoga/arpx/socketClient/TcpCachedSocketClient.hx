package net.kaikoga.arpx.socketClient;

#if (arp_backend_flash || arp_backend_openfl)
import net.kaikoga.arpx.backends.flash.socketClient.TcpCachedSocketClientFlashImpl;
#elseif arp_backend_heaps
import net.kaikoga.arpx.backends.heaps.socketClient.TcpCachedSocketClientHeapsImpl;
#end

@:arpType("socketClient", "tcpCached")
class TcpCachedSocketClient extends SocketClient {

	@:arpField public var host:String;

	#if (arp_backend_flash || arp_backend_openfl)
	@:arpImpl private var flashImpl:TcpCachedSocketClientFlashImpl;
	#elseif arp_backend_heaps
	@:arpImpl private var heapsImpl:TcpCachedSocketClientHeapsImpl;
	#end

	public function new() super();
}


