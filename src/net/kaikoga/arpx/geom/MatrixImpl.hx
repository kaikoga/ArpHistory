package net.kaikoga.arpx.geom;

#if (arp_backend_flash || arp_backend_openfl)
typedef MatrixImpl = flash.geom.Matrix;
#elseif arp_backend_heaps
typedef MatrixImpl = h3d.Matrix;
#end
