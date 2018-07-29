package arpx.impl.cross.console;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef ConsoleImpl = arpx.impl.flash.console.ConsoleImpl;
#elseif arp_display_backend_heaps
typedef ConsoleImpl = arpx.impl.heaps.console.ConsoleImpl;
#elseif arp_display_backend_stub
typedef ConsoleImpl = arpx.impl.stub.console.ConsoleImpl;
#end
