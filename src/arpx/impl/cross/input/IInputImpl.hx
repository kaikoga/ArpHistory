package arpx.impl.cross.input;

#if arp_input_backend_flash
typedef IInputImpl = arpx.impl.flash.input.IInputImpl;
#elseif arp_input_backend_heaps
typedef IInputImpl = arpx.impl.heaps.input.IInputImpl;
#elseif arp_input_backend_sys
typedef IInputImpl = arpx.impl.sys.input.IInputImpl;
#elseif arp_input_backend_stub
typedef IInputImpl = arpx.impl.stub.input.IInputImpl;
#end
