package arpx.impl.cross.chip;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef TextureChipImpl = arpx.impl.flash.chip.TextureChipImpl;
#elseif arp_display_backend_heaps
typedef TextureChipImpl = arpx.impl.heaps.chip.TextureChipImpl;
#elseif arp_display_backend_sys
typedef TextureChipImpl = arpx.impl.sys.chip.TextureChipImpl;
#elseif arp_display_backend_stub
typedef TextureChipImpl = arpx.impl.stub.chip.TextureChipImpl;
#end
