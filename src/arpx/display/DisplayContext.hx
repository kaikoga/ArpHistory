package arpx.display;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef DisplayContext = arpx.impl.backends.flash.display.DisplayContext;
#elseif arp_display_backend_heaps
typedef DisplayContext = arpx.impl.backends.heaps.display.DisplayContext;
#end
