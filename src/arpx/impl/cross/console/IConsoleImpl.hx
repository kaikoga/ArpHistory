package arpx.impl.cross.console;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef IConsoleImpl = arpx.impl.flash.console.IConsoleImpl;
#elseif arp_display_backend_heaps
typedef IConsoleImpl = arpx.impl.heaps.console.IConsoleImpl;
#elseif arp_display_backend_stub
typedef IConsoleImpl = arpx.impl.stub.console.IConsoleImpl;
#end
