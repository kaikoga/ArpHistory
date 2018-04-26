package net.kaikoga.arpx.geom;

#if (arp_backend_flash || arp_backend_openfl)
typedef AMatrix = net.kaikoga.arpx.backends.flash.geom.AMatrix;
#elseif arp_backend_kha
typedef AMatrix = net.kaikoga.arpx.backends.kha.math.AMatrix;
#elseif arp_backend_heaps
typedef AMatrix = net.kaikoga.arpx.backends.heaps.geom.AMatrix;
#end
