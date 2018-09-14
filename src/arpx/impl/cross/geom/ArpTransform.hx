package arpx.impl.cross.geom;

#if arp_display_backend_flash
typedef ArpTransform = arpx.impl.flash.geom.ArpTransform;
#elseif arp_display_backend_heaps
typedef ArpTransform = arpx.impl.heaps.geom.ArpTransform;
#elseif arp_display_backend_sys
typedef ArpTransform = arpx.impl.sys.geom.ArpTransform;
#elseif arp_display_backend_stub
typedef ArpTransform = arpx.impl.stub.geom.ArpTransform;
#end
