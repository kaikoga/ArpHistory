package arpx.impl.cross.chip;

#if (arp_display_backend_flash || arp_display_backend_openfl)
typedef NativeTextChipImpl = arpx.impl.backends.flash.chip.NativeTextChipFlashImpl;
#elseif arp_display_backend_heaps
typedef NativeTextChipImpl = arpx.impl.backends.heaps.chip.NativeTextChipHeapsImpl;
#end
