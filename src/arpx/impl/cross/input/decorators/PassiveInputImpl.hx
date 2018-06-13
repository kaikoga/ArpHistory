package arpx.impl.cross.input.decorators;

#if (arp_input_backend_flash || arp_input_backend_openfl)
typedef PassiveInputImpl = arpx.impl.backends.flash.input.decorators.PassiveInputFlashImpl;
#elseif arp_input_backend_heaps
typedef PassiveInputImpl = arpx.impl.backends.heaps.input.decorators.PassiveInputHeapsImpl;
#end
