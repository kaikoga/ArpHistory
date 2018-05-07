package net.kaikoga.arpx.geom;

#if (arp_backend_flash || arp_backend_openfl)
typedef AMatrix = net.kaikoga.arpx.impl.backends.flash.geom.AMatrix;
#elseif arp_backend_heaps
typedef AMatrix = net.kaikoga.arpx.impl.backends.heaps.geom.AMatrix;
#end
