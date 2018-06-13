package arpx.geom;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef Transform = arpx.impl.backends.flash.geom.Transform;
#elseif arp_display_backend_heaps
typedef Transform = arpx.impl.backends.heaps.geom.Transform;
#end
