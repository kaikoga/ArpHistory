package arpx.impl.cross.texture.decorators;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef TextureFaceInfo = arpx.impl.flash.texture.decorators.TextureFaceInfo;
#elseif arp_display_backend_heaps
typedef TextureFaceInfo = arpx.impl.heaps.texture.decorators.TextureFaceInfo;
#elseif arp_display_backend_sys
typedef TextureFaceInfo = arpx.impl.sys.texture.decorators.TextureFaceInfo;
#elseif arp_display_backend_stub
typedef TextureFaceInfo = arpx.impl.stub.texture.decorators.TextureFaceInfo;
#end
