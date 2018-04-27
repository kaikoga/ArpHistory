package net.kaikoga.arpx.display;

#if (arp_backend_flash || arp_backend_openfl)
typedef DisplayContext = net.kaikoga.arpx.backends.flash.display.DisplayContext;
#elseif arp_backend_heaps
typedef DisplayContext = net.kaikoga.arpx.backends.heaps.display.DisplayContext;
#end
