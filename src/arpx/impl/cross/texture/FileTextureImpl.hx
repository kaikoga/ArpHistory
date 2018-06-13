package arpx.impl.cross.texture;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef FileTextureImpl = arpx.impl.backends.flash.texture.FileTextureFlashImpl;
#elseif arp_display_backend_heaps
typedef FileTextureImpl = arpx.impl.backends.heaps.texture.FileTextureHeapsImpl;
#end
