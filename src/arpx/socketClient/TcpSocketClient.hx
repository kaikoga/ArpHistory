package arpx.socketClient;

#if (flash || openfl)
import arpx.impl.targets.flash.socketClient.TcpSocketClientFlashImpl;
#end

@:arpType("socketClient", "tcp")
class TcpSocketClient extends SocketClient {

	@:arpField public var host:String;

	#if (flash || openfl)
	@:arpImpl private var flashImpl:TcpSocketClientFlashImpl;
	#end

	public function new() super();
}


