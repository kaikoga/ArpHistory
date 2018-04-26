package net.kaikoga.arpx.geom;

#if (arp_backend_flash || arp_backend_openfl)
typedef ITransform = net.kaikoga.arpx.backends.flash.geom.ITransform;
#elseif arp_backend_kha
typedef ITransform = net.kaikoga.arpx.backends.kha.math.ITransform;
#elseif arp_backend_heaps
typedef ITransform = net.kaikoga.arpx.backends.heaps.geom.ITransform;
#end
