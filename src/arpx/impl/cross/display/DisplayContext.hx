package arpx.impl.cross.display;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef DisplayContext = arpx.impl.flash.display.DisplayContext;
#elseif arp_display_backend_heaps
typedef DisplayContext = arpx.impl.heaps.display.DisplayContext;
#elseif arp_display_backend_stub
typedef DisplayContext = arpx.impl.stub.display.DisplayContext;
#end
