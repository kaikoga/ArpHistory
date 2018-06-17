package arpx.impl.cross.texture;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef NativeTextTextureImpl = arpx.impl.flash.texture.NativeTextTextureFlashImpl;
#elseif arp_display_backend_heaps
typedef NativeTextTextureImpl = arpx.impl.heaps.texture.NativeTextTextureHeapsImpl;
#end
