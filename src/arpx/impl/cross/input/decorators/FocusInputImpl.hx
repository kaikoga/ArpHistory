package arpx.impl.cross.input.decorators;

#if (arp_input_backend_flash || arp_input_backend_openfl)
typedef FocusInputImpl = arpx.impl.flash.input.decorators.FocusInputImpl;
#elseif arp_input_backend_heaps
typedef FocusInputImpl = arpx.impl.heaps.input.decorators.FocusInputImpl;
#end
