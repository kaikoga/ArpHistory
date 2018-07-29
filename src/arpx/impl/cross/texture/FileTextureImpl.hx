package arpx.impl.cross.texture;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef FileTextureImpl = arpx.impl.flash.texture.FileTextureImpl;
#elseif arp_display_backend_heaps
typedef FileTextureImpl = arpx.impl.heaps.texture.FileTextureImpl;
#end
