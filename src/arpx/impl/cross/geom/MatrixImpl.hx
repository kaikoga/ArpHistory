package arpx.impl.cross.geom;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef MatrixImpl = flash.geom.Matrix;
#elseif arp_display_backend_heaps
typedef MatrixImpl = h3d.Matrix;
#end
