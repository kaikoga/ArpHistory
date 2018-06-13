package arpx.impl.cross.input;

#if (arp_input_backend_flash || arp_input_backend_openfl)
typedef IInputImpl = arpx.impl.backends.flash.input.IInputFlashImpl;
#elseif arp_input_backend_heaps
typedef IInputImpl = arpx.impl.backends.heaps.input.IInputHeapsImpl;
#end
