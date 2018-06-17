package arpx.impl.cross.chip;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef TextureChipImpl = arpx.impl.flash.chip.TextureChipFlashImpl;
#elseif arp_display_backend_heaps
typedef TextureChipImpl = arpx.impl.heaps.chip.TextureChipHeapsImpl;
#end
