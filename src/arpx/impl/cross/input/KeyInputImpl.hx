package arpx.impl.cross.input;

#if (arp_input_backend_flash || arp_input_backend_openfl)
typedef KeyInputImpl = arpx.impl.flash.input.KeyInputImpl;
#elseif arp_input_backend_heaps
typedef KeyInputImpl = arpx.impl.heaps.input.KeyInputImpl;
#elseif arp_input_backend_stub
typedef KeyInputImpl = arpx.impl.stub.input.KeyInputImpl;
#end
