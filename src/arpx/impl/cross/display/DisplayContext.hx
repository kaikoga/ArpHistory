package arpx.impl.cross.display;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef DisplayContext = arpx.impl.flash.display.DisplayContextImpl;
#elseif arp_display_backend_heaps
typedef DisplayContext = arpx.impl.heaps.display.DisplayContextImpl;
#elseif arp_display_backend_sys
typedef DisplayContext = arpx.impl.sys.display.DisplayContextImpl;
#elseif arp_display_backend_stub
typedef DisplayContext = arpx.impl.stub.display.DisplayContextImpl;
#end
