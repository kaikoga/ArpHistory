package arpx.impl.cross.texture.decorators;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef GridTextureImpl = arpx.impl.flash.texture.decorators.GridTextureImpl;
#elseif arp_display_backend_heaps
typedef GridTextureImpl = arpx.impl.heaps.texture.decorators.GridTextureImpl;
#elseif arp_display_backend_sys
typedef GridTextureImpl = arpx.impl.sys.texture.decorators.GridTextureImpl;
#elseif arp_display_backend_stub
typedef GridTextureImpl = arpx.impl.stub.texture.decorators.GridTextureImpl;
#end
