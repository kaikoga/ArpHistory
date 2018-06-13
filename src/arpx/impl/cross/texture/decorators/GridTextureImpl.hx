package arpx.impl.cross.texture.decorators;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef GridTextureImpl = arpx.impl.backends.flash.texture.decorators.GridTextureFlashImpl;
#elseif arp_display_backend_heaps
typedef GridTextureImpl = arpx.impl.backends.heaps.texture.decorators.GridTextureHeapsImpl;
#end
