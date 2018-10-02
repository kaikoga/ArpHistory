package arpx.impl.heaps.input;

#if arp_input_backend_heaps

import arp.impl.IArpObjectImpl;

interface IInputImpl extends IArpObjectImpl {
	function listen():Void;
	function purge():Void;
}

#end
