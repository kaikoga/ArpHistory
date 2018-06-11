package arpx.geom;

#if (arp_backend_flash || arp_backend_openfl)
typedef Transform = arpx.impl.backends.flash.geom.Transform;
#elseif arp_backend_heaps
typedef Transform = arpx.impl.backends.heaps.geom.Transform;
#end
