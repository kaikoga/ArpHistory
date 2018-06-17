package arpx.impl.cross.socketClient;

#if (arp_socket_backend_flash || arp_socket_backend_openfl)
typedef TcpCachedSocketClientImpl = arpx.impl.flash.socketClient.TcpCachedSocketClientFlashImpl;
#else
typedef TcpCachedSocketClientImpl = ISocketClientImpl;
#end
