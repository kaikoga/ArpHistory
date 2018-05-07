package net.kaikoga.arpx.geom;

#if (arp_backend_flash || arp_backend_openfl)
typedef APoint = net.kaikoga.arpx.impl.backends.flash.geom.APoint;
#elseif arp_backend_heaps
typedef APoint = net.kaikoga.arpx.impl.backends.heaps.geom.APoint;
#end
