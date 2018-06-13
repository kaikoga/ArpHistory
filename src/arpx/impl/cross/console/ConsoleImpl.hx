package arpx.impl.cross.console;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef ConsoleImpl = arpx.impl.backends.flash.console.ConsoleFlashImpl;
#end

#if arp_display_backend_heaps
typedef ConsoleImpl = arpx.impl.backends.heaps.console.ConsoleHeapsImpl;
#end
