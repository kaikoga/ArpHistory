package arpx.impl.cross.texture;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef TextureFaceImpl = arpx.impl.flash.texture.TextureFaceImpl;
#elseif arp_display_backend_heaps
typedef TextureFaceImpl = arpx.impl.heaps.texture.TextureFaceImpl;
#elseif arp_display_backend_sys
typedef TextureFaceImpl = arpx.impl.sys.texture.TextureFaceImpl;
#elseif arp_display_backend_stub
typedef TextureFaceImpl = arpx.impl.stub.texture.TextureFaceImpl;
#end
