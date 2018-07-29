package arpx.impl.cross.texture;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef ResourceTextureImpl = arpx.impl.flash.texture.ResourceTextureImpl;
#elseif arp_display_backend_heaps
typedef ResourceTextureImpl = arpx.impl.heaps.texture.ResourceTextureImpl;
#elseif arp_display_backend_stub
typedef ResourceTextureImpl = arpx.impl.stub.texture.ResourceTextureImpl;
#end
