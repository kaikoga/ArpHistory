package arpx.impl.cross.texture;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef ITextureImpl = arpx.impl.flash.texture.ITextureImpl;
#elseif arp_display_backend_heaps
typedef ITextureImpl = arpx.impl.heaps.texture.ITextureImpl;
#elseif arp_display_backend_sys
typedef ITextureImpl = arpx.impl.sys.texture.ITextureImpl;
#elseif arp_display_backend_stub
typedef ITextureImpl = arpx.impl.stub.texture.ITextureImpl;
#end
