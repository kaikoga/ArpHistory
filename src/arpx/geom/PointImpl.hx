package arpx.geom;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef PointImpl = flash.geom.Point;
#elseif arp_display_backend_heaps
typedef PointImpl = h3d.col.Point;
#end