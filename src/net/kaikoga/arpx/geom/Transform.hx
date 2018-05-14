package net.kaikoga.arpx.geom;

#if (arp_backend_flash || arp_backend_openfl)
typedef Transform = net.kaikoga.arpx.impl.backends.flash.geom.Transform;
#elseif arp_backend_heaps
typedef Transform = net.kaikoga.arpx.impl.backends.heaps.geom.Transform;
#end
