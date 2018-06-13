package arpx.impl.cross.input;

#if (arp_input_backend_flash || arp_input_backend_openfl)
typedef KeyInputImpl = arpx.impl.backends.flash.input.KeyInputFlashImpl;
#elseif arp_input_backend_heaps
typedef KeyInputImpl = arpx.impl.backends.heaps.input.KeyInputHeapsImpl;
#end
