package arpx.impl.cross.texture;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef ITextureImpl = arpx.impl.flash.texture.ITextureFlashImpl;
#elseif arp_display_backend_heaps
typedef ITextureImpl = arpx.impl.heaps.texture.ITextureHeapsImpl;
#end
