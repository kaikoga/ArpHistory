package arpx.impl.cross.input.decorators;

#if (arp_input_backend_flash || arp_input_backend_openfl)
typedef FocusInputImpl = arpx.impl.backends.flash.input.decorators.FocusInputFlashImpl;
#elseif arp_input_backend_heaps
typedef FocusInputImpl = arpx.impl.backends.heaps.input.decorators.FocusInputHeapsImpl;
#end
