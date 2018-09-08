package arpx.impl.cross.geom;

#if arp_display_backend_flash
typedef MatrixImpl = flash.geom.Matrix;
#elseif arp_display_backend_heaps
typedef MatrixImpl = h3d.Matrix;
#elseif arp_display_backend_sys
typedef MatrixImpl = arpx.impl.sys.geom.MatrixImpl;
#elseif arp_display_backend_stub
typedef MatrixImpl = arpx.impl.stub.geom.MatrixImpl;
#end
