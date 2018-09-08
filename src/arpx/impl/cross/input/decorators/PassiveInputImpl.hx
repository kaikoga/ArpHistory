package arpx.impl.cross.input.decorators;

#if arp_input_backend_flash
typedef PassiveInputImpl = arpx.impl.flash.input.decorators.PassiveInputImpl;
#elseif arp_input_backend_heaps
typedef PassiveInputImpl = arpx.impl.heaps.input.decorators.PassiveInputImpl;
#elseif arp_input_backend_sys
typedef PassiveInputImpl = arpx.impl.sys.input.decorators.PassiveInputImpl;
#elseif arp_input_backend_stub
typedef PassiveInputImpl = arpx.impl.stub.input.decorators.PassiveInputImpl;
#end
