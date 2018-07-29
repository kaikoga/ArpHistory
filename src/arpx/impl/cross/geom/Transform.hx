package arpx.impl.cross.geom;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef Transform = arpx.impl.flash.geom.Transform;
#elseif arp_display_backend_heaps
typedef Transform = arpx.impl.heaps.geom.Transform;
#elseif arp_display_backend_stub
typedef Transform = arpx.impl.stub.geom.Transform;
#end
