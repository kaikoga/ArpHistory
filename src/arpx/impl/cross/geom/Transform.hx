package arpx.impl.cross.geom;

#if arp_display_backend_flash
typedef Transform = arpx.impl.flash.geom.Transform;
#elseif arp_display_backend_heaps
typedef Transform = arpx.impl.heaps.geom.Transform;
#elseif arp_display_backend_sys
typedef Transform = arpx.impl.sys.geom.Transform;
#elseif arp_display_backend_stub
typedef Transform = arpx.impl.stub.geom.Transform;
#end
