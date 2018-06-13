package arpx.impl.cross.texture;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef ResourceTextureImpl = arpx.impl.backends.flash.texture.ResourceTextureFlashImpl;
#elseif arp_display_backend_heaps
typedef ResourceTextureImpl = arpx.impl.backends.heaps.texture.ResourceTextureHeapsImpl;
#end
