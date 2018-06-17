package arpx.impl.cross.socketClient;

#if (arp_socket_backend_flash || arp_socket_backend_openfl)
typedef TcpSocketClientImpl = arpx.impl.flash.socketClient.TcpSocketClientFlashImpl;
#else
typedef TcpSocketClientImpl = ISocketClientImpl;
#end
