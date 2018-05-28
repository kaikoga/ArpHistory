package net.kaikoga.arpx.socketClient;

#if (flash || openfl)
import net.kaikoga.arpx.impl.targets.flash.socketClient.TcpCachedSocketClientFlashImpl;
#end

@:arpType("socketClient", "tcpCached")
class TcpCachedSocketClient extends SocketClient {

	@:arpField public var host:String;

	#if (flash || openfl)
	@:arpImpl private var flashImpl:TcpCachedSocketClientFlashImpl;
	#end

	public function new() super();
}


