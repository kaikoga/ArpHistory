package arpx.impl.cross.console;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef IConsoleImpl = arpx.impl.backends.flash.console.IConsoleFlashImpl;
#end

#if arp_display_backend_heaps
typedef IConsoleImpl = arpx.impl.backends.heaps.console.IConsoleHeapsImpl;
#end
