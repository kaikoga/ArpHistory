package net.kaikoga.arpx.geom;

#if (arp_backend_flash || arp_backend_openfl)
typedef PointImpl = flash.geom.Point;
#elseif arp_backend_heaps
typedef PointImpl = h3d.col.Point;
#end
